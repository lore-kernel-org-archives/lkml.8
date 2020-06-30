Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2CC207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TnWnFpc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgF3X7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:59:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17089 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgF3X7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:59:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efbd1c80000>; Tue, 30 Jun 2020 16:59:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 16:59:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 16:59:17 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 23:59:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:59:11 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efbd1cf000d>; Tue, 30 Jun 2020 16:59:11 -0700
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
Subject: [PATCH v9 3/4] dt-bindings: arm-smmu: add binding for Tegra194 SMMU
Date:   Tue, 30 Jun 2020 16:57:51 -0700
Message-ID: <20200630235752.8737-4-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630235752.8737-1-vdumpa@nvidia.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593561544; bh=lsO6WUFTxN9lFHEUuLsqfufII7AoweScei4UwHkFK5w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=TnWnFpc8Kt9V+RVBMkd/q3st6w5H4OAtjALEAv3sDIlcWsAuf+4k8Oa/GHUSr3ueQ
         jwBmrE/xQK/crO3xs/aGtol/oTbyv3lHrZi8Uw7xmAnOM0jYq9FgVXcfVCXnlTHVP+
         LGUHMgsOzlEtE69Sej6tah0GlNRMq87ymabKBDtOrzCvbxCsdFy5lRQ6AC2yD3NE4j
         h1HFtIReklGGjrtsUGp0XSe8DitHfCXO+8VkLAkrVB0xcsRxinJBH9E/Y8FsYCgFgj
         32ozZUpaCNYivXW2QB4UHVzU5hN4qPx3rsO3kBt4IGEdP6ta7feuwxrfm0KS41Wlja
         7PoVkI07PdGBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for NVIDIA's Tegra194 SoC SMMU topology that is based
on ARM MMU-500.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docume=
ntation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423b..662c46e16f07d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,11 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
+        items:
+          - enum:
+              - nvidia,tegra194-smmu
+          - const: arm,mmu-500
       - items:
           - const: arm,mmu-500
           - const: arm,smmu-v2
@@ -138,6 +143,19 @@ required:
=20
 additionalProperties: false
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-smmu
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 3
+
 examples:
   - |+
     /* SMMU with stream matching or stream indexing */
--=20
2.26.2

