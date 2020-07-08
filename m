Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D722078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T2uiJPq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGHFAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:00:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4021 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgGHFAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:00:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0552ad0000>; Tue, 07 Jul 2020 21:59:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 22:00:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 22:00:18 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 05:00:13 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jul 2020 05:00:13 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0552dd000c>; Tue, 07 Jul 2020 22:00:13 -0700
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
Subject: [PATCH v10 2/5] iommu/arm-smmu: ioremap smmu mmio region before implementation init
Date:   Tue, 7 Jul 2020 22:00:14 -0700
Message-ID: <20200708050017.31563-3-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708050017.31563-1-vdumpa@nvidia.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594184365; bh=PhjkGp3ntJu3QkzUq1sohlnOliXJ0oXruRJvrVkl3CE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=T2uiJPq1sUAEUnbU7fpPnCX+OqeOkeDz2nlRats29SF5zVpgEbFlROLDKeD6DKb2W
         ozBpCAh2EoU4F6GMMmECqXkh2yzeBKET6fHGc/ko+jT8YIhK4t48hIaqpz2nP6ckC0
         UkXOWBL/BDTQc5zNU++fCpTYoup3Q+KpH2RVzstz+SGBVKSVEC6+JT9vrFeXkp6R+H
         NA8yO/LFErJJRfxthxcY9XO/0YRnexVWJ4FhTbmDego2oDc+oCvTIptagdV2M2aCtG
         G/zSa9trpDCkPok0rofHVvixLrFLy3vDMTZtmLcTDdtk2stMI3QMRar7hiWKuIJbE8
         OywHlFBJFjpDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap smmu mmio region before calling into implementation init.
This is necessary to allow mapped address available during vendor
specific implementation init.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d2054178df35..e03e873d3bca 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2120,10 +2120,6 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 	if (err)
 		return err;
=20
-	smmu =3D arm_smmu_impl_init(smmu);
-	if (IS_ERR(smmu))
-		return PTR_ERR(smmu);
-
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ioaddr =3D res->start;
 	smmu->base =3D devm_ioremap_resource(dev, res);
@@ -2135,6 +2131,10 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 	 */
 	smmu->numpage =3D resource_size(res);
=20
+	smmu =3D arm_smmu_impl_init(smmu);
+	if (IS_ERR(smmu))
+		return PTR_ERR(smmu);
+
 	num_irqs =3D 0;
 	while ((res =3D platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
 		num_irqs++;
--=20
2.26.2

