Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CEBC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B4E20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420489;
	bh=tVsq6tAoJsobQNAWBk/5/5TNk+DY1mLqE8x5VMYbhB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXVPJK86SUd3Bgd4iBGs+5lEoc5RRSA0E7Qaj8hFUlRSjNIq41ilLIv1TWVsF+M5N
	 Cqch3uOunl0zckglJaQXyYHk5/LgNjyfGpttuNJTYgEEnx2ex+iClcYW6eev1jfxJT
	 GDJPxxuVa9bu4AJGyohcM7bSWF3jGKuqqTjo296c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGJWes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgGJWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:34 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953A52075D;
        Fri, 10 Jul 2020 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420473;
        bh=tVsq6tAoJsobQNAWBk/5/5TNk+DY1mLqE8x5VMYbhB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZaN8eitbLqQ3J1ffz011jaKi3evRotLPxTsAhAIMsFZsKmo4aMSEidGK3Ax57dr8
         hmq/KjEwIB8hP27Vl7Lnf9UMu23pRsMzy/xdemNKoa6Z/m34WRSM87zQKHL9kWPHMf
         sm0IMJ0E4d5DXQm6FTAO197SQvMUxLc4AmXdGoaU=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v3 10/11] xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
Date:   Fri, 10 Jul 2020 15:34:26 -0700
Message-Id: <20200710223427.6897-10-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

xen_dma_sync_for_cpu, xen_dma_sync_for_device, xen_arch_need_swiotlb are
getting called passing dma addresses. On some platforms dma addresses
could be different from physical addresses. Before doing any operations
on these addresses we need to convert them back to physical addresses
using dma_to_phys.

Move the arch_sync_dma_for_cpu and arch_sync_dma_for_device calls from
xen_dma_sync_for_cpu/device to swiotlb-xen.c, and add a call dma_to_phys
to do address translations there.

dma_cache_maint is fixed by the next patch.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>

---
Changes in v2:
- improve commit message
- don't use pfn_valid

Changes in v3:
- move arch_sync_dma_for_cpu/device calls to swiotlb-xen.c
---
 arch/arm/xen/mm.c         | 17 ++++++-----------
 drivers/xen/swiotlb-xen.c | 32 ++++++++++++++++++++++++--------
 include/xen/swiotlb-xen.h |  6 ++----
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f2414ea40a79..a8251a70f442 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/cpu.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -72,22 +73,16 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
  * dma-direct functions, otherwise we call the Xen specific version.
  */
 void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
-			  phys_addr_t paddr, size_t size,
-			  enum dma_data_direction dir)
+			  size_t size, enum dma_data_direction dir)
 {
-	if (pfn_valid(PFN_DOWN(handle)))
-		arch_sync_dma_for_cpu(paddr, size, dir);
-	else if (dir != DMA_TO_DEVICE)
+	if (dir != DMA_TO_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 }
 
 void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
-			     phys_addr_t paddr, size_t size,
-			     enum dma_data_direction dir)
+			     size_t size, enum dma_data_direction dir)
 {
-	if (pfn_valid(PFN_DOWN(handle)))
-		arch_sync_dma_for_device(paddr, size, dir);
-	else if (dir == DMA_FROM_DEVICE)
+	if (dir == DMA_FROM_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 	else
 		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
@@ -98,7 +93,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 			   dma_addr_t dev_addr)
 {
 	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
-	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
+	unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
 
 	/*
 	 * The swiotlb buffer should be used if
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a6a95358a8cb..39a0f2e0847c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -413,8 +413,12 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	}
 
 done:
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xen_dma_sync_for_device(dev, dev_addr, phys, size, dir);
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))))
+			arch_sync_dma_for_device(phys, size, dir);
+		else
+			xen_dma_sync_for_device(dev, dev_addr, size, dir);
+	}
 	return dev_addr;
 }
 
@@ -433,8 +437,12 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xen_dma_sync_for_cpu(hwdev, dev_addr, paddr, size, dir);
+	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
+			arch_sync_dma_for_cpu(paddr, size, dir);
+		else
+			xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
+	}
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
@@ -447,8 +455,12 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
-	if (!dev_is_dma_coherent(dev))
-		xen_dma_sync_for_cpu(dev, dma_addr, paddr, size, dir);
+	if (!dev_is_dma_coherent(dev)) {
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+			arch_sync_dma_for_cpu(paddr, size, dir);
+		else
+			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
+	}
 
 	if (is_xen_swiotlb_buffer(dev, dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
@@ -463,8 +475,12 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 	if (is_xen_swiotlb_buffer(dev, dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
-	if (!dev_is_dma_coherent(dev))
-		xen_dma_sync_for_device(dev, dma_addr, paddr, size, dir);
+	if (!dev_is_dma_coherent(dev)) {
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+			arch_sync_dma_for_device(paddr, size, dir);
+		else
+			xen_dma_sync_for_device(dev, dma_addr, size, dir);
+	}
 }
 
 /*
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 6d235fe2b92d..d5eaf9d682b8 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -5,11 +5,9 @@
 #include <linux/swiotlb.h>
 
 void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
-			  phys_addr_t paddr, size_t size,
-			  enum dma_data_direction dir);
+			  size_t size, enum dma_data_direction dir);
 void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
-			     phys_addr_t paddr, size_t size,
-			     enum dma_data_direction dir);
+			     size_t size, enum dma_data_direction dir);
 
 extern int xen_swiotlb_init(int verbose, bool early);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
-- 
2.17.1

