Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A62C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B5620734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222981;
	bh=Hrv3PVcXYaGZU+pmnuCIi7L6rjwMar9STJmksuaPXR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7WBlZDGQMh3mndhx58UIIlLTQ7mD/z/Ijl2Zi3QeAyggbuxe4ctIenKXyvPnRZFV
	 XCaobfLh3HfWoOFCmBlPWHN3jZEkktnNQbfv9Wp4Bce5IfvLRFXBelZFM8vYG1m9o3
	 xfH2IBepqYjsFFcGJb28lC1zD+6ZZyepvhJuyVTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFCWXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgFCWWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:54 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7467820734;
        Wed,  3 Jun 2020 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222973;
        bh=Hrv3PVcXYaGZU+pmnuCIi7L6rjwMar9STJmksuaPXR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkQYce7A5IplQKy36VI3JG/7NujFadE1r+EI0c7RL3uFRJEv69DT3i7TAokkTisYb
         OkLyN10vvmp1i3ZZTO217L6kktfqJefvAssILhG2e3n3170XdT5olphDHA/tvEY80M
         ndiCNcRva4MAWM/5xUun6d1LH7Ih6/Zg1XaGuG24=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
Date:   Wed,  3 Jun 2020 15:22:46 -0700
Message-Id: <20200603222247.11681-10-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
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

Add dma_to_phys calls to xen_dma_sync_for_cpu, xen_dma_sync_for_device,
and xen_arch_need_swiotlb.

dma_cache_maint is fixed by the next patch.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>

---
Changes in v2:
- improve commit message
- don't use pfn_valid
---
 arch/arm/xen/mm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f2414ea40a79..bbad712a890d 100644
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
@@ -98,7 +99,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 			   dma_addr_t dev_addr)
 {
 	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
-	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
+	unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
 
 	/*
 	 * The swiotlb buffer should be used if
-- 
2.17.1

