package servlet;

public class Result {
    private float x, y, r;
    private boolean isInArea;
    private boolean isCorrect;

    public Result(float x, float y, float r, boolean isInArea) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.isInArea = isInArea;
        this.isCorrect = true;
    }

    public Result() {
        this.isCorrect = false;
    }

    @Override
    public String toString() {
        if (isCorrect)
            return "<tr>" + tdString(x) + tdString(y) + tdString(r) + tdString(isInArea ? "TRUE" : "FALSE") + "</tr>";
        else return "<tr><td colspan='6'><b>ERROR</b></td></tr>";
    }

    private String tdString(Object s) {
        return String.format("<td>%s</td>", s.toString());
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getR() {
        return r;
    }

    public boolean isInArea() {
        return isInArea;
    }

}