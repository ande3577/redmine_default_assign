class DefaultAssignIssueHook < Redmine::Hook::ViewListener
  def controller_issues_new_before_save(context={})
    if context[:issue].assigned_to.nil? && (context[:issue].category.nil? || context[:issue].category.assigned_to.nil?)
        selected = context[:project].default_assignee.id unless context[:project].default_assignee.blank?
        selected ||= Setting.plugin_redmine_default_assign['default_assignee_id'] unless Setting.plugin_redmine_default_assign['default_assignee_id'].blank? or 
  											not context[:project].assignable_users.member?(User.find(Setting.plugin_redmine_default_assign['default_assignee_id']).id)
        selected ||= nil
        
        context[:issue].assigned_to_id = selected      
    end
    
    return
 
  end  
end
