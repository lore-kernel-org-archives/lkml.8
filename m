Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC67C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C72C208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018325;
	bh=Vv+EdXpTbwnuZjYd1z0k52yCJtFShb1TwXsEeRgOU74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B256E2Tfsoh2MBQJRzJ20k0FaNEKkIHGr0s6S7RR+XmWohhJuvnx8NriRKUWmEp8o
	 CFG/H3vYm48tyJ19syJmUqaCfuBjRjuleIZPipK8MCWIXbvIafQrJ1c9QuMTnQIPAZ
	 yv0+Eyyf1CVgOsl3NjES8j9L3SxLUHcghlaK5+Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgETXpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgETXpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:23 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F6120873;
        Wed, 20 May 2020 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018322;
        bh=Vv+EdXpTbwnuZjYd1z0k52yCJtFShb1TwXsEeRgOU74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBVUvkEnVb5CTQSI2t90TDC/MfBITVXjrBOqmirzQIzAeJwdr1sVZyo9BaUXBQWb6
         LLUhyQ43M/LP6uZtRnjF0h93Ma1z5Q2Gci6bg0La5Pw99Q96J4Tt/c0jbgFC2I1Iiz
         ES8P300ufpQlz2z+r0K7tnfeD8kqZ32GjZyT1K4U=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH 02/10] swiotlb-xen: remove start_dma_addr
Date:   Wed, 20 May 2020 16:45:12 -0700
Message-Id: <20200520234520.22563-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

It is not strictly needed. Call virt_to_phys on xen_io_tlb_start
instead. It will be useful not to have a start_dma_addr around with the
next patches.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 drivers/xen/swiotlb-xen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a42129cba36e..b5e0492b07b9 100644
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
@@ -389,7 +386,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
+	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start), phys,
 				     size, size, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
-- 
2.17.1

