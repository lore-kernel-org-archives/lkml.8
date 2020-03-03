Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11557C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20072146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583267285;
	bh=oYZc5mRrLdXWissZPEz+IDkoB4nsZeRxMo6j9CXYSoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCTN/WSWgkfszMoC39z0EonJ+kStprgwODzHNcYjyyphqz56RWLXvQ8tC9JGQv7X+
	 OYX3pvqtb5MPvTRUe8WNOvPIlRhp63tvpQoQ+B5gXElniGbN4xJpon+T+WPmKkHt4b
	 gAwTw9a8df32xKeSjfVPf2sH2oLYLiPtYH6UYvWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgCCU2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbgCCU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:28:03 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC54214D8;
        Tue,  3 Mar 2020 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267282;
        bh=oYZc5mRrLdXWissZPEz+IDkoB4nsZeRxMo6j9CXYSoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6zNorFDnS/4lfRzfFnjBIimLJ0Pbe5haM/dorwLpuBv2bQL4ULQfHzXt4VdMx6Nb
         00qcyoISlDdlqqxkI4dqwIa7EySUoPkXlNXTPEP3QxNyfWE5tg8B7o1GB8mUGQtWCE
         jjzmL3PkaPxiUCAicWeivda8uRIliC+MBZG47vHY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Suman Anna <s-anna@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 4/4] iommu: Enable compile testing for some of drivers
Date:   Tue,  3 Mar 2020 21:27:51 +0100
Message-Id: <20200303202751.5153-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303202751.5153-1-krzk@kernel.org>
References: <20200303202751.5153-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the IOMMU drivers can be compile tested to increase build
coverage.  The OMAP, Rockchip and Exynos drivers use
device.dev_archdata.iommu field which does not exist on all platforms.
The sPAPR TCE and ARM SMMU have also restrictions where they can be
built.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c5df570ef84a..9eb9e16eb620 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -273,7 +273,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARM && MMU
+	depends on ARM && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select IOMMU_API
 	---help---
@@ -291,7 +291,7 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || (COMPILE_TEST && (ARM64 || IA64 || SPARC))
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -325,7 +325,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && MMU
+	depends on ARCH_EXYNOS && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -361,7 +361,7 @@ config IPMMU_VMSA
 
 config SPAPR_TCE_IOMMU
 	bool "sPAPR TCE IOMMU Support"
-	depends on PPC_POWERNV || PPC_PSERIES
+	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -370,7 +370,7 @@ config SPAPR_TCE_IOMMU
 # ARM IOMMU support
 config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
-	depends on (ARM64 || ARM) && MMU
+	depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -440,7 +440,7 @@ config S390_IOMMU
 
 config S390_CCW_IOMMU
 	bool "S390 CCW IOMMU Support"
-	depends on S390 && CCW
+	depends on S390 && CCW || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -448,7 +448,7 @@ config S390_CCW_IOMMU
 
 config S390_AP_IOMMU
 	bool "S390 AP IOMMU Support"
-	depends on S390 && ZCRYPT
+	depends on S390 && ZCRYPT || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -456,7 +456,7 @@ config S390_AP_IOMMU
 
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.17.1

