Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84A22067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222972;
	bh=KkHGhoUNVUm6PPU2Wc3n69d1PFrjoUPau99hvQGcD1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WXXeG/IGWG6zIPBKX0JmLhMSw3t7PrLUA/OcMu9wUylr/vNRh9hNtPk9F9SjW54oY
	 W6IShc7OQwtbukzlKJD0aQf/jcUJw3yu2c6ChP2PddkATchZWhL8l6rwSSBabC7lcu
	 eIsPKue+4jxan2fmk0pWZENvbnst3EiOKdmlpXcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgFCWWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgFCWWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:49 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D431C2067B;
        Wed,  3 Jun 2020 22:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222969;
        bh=KkHGhoUNVUm6PPU2Wc3n69d1PFrjoUPau99hvQGcD1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS/9d1NEK4nODfzf/8QcScf3N+hmvvrgLTCxl91JpBRBcydxeV138kYdTqiJMEt9b
         nhYp1DoW/P0X+h2Do5xbSeYfbg7p+rgwfDoq04oiBlfmzPiGObo11WusHd99feCP+G
         hdz7+XBkfDJCmzl8jFCi1R+GtcVCvV0kGA2FLHcQ=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 01/11] swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses
Date:   Wed,  3 Jun 2020 15:22:37 -0700
Message-Id: <20200603222247.11681-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

xen_alloc_coherent_pages might return pages for which virt_to_phys and
virt_to_page don't work, e.g. ioremap'ed pages.

So in xen_swiotlb_free_coherent we can't assume that virt_to_page works.
Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
virt addresses.

This patch fixes the following crash at boot on RPi4:
https://marc.info/?l=xen-devel&m=158862573216800

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v2:
- update commit message
---
 drivers/xen/swiotlb-xen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b6d27762c6f8..a42129cba36e 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -335,6 +335,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
+	struct page *pg;
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
+	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
+				      virt_to_page(vaddr);
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
-	    TestClearPageXenRemapped(virt_to_page(vaddr)))
+	    TestClearPageXenRemapped(pg))
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
-- 
2.17.1

