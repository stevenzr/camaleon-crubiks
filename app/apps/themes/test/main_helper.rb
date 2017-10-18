module Themes::test::MainHelper
  def self.included(klass)
    klass.helper_method [:perspective_social_networks] rescue "" # here your methods accessible from views
  end

  def perspective_theme_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def perspective_theme_on_install_theme(theme)
    return if theme.get_option('installed_at').present? # it was installed (re enabling...)
    lorem = 'Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur.'

    # Home Slider
    gr = current_theme.add_field_group({name: "Home Slider", slug: "home_slider", is_repeat: true})
    gr.add_field({"name"=>"Title", "slug"=>"home_slider_title"},{field_key: "text_box", translate: true})
    gr.add_field({"name"=>"Description", "slug"=>"home_slider_descr"},{field_key: "text_box", translate: true})

    gr = current_theme.add_field_group({name: "Social networks", slug: "social_networks"})
    gr.add_field({"name"=>"Facebook", "slug"=>"social_fb"},{field_key: "url", translate: true})
    gr.add_field({"name"=>"Pinterest", "slug"=>"social_pi"},{field_key: "url", translate: true})
    gr.add_field({"name"=>"Google plus", "slug"=>"social_go"},{field_key: "url", translate: true})
    gr.add_field({"name"=>"Twitter", "slug"=>"social_tw"},{field_key: "url", translate: true})

    # Our Services
    gr = current_theme.add_field_group({name: "Our Services Layout", slug: "services_layout"})
    gr.add_field({"name"=>"Title", "slug"=>"services_title"},{field_key: "text_box", translate: true, default_value: 'Our Services'})
    gr.add_field({"name"=>"Description", "slug"=>"services_descr"},{field_key: "text_box", translate: true, default_value: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.'})

    pt = current_site.post_types.create(name: "Services", slug: "services")
    pt.set_settings({has_summary: true, has_content: true, has_picture: false, has_template: false, has_keywords: false, has_comments: false})
    pt.add_field({"name"=>"Icon", "slug"=>"service_icon", description: 'Please enter any glyphicon icon, sample: glyphicon-shopping-cart, all icons here: http://getbootstrap.com/components/'}, {"field_key"=>"text_box", default_value: "glyphicon glyphicon-tint"})
    pt.add_post(title: "E-Commerce", post_order: 1, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-shopping-cart'} )
    pt.add_post(title: "Web Development", post_order: 1, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-grain'} )
    pt.add_post(title: "Web Marketing", post_order: 1, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-signal'})
    pt.add_post(title: "Web Security & Optimization", post_order: 1, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-lock'} )

    # Our Works
    gr = current_theme.add_field_group({name: "Our Works", slug: "works_layout"})
    gr.add_field({"name"=>"Title", "slug"=>"works_title"},{field_key: "text_box", translate: true})
    gr.add_field({"name"=>"Description", "slug"=>"works_descr"},{field_key: "text_box", translate: true})

    pt = current_site.post_types.create(name: "Our Works", slug: "works")
    pt.set_settings({has_summary: false, has_content: false, has_picture: false, has_template: false, has_keywords: false, has_comments: false, has_category: true})
    pt.add_field({"name"=>"Small Image", "slug"=>"small_image"}, {"field_key"=>"image"})
    pt.add_field({"name"=>"Large Image", "slug"=>"large_image"}, {"field_key"=>"image"})

    web_cat = pt.categories.create(name: 'Web')
    logo_cat = pt.categories.create(name: 'Logo Design')
    photo_cat = pt.categories.create(name: 'Photography')

    pt.add_post(title: "Work 1", post_order: 1, settings:{categories: [web_cat.id] }, fields: {small_image: 'https://p.w3layouts.com/demos/perspective/web/images/2.jpg', large_image: 'https://p.w3layouts.com/demos/perspective/web/images/2.jpg'} )
    pt.add_post(title: "Work 2", post_order: 2, settings:{categories: [web_cat.id] } )
    pt.add_post(title: "Work 3", post_order: 2, settings:{categories: [logo_cat.id] } )
    pt.add_post(title: "Work 4", post_order: 2, settings:{categories: [web_cat.id, photo_cat.id] } )
    pt.add_post(title: "Work 5", post_order: 2, settings:{categories: [photo_cat.id] } )


    # Our Features
    gr = current_theme.add_field_group({name: "Our Features Layout", slug: "features_layout"})
    gr.add_field({"name"=>"Title", "slug"=>"features_title"},{field_key: "text_box", translate: true, default_value: 'Our Features'})
    gr.add_field({"name"=>"Description", "slug"=>"features_descr"},{field_key: "text_box", translate: true, default_value: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.'})

    pt = current_site.post_types.create(name: "Features", slug: "features")
    pt.set_settings({has_summary: true, has_content: true, has_picture: false, has_template: false, has_keywords: false, has_comments: false})
    pt.add_field({"name"=>"Icon", "slug"=>"feature_icon", description: 'Please enter any glyphicon icon, sample: glyphicon-shopping-cart, all icons here: http://getbootstrap.com/components/'}, {"field_key"=>"text_box", default_value: "glyphicon glyphicon-tint"})
    pt.add_post(title: "Free Images", post_order: 1, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-picture'} )
    pt.add_post(title: "Responsive", post_order: 2, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-phone'} )
    pt.add_post(title: "Google Maps", post_order: 3, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-map-marker'})
    pt.add_post(title: "Easily Customizable", post_order: 4, content: lorem, summary: lorem, fields: {service_icon: 'glyphicon-cog'} )

    plugin_install('cama_subscriber')


    # Footer Settings
    gr = current_theme.add_field_group({name: "Footer Layout", slug: "footer_layout"})
    gr.add_field({"name"=>"Newsletter Title", "slug"=>"newsletter_title"},{field_key: "text_box", translate: true, default_value: 'Newsletter'})
    gr.add_field({"name"=>"Newsletter Description", "slug"=>"newsletter_descr"},{field_key: "text_box", translate: true, default_value: 'Enter your email and subscribe to our newsletter and never miss any updates.'})

    # contact form
    gr.add_field({"name"=>"Contact Title", "slug"=>"contact_title"},{field_key: "text_box", translate: true, default_value: 'Contact Us'})
    gr.add_field({"name"=>"Contact Description", "slug"=>"contact_descr"},{field_key: "text_box", translate: true})

    value = {"fields" =>[
        {"field_type" =>"paragraph","cid" =>"c1","label" =>"Message","required" =>"true", "default_value" =>'[label ci]',"field_options"=>{"description" =>"","field_class" =>"nothing","template" =>"[ci]","field_attributes" =>"{\"onfocus\":\"this.value = '';\", \"onblur\":\"if (this.value == '') {this.value = '[label ci]...';}\"}"}},
        {"field_type" =>"text","cid" =>"c2","label" =>"Name","required" =>"true", "default_value" =>'[label ci]',"field_options"=>{"description" =>"","field_class" =>"nothing","template" =>"[ci]","field_attributes" =>"{\"onfocus\":\"this.value = '';\", \"onblur\":\"if (this.value == '') {this.value = '[label ci]...';}\"}"}},
        {"field_type" =>"email","cid" =>"c3","label" =>"Email","required" =>"true", "default_value" =>'[label ci]',"field_options"=>{"description" =>"","field_class" =>"nothing","template" =>"[ci]","field_attributes" =>"{\"onfocus\":\"this.value = '';\", \"onblur\":\"if (this.value == '') {this.value = '[label ci]...';}\"}"}},
        {"field_type" =>"submit","cid" =>"c4","label" =>"Submit","field_options"=>{"field_class" =>"nothing","template" =>"[ci]"}},
        {"field_type" =>"reset_button","cid" =>"c5","label" =>"Clear","field_options"=>{"field_class" =>"nothing","template" =>"[ci]"}}
    ]}
    settings = {"railscf_mail"=>{"previous_html" =>"","after_html" =>"","to" =>"contact@mysite.com","subject" =>"New Contact Form","body" =>"","to_answer" =>"[c2]","subject_answer" =>"Contact form received","body_answer" =>"Hi [c2],\r\nThanks for contact us."}}
    current_site.contact_forms.create(name: 'Perspective Form', slug: 'perspective_form', value: value.to_json, settings: settings.to_json)

    # About Us Page
    pt = current_site.the_post_type('page')
    post = pt.add_post(title: 'About Us', content: 'Lorem Ipsum', settings: {default_template: "about_us", has_template: false})
    gr = post.add_field_group({name: "Team Members", slug: "team_members", is_repeat: true})
    gr.add_field({"name"=>"Name", "slug"=>"about_member_name"}, {"field_key"=>"text_box"})
    gr.add_field({name: "Role", "slug"=>"about_member_role"}, {"field_key"=>"text_box", translate: true})
    gr.add_field({name: "Photo", "slug"=>"about_member_photo"}, {"field_key"=>"image", dimension: '350x280'})
    gr.add_field({name: "Description", "slug"=>"about_member_descr"}, {"field_key"=>"text_area", translate: true})
    gr.add_field({name: "Facebook Url", "slug"=>"about_member_fb"}, {"field_key"=>"url"})
    gr.add_field({name: "Twitter Url", "slug"=>"about_member_tw"}, {"field_key"=>"url"})

    theme.set_option('installed_at', Time.current.to_s)
  end

  # callback executed after theme uninstalled
  def perspective_theme_on_uninstall_theme(theme)
    # theme.destroy # uncomment this if you want to delete all related content after switched another theme
  end

  # print social links
  def perspective_social_networks
    res = []
    if(fb = current_theme.the_field('social_fb')).present?
      res << "<li><a href='#{fb}' class='facebook'> </a></li>"
    end

    if(p = current_theme.the_field('social_pi')).present?
      res << "<li><a href='#{p}' class='p'> </a></li>"
    end

    if(g = current_theme.the_field('social_go')).present?
      res << "<li><a href='#{g}' class='g'> </a></li>"
    end

    if(t = current_theme.the_field('social_tw')).present?
      res << "<li><a href='#{t}' class='twitter'> </a></li>"
    end
    res.join(' ')
  end
end