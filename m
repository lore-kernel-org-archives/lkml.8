Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92831C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C11C2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018351;
	bh=BdtSeWgXsb31UNe8YibrIGXB2m1r+NP2vHy9sK75VrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8KFBjubrqf1rQ2YvI9UeWitFFe6Tt+V4j8mxnm/Z59idvy9Bh4VmcIA9Dt28/P4n
	 PMNkOi/WC5l4/7XJE99uipviGEk4XOkXiu8qH/KvhelkDFlvrdazN6ZJXWikUJotyq
	 PWuIOEI7fgFa1sqLbewi+1GScZ9pwiqbCiXIeuX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgETXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETXpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:23 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E850620884;
        Wed, 20 May 2020 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018323;
        bh=BdtSeWgXsb31UNe8YibrIGXB2m1r+NP2vHy9sK75VrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4juGHuWLwXCUQ4BiyjK2os9avjDJbMjWHGYOfBv0bIT/y1SSkYFzmXf+J0FUlGmI
         uNxOlH4gYVmZy9fLvLCB6TRrezbkFec377Yz93CtKc+vcXA4qedTTTUz7DcXF6j/EL
         PaBHNJUauI8pORC7ruz8zCF/f70GVyBFHjifAemc=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 03/10] swiotlb-xen: add struct device* parameter to xen_phys_to_bus
Date:   Wed, 20 May 2020 16:45:13 -0700
Message-Id: <20200520234520.22563-3-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The parameter is unused in this patch.
No functional changes.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 drivers/xen/swiotlb-xen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b5e0492b07b9..958ee5517e0b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -57,7 +57,7 @@ static unsigned long xen_io_tlb_nslabs;
  * can be 32bit when dma_addr_t is 64bit leading to a loss in
  * information if the shift is done before casting to 64bit.
  */
-static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
+static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
 {
 	unsigned long bfn = pfn_to_bfn(XEN_PFN_DOWN(paddr));
 	dma_addr_t dma = (dma_addr_t)bfn << XEN_PAGE_SHIFT;
@@ -78,9 +78,9 @@ static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
 	return paddr;
 }
 
-static inline dma_addr_t xen_virt_to_bus(void *address)
+static inline dma_addr_t xen_virt_to_bus(struct device *dev, void *address)
 {
-	return xen_phys_to_bus(virt_to_phys(address));
+	return xen_phys_to_bus(dev, virt_to_phys(address));
 }
 
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
@@ -309,7 +309,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	 * Do not use virt_to_phys(ret) because on ARM it doesn't correspond
 	 * to *dma_handle. */
 	phys = *dma_handle;
-	dev_addr = xen_phys_to_bus(phys);
+	dev_addr = xen_phys_to_bus(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
 	    !range_straddles_page_boundary(phys, size))
 		*dma_handle = dev_addr;
@@ -367,7 +367,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = xen_phys_to_bus(phys);
+	dma_addr_t dev_addr = xen_phys_to_bus(dev, phys);
 
 	BUG_ON(dir == DMA_NONE);
 	/*
@@ -392,7 +392,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	phys = map;
-	dev_addr = xen_phys_to_bus(map);
+	dev_addr = xen_phys_to_bus(dev, map);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
@@ -536,7 +536,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
+	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
-- 
2.17.1

