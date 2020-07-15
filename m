Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A667C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13CC20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="gF+PCH8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGOHHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgGOHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:07:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7DCC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so1351375lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKlU4lKdj3Ftg6VNKCWCajRZmLcVTJL9ntL6mukO1Xo=;
        b=gF+PCH8lg8YMRFFsAE56yzhfmMGgdqCwmFwD+TI9qs4NjXA1tiHS6Ng9cBRIlXAV0+
         WCkjEPG3UJIHt6DeJHB/FjIubAtTL7CyxsoPExKei5HJM7ySufym6lJ+h8iRL9+vTUsw
         ISdsHJA9pYutZad938G9Urv189itUM0pmpe5WHRkQeLIjIhFcCykEhxNOtkdVMccCWtz
         EaTHFk3ScQ1oGdXiGcH/YtvSNom4QWkw2pEzygUwSi6xF6IHglEVq5V0amRAeFsVCEkZ
         +HTLxpKlANISyR6cgjlLextWUoGANjHqlz0Lv5HJ6im9wyutODiiMlXFlGzJTSIoqyIs
         zuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKlU4lKdj3Ftg6VNKCWCajRZmLcVTJL9ntL6mukO1Xo=;
        b=NHhbkGr+xkMYfizvZNEshEyN1Dh6N615z7FDhLyEklW+TQTIx3rLx/rRJetnc/ct9B
         EGZQ9l5GUK+3G66jvT5Q4FaURZG6XeyiHgDLtvHcdUrWzbbkDVgjB6MNONrXcf5z+I++
         t64huIOcDfqnTdP597xbofIawR7KFOFfaHq2XEnvkUqHS650poG28Ub4saV8M2fL1WV8
         oHcm0OpmTOJaFH1gJmZIewWc6AM04+uXsiwGrDc9+PvTsK3ZVmQgbXL3zu7HFHhDMAJV
         9loO5oQJX2vc0eW+HtDKssd4ofQpyfWqd3zO4CU32rACYsgCSJTEE8622IizMeRiYe5n
         Wecg==
X-Gm-Message-State: AOAM530DvWfrZpc4QHMtdpEe1xu5fal0yZp/nM2p16hg94cqAvrK978q
        Pl1vTurDt9s+Tcng0o3gQ2OX+w==
X-Google-Smtp-Source: ABdhPJyht9u1Fi6qxzop87V103kj55HzGKn38flKrFtKPYX7IW+C8BjpSSZJXdo5uDLpBlP6rEyH7Q==
X-Received: by 2002:a2e:9585:: with SMTP id w5mr3671931ljh.58.1594796822599;
        Wed, 15 Jul 2020 00:07:02 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:07:01 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v4 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
Date:   Wed, 15 Jul 2020 09:06:47 +0200
Message-Id: <20200715070649.18733-3-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
ARM SMMUv2 registers.

Provide implementation relevant hooks:
- split the writeq/readq to two accesses of writel/readl.
- mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format (but
only AARCH32_L) since with AArch64 format 32 bits access is not supported.

Note that most 64-bit registers like TTBRn can be accessed as two 32-bit
halves without issue, and AArch32 format ensures that the register writes
which must be atomic (for TLBI etc.) need only be 32-bit.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/iommu/arm-smmu-impl.c          | 45 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 936cf2a59ca4..157214d3abe1 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -125,6 +125,9 @@ stable kernels.
 | Cavium         | ThunderX2 Core  | #219            | CAVIUM_TX2_ERRATUM_219      |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b70..59422cb92488 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -147,6 +147,48 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + off);
+}
+
+static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
+			       u64 val)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + off);
+}
+
+static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
+{
+
+	/*
+	 * Armada-AP806 erratum #582743.
+	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
+	 * formats altogether and allow using 32 bits access on the
+	 * interconnect.
+	 */
+	smmu->features &= ~(ARM_SMMU_FEAT_FMT_AARCH64_4K |
+			    ARM_SMMU_FEAT_FMT_AARCH64_16K |
+			    ARM_SMMU_FEAT_FMT_AARCH64_64K);
+
+	return 0;
+}
+
+static const struct arm_smmu_impl mrvl_mmu500_impl = {
+	.read_reg64 = mrvl_mmu500_readq,
+	.write_reg64 = mrvl_mmu500_writeq,
+	.cfg_probe = mrvl_mmu500_cfg_probe,
+	.reset = arm_mmu500_reset,
+};
+
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -175,5 +217,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
 
+	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
+		smmu->impl = &mrvl_mmu500_impl;
+
 	return smmu;
 }
-- 
2.17.1

