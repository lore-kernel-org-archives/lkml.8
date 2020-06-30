Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83511C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D9F206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PP456qCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgF3X7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:59:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17079 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgF3X7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:59:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efbd1c70001>; Tue, 30 Jun 2020 16:59:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 16:59:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 16:59:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 23:59:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:59:11 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efbd1cf0007>; Tue, 30 Jun 2020 16:59:11 -0700
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
        <nicoleotsuka@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v9 1/4] iommu/arm-smmu: move TLB timeout and spin count macros
Date:   Tue, 30 Jun 2020 16:57:49 -0700
Message-ID: <20200630235752.8737-2-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630235752.8737-1-vdumpa@nvidia.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593561543; bh=wmP8aEJrSuDbPANLVhp+EMx58hwLpDh00JZdQDiNzyI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=PP456qCveo+JyKZ6hK3+Igrag5/IXQnIgtjTKb971wTGHg4i7b+Z8N+hsfcncbA3L
         QQU28XlFpSNr0SOfYAl9csul1/ZWV5bzdC63GisqbyL4+ff0ziA4puQDO6H2wcPPHY
         EQnTtiMYb1QTPiZ5Ll8Xjq3ZNBbVwvZiL429HxCWqUyoGwFdrhJbCaV3pY4+i2vfKA
         U8HtsOZsidlipphE0USUs/fzPUKdUqSq97rsjaQZ3hHNi9h5FJrqKBYvm9W+QgAuTR
         AcxdJRiQ0FZZif+XjlxwiBI+l2mAbqt9vNGrvovMR25cQEAn2eXj9DAW1XbeQlA5tw
         nX6HuRM+znKxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TLB timeout and spin count macros to header file to
allow using the same values from vendor specific implementations.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 3 ---
 drivers/iommu/arm-smmu.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705b..d2054178df357 100644
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
index d172c024be618..c7d0122a7c6ca 100644
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

