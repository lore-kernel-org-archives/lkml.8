Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E85C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB83F208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018323;
	bh=2rJi6KfJ7cKpdb3KgYosM8AG09eJiSBLH85aYQo6tfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01/VF67AFsnvH8G8e6gLay8TrhXjAKpIJWtLXSCMdUKkQKFTewaEwkvDN4LE45ARz
	 YA79cubJNHCaa44V3ueAM5gT98bbkkf1lFdE2lVlHFeYJZn3za1J/TONMbtM1PVoVo
	 r4EzLsJX4hx4QiYH4Fy91BWI0LTtL084/mHkAico=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgETXpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:22 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1812920748;
        Wed, 20 May 2020 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018322;
        bh=2rJi6KfJ7cKpdb3KgYosM8AG09eJiSBLH85aYQo6tfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/XEnES7H/3TARKOmkB1qbDupxUWdE2Iq1shY3iRXvUvUqgWMI9JC8cDHfeS8Yl+u
         +HcspWBrKeLpETCuygnY/0/UPeXGziAinuXs3JHNLhNZdDIMXyospJd0iz+iNx4WVf
         DXuaL5c43gHfkKb/gZV0rdGZ8hqWUrfcfPK0H0bI=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 01/10] swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses
Date:   Wed, 20 May 2020 16:45:11 -0700
Message-Id: <20200520234520.22563-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Don't just assume that virt_to_page works on all virtual addresses.
Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
virt addresses.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
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

