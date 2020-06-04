Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F84207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rBXETk7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgFDXoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:44:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5612 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFDXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:44:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed987420002>; Thu, 04 Jun 2020 16:44:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 16:44:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 16:44:14 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 23:44:12 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Jun 2020 23:44:11 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed9874a0005>; Thu, 04 Jun 2020 16:44:11 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v6 2/4] dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
Date:   Thu, 4 Jun 2020 16:44:12 -0700
Message-ID: <20200604234414.21912-3-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604234414.21912-1-vdumpa@nvidia.com>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591314242; bh=LA4k1vg82nqOEyJBiSaKjPU8uIzrWZealS2lAAvphgk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rBXETk7xwGWbuVNmN3vTOczEhnc2iu7nNASUTnfsSUnD1Ps9OVc+EwjmoWr1lQjq/
         AhP403/amHyAdT60kq+RZj0kHiG/eJ76nAGWigpdvjTfxlEcDUxOE4K3Om42mdWTay
         FsCQUW0PqZaNkppdD62IO/GKKiJDAURu2JmB+R1bAQxmp9j58IE93+JAyMhU4q1ytc
         C5CjYv0lG7nF9iNNBSakm/V8Ydazp7tF/MH44FPjVeHcHPWNGKCbAZg8RX6QyttlEM
         HnJLi7Zu8IjMgZ6SxHIYiIRdU00obAzoDTMXHXRqjXRR1djtCGOIoFx3hyel0TlFlz
         wfBHUbGXow46A==
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
index e3ef1c69d1326..8f7ffd248f303 100644
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

