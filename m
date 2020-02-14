Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8819C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9A720848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kv3oBTuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBNW60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:58:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:41846 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727815AbgBNW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:58:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581721104; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Crn3FL1RKeqIe9JQNOwhOeVTSYotuHa65B4DyFHfQgY=; b=kv3oBTuAyi8JII8n66ggaEQbEzu3ZV8YcQUkTxTt6R9c802IaNnaAfVp/MWMso0XUCdBda8F
 xc93eyvRk0fXz4WvY23oASxW3cPqfNQOIhHwaI7c2uEbC2W7NSHEkQQG5XZLhAOBhHLlKs2L
 4diVjWe0Ru/7uyuH8XvmNYYw6PM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e472610.7fa756bc0998-smtp-out-n02;
 Fri, 14 Feb 2020 22:58:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F1C8C447A0; Fri, 14 Feb 2020 22:58:24 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5692AC4479C;
        Fri, 14 Feb 2020 22:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5692AC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Liam Mark <lmark@codeaurora.org>, joro@8bytes.org,
        pratikp@codeaurora.org, kernel-team@android.com,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Date:   Fri, 14 Feb 2020 14:58:16 -0800
Message-Id: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

Some devices have a memory map which contains gaps or holes.
In order for the device to have as much IOVA space as possible,
allow its driver to inform the DMA-IOMMU layer that it should
not allocate addresses from these holes.

Change-Id: I15bd1d313d889c2572d0eb2adecf6bebde3267f7
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 28 ++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a2e96a5..3b83e1a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -368,6 +368,34 @@ static int iommu_dma_deferred_attach(struct device *dev,
 	return 0;
 }
 
+/*
+ * Should be called prior to using dma-apis
+ */
+int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+			   u64 size)
+{
+	struct iommu_domain *domain;
+	struct iommu_dma_cookie *cookie;
+	struct iova_domain *iovad;
+	unsigned long pfn_lo, pfn_hi;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain || !domain->iova_cookie)
+		return -EINVAL;
+
+	cookie = domain->iova_cookie;
+	iovad = &cookie->iovad;
+
+	/* iova will be freed automatically by put_iova_domain() */
+	pfn_lo = iova_pfn(iovad, base);
+	pfn_hi = iova_pfn(iovad, base + size - 1);
+	if (!reserve_iova(iovad, pfn_lo, pfn_hi))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_reserve_iova);
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21..79eef7c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+			   u64 size);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -78,5 +81,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_reserve_iova(struct device *dev, dma_addr_t base,
+					 u64 size)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
