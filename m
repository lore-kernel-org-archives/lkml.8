Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A17BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E517F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="H+KGwlgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDUUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:20:35 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:58266 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgDUUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:20:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587500434; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8Z/altQqTKdjp/pVqayBVEKEPSRCz4KgGRuB1EudGTI=; b=H+KGwlgH8ppjMGwvhdUywJtHLNqaIQWmO85zdgSe9MX07yqomyp+31GwOjRS0WGFkPamcs2T
 UWXUzSB+3SC4v0zh07JpJP6njfcebt/Po1I0c/zEDIkEQwdZQdefPCoM1C6NfF2UWY4W4/Ha
 G77saQ0DL8EVaMYhK9bsSZdw7go=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f5582.7f4593a22500-smtp-out-n02;
 Tue, 21 Apr 2020 20:20:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69107C44791; Tue, 21 Apr 2020 20:20:17 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 609F3C432C2;
        Tue, 21 Apr 2020 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 609F3C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] iomm/arm-smmu: Add stall implementation hook
Date:   Wed, 22 Apr 2020 01:50:04 +0530
Message-Id: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stall implementation hook to enable stalling
faults on QCOM platforms which supports it without
causing any kind of hardware mishaps. Without this
on QCOM platforms, GPU faults can cause unrelated
GPU memory accesses to return zeroes. This has the
unfortunate result of command-stream reads from CP
getting invalid data, causing a cascade of fail.

Suggested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
This has been attempted previously by Rob Clark in 2017, 2018.
Hopefully we can get something concluded in 2020.
 * https://patchwork.kernel.org/patch/9953803/
 * https://patchwork.kernel.org/patch/10618713/
---
 drivers/iommu/arm-smmu-qcom.c | 1 +
 drivers/iommu/arm-smmu.c      | 7 +++++++
 drivers/iommu/arm-smmu.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 24c071c1d8b0..a13b229389d4 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -32,6 +32,7 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
 	.reset = qcom_sdm845_smmu500_reset,
+	.stall = true,
 };
 
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e622f4e33379..16b03fca9966 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -488,6 +488,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 			    fsr, iova, fsynr, cbfrsynra, idx);
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+	if (smmu->impl && smmu->impl->stall && (fsr & ARM_SMMU_FSR_SS))
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+				  ARM_SMMU_RESUME_TERMINATE);
+
 	return IRQ_HANDLED;
 }
 
@@ -659,6 +664,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= ARM_SMMU_SCTLR_E;
+	if (smmu->impl && smmu->impl->stall)
+		reg |= ARM_SMMU_SCTLR_CFCFG;
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 8d1cd54d82a6..d5134e0d5cce 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -386,6 +386,7 @@ struct arm_smmu_impl {
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
+	bool stall;
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
