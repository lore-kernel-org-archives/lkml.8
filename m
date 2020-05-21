Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4396A20825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oXQHWs4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgEUXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:31:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10001 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbgEUXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:31:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec70ebb0002>; Thu, 21 May 2020 16:28:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 16:31:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 16:31:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 23:31:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 21 May 2020 23:31:23 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec70f4b0005>; Thu, 21 May 2020 16:31:23 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v5 5/5] arm64: tegra: enable SMMU for SDHCI and EQOS on T194
Date:   Thu, 21 May 2020 16:31:07 -0700
Message-ID: <20200521233107.11968-6-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521233107.11968-1-vdumpa@nvidia.com>
References: <20200521233107.11968-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590103739; bh=gpJ7zVDEktQWdt8OOZ30mXZsuHmqPjP7Fg0Tdm8sNVg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=oXQHWs4XYEP3NOSJsoPvq5vf2dtfVy1SUVU04A6jGkEO9Xjnwilh0d0R67zhOygcU
         3cI8gKO47XqWKY4T6/73ueHdnDpUFQMuU5e6HcgEeAIred5f8d1h9SlgHKIVee6VH0
         WlfIPFaAxJgVQuzTTzGFW7mbHQo1z/hlJOknUrIIKnnduU7R1Rxu4aFavb0aj1IsIY
         FIgn8wonsiRy5EyoG3psUr3W9x3LihXYGBMkDjAghvMgwg1e0cg+FLMresg7UomVJG
         BoV/gBkEO8wKFPNfKUZJ26h3Y2VytZMDRDhG8Scafj0WxmO7IBU4A1ixhXB9L4F4Kz
         totbuTXOTMY6Q==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SMMU translations for SDHCI and EQOS transactions on T194.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra194.dtsi
index f7c4399afb55..706bbb439dcd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -59,6 +59,7 @@ ethernet@2490000 {
 			clock-names =3D "master_bus", "slave_bus", "rx", "tx", "ptp_ref";
 			resets =3D <&bpmp TEGRA194_RESET_EQOS>;
 			reset-names =3D "eqos";
+			iommus =3D <&smmu TEGRA194_SID_EQOS>;
 			status =3D "disabled";
=20
 			snps,write-requests =3D <1>;
@@ -457,6 +458,7 @@ sdmmc1: sdhci@3400000 {
 			clock-names =3D "sdhci";
 			resets =3D <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names =3D "sdhci";
+			iommus =3D <&smmu TEGRA194_SID_SDMMC1>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout =3D
 									<0x07>;
 			nvidia,pad-autocal-pull-down-offset-3v3-timeout =3D
@@ -479,6 +481,7 @@ sdmmc3: sdhci@3440000 {
 			clock-names =3D "sdhci";
 			resets =3D <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names =3D "sdhci";
+			iommus =3D <&smmu TEGRA194_SID_SDMMC3>;
 			nvidia,pad-autocal-pull-up-offset-1v8 =3D <0x00>;
 			nvidia,pad-autocal-pull-down-offset-1v8 =3D <0x7a>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout =3D <0x07>;
@@ -506,6 +509,7 @@ sdmmc4: sdhci@3460000 {
 					  <&bpmp TEGRA194_CLK_PLLC4>;
 			resets =3D <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names =3D "sdhci";
+			iommus =3D <&smmu TEGRA194_SID_SDMMC4>;
 			nvidia,pad-autocal-pull-up-offset-hs400 =3D <0x00>;
 			nvidia,pad-autocal-pull-down-offset-hs400 =3D <0x00>;
 			nvidia,pad-autocal-pull-up-offset-1v8-timeout =3D <0x0a>;
--=20
2.26.2

