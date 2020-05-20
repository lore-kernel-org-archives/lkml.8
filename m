Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BDE20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018340;
	bh=K/T4h2BFa+NcoPT654ciuMnQsexCfqtyhB6cVtjK0L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwbGcfl9xF8GaQ4A9uAMDJcWxQ96E+V8aMLg6Q2PIFADAEfpfQsQCQw6D4WXlViuW
	 ++mVk6Ik/V3uNAecjOLymUMtrG1xnBBpNUODqt+luU8t5M269GGsyq7azKtgWl34XU
	 EOORvzqY1dEi21XT9izhd1MQ1AkPkh4y0a4/tH9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgETXpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgETXp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:26 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D156F208C7;
        Wed, 20 May 2020 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018326;
        bh=K/T4h2BFa+NcoPT654ciuMnQsexCfqtyhB6cVtjK0L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO1sa0jxbGms6doP+1SAsu8gCvwCCG2FLgnZDuwrFexC103KNiw38nDll+VHU43s2
         Nh2TpH2F36+9fsLjiS6cJyqFf9ZymsSVC2VoFK1SHz/99E0SURKQRXWu+SOnutOCzF
         s0HqcEICwCpORe7VX79MIUVoZtX9bZ86p6lqngIo=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 10/10] xen/arm: call dma_to_phys on the dma_addr_t parameter of dma_cache_maint
Date:   Wed, 20 May 2020 16:45:20 -0700
Message-Id: <20200520234520.22563-10-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Add a struct device* parameter to dma_cache_maint.

Translate the dma_addr_t parameter of dma_cache_maint by calling
dma_to_phys. Do it for the first page and all the following pages, in
case of multipage handling.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 arch/arm/xen/mm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 7639251bcc79..6ddf3b3c1ab5 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -43,15 +43,18 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
 static bool hypercall_cflush = false;
 
 /* buffers in highmem or foreign pages cannot cross page boundaries */
-static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
+static void dma_cache_maint(struct device *dev, dma_addr_t handle,
+			    size_t size, u32 op)
 {
 	struct gnttab_cache_flush cflush;
 
-	cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;
 	cflush.offset = xen_offset_in_page(handle);
 	cflush.op = op;
+	handle &= XEN_PAGE_MASK;
 
 	do {
+		cflush.a.dev_bus_addr = dma_to_phys(dev, handle);
+
 		if (size + cflush.offset > XEN_PAGE_SIZE)
 			cflush.length = XEN_PAGE_SIZE - cflush.offset;
 		else
@@ -60,7 +63,7 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
 		HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
 
 		cflush.offset = 0;
-		cflush.a.dev_bus_addr += cflush.length;
+		handle += cflush.length;
 		size -= cflush.length;
 	} while (size);
 }
@@ -79,7 +82,7 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
 		arch_sync_dma_for_cpu(paddr, size, dir);
 	else if (dir != DMA_TO_DEVICE)
-		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
 }
 
 void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
@@ -89,9 +92,9 @@ void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
 	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
 		arch_sync_dma_for_device(paddr, size, dir);
 	else if (dir == DMA_FROM_DEVICE)
-		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
 	else
-		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
+		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_CLEAN);
 }
 
 bool xen_arch_need_swiotlb(struct device *dev,
-- 
2.17.1

