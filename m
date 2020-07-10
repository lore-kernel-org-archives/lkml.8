Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC80C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CF120725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420476;
	bh=HgiPdFTfQq90v0qFVQCJWX2B++kBNShoCcFtOr7ILuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mnACOKA0FBxMu5dBD6vxHHpw0+5SmDE+UmhXA66xOAZ9kS75Ji4wDYuuDUGdyOQw/
	 OouzixCqZeaUgUXEzMJIE2Q71ByoyatroPvA5Vcc0xAdTidUky71Xn3JTbo1wBE5hY
	 droRGqzWj3kqBdmYoNYmTpqbAs8FBRzzDscKAjgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgGJWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgGJWeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:31 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FCA207BB;
        Fri, 10 Jul 2020 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420470;
        bh=HgiPdFTfQq90v0qFVQCJWX2B++kBNShoCcFtOr7ILuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phL1a1HmIcF5IqHsARIBc9mSooTg4t/lbu/szXY/+4PhXlbLh/EXV1Y82x/OI9S9m
         PfJ0zM3h9v6KPmNL9qpxrZIycqVE+0H2/vQDY6n6j7N2e+o1NfgbR3z1M9k+3NlkQ+
         bhq96IoKnNBDNwDZZLRkhAXx4YUDXm9SKmyqiY3E=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v3 03/11] swiotlb-xen: add struct device * parameter to xen_phys_to_bus
Date:   Fri, 10 Jul 2020 15:34:19 -0700
Message-Id: <20200710223427.6897-3-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

No functional changes. The parameter is unused in this patch but will be
used by next patches.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v3:
- add whitespace in title
- improve commit message
---
 drivers/xen/swiotlb-xen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 89a775948a02..dbe710a59bf2 100644
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
@@ -370,7 +370,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = xen_phys_to_bus(phys);
+	dma_addr_t dev_addr = xen_phys_to_bus(dev, phys);
 
 	BUG_ON(dir == DMA_NONE);
 	/*
@@ -395,7 +395,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	phys = map;
-	dev_addr = xen_phys_to_bus(map);
+	dev_addr = xen_phys_to_bus(dev, map);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
@@ -539,7 +539,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
+	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
-- 
2.17.1

