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


@WebServlet("/generarPDF")
public class GenerarPDFServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"empleadas_femeninas.pdf\"");

        try (OutputStream out = response.getOutputStream()) {
            PdfWriter writer = new PdfWriter(out);
            try (PdfDocument pdfDoc = new PdfDocument(writer); Document document = new Document(pdfDoc, PageSize.A4)) {
                
                // Encabezado simple para probar
                document.add(new Paragraph("Lista de Empleados Femeninos").setFontSize(18).setBold());

                // Obtener datos y verificar su carga
                Empleados_adm empModel = new Empleados_adm();
                DefaultTableModel tablaEmpleadosFemeninos = empModel.leerEmpleadosFemeninos();

                if (tablaEmpleadosFemeninos.getRowCount() == 0) {
                    document.add(new Paragraph("No se encontraron datos de empleadas femeninas."));
                } else {
                    // Tabla básica
                    // Crear tabla básica para diseño
float[] columnWidths = {1, 2, 2, 3, 2, 2, 2, 2, 2, 2, 1}; // Ajustar anchos
Table table = new Table(columnWidths);
table.setWidth(PageSize.A4.getWidth() - document.getLeftMargin() - document.getRightMargin());


                    // Agregar encabezados de columna
                    String[] columnNames = {"ID", "Nombres", "Apellidos", "Dirección", "Teléfono", "DPI", "Fecha Nac.", "Puesto", "Fecha Inicio", "Fecha Ingreso", "Género"};
                    for (String columnName : columnNames) {
                        Cell headerCell = new Cell().add(new Paragraph(columnName).setBold().setFontSize(10));
                        headerCell.setBackgroundColor(ColorConstants.BLACK);
                        headerCell.setFontColor(ColorConstants.WHITE);
                        headerCell.setTextAlignment(com.itextpdf.layout.property.TextAlignment.CENTER);
                        table.addHeaderCell(headerCell);
                    }

                    // Imprimir datos en consola para verificar
                    for (int row = 0; row < tablaEmpleadosFemeninos.getRowCount(); row++) {
                        for (int col = 0; col < tablaEmpleadosFemeninos.getColumnCount(); col++) {
                            String value = (tablaEmpleadosFemeninos.getValueAt(row, col) != null) 
                                ? tablaEmpleadosFemeninos.getValueAt(row, col).toString() 
                                : "";
                            System.out.println("Fila " + row + ", Columna " + col + ": " + value);  // Imprimir datos

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
