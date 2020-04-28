Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50799C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C385206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ob+Y97a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD1LkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:40:07 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30296 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgD1LkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:40:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588074006; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+B++ebBAF6JRFSA5Mk6Qhv4WL/YpE+dNWWEEO2SgL98=; b=Ob+Y97a0/Rnu3zDtqkSqvlfFjevLxQapcQrF2gQ52bIs6LhCv8Iuy6dgBrJaAVEM8t7sqzDr
 QfIa3xedZn+sIeyUbb4VAID2aC6X1tUHQTf33i0wOyKlO1QqUtTRIEsGcdwztJJedQJK4jlz
 YUqOVfNCK++el9T9CylS8jie16U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea815fd.7ff7e863a180-smtp-out-n05;
 Tue, 28 Apr 2020 11:39:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D548BC433CB; Tue, 28 Apr 2020 11:39:40 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD1ABC433D2;
        Tue, 28 Apr 2020 11:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD1ABC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, vatsa@codeaurora.org,
        christoffer.dall@arm.com, alex.bennee@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] swiotlb: Allow for non-linear mapping between paddr and vaddr
Date:   Tue, 28 Apr 2020 17:09:15 +0530
Message-Id: <1588073958-1793-3-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the memory pool managed by swiotlb driver could fall
outside the direct-mapped range, made accessible via memremap()
routine. To facilitate easy conversion between virtual and
physical address of such memory, store the virtual address of
memory pool in addition to its physical address.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 8c7843f..c634b4d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -61,6 +61,8 @@ struct swiotlb_pool {
 
 	phys_addr_t io_tlb_start, io_tlb_end;
 
+	void *io_tlb_vstart;
+
 	/*
 	 * The number of IO TLB blocks (in groups of 64) between io_tlb_start
 	 * and io_tlb_end.  This is command line adjustable via
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9c504d3..8cf0b57 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -178,6 +178,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	default_swiotlb_pool.io_tlb_start = __pa(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -307,6 +308,7 @@ static void swiotlb_cleanup(void)
 	default_swiotlb_pool.io_tlb_start = 0;
 	default_swiotlb_pool.io_tlb_nslabs = 0;
 	default_swiotlb_pool.max_segment = 0;
+	default_swiotlb_pool.io_tlb_vstart = NULL;
 }
 
 int
@@ -320,6 +322,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	default_swiotlb_pool.io_tlb_start = virt_to_phys(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
@@ -400,11 +403,10 @@ void __init swiotlb_exit(void)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
+static void swiotlb_bounce(phys_addr_t orig_addr, void *vaddr,
 			   size_t size, enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
 
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
@@ -437,6 +439,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
+static inline void *tlb_vaddr(struct swiotlb_pool *pool, phys_addr_t tlb_addr)
+{
+	return pool->io_tlb_vstart + (tlb_addr - pool->io_tlb_start);
+}
+
 phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 				   struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
@@ -569,7 +576,7 @@ phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 						(i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr,
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 					mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
@@ -594,7 +601,8 @@ void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+						mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -643,14 +651,14 @@ void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_FROM_DEVICE);
 		else
 			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_TO_DEVICE);
 		else
 			BUG_ON(dir != DMA_FROM_DEVICE);
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
