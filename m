Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEE4C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8617E206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kwwdbeEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgD1LkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:40:16 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30296 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgD1LkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:40:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588074015; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5ADv1bKSrF0UhkCFdxy491HctCoioNlQOQ7fST9NyRI=; b=kwwdbeEtznY8Wox/MYPazM4YAc4z1NeR6iPA/iYbR4NiP9Ib8YQI7yqNe/XktV+8a/wN8CO7
 tbNfWzWOgoRRPr4K1geAZYtqWrgezFJxs608JSrc88VSJtEanofE6Tg3VVY8+/ClfJLSE/Ys
 x3zZOXA3BP9KhBwmrENQchjDdoQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea81609.7f1cbc469c70-smtp-out-n01;
 Tue, 28 Apr 2020 11:39:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8BD6C432C2; Tue, 28 Apr 2020 11:39:52 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A1BDC433BA;
        Tue, 28 Apr 2020 11:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A1BDC433BA
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
Subject: [PATCH 4/5] swiotlb: Add API to register new pool
Date:   Tue, 28 Apr 2020 17:09:17 +0530
Message-Id: <1588073958-1793-5-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an interface for the swiotlb driver to recognize
a new memory pool. Upon successful initialization of the pool,
swiotlb returns a handle, which needs to be passed as an argument
for any future operations on the pool (map/unmap/alloc/free).

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  9 ++++++++
 kernel/dma/swiotlb.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 957697e..97ac82a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -182,6 +182,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= swiotlb_start() && paddr < swiotlb_end();
 }
 
+extern struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size);
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -236,6 +239,12 @@ static inline void swiotlb_free(struct swiotlb_pool *pool,
 {
 }
 
+static struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7411ce5..9883744 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/slab.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -736,6 +737,65 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
 
+struct swiotlb_pool *swiotlb_register_pool(char *name, phys_addr_t start,
+			void *vstart, size_t size)
+{
+	struct swiotlb_pool *pool;
+	unsigned long i, bytes;
+	unsigned long nslabs;
+
+	nslabs = size >> IO_TLB_SHIFT;
+	if (!nslabs)
+		return ERR_PTR(-EINVAL);
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	bytes = nslabs << IO_TLB_SHIFT;
+
+	strncpy(pool->name, name, sizeof(pool->name));
+	spin_lock_init(&pool->io_tlb_lock);
+	pool->late_alloc = 1;
+	pool->io_tlb_start = start;
+	pool->io_tlb_end = start + bytes;
+	pool->io_tlb_vstart = vstart;
+	pool->io_tlb_nslabs = nslabs;
+	pool->max_segment = rounddown(bytes, PAGE_SIZE);
+
+	/*
+	 * Allocate and initialize the free list array.  This array is used
+	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
+	 * between io_tlb_start and io_tlb_end.
+	 */
+	pool->io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
+			get_order(pool->io_tlb_nslabs * sizeof(int)));
+	if (!pool->io_tlb_list)
+		goto cleanup;
+
+	pool->io_tlb_orig_addr = (phys_addr_t *)
+		__get_free_pages(GFP_KERNEL,
+				 get_order(pool->io_tlb_nslabs *
+					   sizeof(phys_addr_t)));
+	if (!pool->io_tlb_orig_addr)
+		goto cleanup;
+
+	for (i = 0; i < pool->io_tlb_nslabs; i++) {
+		pool->io_tlb_list[i] = IO_TLB_SEGSIZE -
+						OFFSET(i, IO_TLB_SEGSIZE);
+		pool->io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	}
+
+	return pool;
+
+cleanup:
+	kfree(pool->io_tlb_list);
+	kfree(pool->io_tlb_orig_addr);
+	kfree(pool);
+
+	return ERR_PTR(-ENOMEM);
+}
+
 bool is_swiotlb_active(void)
 {
 	/*
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
