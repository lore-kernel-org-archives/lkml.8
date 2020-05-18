Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F2206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCyEcNfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgERHGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:06:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF26C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:06:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id g6so9881086qvn.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EdydckMAIRgoywvYC9taS6wu8h/NeL6uFZqqGoWsOV0=;
        b=eCyEcNfHaJV4neDxlYwCV/DPSbL31u7fA9RdH71L4VTSnvLCXsjHwe0BydsQXl1k4m
         m/JD+BwM14rufAFALECVHUs3XzcNXQE/spP9OyDbtsWeYCrhX07pAboCs7JMXcc00W2s
         qxr0dj4kmUeJ/wBgbujSvx+MUcTgRUTEV92goqfOpNvO3ByC6DH9IIG+gyxld3ZFwjb2
         NC/Ds8DoVqWkiKcoavTzd+lPgyoC68Kp0zVAjTMzXaTm2wef7Ojuumhp8WiG8YmkyFOO
         UOFBpB8goj4N3ORtUweZLMVl+Ue9wdF9M0D8rqxgeIaJhcmS6l7H7v45NmmZYP8gvbHm
         /dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EdydckMAIRgoywvYC9taS6wu8h/NeL6uFZqqGoWsOV0=;
        b=EwfZtgadAwtwg/mqC5VdlDs2GpNBEG+3C6p3pMsD79Wbee13S5knKpzU+e8YtzpwbF
         IUSEuJj84X2pa2OJzAgK9AQwmdwGVi/fyk0szBH9M43jwIBgDuizZ0MIrIr3bmBZLPeP
         oZJ9b6QW0EH7jdLr8RKkbP0LW5QIUsA4fTjzliGNtKCetCsMEXAtgpBgxsS0bvKZevpk
         1HMUYUAhuRxaWXuJVrVOd6D3VORPQUVyD+TGOX4DpEVIC1gOK6/EcC5dTSSB4iOlYqP2
         OiIFUDt85nF/iImJuM9vkDTn3Q39Om8HDglRAUPVwxz15ZWiarHc4rrsIDNBVUT+nEZp
         HhMQ==
X-Gm-Message-State: AOAM5318AeLV41HUiRyIrlfxYdF61dcx//msF7oQW1gHNNPjGdRxGs2i
        8wcA7q+yMYx4mF64M4NINcc1GWIF0H3mw0w=
X-Google-Smtp-Source: ABdhPJzhExRF7JCv9q3w2XK/pFQ5X9qZhnq0csN49ibYgVBmcK0+FYz96r7qMIZf5sQkv6odMJlFjOzQLg3jOmc=
X-Received: by 2002:ad4:4890:: with SMTP id bv16mr3405816qvb.164.1589785573591;
 Mon, 18 May 2020 00:06:13 -0700 (PDT)
Date:   Mon, 18 May 2020 00:06:07 -0700
Message-Id: <20200518070607.104611-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [RFC PATCH v1] driver core: Expose device link details in sysfs
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
	flags
	supplier/ -> .../device-A/
	consumer/ -> .../device-B/

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

For now, I'm just exporting "flags", supplier and consumer for each
device link. But the goal is to expand it to "state", etc once the
overall idea is accepted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg/Rafael,

Wanted to check if both of you are okay with the overall idea of
exporting device link details through sysfs and if using a "struct
device" is how you'd like to do it. I think this information would be
helpful in debugging all kinds of suspend/resume, probe and power issues
in a production system. I didn't want to spend more time on this patch
before I got your okays.

I'm not too familiar with the right way to do kobjs and symlinks in
sysfs -- so apologies any crazy code. But overall, the patch does create
the layout I describe above and seems to work.

I could also remove kref and switch to using link_dev to keep track of
refcount and releasing stuff, but I wasn't sure if we really needed the
srcu implementation or not. So didn't remove it in this series and left
it as is.

Known issues:
- There seem to be some issue in the srcu clean up path where it can't
  find the "consumer" and "supplier" links to remove. I need to debug
  that. It could be one due to one of those weird dwc3 drivers. Just a
  FYI in case you spot something wrong with my patch. Pointers welcome.
  "kernfs  : can not remove 'consumer', no directory"

Thanks,
Saravana

 drivers/base/core.c    | 129 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h |  58 +++++++++---------
 2 files changed, 156 insertions(+), 31 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0b7aff8f0412..3f05c910b244 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -52,6 +52,7 @@ static unsigned int defer_sync_state_count = 1;
 static unsigned int defer_fw_devlink_count;
 static DEFINE_MUTEX(defer_fw_devlink_lock);
 static bool fw_devlink_is_permissive(void);
+static void __device_link_del(struct kref *kref);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -235,6 +236,108 @@ void device_pm_move_to_tail(struct device *dev)
 	device_links_read_unlock(idx);
 }
 
+#define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
+
+static ssize_t flags_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%08x\n", to_devlink(dev)->flags);
+}
+static DEVICE_ATTR_RO(flags);
+
+static struct attribute *devlink_attrs[] = {
+	&dev_attr_flags.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(devlink);
+
+static struct class devlink_class = {
+	.name = "devlink",
+	.owner = THIS_MODULE,
+	.dev_groups = devlink_groups,
+};
+
+static int __init devlink_class_init(void)
+{
+	return class_register(&devlink_class);
+}
+postcore_initcall(devlink_class_init);
+
+static int devlink_add_symlinks(struct device_link *link)
+{
+	int ret;
+	size_t len;
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
+static void device_link_dev_release(struct device *dev)
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
+		WARN(1, "Unable to properly free device link!\n");
+		return;
+	}
+
+	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	sysfs_remove_link(&con->kobj, buf);
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	sysfs_remove_link(&sup->kobj, buf);
+	kfree(buf);
+	put_device(link->consumer);
+	put_device(link->supplier);
+	kfree(link);
+}
+
 #define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
@@ -422,6 +525,17 @@ struct device_link *device_link_add(struct device *consumer,
 	link->flags = flags;
 	kref_init(&link->kref);
 
+	link->link_dev.class = &devlink_class;
+	link->link_dev.release = &device_link_dev_release;
+	device_set_pm_not_required(&link->link_dev);
+	dev_set_name(&link->link_dev, "%s:%s",
+		     dev_name(supplier), dev_name(consumer));
+
+	if (device_register(&link->link_dev))
+		goto err_dev_reg;
+	if (devlink_add_symlinks(link))
+		goto err_symlinks;
+
 	/* Determine the initial link state. */
 	if (flags & DL_FLAG_STATELESS)
 		link->status = DL_STATE_NONE;
@@ -466,6 +580,14 @@ struct device_link *device_link_add(struct device *consumer,
 		pm_runtime_put(supplier);
 
 	return link;
+
+err_symlinks:
+	device_unregister(&link->link_dev);
+err_dev_reg:
+	kref_put(&link->kref, __device_link_del);
+	device_pm_unlock();
+	device_links_write_unlock();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(device_link_add);
 
@@ -542,9 +664,7 @@ static void device_link_free(struct device_link *link)
 	while (refcount_dec_not_one(&link->rpm_active))
 		pm_runtime_put(link->supplier);
 
-	put_device(link->consumer);
-	put_device(link->supplier);
-	kfree(link);
+	device_unregister(&link->link_dev);
 }
 
 #ifdef CONFIG_SRCU
@@ -1123,6 +1243,9 @@ static void device_links_purge(struct device *dev)
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

