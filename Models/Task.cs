using System.ComponentModel.DataAnnotations;

public class Task
{
    public int Id { get; set; }

    // Use the required modifier
    public required string Title { get; set; }

    public required string Description { get; set; }

    public bool IsCompleted { get; set; }
    public DateTime DueDate { get; set; }
}
