Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37CEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66072074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiFL1Ay9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHXSna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgHXSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:43:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990DDC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:43:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so1882808pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORHfJz2e9TNUi11ClButtEprelkWs9RC+Iw7WuZZvQo=;
        b=QiFL1Ay9VZ+o7FljpSkk11RnZQkof5/enbgvZ9/7pqco8XN9U1Hp4Elf8D9nIZRA8C
         nGD5FCRG+OzA+aDgKTU0oOJMz4fa3mXl7u0lD7n28ZSbHqCti/Zt9QxkqsHpaM4NLC3o
         enFNf1XQmCmKZJIaP6vQYsb6HzRH3aKXBN4KuqFyPm4ANqDduI5Ao/TPi5ukL0LW4gBC
         5Uctli6acz1d1aIAAnhKPO5aVrIgSAIZBf3VtqRMv/BoPdq5cT0VOvc+6VYRRTGd2uh/
         5F8EkZDgWqrbkgaT3QhaajydJj2zkeaBerdXPu5aXqu0i6rs20/nOHeGwvzMmO/X3iAP
         0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORHfJz2e9TNUi11ClButtEprelkWs9RC+Iw7WuZZvQo=;
        b=L2w03aXjiiQvQI7VpNuwhQq0RUXc8k9y3F3Lu//KGyFJYUtubvmfH4DZXj9gbmBUd9
         GqEhNAffnjM+XODS7148mkFYDvrxhCTiNoBzzKwd4LZf4YX+Lv9fs1L0odf6mcPYuost
         5WPbj52F/BoOjhQnCMbeMh7vDPltt7/JFaol829LWQ6CUohwll+HZapDFKuzYDON6EIQ
         S7vpqzufN9mQsRmXCsuPmx/9kNsF/2dQFMH7nzo7WRxoZopTxz29sktK1uyvuY97eSh+
         Rn3ywN5juKhmCa4UfnFuYKe+5nr+K4f05dT9Zn2lKPouqBQoj9JFdTry5nmfeqEUtjTm
         1niw==
X-Gm-Message-State: AOAM533+i6wiSrwyrRbR/BO7tanHiwNmKzBw1S869U024LNMnvzxWmod
        LGb7RUbfRHlX37dUXMaj720=
X-Google-Smtp-Source: ABdhPJwn5FgCJ9VyPOqih4HSDVzsr7XdR6VCZfi5iJqTQOJt7mF0wpqzXVZYMoaHoEoWg8tPnsqkYA==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr4753119pll.39.1598294590126;
        Mon, 24 Aug 2020 11:43:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id l5sm3347202pga.43.2020.08.24.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:43:08 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Brian Masney <masneyb@onstation.org>,
        Eric Anholt <eric@anholt.net>, Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 19/20] iommu/arm-smmu: add a way for implementations to influence SCTLR
Date:   Mon, 24 Aug 2020 11:37:53 -0700
Message-Id: <20200824183825.1778810-20-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
pending translations are not terminated on iova fault.  Otherwise
a terminated CP read could hang the GPU by returning invalid
command-stream data.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 5640d9960610..2aa6249050ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -127,6 +127,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
 		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
 
+	/*
+	 * On the GPU device we want to process subsequent transactions after a
+	 * fault to keep the GPU from hanging
+	 */
+	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
+
 	/*
 	 * Initialize private interface with GPU:
 	 */
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index e63a480d7f71..bbec5793faf8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= ARM_SMMU_SCTLR_E;
 
+	reg |= cfg->sctlr_set;
+	reg &= ~cfg->sctlr_clr;
+
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index cd75a33967bb..2df3a70a8a41 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
 #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
+#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
 #define ARM_SMMU_SCTLR_CFIE		BIT(6)
 #define ARM_SMMU_SCTLR_CFRE		BIT(5)
 #define ARM_SMMU_SCTLR_E		BIT(4)
@@ -341,6 +342,8 @@ struct arm_smmu_cfg {
 		u16			asid;
 		u16			vmid;
 	};
+	u32				sctlr_set;    /* extra bits to set in SCTLR */
+	u32				sctlr_clr;    /* bits to mask in SCTLR */
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
 };
-- 
2.26.2

