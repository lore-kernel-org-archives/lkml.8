Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B33208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCIPyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:45816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCIPyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD0C1AE84;
        Mon,  9 Mar 2020 15:54:46 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen/xenbus: remove unused xenbus_map_ring()
Date:   Mon,  9 Mar 2020 16:54:41 +0100
Message-Id: <20200309155441.30997-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xenbus_map_ring() is used nowhere in the tree, remove it.
xenbus_unmap_ring() is used only locally, so make it static and move it
up.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_client.c | 126 +++++++++++++------------------------
 include/xen/xenbus.h               |   7 ---
 2 files changed, 42 insertions(+), 91 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 77905b08a343..99a8343a90b9 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -523,6 +523,48 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 	return err;
 }
 
+/**
+ * xenbus_unmap_ring
+ * @dev: xenbus device
+ * @handles: grant handle array
+ * @nr_handles: number of handles in the array
+ * @vaddrs: addresses to unmap
+ *
+ * Unmap memory in this domain that was imported from another domain.
+ * Returns 0 on success and returns GNTST_* on error
+ * (see xen/include/interface/grant_table.h).
+ */
+static int xenbus_unmap_ring(struct xenbus_device *dev, grant_handle_t *handles,
+			     unsigned int nr_handles, unsigned long *vaddrs)
+{
+	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
+	int i;
+	int err;
+
+	if (nr_handles > XENBUS_MAX_RING_GRANTS)
+		return -EINVAL;
+
+	for (i = 0; i < nr_handles; i++)
+		gnttab_set_unmap_op(&unmap[i], vaddrs[i],
+				    GNTMAP_host_map, handles[i]);
+
+	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, i))
+		BUG();
+
+	err = GNTST_okay;
+	for (i = 0; i < nr_handles; i++) {
+		if (unmap[i].status != GNTST_okay) {
+			xenbus_dev_error(dev, unmap[i].status,
+					 "unmapping page at handle %d error %d",
+					 handles[i], unmap[i].status);
+			err = unmap[i].status;
+			break;
+		}
+	}
+
+	return err;
+}
+
 struct map_ring_valloc_hvm
 {
 	unsigned int idx;
@@ -614,45 +656,6 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 	return err;
 }
 
-
-/**
- * xenbus_map_ring
- * @dev: xenbus device
- * @gnt_refs: grant reference array
- * @nr_grefs: number of grant reference
- * @handles: pointer to grant handle to be filled
- * @vaddrs: addresses to be mapped to
- * @leaked: fail to clean up a failed map, caller should not free vaddr
- *
- * Map pages of memory into this domain from another domain's grant table.
- * xenbus_map_ring does not allocate the virtual address space (you must do
- * this yourself!). It only maps in the pages to the specified address.
- * Returns 0 on success, and GNTST_* (see xen/include/interface/grant_table.h)
- * or -ENOMEM / -EINVAL on error. If an error is returned, device will switch to
- * XenbusStateClosing and the first error message will be saved in XenStore.
- * Further more if we fail to map the ring, caller should check @leaked.
- * If @leaked is not zero it means xenbus_map_ring fails to clean up, caller
- * should not free the address space of @vaddr.
- */
-int xenbus_map_ring(struct xenbus_device *dev, grant_ref_t *gnt_refs,
-		    unsigned int nr_grefs, grant_handle_t *handles,
-		    unsigned long *vaddrs, bool *leaked)
-{
-	phys_addr_t phys_addrs[XENBUS_MAX_RING_GRANTS];
-	int i;
-
-	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
-		return -EINVAL;
-
-	for (i = 0; i < nr_grefs; i++)
-		phys_addrs[i] = (unsigned long)vaddrs[i];
-
-	return __xenbus_map_ring(dev, gnt_refs, nr_grefs, handles,
-				 phys_addrs, GNTMAP_host_map, leaked);
-}
-EXPORT_SYMBOL_GPL(xenbus_map_ring);
-
-
 /**
  * xenbus_unmap_ring_vfree
  * @dev: xenbus device
@@ -864,51 +867,6 @@ static int xenbus_unmap_ring_vfree_hvm(struct xenbus_device *dev, void *vaddr)
 	return rv;
 }
 
-/**
- * xenbus_unmap_ring
- * @dev: xenbus device
- * @handles: grant handle array
- * @nr_handles: number of handles in the array
- * @vaddrs: addresses to unmap
- *
- * Unmap memory in this domain that was imported from another domain.
- * Returns 0 on success and returns GNTST_* on error
- * (see xen/include/interface/grant_table.h).
- */
-int xenbus_unmap_ring(struct xenbus_device *dev,
-		      grant_handle_t *handles, unsigned int nr_handles,
-		      unsigned long *vaddrs)
-{
-	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
-	int i;
-	int err;
-
-	if (nr_handles > XENBUS_MAX_RING_GRANTS)
-		return -EINVAL;
-
-	for (i = 0; i < nr_handles; i++)
-		gnttab_set_unmap_op(&unmap[i], vaddrs[i],
-				    GNTMAP_host_map, handles[i]);
-
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, i))
-		BUG();
-
-	err = GNTST_okay;
-	for (i = 0; i < nr_handles; i++) {
-		if (unmap[i].status != GNTST_okay) {
-			xenbus_dev_error(dev, unmap[i].status,
-					 "unmapping page at handle %d error %d",
-					 handles[i], unmap[i].status);
-			err = unmap[i].status;
-			break;
-		}
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(xenbus_unmap_ring);
-
-
 /**
  * xenbus_read_driver_state
  * @path: path for driver
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 850a43bd69d3..8c0d1edc121c 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -209,15 +209,8 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 		      unsigned int nr_pages, grant_ref_t *grefs);
 int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 			   unsigned int nr_grefs, void **vaddr);
-int xenbus_map_ring(struct xenbus_device *dev,
-		    grant_ref_t *gnt_refs, unsigned int nr_grefs,
-		    grant_handle_t *handles, unsigned long *vaddrs,
-		    bool *leaked);
 
 int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr);
-int xenbus_unmap_ring(struct xenbus_device *dev,
-		      grant_handle_t *handles, unsigned int nr_handles,
-		      unsigned long *vaddrs);
 
 int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
 int xenbus_free_evtchn(struct xenbus_device *dev, int port);
-- 
2.16.4

