Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA2CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2991D2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCEKD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:03:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEKD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:03:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D629B23A;
        Thu,  5 Mar 2020 10:03:25 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen/xenbus: fix locking
Date:   Thu,  5 Mar 2020 11:03:23 +0100
Message-Id: <20200305100323.16736-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 060eabe8fbe726 ("xenbus/backend: Protect xenbus callback with
lock") introduced a bug by holding a lock while calling a function
which might schedule.

Fix that by using a semaphore instead.

Fixes: 060eabe8fbe726 ("xenbus/backend: Protect xenbus callback with lock")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_probe.c         | 10 +++++-----
 drivers/xen/xenbus/xenbus_probe_backend.c |  5 +++--
 include/xen/xenbus.h                      |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 66975da4f3b6..8c4d05b687b7 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -239,9 +239,9 @@ int xenbus_dev_probe(struct device *_dev)
 		goto fail;
 	}
 
-	spin_lock(&dev->reclaim_lock);
+	down(&dev->reclaim_sem);
 	err = drv->probe(dev, id);
-	spin_unlock(&dev->reclaim_lock);
+	up(&dev->reclaim_sem);
 	if (err)
 		goto fail_put;
 
@@ -271,9 +271,9 @@ int xenbus_dev_remove(struct device *_dev)
 	free_otherend_watch(dev);
 
 	if (drv->remove) {
-		spin_lock(&dev->reclaim_lock);
+		down(&dev->reclaim_sem);
 		drv->remove(dev);
-		spin_unlock(&dev->reclaim_lock);
+		up(&dev->reclaim_sem);
 	}
 
 	module_put(drv->driver.owner);
@@ -473,7 +473,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 		goto fail;
 
 	dev_set_name(&xendev->dev, "%s", devname);
-	spin_lock_init(&xendev->reclaim_lock);
+	sema_init(&xendev->reclaim_sem, 1);
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 791f6fe01e91..9b2fbe69bccc 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -45,6 +45,7 @@
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/export.h>
+#include <linux/semaphore.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -257,10 +258,10 @@ static int backend_reclaim_memory(struct device *dev, void *data)
 	drv = to_xenbus_driver(dev->driver);
 	if (drv && drv->reclaim_memory) {
 		xdev = to_xenbus_device(dev);
-		if (!spin_trylock(&xdev->reclaim_lock))
+		if (down_trylock(&xdev->reclaim_sem))
 			return 0;
 		drv->reclaim_memory(xdev);
-		spin_unlock(&xdev->reclaim_lock);
+		up(&xdev->reclaim_sem);
 	}
 	return 0;
 }
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 89a889585ba0..850a43bd69d3 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -42,6 +42,7 @@
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/semaphore.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/grant_table.h>
 #include <xen/interface/io/xenbus.h>
@@ -76,7 +77,7 @@ struct xenbus_device {
 	enum xenbus_state state;
 	struct completion down;
 	struct work_struct work;
-	spinlock_t reclaim_lock;
+	struct semaphore reclaim_sem;
 };
 
 static inline struct xenbus_device *to_xenbus_device(struct device *dev)
-- 
2.16.4

