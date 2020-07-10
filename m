Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04EBC433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05FF206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420495;
	bh=jLgIlw0XpAVuOCkBCu96F/m3f+tfTNFZAXAR4R0KYhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUEnpb07We7p0/8U+IYL+Hv7NnMf///w0guk4Ixk8Sok3JWvi08UqPrq8nje7tDFf
	 88qEQpfBvaL1yu1ZnLD5B0FKMQ2O/paxY/1LKTbz28XKp1mUgoc2xXqAXxSbaY+ODk
	 N9ZznLJ+LT847CBbe4EaZ1Z+me/K1bXRnZbukBRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGJWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgGJWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:33 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6EE2084C;
        Fri, 10 Jul 2020 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420473;
        bh=jLgIlw0XpAVuOCkBCu96F/m3f+tfTNFZAXAR4R0KYhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsgLFsqHx83ZxrVE357/rAy2BkLYAlHXH3STs/PYChzyTa06t95Oll0lDdW/RvhzA
         3w15KyVrAiCPA2w60Luc8SqDOVyQyqkDSy2CJJiPwbNNxRy1ZFtBmpSrg/JPH5N0pg
         53S4KsSkr+3N1JIHxPP80eE+akQ+CPF2WRZY7gSM=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH v3 08/11] swiotlb-xen: remove XEN_PFN_PHYS
Date:   Fri, 10 Jul 2020 15:34:24 -0700
Message-Id: <20200710223427.6897-8-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

XEN_PFN_PHYS is only used in one place in swiotlb-xen making things more
complex than need to be.

Remove the definition of XEN_PFN_PHYS and open code the cast in the one
place where it is needed.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 drivers/xen/swiotlb-xen.c | 7 +------
 include/xen/page.h        | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e2c35f45f91e..03d118b6c141 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -52,11 +52,6 @@ static unsigned long xen_io_tlb_nslabs;
  * Quick lookup value of the bus address of the IOTLB.
  */
 
-/*
- * Both of these functions should avoid XEN_PFN_PHYS because phys_addr_t
- * can be 32bit when dma_addr_t is 64bit leading to a loss in
- * information if the shift is done before casting to 64bit.
- */
 static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
 {
 	unsigned long bfn = pfn_to_bfn(XEN_PFN_DOWN(paddr));
@@ -101,7 +96,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 {
 	unsigned long bfn = XEN_PFN_DOWN(dma_addr);
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
-	phys_addr_t paddr = XEN_PFN_PHYS(xen_pfn);
+	phys_addr_t paddr = (phys_addr_t)xen_pfn << XEN_PAGE_SHIFT;
 
 	/* If the address is outside our domain, it CAN
 	 * have the same virtual address as another address
diff --git a/include/xen/page.h b/include/xen/page.h
index df6d6b6ec66e..285677b42943 100644
--- a/include/xen/page.h
+++ b/include/xen/page.h
@@ -24,7 +24,6 @@
 
 #define XEN_PFN_DOWN(x)	((x) >> XEN_PAGE_SHIFT)
 #define XEN_PFN_UP(x)	(((x) + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT)
-#define XEN_PFN_PHYS(x)	((phys_addr_t)(x) << XEN_PAGE_SHIFT)
 
 #include <asm/xen/page.h>
 
-- 
2.17.1

