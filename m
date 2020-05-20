Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5182C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FB920756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8O9jWBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgETDsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgETDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:48:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4EC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y7so626369ybj.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzrzYJO40IC5z2yldlSulxATnFlT1aohCTQK4MKTYi0=;
        b=L8O9jWBHkd5ljwibRH2T+i9h2E1GLS4PQ5iWxSUYfs+43V2a4t+p/yd9XkM6t3RBtB
         Gx4RyDCssrFuvXPlesP0txHnJzwoH1h5EH0pVb2RU9O69NkTE/oj3/mhho8yT9Z/tGjb
         WAmrKHyfXqpG1BX+qHYI8djGtfRGFR1NTlaUDyT+smsSFSrnyzP7slvvHhd5kDKH4uI2
         KGV9J51eRAY/bF43/02g/ZhZw+2taKtso+dBApqf6iogUnxz5dZZJNvtzHYw46+oiwSo
         WYm126t25aHc4PBu0tvX6Fnwp6sfPXKgPW3ZFb/xfPBhErGQHlkt8iEdrfPK/cEld0nx
         pKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzrzYJO40IC5z2yldlSulxATnFlT1aohCTQK4MKTYi0=;
        b=dP4Rg7Gc9jFhIuouonTOsVlO93TUu42xT2OSVrAR4DUYl6A4cVbVNL/yoOHuy0z91f
         9rF96zhk6RnDp1Zj6BZ5ds/JqYi7PJqsTQqhYFvi9tYY0B6+XRfGivywH6CgWjkKE8PN
         PXtm8BiueQHbfwxPAfgCLvw8Lrbqo88NIIiWiBK7KYIV9U+j/TC1Nipg4bZ1Fyk3h4wG
         2b8rL7aYF5qIYdE3M7TjMbKKbO/DNSrfgqgMf69y+27y8Wnq1H9JpvzJ8+MHeuGk6jT5
         qweyxMTUGerIUT0qc4ct2awjkjS2GW6Amq9hpYS6YlPYwriw3SguvXdmvRfXAZ6YANKy
         gfiA==
X-Gm-Message-State: AOAM533Lg8t3McL9F4BgYIVWp858QikrYZzl7xD/sGsEBHMEkbhOiapP
        5tBuCWfRt526QRLKDWOpRAgoc3IxXADyuiQ=
X-Google-Smtp-Source: ABdhPJwYL8/xtbv8VdlsQe/M51izSLHWDF2exO3tW4chnpeO1mUu/J+QgZMnzatsOxH2NzaquZsiblTFyMq0340=
X-Received: by 2002:a25:f04:: with SMTP id 4mr4260842ybp.233.1589946513031;
 Tue, 19 May 2020 20:48:33 -0700 (PDT)
Date:   Tue, 19 May 2020 20:48:22 -0700
In-Reply-To: <20200520034824.79049-1-saravanak@google.com>
Message-Id: <20200520034824.79049-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200520034824.79049-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 2/4] driver core: Expose device link details in sysfs
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's helpful to be able to look at device link details from sysfs. So,
expose it in sysfs.

Say device-A is supplier of device-B. These are the additional files
this patch would create:

/sys/class/devlink/device-A:device-B/
	auto_remove_on
	consumer/ -> .../device-B/
	runtime_pm
	status
	supplier/ -> .../device-A/
	sync_state_only

/sys/devices/.../device-A/
	consumer:device-B/ -> /sys/class/devlink/device-A:device-B/

/sys/devices/.../device-B/
	supplier:device-A/ -> /sys/class/devlink/device-A:device-B/

That way:
To get a list of all the device link in the system:
ls /sys/class/devlink/

To get the consumer names and links of a device:
ls -d /sys/devices/.../device-X/consumer:*

To get the supplier names and links of a device:
ls -d /sys/devices/.../device-X/supplier:*

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 211 +++++++++++++++++++++++++++++++++++++++--
 include/linux/device.h |  58 +++++------
 2 files changed, 233 insertions(+), 36 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6dbee5885abb..3304ea1a2604 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -235,6 +235,186 @@ void device_pm_move_to_tail(struct device *dev)
 	device_links_read_unlock(idx);
 }
 
+#define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
+
+static ssize_t status_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	char *status;
+
+	switch (to_devlink(dev)->status) {
+	case DL_STATE_NONE:
+		status = "not tracked"; break;
+	case DL_STATE_DORMANT:
+		status = "dormant"; break;
+	case DL_STATE_AVAILABLE:
+		status = "available"; break;
+	case DL_STATE_CONSUMER_PROBE:
+		status = "consumer probing"; break;
+	case DL_STATE_ACTIVE:
+		status = "active"; break;
+	case DL_STATE_SUPPLIER_UNBIND:
+		status = "supplier unbinding"; break;
+	default:
+		status = "unknown"; break;
+	}
+	return sprintf(buf, "%s\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t auto_remove_on_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+	char *str;
+
+	if (link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+		str = "supplier unbind";
+	else if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+		str = "consumer unbind";
+	else
+		str = "never";
+
+	return sprintf(buf, "%s\n", str);
+}
+static DEVICE_ATTR_RO(auto_remove_on);
+
+static ssize_t runtime_pm_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+
+	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_PM_RUNTIME));
+}
+static DEVICE_ATTR_RO(runtime_pm);
+
+static ssize_t sync_state_only_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+
+	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+}
+static DEVICE_ATTR_RO(sync_state_only);
+
+static struct attribute *devlink_attrs[] = {
+	&dev_attr_status.attr,
+	&dev_attr_auto_remove_on.attr,
+	&dev_attr_runtime_pm.attr,
+	&dev_attr_sync_state_only.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(devlink);
+
+static void devlink_dev_release(struct device *dev)
+{
+	kfree(to_devlink(dev));
+}
+
+static struct class devlink_class = {
+	.name = "devlink",
+	.owner = THIS_MODULE,
+	.dev_groups = devlink_groups,
+	.dev_release = devlink_dev_release,
+};
+
+static int devlink_add_symlinks(struct device *dev,
+				struct class_interface *class_intf)
+{
+	int ret;
+	size_t len;
+	struct device_link *link = to_devlink(dev);
+	struct device *sup = link->supplier;
+	struct device *con = link->consumer;
+	char *buf;
+
+	len = max(strlen(dev_name(sup)), strlen(dev_name(con)));
+	len += strlen("supplier:") + 1;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = sysfs_create_link(&link->link_dev.kobj, &sup->kobj, "supplier");
+	if (ret)
+		goto out;
+
+	ret = sysfs_create_link(&link->link_dev.kobj, &con->kobj, "consumer");
+	if (ret)
+		goto err_con;
+
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	ret = sysfs_create_link(&sup->kobj, &link->link_dev.kobj, buf);
+	if (ret)
+		goto err_con_dev;
+
+	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	ret = sysfs_create_link(&con->kobj, &link->link_dev.kobj, buf);
+	if (ret)
+		goto err_sup_dev;
+
+	goto out;
+
+err_sup_dev:
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	sysfs_remove_link(&sup->kobj, buf);
+err_con_dev:
+	sysfs_remove_link(&link->link_dev.kobj, "consumer");
+err_con:
+	sysfs_remove_link(&link->link_dev.kobj, "supplier");
+out:
+	kfree(buf);
+	return ret;
+}
+
+static void devlink_remove_symlinks(struct device *dev,
+				   struct class_interface *class_intf)
+{
+	struct device_link *link = to_devlink(dev);
+	size_t len;
+	struct device *sup = link->supplier;
+	struct device *con = link->consumer;
+	char *buf;
+
+	sysfs_remove_link(&link->link_dev.kobj, "consumer");
+	sysfs_remove_link(&link->link_dev.kobj, "supplier");
+
+	len = max(strlen(dev_name(sup)), strlen(dev_name(con)));
+	len += strlen("supplier:") + 1;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf) {
+		WARN(1, "Unable to properly free device link symlinks!\n");
+		return;
+	}
+
+	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	sysfs_remove_link(&con->kobj, buf);
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	sysfs_remove_link(&sup->kobj, buf);
+	kfree(buf);
+}
+
+static struct class_interface devlink_class_intf = {
+	.class = &devlink_class,
+	.add_dev = devlink_add_symlinks,
+	.remove_dev = devlink_remove_symlinks,
+};
+
+static int __init devlink_class_init(void)
+{
+	int ret;
+
+	ret = class_register(&devlink_class);
+	if (ret)
+		return ret;
+
+	ret = class_interface_register(&devlink_class_intf);
+	if (ret)
+		class_unregister(&devlink_class);
+
+	return ret;
+}
+postcore_initcall(devlink_class_init);
+
 #define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
@@ -405,13 +585,6 @@ struct device_link *device_link_add(struct device *consumer,
 
 	refcount_set(&link->rpm_active, 1);
 
-	if (flags & DL_FLAG_PM_RUNTIME) {
-		if (flags & DL_FLAG_RPM_ACTIVE)
-			refcount_inc(&link->rpm_active);
-
-		pm_runtime_new_link(consumer);
-	}
-
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
@@ -421,6 +594,25 @@ struct device_link *device_link_add(struct device *consumer,
 	link->flags = flags;
 	kref_init(&link->kref);
 
+	link->link_dev.class = &devlink_class;
+	device_set_pm_not_required(&link->link_dev);
+	dev_set_name(&link->link_dev, "%s:%s",
+		     dev_name(supplier), dev_name(consumer));
+	if (device_register(&link->link_dev)) {
+		put_device(consumer);
+		put_device(supplier);
+		kfree(link);
+		link = NULL;
+		goto out;
+	}
+
+	if (flags & DL_FLAG_PM_RUNTIME) {
+		if (flags & DL_FLAG_RPM_ACTIVE)
+			refcount_inc(&link->rpm_active);
+
+		pm_runtime_new_link(consumer);
+	}
+
 	/* Determine the initial link state. */
 	if (flags & DL_FLAG_STATELESS)
 		link->status = DL_STATE_NONE;
@@ -543,7 +735,7 @@ static void device_link_free(struct device_link *link)
 
 	put_device(link->consumer);
 	put_device(link->supplier);
-	kfree(link);
+	device_unregister(&link->link_dev);
 }
 
 #ifdef CONFIG_SRCU
@@ -1139,6 +1331,9 @@ static void device_links_purge(struct device *dev)
 {
 	struct device_link *link, *ln;
 
+	if (dev->class == &devlink_class)
+		return;
+
 	mutex_lock(&wfs_lock);
 	list_del(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..4c10afed9cd6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -386,34 +386,6 @@ enum device_link_state {
 #define DL_FLAG_MANAGED			BIT(6)
 #define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
 
-/**
- * struct device_link - Device link representation.
- * @supplier: The device on the supplier end of the link.
- * @s_node: Hook to the supplier device's list of links to consumers.
- * @consumer: The device on the consumer end of the link.
- * @c_node: Hook to the consumer device's list of links to suppliers.
- * @status: The state of the link (with respect to the presence of drivers).
- * @flags: Link flags.
- * @rpm_active: Whether or not the consumer device is runtime-PM-active.
- * @kref: Count repeated addition of the same link.
- * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
- * @supplier_preactivated: Supplier has been made active before consumer probe.
- */
-struct device_link {
-	struct device *supplier;
-	struct list_head s_node;
-	struct device *consumer;
-	struct list_head c_node;
-	enum device_link_state status;
-	u32 flags;
-	refcount_t rpm_active;
-	struct kref kref;
-#ifdef CONFIG_SRCU
-	struct rcu_head rcu_head;
-#endif
-	bool supplier_preactivated; /* Owned by consumer probe. */
-};
-
 /**
  * enum dl_dev_state - Device driver presence tracking information.
  * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
@@ -624,6 +596,36 @@ struct device {
 #endif
 };
 
+/**
+ * struct device_link - Device link representation.
+ * @supplier: The device on the supplier end of the link.
+ * @s_node: Hook to the supplier device's list of links to consumers.
+ * @consumer: The device on the consumer end of the link.
+ * @c_node: Hook to the consumer device's list of links to suppliers.
+ * @link_dev: device used to expose link details in sysfs
+ * @status: The state of the link (with respect to the presence of drivers).
+ * @flags: Link flags.
+ * @rpm_active: Whether or not the consumer device is runtime-PM-active.
+ * @kref: Count repeated addition of the same link.
+ * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
+ */
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	struct device link_dev;
+	enum device_link_state status;
+	u32 flags;
+	refcount_t rpm_active;
+	struct kref kref;
+#ifdef CONFIG_SRCU
+	struct rcu_head rcu_head;
+#endif
+	bool supplier_preactivated; /* Owned by consumer probe. */
+};
+
 static inline struct device *kobj_to_dev(struct kobject *kobj)
 {
 	return container_of(kobj, struct device, kobj);
-- 
2.26.2.761.g0e0b3e54be-goog

