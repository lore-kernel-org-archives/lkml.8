Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21762C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA61C2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222986;
	bh=9EMRvn5Dc8JT3MH0CrfmZw6otCxJqhqF6+OrT0rmyo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPcSWAiclSp3lXuzEUs06JyLXwAPblVGyyU2KSIqxh3KR+2pctU4Rw2IycJZf8UQY
	 AxJ7EHtxXBW4FlBsCGFXRSU/vbJuqdDw96YcotpuI5LeIXywq0Gg77xQGaEqfhlDjy
	 +kN5I2e1i2jnV0FRNUqcaUwfrEF+LG9B2CffGze4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgFCWWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgFCWWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:51 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE2320810;
        Wed,  3 Jun 2020 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222970;
        bh=9EMRvn5Dc8JT3MH0CrfmZw6otCxJqhqF6+OrT0rmyo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMkfTrY//kEo3frQh5UBqXlCY9gFA+q6O15I10yf40UHEg4tU61PHkQsi8VdYPfSO
         xsOTh7eIQ4IPEZPYj3ZapuGsrb9NoQ7wtwIaS1B35AciFYGS+Ad43u6D+yn07Q0fQN
         barpbM44FRjfXKV+ngWD+/yMJGKIZKzXQEoDlbe4=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 04/11] swiotlb-xen: add struct device* parameter to xen_bus_to_phys
Date:   Wed,  3 Jun 2020 15:22:40 -0700
Message-Id: <20200603222247.11681-4-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The parameter is unused in this patch.
No functional changes.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
 drivers/xen/swiotlb-xen.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1c44dbc69b70..e38a1cce4100 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -67,7 +67,7 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
 	return dma;
 }
 
-static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
+static inline phys_addr_t xen_bus_to_phys(struct device *dev, dma_addr_t baddr)
 {
 	unsigned long xen_pfn = bfn_to_pfn(XEN_PFN_DOWN(baddr));
 	dma_addr_t dma = (dma_addr_t)xen_pfn << XEN_PAGE_SHIFT;
@@ -339,7 +339,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	/* do not use virt_to_phys because on ARM it doesn't return you the
 	 * physical address */
-	phys = xen_bus_to_phys(dev_addr);
+	phys = xen_bus_to_phys(hwdev, dev_addr);
 
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
@@ -420,7 +420,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
+	phys_addr_t paddr = xen_bus_to_phys(hwdev, dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -436,7 +436,7 @@ static void
 xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
+	phys_addr_t paddr = xen_bus_to_phys(dev, dma_addr);
 
 	if (!dev_is_dma_coherent(dev))
 		xen_dma_sync_for_cpu(dma_addr, paddr, size, dir);
@@ -449,7 +449,7 @@ static void
 xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
+	phys_addr_t paddr = xen_bus_to_phys(dev, dma_addr);
 
 	if (is_xen_swiotlb_buffer(dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
-- 
2.17.1

