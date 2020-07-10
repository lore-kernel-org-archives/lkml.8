Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135EDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB12520720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420472;
	bh=3GwsLOtHN4zRKft6xlDRfAH+KgUHUTf+yyaVBSSdyn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oT+gP2gaTnoUeM3jDebO+PTmq+329UAGGVhrJTHp7mTSGy9qEi+Nkx0vsEmb6+sOE
	 h1iEc0xaz7MOBf9XblT/SFDqRnDpgLSEURfMFj2XpUzCyNfYJ+GcTnpXH2WLhWgEIa
	 rByDROBYh51b2uU91otksHTttgol8x44hoW1yiDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGJWeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgGJWea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:30 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CB62075D;
        Fri, 10 Jul 2020 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420469;
        bh=3GwsLOtHN4zRKft6xlDRfAH+KgUHUTf+yyaVBSSdyn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jt2yh5WNYaKPWaJY8JQkbiswMPHMg7BCgVT5x2iJ3qNwf8+ekBcSJjbVzC8gz0G3r
         PNuGsVuGq0X296MIu4/hRFaRwZcNLrviXcJ+HjZ31g6Yg4pSVFCK5WlTb5HIX2kvj4
         Rqu3BmiwZNkKDZrBDxg3PWP5kl8dkREO6P7GkM/M=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v3 02/11] swiotlb-xen: remove start_dma_addr
Date:   Fri, 10 Jul 2020 15:34:18 -0700
Message-Id: <20200710223427.6897-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

It is not strictly needed. Call virt_to_phys on xen_io_tlb_start
instead. It will be useful not to have a start_dma_addr around with the
next patches.

Note that virt_to_phys is not the same as xen_virt_to_bus but actually
it is used to compared again __pa(xen_io_tlb_start) as passed to
swiotlb_init_with_tbl, so virt_to_phys is actually what we want.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v2:
- update commit message
---
 drivers/xen/swiotlb-xen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5fbadd07819b..89a775948a02 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -52,8 +52,6 @@ static unsigned long xen_io_tlb_nslabs;
  * Quick lookup value of the bus address of the IOTLB.
  */
 
-static u64 start_dma_addr;
-
 /*
  * Both of these functions should avoid XEN_PFN_PHYS because phys_addr_t
  * can be 32bit when dma_addr_t is 64bit leading to a loss in
@@ -241,7 +239,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 		m_ret = XEN_SWIOTLB_EFIXUP;
 		goto error;
 	}
-	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
 	if (early) {
 		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
 			 verbose))
@@ -392,8 +389,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
-				     size, size, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
+				     phys, size, size, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-- 
2.17.1

