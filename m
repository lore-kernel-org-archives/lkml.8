Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC978C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBKXhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:37:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40438 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgBKXhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:37:39 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD1D7224B1B;
        Wed, 12 Feb 2020 00:37:36 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B42F224B09;
        Wed, 12 Feb 2020 00:37:36 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 37E4340CB6;
        Tue, 11 Feb 2020 16:37:35 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass parameter
Date:   Tue, 11 Feb 2020 17:36:55 -0600
Message-Id: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module"),
there is a side effect that the module name is changed from arm-smmu to
arm-smmu-mod.  So the kernel parameter for disable_bypass need to be
changed too.  Fix the Kconfig help and error message to the correct
parameter name.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/Kconfig    | 2 +-
 drivers/iommu/arm-smmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d2fade984999..fb54be903c60 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -415,7 +415,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  hardcode the bypass disable in the code.
 
 	  NOTE: the kernel command line parameter
-	  'arm-smmu.disable_bypass' will continue to override this
+	  'arm-smmu-mod.disable_bypass' will continue to override this
 	  config.
 
 config ARM_SMMU_V3
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..2ffe8ff04393 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 		if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
 		    (gfsr & ARM_SMMU_sGFSR_USF))
 			dev_err(smmu->dev,
-				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu.disable_bypass=0\" to allow, but this may have security implications\n",
+				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu-mod.disable_bypass=0\" to allow, but this may have security implications\n",
 				(u16)gfsynr1);
 		else
 			dev_err(smmu->dev,
-- 
2.17.1

