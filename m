Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557FA2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222979;
	bh=+z55nUlwZHxq9stQuss6H0bHixpaR3RARWD3UmReZtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=se/4K43vQXg48KOav+S/VYRHzHCWojshlxEKH3TbKYE/WuJUWZgVY6h5n/Itp4zyk
	 8NJsf23ylvPKOQx08mGDXg8ivtp8odrz36s68btdKeOB7O0eJymOSofZPDy7fePKAg
	 sUvYuuasxA9wra38B3MtRBc3A7GWoi0XsaYFPknw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFCWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgFCWWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:53 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5D6207ED;
        Wed,  3 Jun 2020 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222972;
        bh=+z55nUlwZHxq9stQuss6H0bHixpaR3RARWD3UmReZtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6ia45bnDvUyQkxDk+aoX+tqGp81s5QYe9FvIOXr9V8o56IcdT842aYnX5xSpdRLf
         EcLyEWx6YxKPWFBZRUWoL3CSCiAne8JEWk5TnFtJEl42rqbJt+bTaCv0a3cIBYT0Cn
         jviQoYUCQs/dtqo1eNn6gWFdozsjjrBggRJoOsJ0=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 08/11] swiotlb-xen: introduce phys_to_dma/dma_to_phys translations
Date:   Wed,  3 Jun 2020 15:22:44 -0700
Message-Id: <20200603222247.11681-8-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

With some devices physical addresses are different than dma addresses.
To be able to deal with these cases, we need to call phys_to_dma on
physical addresses (including machine addresses in Xen terminology)
before returning them from xen_swiotlb_alloc_coherent and
xen_swiotlb_map_page.

We also need to convert dma addresses back to physical addresses using
dma_to_phys in xen_swiotlb_free_coherent and xen_swiotlb_unmap_page if
we want to do any operations on them.

Call dma_to_phys in is_xen_swiotlb_buffer.
Call phys_to_dma in xen_phys_to_bus.
Call dma_to_phys in xen_bus_to_phys.

Everything is taken care of by these changes except for
xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent, which need a
few explicit phys_to_dma/dma_to_phys calls.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v2:
- improve commit message
---
 drivers/xen/swiotlb-xen.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0a6cb67f0fc4..60ef07440905 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -64,16 +64,16 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
 
 	dma |= paddr & ~XEN_PAGE_MASK;
 
-	return dma;
+	return phys_to_dma(dev, dma);
 }
 
-static inline phys_addr_t xen_bus_to_phys(struct device *dev, dma_addr_t baddr)
+static inline phys_addr_t xen_bus_to_phys(struct device *dev,
+					  dma_addr_t dma_addr)
 {
+	phys_addr_t baddr = dma_to_phys(dev, dma_addr);
 	unsigned long xen_pfn = bfn_to_pfn(XEN_PFN_DOWN(baddr));
-	dma_addr_t dma = (dma_addr_t)xen_pfn << XEN_PAGE_SHIFT;
-	phys_addr_t paddr = dma;
-
-	paddr |= baddr & ~XEN_PAGE_MASK;
+	phys_addr_t paddr = (xen_pfn << XEN_PAGE_SHIFT) |
+			    (baddr & ~XEN_PAGE_MASK);
 
 	return paddr;
 }
@@ -99,7 +99,7 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 
 static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 {
-	unsigned long bfn = XEN_PFN_DOWN(dma_addr);
+	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
 	phys_addr_t paddr = XEN_PFN_PHYS(xen_pfn);
 
@@ -304,11 +304,11 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
 
-	/* At this point dma_handle is the physical address, next we are
+	/* At this point dma_handle is the dma address, next we are
 	 * going to set it to the machine address.
 	 * Do not use virt_to_phys(ret) because on ARM it doesn't correspond
 	 * to *dma_handle. */
-	phys = *dma_handle;
+	phys = dma_to_phys(hwdev, *dma_handle);
 	dev_addr = xen_phys_to_bus(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
 	    !range_straddles_page_boundary(phys, size))
@@ -319,6 +319,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
 			return NULL;
 		}
+		*dma_handle = phys_to_dma(hwdev, *dma_handle);
 		SetPageXenRemapped(virt_to_page(ret));
 	}
 	memset(ret, 0, size);
@@ -351,7 +352,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	    TestClearPageXenRemapped(pg))
 		xen_destroy_contiguous_region(phys, order);
 
-	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
+	xen_free_coherent_pages(hwdev, size, vaddr, phys_to_dma(hwdev, phys),
+				attrs);
 }
 
 /*
-- 
2.17.1

