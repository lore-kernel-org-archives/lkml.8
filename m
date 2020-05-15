Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B10C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9765D206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4Ednklj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgEOFfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbgEOFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:35:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0DC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g15so1497265qvx.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWhO5anUDBUoeZ5ya2LJvLEB+Rih7YqmYbCBAkd+SfU=;
        b=X4EdnkljxZN1gGkqK79onM46/6Tljbkxek8tFeo4vdNLUR45GdlwewfukRIfu8g3q8
         TIBGSWYxorYwfrON38B1GIuSb4UkF9ZDBXvoA+ri3xSzcrgEn5WxPa9NPTk3DmUoTuvq
         1sOn5rFmlP9fDSbh/dJsXyJCEuLArRzQXJwLxZQKu+mBnjOhYjTT5X6CXh/xAprnl+tx
         fQEJ1SrydXkgB/CRKaVCyDBoErO7S1fvMtHG7fMdhyiAKffjMEiF1Uba3huXJTrKODzx
         mSPbHE0fslUYKNFDYZ1lhM07A5s/FFvRStTYSaMkiee4lw9rFYKFNrU1O/NKCizbccc7
         RP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWhO5anUDBUoeZ5ya2LJvLEB+Rih7YqmYbCBAkd+SfU=;
        b=XkiTQXJ1MBJmIrsfxAmED4JSRAPynUkNGOvBtVTwGyXuQhIuYAZL8Qp9BArwb3Smy0
         rwYbGmVS723PIcSuMZAXvIiNnKqbYKHxnKXnpIMOBLJcETnkkRG2OQWcK16LBhK5arT2
         4Q2QEq9d9xcGJqvlCixlO3o5ZFUKMMhB1cCJlHZBeZCPsZgm3uwZjJuufUPRK1yiLpuS
         AETjJU7rAyNjoLfwDtUaUh0z5QV0938aHahgNTAwt2fgQlEUaAqMpcmXCziu1YDw7+qk
         ULibjmNWzW/EOFAgsuhuZ29lVzzODPW+fBKcyeLv0p6C8evfghtKrgidSVJZaMbsqUO8
         bwKQ==
X-Gm-Message-State: AOAM5314Q/oAAkCElQN+VvokQWeHFdIeXZb/TPbUsBjA/6fPbjZcK519
        x/pQZ0Eg5ir+WtTT46Sb8qmdYjpP0ygCwZA=
X-Google-Smtp-Source: ABdhPJzf+yR6toilb6eZvzt8nUDldrlq3UvGr4np2ygHZkdy3MBL8xvEzwokJYuxVbKMuhtzbC8xDJ3p+xEBBx4=
X-Received: by 2002:a0c:e744:: with SMTP id g4mr1872339qvn.55.1589520911303;
 Thu, 14 May 2020 22:35:11 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:59 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 3/4] driver core: fw_devlink: Add support for batching
 fwnode parsing
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amount of time spent parsing fwnodes of devices can become really
high if the devices are added in an non-ideal order. Worst case can be
O(N^2) when N devices are added. But this can be optimized to O(N) by
adding all the devices and then parsing all their fwnodes in one batch.

This commit adds fw_devlink_pause() and fw_devlink_resume() to allow
doing this.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h    |   1 +
 drivers/base/core.c    | 116 ++++++++++++++++++++++++++++++++++++++---
 drivers/base/dd.c      |   8 +++
 include/linux/fwnode.h |   2 +
 4 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 40fb069a8a7e..95c22c0f9036 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -153,6 +153,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void driver_deferred_probe_force_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f585d92e09d0..84c569726d75 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -49,6 +49,9 @@ static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
+static unsigned int defer_fw_devlink_count;
+static DEFINE_MUTEX(defer_fw_devlink_lock);
+static bool fw_devlink_is_permissive(void);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -527,7 +530,7 @@ static void device_link_add_missing_supplier_links(void)
 		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
 		if (!ret)
 			list_del_init(&dev->links.needs_suppliers);
-		else if (ret != -ENODEV)
+		else if (ret != -ENODEV || fw_devlink_is_permissive())
 			dev->links.need_for_probe = false;
 	}
 	mutex_unlock(&wfs_lock);
@@ -1177,17 +1180,116 @@ static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
 
-	device_link_add_missing_supplier_links();
+	if (!fw_devlink_flags)
+		return;
+
+	mutex_lock(&defer_fw_devlink_lock);
+	if (!defer_fw_devlink_count)
+		device_link_add_missing_supplier_links();
+
+	/*
+	 * The device's fwnode not having add_links() doesn't affect if other
+	 * consumers can find this device as a supplier.  So, this check is
+	 * intentionally placed after device_link_add_missing_supplier_links().
+	 */
+	if (!fwnode_has_op(dev->fwnode, add_links))
+		goto out;
 
-	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
+	/*
+	 * If fw_devlink is being deferred, assume all devices have mandatory
+	 * suppliers they need to link to later. Then, when the fw_devlink is
+	 * resumed, all these devices will get a chance to try and link to any
+	 * suppliers they have.
+	 */
+	if (!defer_fw_devlink_count) {
 		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
-			device_link_wait_for_mandatory_supplier(dev);
-		else if (fw_ret)
-			device_link_wait_for_optional_supplier(dev);
+		if (fw_ret == -ENODEV && fw_devlink_is_permissive())
+			fw_ret = -EAGAIN;
+	} else {
+		fw_ret = -ENODEV;
 	}
+
+	if (fw_ret == -ENODEV)
+		device_link_wait_for_mandatory_supplier(dev);
+	else if (fw_ret)
+		device_link_wait_for_optional_supplier(dev);
+
+out:
+	mutex_unlock(&defer_fw_devlink_lock);
 }
 
+/**
+ * fw_devlink_pause - Pause parsing of fwnode to create device links
+ *
+ * Calling this function defers any fwnode parsing to create device links until
+ * fw_devlink_resume() is called. Both these functions are ref counted and the
+ * caller needs to match the calls.
+ *
+ * While fw_devlink is paused:
+ * - Any device that is added won't have its fwnode parsed to create device
+ *   links.
+ * - The probe of the device will also be deferred during this period.
+ * - Any devices that were already added, but waiting for suppliers won't be
+ *   able to link to newly added devices.
+ *
+ * Once fw_devlink_resume():
+ * - All the fwnodes that was not parsed will be parsed.
+ * - All the devices that were deferred probing will be reattempted if they
+ *   aren't waiting for any more suppliers.
+ *
+ * This pair of functions, is mainly meant to optimize the parsing of fwnodes
+ * when a lot of devices that need to link to each other are added in a short
+ * interval of time. For example, adding all the top level devices in a system.
+ *
+ * For example, if N devices are added and:
+ * - All the consumers are added before their suppliers
+ * - All the suppliers of the N devices are part of the N devices
+ *
+ * Then:
+ *
+ * - With the use of fw_devlink_pause() and fw_devlink_resume(), each device
+ *   will only need one parsing of its fwnode because it is guaranteed to find
+ *   all the supplier devices already registered and ready to link to. It won't
+ *   have to do another pass later to find one or more suppliers it couldn't
+ *   find in the first parse of the fwnode. So, we'll only need O(N) fwnode
+ *   parses.
+ *
+ * - Without the use of fw_devlink_pause() and fw_devlink_resume(), we would
+ *   end up doing O(N^2) parses of fwnodes because every device that's added is
+ *   guaranteed to trigger a parse of the fwnode of every device added before
+ *   it. This O(N^2) parse is made worse by the fact that when a fwnode of a
+ *   device is parsed, all it descendant devices might need to have their
+ *   fwnodes parsed too (even if the devices themselves aren't added).
+ */
+void fw_devlink_pause(void)
+{
+	mutex_lock(&defer_fw_devlink_lock);
+	defer_fw_devlink_count++;
+	mutex_unlock(&defer_fw_devlink_lock);
+}
+
+/** fw_devlink_resume - Resume parsing of fwnode to create device links
+ *
+ * This function is used in conjunction with fw_devlink_pause() and is ref
+ * counted. See documentation for fw_devlink_pause() for more details.
+ */
+void fw_devlink_resume(void)
+{
+	mutex_lock(&defer_fw_devlink_lock);
+	if (!defer_fw_devlink_count) {
+		WARN(true, "Unmatched fw_devlink pause/resume!");
+		goto out;
+	}
+
+	defer_fw_devlink_count--;
+	if (defer_fw_devlink_count)
+		goto out;
+
+	device_link_add_missing_supplier_links();
+	driver_deferred_probe_force_trigger();
+out:
+	mutex_unlock(&defer_fw_devlink_lock);
+}
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 48ca81cb8ebc..63991d97adcc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -160,6 +160,14 @@ static bool driver_deferred_probe_enable = false;
  * again.
  */
 static void driver_deferred_probe_trigger(void)
+{
+	if (!driver_deferred_probe_enable)
+		return;
+
+	driver_deferred_probe_force_trigger();
+}
+
+void driver_deferred_probe_force_trigger(void)
 {
 	if (!driver_deferred_probe_enable)
 		return;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index e0abafbb17f8..9506f8ec0974 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -171,5 +171,7 @@ struct fwnode_operations {
 #define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
 extern u32 fw_devlink_get_flags(void);
+void fw_devlink_pause(void);
+void fw_devlink_resume(void);
 
 #endif
-- 
2.26.2.761.g0e0b3e54be-goog

