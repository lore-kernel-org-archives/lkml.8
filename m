Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E2EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8372067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222994;
	bh=p13t7h6OgZd3c3rlyfugdVMmCRk9goZBfF3/sQLkgpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jmHg5M6TBlQ2xV/O/0lFpvF/hlBSwYkyxXuUqDCAks6nR97sfRmU5ONcrzQ/l1uum
	 lhBvNuNnYUIbA8hnM7NmLI2Fwk2JWXuoRUBYYprDINZGAbL1N4O4j+xcQlAvwgk9iF
	 AEngvKGVFH98fRro6r1OIhrweYpm63xBMi0bHqak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFCWXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFCWWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:53 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB97207F5;
        Wed,  3 Jun 2020 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222973;
        bh=p13t7h6OgZd3c3rlyfugdVMmCRk9goZBfF3/sQLkgpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AurZxJAJFOB7GSce2yJBE5z0Eu104WUXUTPvSKeFv/irIMHX/PuBIfT0tdjwggKaW
         7GCQsJ2VWCh327dm4Ybc2CJe54tOeeR6oSZ7Eo14y3kYiRMph040HSWsEV6/ddWT2r
         FSteCb/rY0YjJJSQg6BgK7qST3egSc9aGEbLg8l0=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 09/11] swiotlb-xen: rename xen_phys_to_bus to xen_phys_to_dma and xen_bus_to_phys to xen_dma_to_phys
Date:   Wed,  3 Jun 2020 15:22:45 -0700
Message-Id: <20200603222247.11681-9-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that their names can better describe their behavior.

No functional changes.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 drivers/xen/swiotlb-xen.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 60ef07440905..41129c02d59a 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -57,7 +57,7 @@ static unsigned long xen_io_tlb_nslabs;
  * can be 32bit when dma_addr_t is 64bit leading to a loss in
  * information if the shift is done before casting to 64bit.
  */
-static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
+static inline dma_addr_t xen_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned long bfn = pfn_to_bfn(XEN_PFN_DOWN(paddr));
 	dma_addr_t dma = (dma_addr_t)bfn << XEN_PAGE_SHIFT;
@@ -67,7 +67,7 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
 	return phys_to_dma(dev, dma);
 }
 
-static inline phys_addr_t xen_bus_to_phys(struct device *dev,
+static inline phys_addr_t xen_dma_to_phys(struct device *dev,
 					  dma_addr_t dma_addr)
 {
 	phys_addr_t baddr = dma_to_phys(dev, dma_addr);
@@ -80,7 +80,7 @@ static inline phys_addr_t xen_bus_to_phys(struct device *dev,
 
 static inline dma_addr_t xen_virt_to_bus(struct device *dev, void *address)
 {
-	return xen_phys_to_bus(dev, virt_to_phys(address));
+	return xen_phys_to_dma(dev, virt_to_phys(address));
 }
 
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
@@ -309,7 +309,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	 * Do not use virt_to_phys(ret) because on ARM it doesn't correspond
 	 * to *dma_handle. */
 	phys = dma_to_phys(hwdev, *dma_handle);
-	dev_addr = xen_phys_to_bus(hwdev, phys);
+	dev_addr = xen_phys_to_dma(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
 	    !range_straddles_page_boundary(phys, size))
 		*dma_handle = dev_addr;
@@ -340,7 +340,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	/* do not use virt_to_phys because on ARM it doesn't return you the
 	 * physical address */
-	phys = xen_bus_to_phys(hwdev, dev_addr);
+	phys = xen_dma_to_phys(hwdev, dev_addr);
 
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
@@ -369,7 +369,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = xen_phys_to_bus(dev, phys);
+	dma_addr_t dev_addr = xen_phys_to_dma(dev, phys);
 
 	BUG_ON(dir == DMA_NONE);
 	/*
@@ -394,7 +394,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	phys = map;
-	dev_addr = xen_phys_to_bus(dev, map);
+	dev_addr = xen_phys_to_dma(dev, map);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
@@ -422,7 +422,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	phys_addr_t paddr = xen_bus_to_phys(hwdev, dev_addr);
+	phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -438,7 +438,7 @@ static void
 xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dev, dma_addr);
+	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
 	if (!dev_is_dma_coherent(dev))
 		xen_dma_sync_for_cpu(dev, dma_addr, paddr, size, dir);
@@ -451,7 +451,7 @@ static void
 xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dev, dma_addr);
+	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
 	if (is_xen_swiotlb_buffer(dev, dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
-- 
2.17.1

