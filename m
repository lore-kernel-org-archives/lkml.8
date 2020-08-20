Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D879BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C87208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597881776;
	bh=UfnvacykJk5ebnnFuOHKhcQ5y/mX76Whr9BDBzHGjPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJQCxFAQYHpEIOcr8GoO9biBIzvE3dSbFm5vgWL3VEk5EHjah2tzY4B3X2FcEzLuL
	 wpVS9p3snScftX05R2QBZFFynEvOjD7TCkdxjewVBV5WyXJwji3n+6XRswYSPcOld4
	 hGCN+CEmihOJv6b9QXdjfKJ920ymCl8HsmtKxuiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHTACy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgHTACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7E3207FB;
        Thu, 20 Aug 2020 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881769;
        bh=UfnvacykJk5ebnnFuOHKhcQ5y/mX76Whr9BDBzHGjPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmaOUcfOGd/3w/4J8SwDQW16uqVgKoJYFbpXnGhTqCnG5lse5VfSMgGUVu3D+fhXX
         9xBA0hxKq/PxYDSxrxQd1u5y0NGeBpUZvaMZKH31ptNN75qLPOaL+c2HIwQFg0JVB/
         PSEA/GU+awW0cbC2d3DbsLFNZO4y1b6uayKSmldM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Corey Minyard <cminyard@mvista.com>,
        Roman Shaposhnik <roman@zededa.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 14/22] swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses
Date:   Wed, 19 Aug 2020 20:02:21 -0400
Message-Id: <20200820000229.215333-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000229.215333-1-sashal@kernel.org>
References: <20200820000229.215333-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

[ Upstream commit 8b1e868f66076490189a36d984fcce286cdd6295 ]

xen_alloc_coherent_pages might return pages for which virt_to_phys and
virt_to_page don't work, e.g. ioremap'ed pages.

So in xen_swiotlb_free_coherent we can't assume that virt_to_page works.
Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
virt addresses.

This patch fixes the following crash at boot on RPi4 (the underlying
issue is not RPi4 specific):
https://marc.info/?l=xen-devel&m=158862573216800

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
Link: https://lore.kernel.org/r/20200710223427.6897-1-sstabellini@kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index bd3a10dfac157..06346422f7432 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -335,6 +335,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
+	struct page *page;
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -346,9 +347,14 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
+	if (is_vmalloc_addr(vaddr))
+		page = vmalloc_to_page(vaddr);
+	else
+		page = virt_to_page(vaddr);
+
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
-	    TestClearPageXenRemapped(virt_to_page(vaddr)))
+	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
-- 
2.25.1

