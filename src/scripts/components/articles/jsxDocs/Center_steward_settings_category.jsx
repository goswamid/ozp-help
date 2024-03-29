// Automatically Generated Module
var React = require('react');
var Router = require('react-router');
var Reflux = require('reflux');
var { Route, RouteHandler, Link } = Router;
module.exports = React.createClass({
	mixins: [ Router.State, Reflux.ListenerMixin],
	contextTypes: { router: React.PropTypes.func },
	
render: function(){return ( 
<div>

<h1>Manage Center Categories</h1>

<p>Center Stewards can add, edit or delete categories. </p>
<p>Categories group listings by similar characteristics. They help people narrow their search results on the Search and Discovery Page:</p>

<p><img alt="Categories on the Search and Discovery Page" src="Doc_images/categories_SearchDiscoverPage.png"  title="Categories on the Search and Discovery Page" /></p>

<h3>Access category settings:</h3>

<ol>
	<li>Click <img alt="Main Menu" src="Doc_images/Main_menu_icon.png"  /> on the right-side of the Global Toolbar.</li>
	<li>Select Center Settings<br />
	<img alt="Center Settings Link on Main Menu" src="Doc_images/centerSettingsLink_MainMenu.png"  title="Center Settings Link on Main Menu" /></li>
	<li>The Center Settings page will open to the Categories tab:<br />
	<img alt="Center Settings Page" src="Doc_images/centerSettings.png"  title="Center Settings Page" /></li>
</ol>

<h2>Create a category:</h2>

<ol>
	<li>Click the Add New button at the top of the Categories table:<br />
	<img alt="Add new category" src="Doc_images/AddNewCategory.png"  title="Add new category" /></li>
	<li>The Create Category window opens. Give the category a Title and Description, and then click Save.</li>
	<li>The category will appear on the list of categories on the Center Settings page and on the Search and Discovery Page.<br />
	<em>Note: Listings are sorted alphabetically.</em></li>
</ol>

<h2>Edit a category:</h2>

<ol>
	<li>From the Categories tab on the Center Settings page, click the category that you want to edit.</li>
	<li>The Edit button will become active, click it.</li>
	<li>The Edit Category window will open, make your change and click Save.</li>
	<li>The change will appear on the list of categories on the Center Settings page and on the Search and Discovery Page.</li>
</ol>

<h2>Delete a category:</h2>

<ol>
	<li>From the Categories tab on the Center Settings page, click the category that you want to delete.</li>
	<li>The Delete button will become active, click it.</li>
	<li>A confirmation window appears, click Delete:<br />
	<img alt="Category Delete Warning" src="Doc_images/categoryDeleteWarning.png"  title="Category Delete Warning" /></li>
	<li>The category will be removed from the list of categories on the Center Settings page and on the Search and Discovery Page.<br />
	<i>However, if the category is associated with a listing, it cannot be deleted. To delete the category you have to remove its association with all listings. Edit each listing using the Create/Edit Form.</i></li>
</ol>


	</div>
	);
	}
});
