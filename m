Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD59C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A00D2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M9rbBpaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGRTfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:35:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16177 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGRTfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 15:35:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f134e7a0002>; Sat, 18 Jul 2020 12:33:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 18 Jul 2020 12:35:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 18 Jul 2020 12:35:11 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 18 Jul
 2020 19:35:08 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 18 Jul 2020 19:35:07 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f134eea0000>; Sat, 18 Jul 2020 12:35:07 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v11 1/5] iommu/arm-smmu: move TLB timeout and spin count macros
Date:   Sat, 18 Jul 2020 12:34:53 -0700
Message-ID: <20200718193457.30046-2-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718193457.30046-1-vdumpa@nvidia.com>
References: <20200718193457.30046-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595100794; bh=qPS2Zde0PkvVJILigsJkjD3Do3jtE9kFjxO2xm+rwAI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=M9rbBpaEoRYm8EV2DiOWt9d9YwENtbZkmGs//oEHYoU9c3iNQWLAiBE/CFo9Vah1Y
         emZRVNQgaIK85moYVKKQvBdpF2k/UzMnIAC5BasTCSm5HiZml0a6bIrBRjIQGSAiqZ
         5z820WELHgI9Jr2fl97Xr17mSqhR+JuaN8HDkHXrKxNGTsdEySXdyqf+LvYXb/cZdS
         1Y5xOdmrI3hGOg+q1Gr8EXPIEE0E3wWj7ncfGWEvK3QOwUgBjPZ3naufiUg//rZEsU
         WLfk1F+qewRrE0w/ckH4XOqcQqd5WdWsjnORQE8J3EnyJSxYAdsbAhM+0HUS79mowU
         eAo2tCpALigUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TLB timeout and spin count macros to header file to
allow using the same from vendor specific implementations.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Pritesh Raithatha <praithatha@nvidia.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 3 ---
 drivers/iommu/arm-smmu.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 19f906de6420..cdd15ead9bc4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,9 +52,6 @@
  */
 #define QCOM_DUMMY_VAL -1
=20
-#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
-#define TLB_SPIN_COUNT			10
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
=20
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be61..c7d0122a7c6c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -236,6 +236,8 @@ enum arm_smmu_cbar_type {
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
=20
+#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
=20
 /* Shared driver definitions */
 enum arm_smmu_arch_version {
--=20
2.26.2

