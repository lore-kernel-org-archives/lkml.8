Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E0C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F61A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HSal6ZV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBNXGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:06:51 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:54709 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgBNXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:06:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581721610; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ngya2sELbTUtwPSa9Tco4Zs/75SfdxNfR45aMO4h/R8=; b=HSal6ZV88pDEfHhTmKnCA3J4ddmIVOk8ROdK0EJaot0Rhn+jReq6E8nSjVfgJX8OQNsi17q7
 R7pby1UuVDNvS1NwRaI6hOgw0VLP3hrwJUZMVIsweWElkvqrq4MXGBTTx7rFB9H7ixW/0aDU
 yvVacS35869QY2t4VszCa5Vh0eE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e472809.7f5ac631f848-smtp-out-n02;
 Fri, 14 Feb 2020 23:06:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92CEBC4479F; Fri, 14 Feb 2020 23:06:49 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60447C43383;
        Fri, 14 Feb 2020 23:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60447C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Liam Mark <lmark@codeaurora.org>, joro@8bytes.org,
        pratikp@codeaurora.org, kernel-team@android.com,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Date:   Fri, 14 Feb 2020 15:06:42 -0800
Message-Id: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

Using the best-fit algorithm, instead of the first-fit
algorithm, may reduce fragmentation when allocating
IOVAs.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++
 drivers/iommu/iova.c      | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dma-iommu.h |  7 +++++
 include/linux/iova.h      |  1 +
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a2e96a5..af08770 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -364,9 +364,26 @@ static int iommu_dma_deferred_attach(struct device *dev,
 	if (unlikely(ops->is_attach_deferred &&
 			ops->is_attach_deferred(domain, dev)))
 		return iommu_attach_device(domain, dev);
+	return 0;
+}
+
+/*
+ * Should be called prior to using dma-apis.
+ */
+int iommu_dma_enable_best_fit_algo(struct device *dev)
+{
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain || !domain->iova_cookie)
+		return -EINVAL;
 
+	iovad = &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
+	iovad->best_fit = true;
 	return 0;
 }
+EXPORT_SYMBOL(iommu_dma_enable_best_fit_algo);
 
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a953..716b05f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,6 +50,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
+	iovad->best_fit = false;
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -227,6 +228,69 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static int __alloc_and_insert_iova_best_fit(struct iova_domain *iovad,
+		unsigned long size, unsigned long limit_pfn,
+			struct iova *new, bool size_aligned)
+{
+	struct rb_node *curr, *prev;
+	struct iova *curr_iova, *prev_iova;
+	unsigned long flags;
+	unsigned long align_mask = ~0UL;
+	struct rb_node *candidate_rb_parent;
+	unsigned long new_pfn, candidate_pfn = ~0UL;
+	unsigned long gap, candidate_gap = ~0UL;
+
+	if (size_aligned)
+		align_mask <<= limit_align(iovad, fls_long(size - 1));
+
+	/* Walk the tree backwards */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	curr = &iovad->anchor.node;
+	prev = rb_prev(curr);
+	for (; prev; curr = prev, prev = rb_prev(curr)) {
+		curr_iova = rb_entry(curr, struct iova, node);
+		prev_iova = rb_entry(prev, struct iova, node);
+
+		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+		new_pfn = (limit_pfn - size) & align_mask;
+		gap = curr_iova->pfn_lo - prev_iova->pfn_hi - 1;
+		if ((limit_pfn >= size) && (new_pfn > prev_iova->pfn_hi)
+				&& (gap < candidate_gap)) {
+			candidate_gap = gap;
+			candidate_pfn = new_pfn;
+			candidate_rb_parent = curr;
+			if (gap == size)
+				goto insert;
+		}
+	}
+
+	curr_iova = rb_entry(curr, struct iova, node);
+	limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+	new_pfn = (limit_pfn - size) & align_mask;
+	gap = curr_iova->pfn_lo - iovad->start_pfn;
+	if (limit_pfn >= size && new_pfn >= iovad->start_pfn &&
+			gap < candidate_gap) {
+		candidate_gap = gap;
+		candidate_pfn = new_pfn;
+		candidate_rb_parent = curr;
+	}
+
+insert:
+	if (candidate_pfn == ~0UL) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* pfn_lo will point to size aligned address if size_aligned is set */
+	new->pfn_lo = candidate_pfn;
+	new->pfn_hi = new->pfn_lo + size - 1;
+
+	/* If we have 'prev', it's a valid place to start the insertion. */
+	iova_insert_rbtree(&iovad->rbroot, new, candidate_rb_parent);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return 0;
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -302,8 +366,13 @@ struct iova *
 	if (!new_iova)
 		return NULL;
 
-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
-			new_iova, size_aligned);
+	if (iovad->best_fit) {
+		ret = __alloc_and_insert_iova_best_fit(iovad, size,
+				limit_pfn + 1, new_iova, size_aligned);
+	} else {
+		ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
+				new_iova, size_aligned);
+	}
 
 	if (ret) {
 		free_iova_mem(new_iova);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21..b01a31a 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,8 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_enable_best_fit_algo(struct device *dev);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -78,5 +80,10 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_enable_best_fit_algo(struct device *dev)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637ab..58713bb 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -95,6 +95,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
+	bool best_fit;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
