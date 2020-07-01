Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D9820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgGAMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:16:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:34620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgGAMQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:16:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FE32ADE2;
        Wed,  1 Jul 2020 12:16:42 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 2/2] xen/xenbus: let xenbus_map_ring_valloc() return errno values only
Date:   Wed,  1 Jul 2020 14:16:38 +0200
Message-Id: <20200701121638.19840-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701121638.19840-1-jgross@suse.com>
References: <20200701121638.19840-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today xenbus_map_ring_valloc() can return either a negative errno
value (-ENOMEM or -EINVAL) or a grant status value. This is a mess as
e.g -ENOMEM and GNTST_eagain have the same numeric value.

Fix that by turning all grant mapping errors into -ENOENT. This is
no problem as all callers of xenbus_map_ring_valloc() only use the
return value to print an error message, and in case of mapping errors
the grant status value has already been printed by __xenbus_map_ring()
before.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/xenbus/xenbus_client.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 9f8372079ecf..4f168b46fbca 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -456,8 +456,7 @@ EXPORT_SYMBOL_GPL(xenbus_free_evtchn);
  * Map @nr_grefs pages of memory into this domain from another
  * domain's grant table.  xenbus_map_ring_valloc allocates @nr_grefs
  * pages of virtual address space, maps the pages to that address, and
- * sets *vaddr to that address.  Returns 0 on success, and GNTST_*
- * (see xen/include/interface/grant_table.h) or -ENOMEM / -EINVAL on
+ * sets *vaddr to that address.  Returns 0 on success, and -errno on
  * error. If an error is returned, device will switch to
  * XenbusStateClosing and the error message will be saved in XenStore.
  */
@@ -477,18 +476,11 @@ int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 		return -ENOMEM;
 
 	info->node = kzalloc(sizeof(*info->node), GFP_KERNEL);
-	if (!info->node) {
+	if (!info->node)
 		err = -ENOMEM;
-		goto out;
-	}
-
-	err = ring_ops->map(dev, info, gnt_refs, nr_grefs, vaddr);
-
-	/* Some hypervisors are buggy and can return 1. */
-	if (err > 0)
-		err = GNTST_general_error;
+	else
+		err = ring_ops->map(dev, info, gnt_refs, nr_grefs, vaddr);
 
- out:
 	kfree(info->node);
 	kfree(info);
 	return err;
@@ -507,7 +499,6 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			     bool *leaked)
 {
 	int i, j;
-	int err = GNTST_okay;
 
 	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
 		return -EINVAL;
@@ -522,7 +513,6 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 
 	for (i = 0; i < nr_grefs; i++) {
 		if (info->map[i].status != GNTST_okay) {
-			err = info->map[i].status;
 			xenbus_dev_fatal(dev, info->map[i].status,
 					 "mapping in shared page %d from domain %d",
 					 gnt_refs[i], dev->otherend_id);
@@ -531,7 +521,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			handles[i] = info->map[i].handle;
 	}
 
-	return GNTST_okay;
+	return 0;
 
  fail:
 	for (i = j = 0; i < nr_grefs; i++) {
@@ -554,7 +544,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		}
 	}
 
-	return err;
+	return -ENOENT;
 }
 
 /**
-- 
2.26.2

