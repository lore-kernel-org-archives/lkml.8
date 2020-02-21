Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FCC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE4206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMsmaYKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgBUIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:45:56 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:60337 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgBUHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:45 -0500
Received: by mail-pj1-f74.google.com with SMTP id z5so498007pjq.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y7uM3w77h2Gn0yEivNMhyewHaqjCcqiwBI+mwPIiJHs=;
        b=mMsmaYKZyOgfxwfcOwYdJ2ReONJjt8mM0r6AXOMXja/R2IRChUNdp94NPI6lmzReEx
         BFzSbHQ72mSIJxAPQsSVz1kRxHRpLs3HNbXjNd6khqX7+Mjg3OxP8ZGguXksSnXT/waV
         Uh2yf30YkA7GYVQjErpdmOX2z2HQ/k0drAQ7CpuFYdciiAzjfUNK4ZWfYceLujMbIiKP
         EI32HujwIYSsx3PuyFLjIifzfAWgDRV5F1uwy6pwvw0KTyTwvTZRV+nPdisf8tIeoFNh
         vjhBCGH7/hHdLLsOSEPtdqTibT6c+BAF3DeNZLWmo8vEd6jAmXm73I3gNwKRGSK61x0Y
         RCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y7uM3w77h2Gn0yEivNMhyewHaqjCcqiwBI+mwPIiJHs=;
        b=boOYhA7svv+nbYttij5KIa+IQj7gm61BJFtyjSZum0AU9su45MoknYw6M2kK+gM9Dd
         5nhFZ2/hwcRIpAUCYeS6SBo5Rytvba61PTgqrAjAZ8zilt9g9C2JqSVBjoZPhfg6XSxM
         aJHceUX8AJXhFWgXS5G88vK3I1hVvFSQvUf0rNmkiUKIHUKzDc+gg3f97TrailnJ1WwD
         rScT1mRj0QjTnRamZ+Akr0JjgVEtZJeHNrVHQmU4mx47FPsF1CTBaBy+EGnYWWKXXw6U
         j26BV3x/nvYhG3zj2Wp8lCfzZBoh+MciWBfyKMTq5cjeux4WWQIJ/ZD3lndKZ7q//SUl
         u+WA==
X-Gm-Message-State: APjAAAVSxQO02jws55njKMT7MpK/t4wnx7HDHc4u+ZawGlFcUOPvyuMa
        KH3gOIYmI0dmZ3+/lQ5mRG1dVqJI5DnuvZU=
X-Google-Smtp-Source: APXvYqwvn0TRoYG5IVsuf8uE6IYzDa/7iWpibKKcHNtYS1Io3OaX4OCU9hjgP/VmyC2CsgX/iEqv9AGlkn/DXog=
X-Received: by 2002:a63:354b:: with SMTP id c72mr32817161pga.99.1582271443680;
 Thu, 20 Feb 2020 23:50:43 -0800 (PST)
Date:   Thu, 20 Feb 2020 23:50:34 -0800
In-Reply-To: <20200221075036.181885-1-saravanak@google.com>
Message-Id: <20200221075036.181885-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200221075036.181885-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 1/3] driver core: Call sync_state() even if supplier has no consumers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial patch that added sync_state() support didn't handle the case
where a supplier has no consumers. This was because when a device is
successfully bound with a driver, only its suppliers were checked to see
if they are eligible to get a sync_state(). This is not sufficient for
devices that have no consumers but still need to do device state clean
up. So fix this.

Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 42a672456432..3306d5ae92a6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -745,25 +745,31 @@ static void __device_links_queue_sync_state(struct device *dev,
 /**
  * device_links_flush_sync_list - Call sync_state() on a list of devices
  * @list: List of devices to call sync_state() on
+ * @dont_lock_dev: Device for which lock is already held by the caller
  *
  * Calls sync_state() on all the devices that have been queued for it. This
- * function is used in conjunction with __device_links_queue_sync_state().
+ * function is used in conjunction with __device_links_queue_sync_state(). The
+ * @dont_lock_dev parameter is useful when this function is called from a
+ * context where a device lock is already held.
  */
-static void device_links_flush_sync_list(struct list_head *list)
+static void device_links_flush_sync_list(struct list_head *list,
+					 struct device *dont_lock_dev)
 {
 	struct device *dev, *tmp;
 
 	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
 		list_del_init(&dev->links.defer_sync);
 
-		device_lock(dev);
+		if (dev != dont_lock_dev)
+			device_lock(dev);
 
 		if (dev->bus->sync_state)
 			dev->bus->sync_state(dev);
 		else if (dev->driver && dev->driver->sync_state)
 			dev->driver->sync_state(dev);
 
-		device_unlock(dev);
+		if (dev != dont_lock_dev)
+			device_unlock(dev);
 
 		put_device(dev);
 	}
@@ -801,7 +807,7 @@ void device_links_supplier_sync_state_resume(void)
 out:
 	device_links_write_unlock();
 
-	device_links_flush_sync_list(&sync_list);
+	device_links_flush_sync_list(&sync_list, NULL);
 }
 
 static int sync_state_resume_initcall(void)
@@ -865,6 +871,11 @@ void device_links_driver_bound(struct device *dev)
 			driver_deferred_probe_add(link->consumer);
 	}
 
+	if (defer_sync_state_count)
+		__device_links_supplier_defer_sync(dev);
+	else
+		__device_links_queue_sync_state(dev, &sync_list);
+
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
 		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
@@ -883,7 +894,7 @@ void device_links_driver_bound(struct device *dev)
 
 	device_links_write_unlock();
 
-	device_links_flush_sync_list(&sync_list);
+	device_links_flush_sync_list(&sync_list, dev);
 }
 
 static void device_link_drop_managed(struct device_link *link)
-- 
2.25.0.265.gbab2e86ba0-goog

