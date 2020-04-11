Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19858C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC50720753
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDKNcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:32:04 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:23549 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 09:32:03 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d41 with ME
        id RRXz2200m0scBcy03RY00n; Sat, 11 Apr 2020 15:32:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 15:32:01 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] driver core: Add missing '\n' in log messages
Date:   Sat, 11 Apr 2020 15:31:58 +0200
Message-Id: <20200411133158.27390-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

While at it, convert some "printk(KERN_" into equivalent but less verbose
(pr|dev)_xxx functions.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Some pr_xxx may be simplified using dev_xxx
---
 drivers/base/dd.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 06ec0e851fa1..efe6df5bff26 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -262,12 +262,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 int driver_deferred_probe_check_state(struct device *dev)
 {
 	if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done) {
-		dev_warn(dev, "ignoring dependency for device, assuming no driver");
+		dev_warn(dev, "ignoring dependency for device, assuming no driver\n");
 		return -ENODEV;
 	}
 
 	if (!driver_deferred_probe_timeout) {
-		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+		dev_WARN(dev, "deferred probe timeout, ignoring dependency\n");
 		return -ETIMEDOUT;
 	}
 
@@ -283,7 +283,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 	flush_work(&deferred_probe_work);
 
 	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
-		dev_info(private->device, "deferred probe pending");
+		dev_info(private->device, "deferred probe pending\n");
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
@@ -343,7 +343,7 @@ bool device_is_bound(struct device *dev)
 static void driver_bound(struct device *dev)
 {
 	if (device_is_bound(dev)) {
-		printk(KERN_WARNING "%s: device %s already bound\n",
+		pr_warn("%s: device %s already bound\n",
 			__func__, kobject_name(&dev->kobj));
 		return;
 	}
@@ -512,8 +512,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	}
 
 	if (driver_sysfs_add(dev)) {
-		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
-			__func__, dev_name(dev));
+		pr_err("%s: driver_sysfs_add(%s) failed\n",
+		       __func__, dev_name(dev));
 		goto probe_failed;
 	}
 
@@ -604,9 +604,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		break;
 	default:
 		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev_name(dev), ret);
+		pr_warn("%s: probe of %s failed with error %d\n",
+			drv->name, dev_name(dev), ret);
 	}
 	/*
 	 * Ignore errors returned by ->probe so that the next driver can try
@@ -631,8 +630,8 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
-	       dev_name(dev), ret, (s64) ktime_to_us(delta));
+	pr_debug("probe of %s returned %d after %lld usecs\n",
+		 dev_name(dev), ret, (s64) ktime_to_us(delta));
 	return ret;
 }
 
@@ -717,8 +716,7 @@ static inline bool cmdline_requested_async_probing(const char *drv_name)
 static int __init save_async_options(char *buf)
 {
 	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
-		printk(KERN_WARNING
-			"Too long list of driver names for 'driver_async_probe'!\n");
+		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
 
 	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
 	return 0;
@@ -793,7 +791,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
-		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		return ret;
 	} /* ret > 0 means positive match */
 
@@ -1026,7 +1024,7 @@ static int __driver_attach(struct device *dev, void *data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
-		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		return ret;
 	} /* ret > 0 means positive match */
 
-- 
2.20.1

