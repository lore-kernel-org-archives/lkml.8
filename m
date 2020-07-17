Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F1C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3564D20787
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACUa/dg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGQAQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgGQAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36516C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so5775824pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYsMERNFzcWVzzWKbxXkh/fS5B+pLfajmEgKGDyW4yE=;
        b=ACUa/dg0RtByVMt9xT8idk9edkL1VWJ+N7/9FygWGHzA75v425qOq0Z8LN40KT48aQ
         XS+uAB6LyIMEXYIm6xVr8V/lfpFNWEfD0sd1XgRGnyTDRKRk2eL/F3PTm0dyZIVhbCqw
         MVJD6CT7OYkIUAbzHKZSCuf7bppvuS8+OxFPlu/eEr+Nd+S6mOumj6wpwaxxWTJ69sB/
         kEFuECFghKm8t17l3PHuKfjJsJ6nQSGNtzlFVWOR8i5+tPMJADbxpJO492+meqeVpTUz
         oCM4cFpko71JnxaLabhcDlrbF9bqfKG7GQXRQA9v8u0MDZuK7zcvNd+x8ZRjIx85dd3s
         jdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYsMERNFzcWVzzWKbxXkh/fS5B+pLfajmEgKGDyW4yE=;
        b=ubwGxUln2TRtS6IkiMZE8jQfDpxoVzzId0oFs88Rn8YPL7kBrWqhX95cdNRPUEyKS9
         4PuFQyIhB3UkGtoXqIfVWiJQ6fRsr+9LNTMoKlxrzczU+o9FBVDtTdBS2qv+CF2TjNeL
         gL42/a8uFWgYjpJpJXsrfOJ8K449kksgkk7YN2+rxn25dIgYJ1W0sY3UFdOhvYVA4j3q
         +a3B6s/2d3a7X2xuOWoHL1gjBaJxo3YDtiix9WfPLzVKijqJ7z+LAVAIr2iHukAhX+vI
         I10wMAFCZRKkDToKKqQOs9AWkQmtujTtMz8PoYNsX1b4SvJCWa2+ySFk9rl8R96sltDH
         B4TQ==
X-Gm-Message-State: AOAM5328FH7S281vN2hQ1+fwdArVEVMChnDId3EPthfT7jBR/Ub643Yv
        HcHvrLgpQ9ZnIu8+xlujg2I/Cw==
X-Google-Smtp-Source: ABdhPJwiyfAnAN/TK+ra7+uHH2Vvek0wIikdAmdNSXORE85NgOe0yoW3wbsVsxu+69uyGeh2UlLvqg==
X-Received: by 2002:a63:1b4b:: with SMTP id b11mr6245310pgm.243.1594944984685;
        Thu, 16 Jul 2020 17:16:24 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/5] iommu/arm-smmu: Emulate bypass by using context banks
Date:   Thu, 16 Jul 2020 17:16:16 -0700
Message-Id: <20200717001619.325317-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmware found on various Qualcomm platforms traps writes to S2CR
of type BYPASS and writes FAULT into the register. This prevents us from
marking the streams for the display controller as BYPASS to allow
continued scanout of the screen through the initialization of the ARM
SMMU.

This adds a Qualcomm specific cfg_probe function, which probes the
behavior of the S2CR registers and if found faulty enables the related
quirk. Based on this quirk context banks are allocated for IDENTITY
domains as well, but with ARM_SMMU_SCTLR_M omitted.

The result is valid stream mappings, without translation.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up tested-by

 drivers/iommu/arm-smmu-qcom.c | 21 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
 drivers/iommu/arm-smmu.h      |  3 +++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index be4318044f96..d95a5ee8c83c 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -23,6 +23,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	u32 reg;
+
+	/*
+	 * With some firmware writes to S2CR of type FAULT are ignored, and
+	 * writing BYPASS will end up as FAULT in the register. Perform a write
+	 * to S2CR to detect if this is the case with the current firmware.
+	 */
+	arm_smmu_gr0_write(smmu, last_s2cr, FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
+					    FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
+					    FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
+	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+		smmu->qcom_bypass_quirk = true;
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -61,6 +81,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 };
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fb85e716ae9a..5d5fe6741ed4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -654,7 +654,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* SCTLR */
 	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
-	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
+	      ARM_SMMU_SCTLR_TRE;
+	if (cfg->m)
+		reg |= ARM_SMMU_SCTLR_M;
 	if (stage1)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
@@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	/*
+	 * Nothing to do for IDENTITY domains,unless disabled context banks are
+	 * used to emulate bypass mappings on Qualcomm platforms.
+	 */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
 		smmu_domain->smmu = smmu;
 		goto out_unlock;
@@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
 
+	/* Enable translation for non-identity context banks */
+	if (domain->type != IOMMU_DOMAIN_IDENTITY)
+		cfg->m = true;
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 	arm_smmu_write_context_bank(smmu, cfg->cbndx);
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be61..a71d193073e4 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -305,6 +305,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	bool				qcom_bypass_quirk;
 };
 
 enum arm_smmu_context_fmt {
@@ -323,6 +325,7 @@ struct arm_smmu_cfg {
 	};
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
+	bool				m;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
-- 
2.26.2

