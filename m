Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA6C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A47020836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBXMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:14:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:3613 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgBXMOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:14:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 04:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349909432"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 04:14:15 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 4/9] usb: roles: Leave the private driver data pointer to the drivers
Date:   Mon, 24 Feb 2020 15:14:01 +0300
Message-Id: <20200224121406.2419-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding usb_role_switch_get/set_drvdata() functions that the
switch drivers can use for setting and getting private data
pointer that is associated with the switch.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/roles/class.c | 22 ++++++++++++++++++++++
 include/linux/usb/role.h  | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 63a00ff26655..49511d446410 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -329,6 +329,7 @@ usb_role_switch_register(struct device *parent,
 	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
 	sw->dev.type = &usb_role_dev_type;
+	dev_set_drvdata(&sw->dev, desc->driver_data);
 	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
 
 	ret = device_register(&sw->dev);
@@ -356,6 +357,27 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 
+/**
+ * usb_role_switch_set_drvdata - Assign private data pointer to a switch
+ * @sw: USB Role Switch
+ * @data: Private data pointer
+ */
+void usb_role_switch_set_drvdata(struct usb_role_switch *sw, void *data)
+{
+	dev_set_drvdata(&sw->dev, data);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_set_drvdata);
+
+/**
+ * usb_role_switch_get_drvdata - Get the private data pointer of a switch
+ * @sw: USB Role Switch
+ */
+void *usb_role_switch_get_drvdata(struct usb_role_switch *sw)
+{
+	return dev_get_drvdata(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_get_drvdata);
+
 static int __init usb_roles_init(void)
 {
 	role_class = class_create(THIS_MODULE, "usb_role");
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index efac3af83d6b..02dae936cebd 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -25,6 +25,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
  * @set: Callback for setting the role
  * @get: Callback for getting the role (optional)
  * @allow_userspace_control: If true userspace may change the role through sysfs
+ * @driver_data: Private data pointer
  *
  * @usb2_port and @usb3_port will point to the USB host port and @udc to the USB
  * device controller behind the USB connector with the role switch. If
@@ -40,6 +41,7 @@ struct usb_role_switch_desc {
 	usb_role_switch_set_t set;
 	usb_role_switch_get_t get;
 	bool allow_userspace_control;
+	void *driver_data;
 };
 
 
@@ -57,6 +59,9 @@ struct usb_role_switch *
 usb_role_switch_register(struct device *parent,
 			 const struct usb_role_switch_desc *desc);
 void usb_role_switch_unregister(struct usb_role_switch *sw);
+
+void usb_role_switch_set_drvdata(struct usb_role_switch *sw, void *data);
+void *usb_role_switch_get_drvdata(struct usb_role_switch *sw);
 #else
 static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
 		enum usb_role role)
@@ -90,6 +95,17 @@ usb_role_switch_register(struct device *parent,
 }
 
 static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
+
+static inline void
+usb_role_switch_set_drvdata(struct usb_role_switch *sw, void *data)
+{
+}
+
+static inline void *usb_role_switch_get_drvdata(struct usb_role_switch *sw)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* __LINUX_USB_ROLE_H */
-- 
2.25.0

