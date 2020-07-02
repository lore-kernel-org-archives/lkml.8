Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026042088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="NsMNCLtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGBURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGBURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:17:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE82C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:17:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so33811635ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9HqU9qZ8LmsuIM9rC8wWt6FyyRyxinkgL6r/PQ1v140=;
        b=NsMNCLtvpw+rfbkzZ7WMHoUxkhwYpEr7ti2zDzD4RO214DSM61TASKnJ70FUtvL8Xe
         OPkb+gbm15X1yDJx8XxVSNyulMFihrw0kGMzp8vrp1BuuVpeJX/44bcILZU1krIWZ1ij
         TCU/iBWbRN7DpMH6Osw8VUjMetNmm0b7KEZZj4o1KCjJjNrY8KaBojlb9ezzxTtQVnmh
         ciCxQfncvCUnyTDyh/AyZkjjtzGGjrpW0bj/UIgKdP1x6X/BPSLWc/7Qb/0pwsUDF8WI
         pCfcE1Jy0ZYxCK29bhuFMsA3hjr0CQFi6Yq6smYXJZhNjvpLa4GTNN/vGt8GXvyzOIqP
         7kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9HqU9qZ8LmsuIM9rC8wWt6FyyRyxinkgL6r/PQ1v140=;
        b=tMi3ezIe5UT4/9eOw4elfqihSw69AxGFUAmJ1crvxAO3ZOKczuaJty0v9FLta8QIlO
         52Bif5CXmMo5ofDhAtxM69rArde10+KI0KgsDhlh4jHhQXXQDqacH3NTAH7hDqPnmJiy
         WJgngzlVnHIUxwJqrP23V1L+EfAQEbdMlr3n9NMbTDNUE1HFPT864KhmIrqVma4Ol7qJ
         x35AYKoAa0obdImjKh0c86vDhSmdAnaOVj/ub/VAEBhMWNc8FwgTnRCBZiGMEZuIZaq3
         +ezLBwkqNXi5x+2wz1Rh6lmrzHywjKCtlbQT4IN97tAT3R3W4OKCNEfL3t/dZ0YdFFis
         +ooA==
X-Gm-Message-State: AOAM530mGpLsTq3YXNKv37BpFoLao9zKsfPS3jvVZLWJxHIibBsELvU1
        FbwKbl4n++8TU+CibPdgtuf5AQ==
X-Google-Smtp-Source: ABdhPJxGJkhWxJ6CLztWNrISccJQIv1xdDY/rNe/lZBtJ1m/1dz/spNq4FMTtpQYU5jq8Ot1Y9n/tA==
X-Received: by 2002:a2e:2c18:: with SMTP id s24mr10019389ljs.291.1593721020921;
        Thu, 02 Jul 2020 13:17:00 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:17:00 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v3 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
Date:   Thu,  2 Jul 2020 22:16:31 +0200
Message-Id: <20200702201633.22693-3-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
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

Note that separate writes/reads to 2 is not problem regards to
atomicity, because the driver use the readq/writeq while initialize
the SMMU, report for SMMU fault, and use spinlock in one
case (iova_to_phys).

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/iommu/arm-smmu-impl.c          | 52 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index c75b9d957b70..c1fc5e1b8193 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -147,6 +147,53 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
+{
+	u64 val;
+
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	val = (u64)readl_relaxed(arm_smmu_page(smmu, page) + off + 4) << 32;
+	val |= readl_relaxed(arm_smmu_page(smmu, page) + off);
+
+	return val;
+}
+
+static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
+			       u64 val)
+{
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	writel_relaxed(upper_32_bits(val), arm_smmu_page(smmu, page) + off + 4);
+	writel_relaxed(lower_32_bits(val), arm_smmu_page(smmu, page) + off);
+}
+
+static u32 mrvl_mmu500_cfg_id2_fixup(u32 id)
+{
+
+	/*
+	 * Armada-AP806 erratum #582743.
+	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
+	 * formats altogether and allow using 32 bits access on the
+	 * interconnect.
+	 */
+	id &= ~(ARM_SMMU_ID2_PTFS_4K | ARM_SMMU_ID2_PTFS_16K |
+		ARM_SMMU_ID2_PTFS_64K);
+
+	return id;
+}
+
+static const struct arm_smmu_impl mrvl_mmu500_impl = {
+	.read_reg64 = mrvl_mmu500_readq,
+	.write_reg64 = mrvl_mmu500_writeq,
+	.cfg_id2_fixup = mrvl_mmu500_cfg_id2_fixup,
+	.reset = arm_mmu500_reset,
+};
+
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -160,6 +207,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	 */
 	switch (smmu->model) {
 	case ARM_MMU500:
+		if (of_device_is_compatible(smmu->dev->of_node,
+					    "marvell,ap806-smmu-500")) {
+			smmu->impl = &mrvl_mmu500_impl;
+			return smmu;
+		}
 		smmu->impl = &arm_mmu500_impl;
 		break;
 	case CAVIUM_SMMUV2:
-- 
2.17.1

