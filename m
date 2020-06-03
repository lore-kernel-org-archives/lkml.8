Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3B2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591223010;
	bh=z/W3HOqwZFpxh5RTvZrhBEC0DsqYoSYR2jgxAVw6hXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzorIL0hNh8ln0NU14O8vxdDo3uep0sIgEIsDfeSpuXoVGIZCVyJu4HpfObsB0rhd
	 V6Bu2ctZe8Fcia2k3tC+Yq5adfvVbLDKQGMEKt8QcHZxgS7GmdtsCnlE0w2u/rJN+l
	 cwVT4wPhTFS8MT8bCr0f+dvrtlhoUkRZid4kBnqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFCWX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgFCWWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:50 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62443207D0;
        Wed,  3 Jun 2020 22:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222969;
        bh=z/W3HOqwZFpxh5RTvZrhBEC0DsqYoSYR2jgxAVw6hXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8Gw2iZrApw37MILwEXd0XFn8MbQQTyVONoBAo2odDCqo4bx9EMQ0+3ZRahBnmF3c
         0SbM5LE5YCEo4zkcQTFe/l6VXtj6IYfiLHSIpwoMiuBD/hlmH+w7eZtnJoVwe8uH1F
         EBekaEg39hytF9DxdM0Q7iKp0OHg9bfrinazSkS8=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v2 02/11] swiotlb-xen: remove start_dma_addr
Date:   Wed,  3 Jun 2020 15:22:38 -0700
Message-Id: <20200603222247.11681-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
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
Tested-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Roman Shaposhnik <roman@zededa.com>
---
Changes in v2:
- update commit message

---
---
 drivers/xen/swiotlb-xen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a42129cba36e..ed09f8ac34c5 100644
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
@@ -389,8 +386,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
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

