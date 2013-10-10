/* Plugin generated by AMXX-Studio */

/*
 *	------------------------------------------------------------------
 *	  This is part of Vdf module examples, designed only to test and 
 *	  demonstrate this module functionality.
 *	  For more information check this topic:
 *	  http://forums.alliedmods.net/showthread.php?t=51662
 *	------------------------------------------------------------------
 */


#include <amxmodx>
#include <amxmisc>
#include <vdf>

// This is a crap test of vdf sort functions.


#define PLUGIN "sort sample"
#define VERSION "1.0"
#define AUTHOR "commonbullet"

new VdfTree:g_Tree

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	create_tree()
	register_concmd("show_names", "sort_by_name")
	register_concmd("show_scores", "sort_by_score")
}

create_tree()
{
	new VdfNode:node
	
	g_Tree = vdf_create_tree("sort.vdf")
	node = vdf_get_root_node(g_Tree)
	
	vdf_set_node_key(node, "scores")
	
	vdf_append_child_node(g_Tree, node, "Paul", "2231")
	vdf_append_child_node(g_Tree, node, "Helen", "2121")
	vdf_append_child_node(g_Tree, node, "Albert", "5332")
	vdf_append_child_node(g_Tree, node, "John", "12111")
	
	node = vdf_get_child_node(node)
	
}

public sort_by_name(id)
{
	if(g_Tree) {
		new VdfNode:node
		new VdfNode:rootnode
		
		rootnode = vdf_get_root_node(g_Tree)
		node = vdf_get_child_node(rootnode)
		
		vdf_sort_branch(g_Tree, node)
		display_branch(id, rootnode)		
	}
	return PLUGIN_HANDLED
}

public sort_by_score(id)
{
	if(g_Tree) {
		new VdfNode:node
		new VdfNode:rootnode
		
		rootnode = vdf_get_root_node(g_Tree)
		node = vdf_get_child_node(rootnode)
		
		vdf_sort_branch(g_Tree, node, false, true)
		display_branch(id, rootnode, 1)		
	}
	return PLUGIN_HANDLED
}


display_branch(id, VdfNode:parentnode, reverse = 0)
{
	new VdfNode:node
	new key[32]
	new value
	
	node = vdf_get_child_node(parentnode)
	
	if(reverse)
		node = vdf_get_last_node(node)
	
	while(node) {
		vdf_get_node_key(node, key, 31)
		value = vdf_get_node_value_num(node)		
		console_print(id, "Name: %s, Points: %d", key, value)		
		node = (reverse) ? vdf_get_previous_node(node): vdf_get_next_node(node)
	}
}