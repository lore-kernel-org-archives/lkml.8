Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B4C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0F20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBLAho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:37:44 -0500
Received: from inva020.nxp.com ([92.121.34.13]:49028 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgBLAhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:37:43 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E5881C6A9B;
        Wed, 12 Feb 2020 01:37:41 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 628A41A00C8;
        Wed, 12 Feb 2020 01:37:41 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8E69B40CB6;
        Tue, 11 Feb 2020 17:37:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu: fix the module name to be consistent with older kernel
Date:   Tue, 11 Feb 2020 18:37:20 -0600
Message-Id: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
introduced a side effect that changed the module name from arm-smmu to
arm-smmu-mod.  This breaks the users of kernel parameters for the driver
(e.g. arm-smmu.disable_bypass).  This patch changes the module name back
to be consistent.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/Makefile                          | 4 ++--
 drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2104fb8afc06..f39e82e68640 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
-arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
+arm-smmu-objs := arm-smmu-common.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu-common.c
similarity index 100%
rename from drivers/iommu/arm-smmu.c
rename to drivers/iommu/arm-smmu-common.c
-- 
2.17.1

