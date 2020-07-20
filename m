Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF8C43446
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BD82064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="chUlq1hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgGTPmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:42:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56113 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729981AbgGTPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595259717; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lck5WIv/+y3EEHR7IuauWRNqWyfXrGWXMmHlQYUWUqs=; b=chUlq1hWYLvEiIumJI5nHSlbCPoGw9lGwStTGf6+E7ODiw5B6s4Psbl6QpPK9P+iDQABYA1M
 /pJzv82lAadB/Hu7jjB65hDs7sg3u9B6yC3BS0hM7OYTPMzqeSJnBEDOtU2nbOiAxKL8H6zQ
 aBoaiZKLhubHlx5TbwZCvhKXv9w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f15bb18c7a053446a4c109f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 15:41:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9ECCFC433C6; Mon, 20 Jul 2020 15:41:08 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 632BAC433B7;
        Mon, 20 Jul 2020 15:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 632BAC433B7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        iommu@lists.linux-foundation.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 03/13] iommu/arm-smmu: Add implementation hooks to configure contexts
Date:   Mon, 20 Jul 2020 09:40:37 -0600
Message-Id: <20200720154047.3611092-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720154047.3611092-1-jcrouse@codeaurora.org>
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new hook to allow implementations to implement their own context
bank allocation scheme and update the existing init_context function to
take the device pointer.

These modifications will be used by the upcoming Adreno SMMU
implementation to identify the GPU device and properly configure it
for pagetable switching.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu-impl.c |  2 +-
 drivers/iommu/arm-smmu.c      | 46 ++++++++++++-----------------------
 drivers/iommu/arm-smmu.h      | 28 ++++++++++++++++++++-
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index a20e426d81ac..b71b14685cc9 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -69,7 +69,7 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 }
 
 static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
-		struct io_pgtable_cfg *pgtbl_cfg)
+		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
 	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
 					      struct cavium_smmu, smmu);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8798428a4c8d..fff536a44faa 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -93,16 +93,6 @@ struct arm_smmu_cb {
 	struct arm_smmu_cfg		*cfg;
 };
 
-struct arm_smmu_master_cfg {
-	struct arm_smmu_device		*smmu;
-	s16				smendx[];
-};
-#define INVALID_SMENDX			-1
-#define cfg_smendx(cfg, fw, i) \
-	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
-#define for_each_cfg_sme(cfg, fw, i, idx) \
-	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
-
 static bool using_legacy_binding, using_generic_binding;
 
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
@@ -237,19 +227,6 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 }
 #endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
 
-static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
-{
-	int idx;
-
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
-}
-
 static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 {
 	clear_bit(idx, map);
@@ -668,7 +645,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct arm_smmu_device *smmu)
+					struct arm_smmu_device *smmu,
+					struct device *dev)
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
@@ -782,10 +760,20 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
+
+	smmu_domain->smmu = smmu;
+
+	if (smmu->impl && smmu->impl->alloc_context_bank)
+		ret = smmu->impl->alloc_context_bank(smmu_domain, dev,
+				start, smmu->num_context_banks);
+	else
+		ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
 				      smmu->num_context_banks);
-	if (ret < 0)
+
+	if (ret < 0) {
+		smmu_domain->smmu = NULL;
 		goto out_unlock;
+	}
 
 	cfg->cbndx = ret;
 	if (smmu->version < ARM_SMMU_V2) {
@@ -800,8 +788,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	else
 		cfg->asid = cfg->cbndx;
 
-	smmu_domain->smmu = smmu;
-
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
@@ -812,7 +798,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	};
 
 	if (smmu->impl && smmu->impl->init_context) {
-		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
+		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg, dev);
 		if (ret)
 			goto out_clear_smmu;
 	}
@@ -1190,7 +1176,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu);
+	ret = arm_smmu_init_domain_context(domain, smmu, dev);
 	if (ret < 0)
 		goto rpm_put;
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 5f2de20e883b..d10d745a0290 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -347,6 +347,11 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+struct arm_smmu_master_cfg {
+	struct arm_smmu_device		*smmu;
+	s16				smendx[];
+};
+
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 {
 	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
@@ -397,12 +402,33 @@ struct arm_smmu_impl {
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain,
-			struct io_pgtable_cfg *cfg);
+			struct io_pgtable_cfg *cfg, struct device *dev);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 	int (*def_domain_type)(struct device *dev);
+	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
+			struct device *dev, int start, int max);
 };
 
+#define INVALID_SMENDX			-1
+#define cfg_smendx(cfg, fw, i) \
+	(i >= fw->num_ids ? INVALID_SMENDX : cfg->smendx[i])
+#define for_each_cfg_sme(cfg, fw, i, idx) \
+	for (i = 0; idx = cfg_smendx(cfg, fw, i), i < fw->num_ids; ++i)
+
+static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
+{
+	int idx;
+
+	do {
+		idx = find_next_zero_bit(map, end, start);
+		if (idx == end)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, map));
+
+	return idx;
+}
+
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
 {
 	return smmu->base + (n << smmu->pgshift);
-- 
2.25.1

