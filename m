Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E036C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3935A2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018347;
	bh=L20gKWj8zlek7VJV9PmfeUsnev8ccHkezeGqO5r/j0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJc/Pt2Kpdtg6hpD24bBsZJjoijokJlmMEHOpakerFCDem76L58+WAIliQLdaYM7d
	 AN/048YH9ehRmV8I70ReDVYVvLDOvrp9TtiNcysOMudXSveLYDqQfu0ucpfZ/Sltw9
	 hvW3AWj/adj1GvLUVGTDz4Wbarr4ayq5aRlwO9Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgETXpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgETXpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:24 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30682208B3;
        Wed, 20 May 2020 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018324;
        bh=L20gKWj8zlek7VJV9PmfeUsnev8ccHkezeGqO5r/j0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnTOgRAhyAKhhIqmhcyTNxvwKS7YZkziiXSq2B8Bf3L2jwD/2wcYZFCXYaLBTB/H3
         a5SP8AwC6k1h40imuvELO7bRpU77mncT/fN5LRmTcW8ndOxsBdcFDJtcHDYQ+ee4yM
         Rw5m1CKwyl4TbFieBldPA5YNa+ZIT6x9HG5pDjsw=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 06/10] swiotlb-xen: add struct device* parameter to xen_dma_sync_for_device
Date:   Wed, 20 May 2020 16:45:16 -0700
Message-Id: <20200520234520.22563-6-sstabellini@kernel.org>
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
 arch/arm/xen/mm.c         | 5 +++--
 drivers/xen/swiotlb-xen.c | 4 ++--
 include/xen/swiotlb-xen.h | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 1a00e8003c64..f2414ea40a79 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -81,8 +81,9 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 }
 
-void xen_dma_sync_for_device(dma_addr_t handle, phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
+void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
+			     phys_addr_t paddr, size_t size,
+			     enum dma_data_direction dir)
 {
 	if (pfn_valid(PFN_DOWN(handle)))
 		arch_sync_dma_for_device(paddr, size, dir);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f9aa932973dd..ef58f05ae445 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -405,7 +405,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 done:
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xen_dma_sync_for_device(dev_addr, phys, size, dir);
+		xen_dma_sync_for_device(dev, dev_addr, phys, size, dir);
 	return dev_addr;
 }
 
@@ -455,7 +455,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
-		xen_dma_sync_for_device(dma_addr, paddr, size, dir);
+		xen_dma_sync_for_device(dev, dma_addr, paddr, size, dir);
 }
 
 /*
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index f62d1854780b..6d235fe2b92d 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -7,8 +7,9 @@
 void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 			  phys_addr_t paddr, size_t size,
 			  enum dma_data_direction dir);
-void xen_dma_sync_for_device(dma_addr_t handle, phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir);
+void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
+			     phys_addr_t paddr, size_t size,
+			     enum dma_data_direction dir);
 
 extern int xen_swiotlb_init(int verbose, bool early);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
-- 
2.17.1

