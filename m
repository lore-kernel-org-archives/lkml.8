Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B565E20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018328;
	bh=zOggHTvrAHnGnYxgbdj7YkRZVsHE+BJZQ+7OWADQwYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E21vu4W7cBVJbMnuEhvh7dyg/G61Z04ijhG2J6ltMeBDE2xhzT1uKD4GD/mphkdUa
	 xgy8mnkEf+ixdfwscPkVrhROx1FDZJoZwrW/66HN+M0Cv8MPCzRW5SHAeJLfX0Sz1R
	 bWqpd2oHRCDt/yDnaWNgx1kk+CkXQ62r93ZtrFJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgETXp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgETXp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:26 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE5920B80;
        Wed, 20 May 2020 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018325;
        bh=zOggHTvrAHnGnYxgbdj7YkRZVsHE+BJZQ+7OWADQwYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVwAtmtAzOWjanAHNYSDwz0EACLtThGIDZ+uUg3zRvGSkZ75zhEpQJU3GzzON3sTQ
         a4K7Q8VcswpaFBNTBAKJzXJgfqEM28xLxpmJbB7BCuTDWgYrzJXzFN48YVh7WrmbLS
         h39JcTbntVeLgiFMkXpexgwcaiT0drFuU4zHbALQ=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 09/10] xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
Date:   Wed, 20 May 2020 16:45:19 -0700
Message-Id: <20200520234520.22563-9-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Add phys_to_dma/dma_to_phys calls to
xen_dma_sync_for_cpu, xen_dma_sync_for_device, and
xen_arch_need_swiotlb.

In xen_arch_need_swiotlb, take the opportunity to switch to the simpler
pfn_valid check we use everywhere else.

dma_cache_maint is fixed by the next patch.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 arch/arm/xen/mm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f2414ea40a79..7639251bcc79 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/cpu.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -75,7 +76,7 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
 			  phys_addr_t paddr, size_t size,
 			  enum dma_data_direction dir)
 {
-	if (pfn_valid(PFN_DOWN(handle)))
+	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
 		arch_sync_dma_for_cpu(paddr, size, dir);
 	else if (dir != DMA_TO_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
@@ -85,7 +86,7 @@ void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
 			     phys_addr_t paddr, size_t size,
 			     enum dma_data_direction dir)
 {
-	if (pfn_valid(PFN_DOWN(handle)))
+	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
 		arch_sync_dma_for_device(paddr, size, dir);
 	else if (dir == DMA_FROM_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
@@ -97,8 +98,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 			   phys_addr_t phys,
 			   dma_addr_t dev_addr)
 {
-	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
-	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
+	unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
 
 	/*
 	 * The swiotlb buffer should be used if
@@ -115,7 +115,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 * require a bounce buffer because the device doesn't support coherent
 	 * memory and we are not able to flush the cache.
 	 */
-	return (!hypercall_cflush && (xen_pfn != bfn) &&
+	return (!hypercall_cflush && !pfn_valid(bfn) &&
 		!dev_is_dma_coherent(dev));
 }
 
-- 
2.17.1

