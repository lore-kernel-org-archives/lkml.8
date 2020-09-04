Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F61C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22AB2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMAZ1OmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIDP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgIDPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:55:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55516C06124F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:55:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so6739193qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5uFJW/6fnBFkfrDyRmkYDvlEgZwoUK08VgApDtVqc4=;
        b=EMAZ1OmDd9nFxAqWSODUqd6ceL4IsY1y8RrE5+ltjJztLmCsfdK71uf11dSoSWqOnM
         +Vf02d28fy9I9YsR1nQ7rdmtNQOhU0RUIiz0nUe1mAlTGhDTNejFezB45NW1a4VTvvMD
         8WiPfcmusc0d8CXGgs5v/AE3QiD95HlLyMUguYboj2GCrTgwWRVv4m+kMRk80d1YplUY
         iuW0wy4mPHUz+wbqG4brFkrRDerbs0AGM/WIY+6jerzDQO2wg3Io8Z3JmTbseq4TEXj2
         PIkwmPlXmcW4PDhpX2okwL9LtgyE5EHxoQlG+xJLoGcSyTuV4kTY00rRMvHJIAl04nWy
         MC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5uFJW/6fnBFkfrDyRmkYDvlEgZwoUK08VgApDtVqc4=;
        b=qDzcsqCUlsr96WdtZE+yxQ+ikndhbqmzj8jn+tR/o+Ql0v32WVn60Gzga9pVFJNJvV
         4IK9J6wCZF85WZiDU3LWPW7Itd/1H5l0HDi/9CpapOeTP3eFhKfO9MXSBzipfrZU+R/v
         1uRTKNDSQYWjryuLQdlZEWmE/j5sHsn1HfNJQqX3CG/4dVAG/4IvSXljuMzFbiJKupVH
         eX4mM7vMzIVYAAe+M68XCMDXQbjaPSmUGkwg1dOfLToN+PLF3wuzmon9hP6aDIy5u8BP
         2jRy9jPzThItWgZ5qpuEGLk6bq6JNWbe/yt0DPghNz07xuN4c7WfTo3fLtdAHOSnxO8z
         W3Bw==
X-Gm-Message-State: AOAM533Qm38Fow3q5oHXDO7wgVXyVyszYu/bOjvavVRVyztGTMrymJTR
        YjeTcWltxTrLJ63s09NqiZ3Mmg==
X-Google-Smtp-Source: ABdhPJxd7USRDl6Yb7MfgkAYxzICxZXDUshL8k4VKasevb5x6VcguJCsqPzZGsq59oyACgW/0jcFqg==
X-Received: by 2002:a37:e502:: with SMTP id e2mr8513643qkg.141.1599234918474;
        Fri, 04 Sep 2020 08:55:18 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:55:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/8] iommu/arm-smmu: Consult context bank allocator for identify domains
Date:   Fri,  4 Sep 2020 15:55:08 +0000
Message-Id: <20200904155513.282067-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For implementations of the ARM SMMU where stream mappings of bypass type
are prohibited identity domains can be implemented by using context
banks with translation disabled.

Postpone the decision to skip allocating a context bank until the
implementation specific context bank allocator has been consulted and if
it decides to use a context bank for the identity map, don't enable
translation (i.e. omit ARM_SMMU_SCTLR_M).

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Tie this to alloc_context_bank rather than carrying a Qualcomm specific quirk
  in the generic code.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  4 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 23 +++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 +++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 0663d7d26908..229fc8ff8cea 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -94,8 +94,12 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 					       struct arm_smmu_device *smmu,
 					       struct device *dev, int start)
 {
+	struct iommu_domain *domain = &smmu_domain->domain;
 	int count;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return ARM_SMMU_CBNDX_BYPASS;
+
 	/*
 	 * Assign context bank 0 to the GPU device so the GPU hardware can
 	 * switch pagetables
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index add2e1807e21..eb5c6ca5c138 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -611,7 +611,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* SCTLR */
 	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
-	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
+	      ARM_SMMU_SCTLR_TRE;
+	if (cfg->m)
+		reg |= ARM_SMMU_SCTLR_M;
 	if (stage1)
 		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
@@ -627,9 +629,14 @@ static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_device *smmu,
 				       struct device *dev, unsigned int start)
 {
+	struct iommu_domain *domain = &smmu_domain->domain;
+
 	if (smmu->impl && smmu->impl->alloc_context_bank)
 		return smmu->impl->alloc_context_bank(smmu_domain, smmu, dev, start);
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return ARM_SMMU_CBNDX_BYPASS;
+
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
 }
 
@@ -653,12 +660,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
-		smmu_domain->smmu = smmu;
-		goto out_unlock;
-	}
-
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -757,6 +758,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	ret = arm_smmu_alloc_context_bank(smmu_domain, smmu, dev, start);
 	if (ret < 0) {
 		goto out_unlock;
+	} else if (ret == ARM_SMMU_CBNDX_BYPASS) {
+		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
+		smmu_domain->smmu = smmu;
+		goto out_unlock;
 	}
 
 	smmu_domain->smmu = smmu;
@@ -813,6 +818,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	domain->geometry.force_aperture = true;
 
+	/* Enable translation for non-identity context banks */
+	if (domain->type != IOMMU_DOMAIN_IDENTITY)
+		cfg->m = true;
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 	arm_smmu_write_context_bank(smmu, cfg->cbndx);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index ddf2ca4c923d..235d9a3a6ab6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -243,6 +243,8 @@ enum arm_smmu_cbar_type {
 #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
 #define TLB_SPIN_COUNT			10
 
+#define ARM_SMMU_CBNDX_BYPASS		0xffff
+
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
 	ARM_SMMU_V1,
@@ -346,6 +348,7 @@ struct arm_smmu_cfg {
 	u32				sctlr_clr;    /* bits to mask in SCTLR */
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
+	bool				m;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 
-- 
2.28.0

