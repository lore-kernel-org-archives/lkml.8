Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A95C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A12E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018331;
	bh=68bz29KGiO4K1vLdUXFPavN9cfZPRxxaUFsbZLLeOQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wk55rUu+lQPtwXEgwS+FrsL+cgS6mmMb4p3/6PnuLX3dK+lbFi5ZnnvbMngaJB5C8
	 HQHLJJMtz3h7UnC0CMM0NIEk8Gn45myKyTOgzxsp3V8K01EAW3eHej3CNKE/H5LC8X
	 ShHqrV7K7v9MMaQrjeZsIR4HH3ZWG5hoMFHEZlFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgETXp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgETXpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:25 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AEA208B8;
        Wed, 20 May 2020 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018324;
        bh=68bz29KGiO4K1vLdUXFPavN9cfZPRxxaUFsbZLLeOQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTE+kbnCMNQDzzVwFHnyCGj6ceXloekheSqEc/mfi4uXHnNX9YcX6KNuk+7Xjfu1e
         4Ivslg+Y9YsbA3JPm/E/DYimCIufADyo/rByZJDKZvlNR4WU+bwFRttIiSiZLilf48
         QwBlp0h7JbG+8wQ41SDtLC7LELN2RoJXH8oONqRI=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 07/10] swiotlb-xen: add struct device* parameter to is_xen_swiotlb_buffer
Date:   Wed, 20 May 2020 16:45:17 -0700
Message-Id: <20200520234520.22563-7-sstabellini@kernel.org>
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
 drivers/xen/swiotlb-xen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ef58f05ae445..c50448fd9b75 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -97,7 +97,7 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 	return 0;
 }
 
-static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
+static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 {
 	unsigned long bfn = XEN_PFN_DOWN(dma_addr);
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
@@ -428,7 +428,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 		xen_dma_sync_for_cpu(hwdev, dev_addr, paddr, size, dir);
 
 	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(dev_addr))
+	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, size, dir, attrs);
 }
 
@@ -441,7 +441,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 	if (!dev_is_dma_coherent(dev))
 		xen_dma_sync_for_cpu(dev, dma_addr, paddr, size, dir);
 
-	if (is_xen_swiotlb_buffer(dma_addr))
+	if (is_xen_swiotlb_buffer(dev, dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
 
@@ -451,7 +451,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev, dma_addr);
 
-	if (is_xen_swiotlb_buffer(dma_addr))
+	if (is_xen_swiotlb_buffer(dev, dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
-- 
2.17.1

