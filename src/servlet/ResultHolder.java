package servlet;

import java.util.ArrayList;

public class ResultHolder {
    private ArrayList<Result> results;
    private float x_dot;
    private float y_dot;
    private float r_dot;
    private boolean isDot = false;

    public ResultHolder() {
        results = new ArrayList<>();
    }

    public ArrayList<Result> getResults() {
        return results;
    }

    public void setResults(ArrayList<Result> results) {
        this.results = results;
    }

    public void add(Result result) {
        results.add(result);
    }

    @Override
    public String toString() {
        if (results.size() == 0) return "";
        StringBuilder res = new StringBuilder();
        Result[] resArray = new Result[results.size()];
        results.toArray(resArray);
        for (int i = resArray.length - 1; i > -1; i--) {
            res.append(resArray[i].toString());
        }
        return "<div class=\"block\"><table class=\"table\"><caption>Табличка</caption><tr><th>X</th><th>Y</th><th>R</th><th>RESULT</th></tr>" + res.toString() + "</table></div>";
    }

    public void setDot(float x, Float y, float r) {
        x_dot = x;
        y_dot = y;
        r_dot = r;
        isDot = true;
    }

    public String getDot() {
        if (isDot)
            return String.format("<circle id=\"dot\" r=\"3\" cx=\"%d\" cy=\"%d\" fill=\"#AD2D2D\" stroke=\"#AD2D2D\"></circle>", (int) (150 + x_dot * 120 / r_dot), (int) (150 - y_dot * 120 / r_dot));
        else return "";
    }

    public void refresh() {
        results = new ArrayList<>();
    }
}