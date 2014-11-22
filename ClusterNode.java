import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

/**
*This class was intended to club information from communities written out by R and reading the pid text file to 
*ascertain the product information and write out community information in detail*/
public class ClusterNode {
    public ClusterNode() {
        super();
    }
    
    private String path = "D:\\Courses\\Social Network Analysis\\project\\";
    private String nodeDetail = path+"pid.txt";
    private String commCl = path + "FastGreedy\\fg11wc21.txt";
    
    public void parseAndReadFiles() throws FileNotFoundException, IOException {
        BufferedReader brNode = new BufferedReader(new InputStreamReader(new FileInputStream(nodeDetail)));
        BufferedReader brCluster = new BufferedReader(new InputStreamReader(new FileInputStream(commCl)));
        BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"Fg11Wc21WithDetails.txt"),"UTF-8"));
        String lineInCluster = null;
        while((lineInCluster = brCluster.readLine()) != null){
            lineInCluster = lineInCluster.trim();
            String[] elements = lineInCluster.split(" ");
            for(String element : elements){
                String match = getNodeDetail(brNode,element);
                out.write(match+"\n");
            }
            out.flush();
        }
    }
    
    public String getNodeDetail(BufferedReader brNode,String id){
        String str = null;
        try{
            int i1 = Integer.parseInt(id);   
        }catch(NumberFormatException e){
            return str;
        }
        try {
            while ((str = brNode.readLine()) != null){
                String[] commaSplit = str.split(",");
                String match = commaSplit[0];
                if(match.equals(id))    return str;
            }
                
        } catch (IOException e) {
            e.printStackTrace();
        }
        return str;
    }
    
    public static void main(String[] args) throws FileNotFoundException, IOException {
        ClusterNode cn = new ClusterNode();
        cn.parseAndReadFiles();
    }
}
