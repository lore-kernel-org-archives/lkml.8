Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDC02073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qvz02CSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFKWV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:21:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63484 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgFKWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:21:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591914104; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IrKa62qGqk3M+KdsTYYQGvTxyZtl6tNd2zDtInHmPF4=; b=qvz02CSfCGy/SWo8PAkP8xZuCTNeHpb95zFCezKBkwsQazPoDQcBhdtFwWBMYpuGQkpgxMLu
 ya4hBgXksR/4brrvOCK2CmRhaDhFqTuTkWwefjxtG+LEfQrlwVBTWYc5t2I6KPBnWBC8UICq
 wGME092R9SRPguZU44h5pmKpSr0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ee2ae7786de6ccd4417779a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 22:21:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C302C43450; Thu, 11 Jun 2020 22:21:42 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 015C3C433B6;
        Thu, 11 Jun 2020 22:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 015C3C433B6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] iommu/arm-smmu: Add support for split pagetables
Date:   Thu, 11 Jun 2020 16:21:23 -0600
Message-Id: <20200611222128.28826-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611222128.28826-1-jcrouse@codeaurora.org>
References: <20200611222128.28826-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TTBR1 for a context bank if IO_PGTABLE_QUIRK_ARM_TTBR1 is selected
by the io-pgtable configuration.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 21 ++++++++++++++++-----
 drivers/iommu/arm-smmu.h | 25 +++++++++++++++++++------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8a3a6c8c887a..048de2681670 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -555,11 +555,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
 			cb->ttbr[1] = 0;
 		} else {
-			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-			cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID,
-						  cfg->asid);
+			cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
+				cfg->asid);
 			cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
-						 cfg->asid);
+				cfg->asid);
+
+			if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+				cb->ttbr[1] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+			else
+				cb->ttbr[0] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 		}
 	} else {
 		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
@@ -824,7 +828,14 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	/* Update the domain's page sizes to reflect the page table format */
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << ias) - 1;
+
+	if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
+		domain->geometry.aperture_start = ~0UL << ias;
+		domain->geometry.aperture_end = ~0UL;
+	} else {
+		domain->geometry.aperture_end = (1UL << ias) - 1;
+	}
+
 	domain->geometry.force_aperture = true;
 
 	/* Initialise the context bank with our page table cfg */
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 38b041530a4f..5f2de20e883b 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -168,10 +168,12 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_TCR			0x30
 #define ARM_SMMU_TCR_EAE		BIT(31)
 #define ARM_SMMU_TCR_EPD1		BIT(23)
+#define ARM_SMMU_TCR_A1			BIT(22)
 #define ARM_SMMU_TCR_TG0		GENMASK(15, 14)
 #define ARM_SMMU_TCR_SH0		GENMASK(13, 12)
 #define ARM_SMMU_TCR_ORGN0		GENMASK(11, 10)
 #define ARM_SMMU_TCR_IRGN0		GENMASK(9, 8)
+#define ARM_SMMU_TCR_EPD0		BIT(7)
 #define ARM_SMMU_TCR_T0SZ		GENMASK(5, 0)
 
 #define ARM_SMMU_VTCR_RES1		BIT(31)
@@ -347,12 +349,23 @@ struct arm_smmu_domain {
 
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 {
-	return ARM_SMMU_TCR_EPD1 |
-	       FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
-	       FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
-	       FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
-	       FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
-	       FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
+	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
+		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
+		FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
+		FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
+		FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
+
+       /*
+	* When TTBR1 is selected shift the TCR fields by 16 bits and disable
+	* translation in TTBR0
+	*/
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
+		tcr = (tcr << 16) & ~ARM_SMMU_TCR_A1;
+		tcr |= ARM_SMMU_TCR_EPD0;
+	} else
+		tcr |= ARM_SMMU_TCR_EPD1;
+
+	return tcr;
 }
 
 static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
-- 
2.17.1

