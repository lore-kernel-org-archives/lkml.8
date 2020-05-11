Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE603C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D349E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEKHb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:31:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgEKHb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:31:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0575AC5B;
        Mon, 11 May 2020 07:31:56 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] xen/xenbus: avoid large structs and arrays on the stack
Date:   Mon, 11 May 2020 09:31:50 +0200
Message-Id: <20200511073151.19043-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200511073151.19043-1-jgross@suse.com>
References: <20200511073151.19043-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xenbus_map_ring_valloc() and its sub-functions are putting quite large
structs and arrays on the stack. This is problematic at runtime, but
might also result in build failures (e.g. with clang due to the option
-Werror,-Wframe-larger-than=... used).

Fix that by moving most of the data from the stack into a dynamically
allocated struct. Performance is no issue here, as
xenbus_map_ring_valloc() is used only when adding a new PV device to
a backend driver.

While at it move some duplicated code from pv/hvm specific mapping
functions to the single caller.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_client.c | 127 +++++++++++++++--------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 040d2a43e8e3..d8e5c5e4fa67 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -69,11 +69,27 @@ struct xenbus_map_node {
 	unsigned int   nr_handles;
 };
 
+struct map_ring_valloc {
+	struct xenbus_map_node *node;
+
+	/* Why do we need two arrays? See comment of __xenbus_map_ring */
+	union {
+		unsigned long addrs[XENBUS_MAX_RING_GRANTS];
+		pte_t *ptes[XENBUS_MAX_RING_GRANTS];
+	};
+	phys_addr_t phys_addrs[XENBUS_MAX_RING_GRANTS];
+
+	struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
+	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
+
+	unsigned int idx;	/* HVM only. */
+};
+
 static DEFINE_SPINLOCK(xenbus_valloc_lock);
 static LIST_HEAD(xenbus_valloc_pages);
 
 struct xenbus_ring_ops {
-	int (*map)(struct xenbus_device *dev,
+	int (*map)(struct xenbus_device *dev, struct map_ring_valloc *info,
 		   grant_ref_t *gnt_refs, unsigned int nr_grefs,
 		   void **vaddr);
 	int (*unmap)(struct xenbus_device *dev, void *vaddr);
@@ -449,12 +465,32 @@ int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 			   unsigned int nr_grefs, void **vaddr)
 {
 	int err;
+	struct map_ring_valloc *info;
+
+	*vaddr = NULL;
+
+	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
+		return -EINVAL;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->node = kzalloc(sizeof(*info->node), GFP_KERNEL);
+	if (!info->node) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = ring_ops->map(dev, info, gnt_refs, nr_grefs, vaddr);
 
-	err = ring_ops->map(dev, gnt_refs, nr_grefs, vaddr);
 	/* Some hypervisors are buggy and can return 1. */
 	if (err > 0)
 		err = GNTST_general_error;
 
+ out:
+	kfree(info->node);
+	kfree(info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_map_ring_valloc);
@@ -466,12 +502,10 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			     grant_ref_t *gnt_refs,
 			     unsigned int nr_grefs,
 			     grant_handle_t *handles,
-			     phys_addr_t *addrs,
+			     struct map_ring_valloc *info,
 			     unsigned int flags,
 			     bool *leaked)
 {
-	struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
-	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
 	int i, j;
 	int err = GNTST_okay;
 
@@ -479,23 +513,22 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		return -EINVAL;
 
 	for (i = 0; i < nr_grefs; i++) {
-		memset(&map[i], 0, sizeof(map[i]));
-		gnttab_set_map_op(&map[i], addrs[i], flags, gnt_refs[i],
-				  dev->otherend_id);
+		gnttab_set_map_op(&info->map[i], info->phys_addrs[i], flags,
+				  gnt_refs[i], dev->otherend_id);
 		handles[i] = INVALID_GRANT_HANDLE;
 	}
 
-	gnttab_batch_map(map, i);
+	gnttab_batch_map(info->map, i);
 
 	for (i = 0; i < nr_grefs; i++) {
-		if (map[i].status != GNTST_okay) {
-			err = map[i].status;
-			xenbus_dev_fatal(dev, map[i].status,
+		if (info->map[i].status != GNTST_okay) {
+			err = info->map[i].status;
+			xenbus_dev_fatal(dev, info->map[i].status,
 					 "mapping in shared page %d from domain %d",
 					 gnt_refs[i], dev->otherend_id);
 			goto fail;
 		} else
-			handles[i] = map[i].handle;
+			handles[i] = info->map[i].handle;
 	}
 
 	return GNTST_okay;
@@ -503,19 +536,19 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
  fail:
 	for (i = j = 0; i < nr_grefs; i++) {
 		if (handles[i] != INVALID_GRANT_HANDLE) {
-			memset(&unmap[j], 0, sizeof(unmap[j]));
-			gnttab_set_unmap_op(&unmap[j], (phys_addr_t)addrs[i],
+			gnttab_set_unmap_op(&info->unmap[j],
+					    info->phys_addrs[i],
 					    GNTMAP_host_map, handles[i]);
 			j++;
 		}
 	}
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, j))
+	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, info->unmap, j))
 		BUG();
 
 	*leaked = false;
 	for (i = 0; i < j; i++) {
-		if (unmap[i].status != GNTST_okay) {
+		if (info->unmap[i].status != GNTST_okay) {
 			*leaked = true;
 			break;
 		}
@@ -566,21 +599,12 @@ static int xenbus_unmap_ring(struct xenbus_device *dev, grant_handle_t *handles,
 	return err;
 }
 
-struct map_ring_valloc_hvm
-{
-	unsigned int idx;
-
-	/* Why do we need two arrays? See comment of __xenbus_map_ring */
-	phys_addr_t phys_addrs[XENBUS_MAX_RING_GRANTS];
-	unsigned long addrs[XENBUS_MAX_RING_GRANTS];
-};
-
 static void xenbus_map_ring_setup_grant_hvm(unsigned long gfn,
 					    unsigned int goffset,
 					    unsigned int len,
 					    void *data)
 {
-	struct map_ring_valloc_hvm *info = data;
+	struct map_ring_valloc *info = data;
 	unsigned long vaddr = (unsigned long)gfn_to_virt(gfn);
 
 	info->phys_addrs[info->idx] = vaddr;
@@ -590,38 +614,27 @@ static void xenbus_map_ring_setup_grant_hvm(unsigned long gfn,
 }
 
 static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
+				      struct map_ring_valloc *info,
 				      grant_ref_t *gnt_ref,
 				      unsigned int nr_grefs,
 				      void **vaddr)
 {
-	struct xenbus_map_node *node;
+	struct xenbus_map_node *node = info->node;
 	int err;
 	void *addr;
 	bool leaked = false;
-	struct map_ring_valloc_hvm info = {
-		.idx = 0,
-	};
 	unsigned int nr_pages = XENBUS_PAGES(nr_grefs);
 
-	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
-		return -EINVAL;
-
-	*vaddr = NULL;
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
 	err = alloc_xenballooned_pages(nr_pages, node->hvm.pages);
 	if (err)
 		goto out_err;
 
 	gnttab_foreach_grant(node->hvm.pages, nr_grefs,
 			     xenbus_map_ring_setup_grant_hvm,
-			     &info);
+			     info);
 
 	err = __xenbus_map_ring(dev, gnt_ref, nr_grefs, node->handles,
-				info.phys_addrs, GNTMAP_host_map, &leaked);
+				info, GNTMAP_host_map, &leaked);
 	node->nr_handles = nr_grefs;
 
 	if (err)
@@ -641,11 +654,13 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 	spin_unlock(&xenbus_valloc_lock);
 
 	*vaddr = addr;
+	info->node = NULL;
+
 	return 0;
 
  out_xenbus_unmap_ring:
 	if (!leaked)
-		xenbus_unmap_ring(dev, node->handles, nr_grefs, info.addrs);
+		xenbus_unmap_ring(dev, node->handles, nr_grefs, info->addrs);
 	else
 		pr_alert("leaking %p size %u page(s)",
 			 addr, nr_pages);
@@ -653,7 +668,6 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 	if (!leaked)
 		free_xenballooned_pages(nr_pages, node->hvm.pages);
  out_err:
-	kfree(node);
 	return err;
 }
 
@@ -677,39 +691,29 @@ EXPORT_SYMBOL_GPL(xenbus_unmap_ring_vfree);
 
 #ifdef CONFIG_XEN_PV
 static int xenbus_map_ring_valloc_pv(struct xenbus_device *dev,
+				     struct map_ring_valloc *info,
 				     grant_ref_t *gnt_refs,
 				     unsigned int nr_grefs,
 				     void **vaddr)
 {
-	struct xenbus_map_node *node;
+	struct xenbus_map_node *node = info->node;
 	struct vm_struct *area;
-	pte_t *ptes[XENBUS_MAX_RING_GRANTS];
-	phys_addr_t phys_addrs[XENBUS_MAX_RING_GRANTS];
 	int err = GNTST_okay;
 	int i;
 	bool leaked;
 
-	*vaddr = NULL;
-
-	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
-		return -EINVAL;
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	area = alloc_vm_area(XEN_PAGE_SIZE * nr_grefs, ptes);
+	area = alloc_vm_area(XEN_PAGE_SIZE * nr_grefs, info->ptes);
 	if (!area) {
 		kfree(node);
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < nr_grefs; i++)
-		phys_addrs[i] = arbitrary_virt_to_machine(ptes[i]).maddr;
+		info->phys_addrs[i] =
+			arbitrary_virt_to_machine(info->ptes[i]).maddr;
 
 	err = __xenbus_map_ring(dev, gnt_refs, nr_grefs, node->handles,
-				phys_addrs,
-				GNTMAP_host_map | GNTMAP_contains_pte,
+				info, GNTMAP_host_map | GNTMAP_contains_pte,
 				&leaked);
 	if (err)
 		goto failed;
@@ -722,6 +726,8 @@ static int xenbus_map_ring_valloc_pv(struct xenbus_device *dev,
 	spin_unlock(&xenbus_valloc_lock);
 
 	*vaddr = area->addr;
+	info->node = NULL;
+
 	return 0;
 
 failed:
@@ -730,7 +736,6 @@ static int xenbus_map_ring_valloc_pv(struct xenbus_device *dev,
 	else
 		pr_alert("leaking VM area %p size %u page(s)", area, nr_grefs);
 
-	kfree(node);
 	return err;
 }
 
-- 
2.26.1

