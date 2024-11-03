package modelo;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import javax.swing.table.DefaultTableModel;

@WebServlet("/comprasPDF")
public class ComprasReport extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"compras.pdf\"");

        try (OutputStream out = response.getOutputStream()) {
            PdfWriter writer = new PdfWriter(out);
            try (PdfDocument pdfDoc = new PdfDocument(writer); Document document = new Document(pdfDoc, PageSize.A4)) {
                
                // Encabezado simple
                document.add(new Paragraph("Lista de Compras").setFontSize(18).setBold());

                // Obtener datos de compras
                Compras comprasModel = new Compras();
                DefaultTableModel tablaCompras = comprasModel.reportecompras6(); // Asegúrate de que este método ejecute el query que has proporcionado

                if (tablaCompras.getRowCount() == 0) {
                    document.add(new Paragraph("No se encontraron datos de compras."));
                } else {
                    // Crear tabla para las compras
                    float[] columnWidths = {1, 2, 2, 3, 2}; // Ajustar anchos
                    Table table = new Table(columnWidths);
                    table.setWidth(PageSize.A4.getWidth() - document.getLeftMargin() - document.getRightMargin());

                    // Encabezados de columna
                    String[] columnNames = {"ID Compra", "Orden Compra", "ID Proveedor", "Fecha Orden", "Fecha Ingreso"};
                    for (String columnName : columnNames) {
                        Cell headerCell = new Cell().add(new Paragraph(columnName).setBold().setFontSize(10));
                        headerCell.setBackgroundColor(ColorConstants.BLACK);
                        headerCell.setFontColor(ColorConstants.WHITE);
                        headerCell.setTextAlignment(com.itextpdf.layout.property.TextAlignment.CENTER);
                        table.addHeaderCell(headerCell);
                    }

                    // Agregar datos a la tabla
                    for (int row = 0; row < tablaCompras.getRowCount(); row++) {
                        for (int col = 0; col < tablaCompras.getColumnCount(); col++) {
                            String value = (tablaCompras.getValueAt(row, col) != null) 
                                ? tablaCompras.getValueAt(row, col).toString() 
                                : "";
                            Cell cell = new Cell().add(new Paragraph(value));
                            cell.setTextAlignment(com.itextpdf.layout.property.TextAlignment.CENTER);
                            table.addCell(cell);
                        }
                    }
                    
                    document.add(table);  // Agregar la tabla al documento
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error al crear PDF: " + e.getMessage(), e);
        }
    }
}



