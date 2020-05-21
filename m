Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A833B20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qAmcV1Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEUXbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:31:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9991 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgEUXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:31:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec70ebb0000>; Thu, 21 May 2020 16:28:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 16:31:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 May 2020 16:31:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 23:31:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 21 May 2020 23:31:23 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec70f4b0002>; Thu, 21 May 2020 16:31:23 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v5 2/5] dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
Date:   Thu, 21 May 2020 16:31:04 -0700
Message-ID: <20200521233107.11968-3-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521233107.11968-1-vdumpa@nvidia.com>
References: <20200521233107.11968-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590103739; bh=TG4gqxjL+s2Hy+PeTtRv+rn2Rlan9hLed3GxOxkRROI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=qAmcV1XuhAyjhWi176fKN9d4IZFIv+pBgdrHWGN0w50ixS0RuYE7vyq/xs27BvC/C
         vLjQAdXEVNW8OrcBkGZR2oDHfSR7kq7Gak4lexI9Zmwt7eee7Vs78Sm1C0npAPV825
         42lceW05aDoFM6lMiY1LCuceA0uxx10CJF56XfJwQv+ZyGkECaPtHOQBLzDM3bMzBK
         hTEMdrXCucFG0x0TAsFbLS8KZL4sHJQEucR/Bm+uENOk0EQ4+c7PUU0T7PkwBTn/KH
         4ekg48taQd4oexC2Stz3DamJlOqCcUp56cs47TAIHkt0hI4vFeeZME64XawloDXJ+K
         898DU/981jdtg==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for NVIDIA's Tegra194 Soc SMMU that is based
on ARM MMU-500.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docume=
ntation/devicetree/bindings/iommu/arm,smmu.yaml
index 6515dbe47508..78aba7dd5a61 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,11 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
+        items:
+          - enum:
+              - nvdia,tegra194-smmu-500
+          - const: arm,mmu-500
       - items:
           - const: arm,mmu-500
           - const: arm,smmu-v2
--=20
2.26.2

