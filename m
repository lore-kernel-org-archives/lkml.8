Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3692C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBCB2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kFzaIrtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCWRwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:52:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17093 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgCWRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:52:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e78f7110000>; Mon, 23 Mar 2020 10:51:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 23 Mar 2020 10:52:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 23 Mar 2020 10:52:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Mar
 2020 17:52:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Mar 2020 17:52:42 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.160.78]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e78f76a0000>; Mon, 23 Mar 2020 10:52:42 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v5 9/9] arm64: tegra: Add Tegra VI CSI support in device tree
Date:   Mon, 23 Mar 2020 10:52:35 -0700
Message-ID: <1584985955-19101-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584985955-19101-1-git-send-email-skomatineni@nvidia.com>
References: <1584985955-19101-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584985873; bh=qg4/50YwdGiG0ifmC8NW2wUPpPGLSESHVND184P5UFw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kFzaIrtxtdihQI5PAHWVWD/UqOIby7BGGDpM+ZaaV/ObTaFIMJs+ZJWEWARzbmnXT
         Ca204D+JfmYqEQNxS8Rh24W/uHV2S3AhvYPNR6ZQgEmZhYyLa4CH9oOu1+XLiiBtaF
         zZqG/v/6VGz9uuAS1exEQMqWOkOKo6mDGJmhVvSLmcYvLnkh1fBPVH8J36Jmhn14Rg
         yzHqgp0rFSHyF6z5PcjxpQVFLNW1phlCBNXTIiRIe10ZnjaaGjO9zkHzbPS/kMwIrN
         6UgbN+jg/cWGn+mTW9SyomtuhIZYwvL1Be1T1gKqRdQS8ktM0A26X4/z6O1tuD8Pv4
         t0wEW0mA7D7Tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 contains VI controller for video input capture from MIPI
CSI camera sensors and also supports built-in test pattern generator.

CSI ports can be one-to-one mapped to VI channels for capturing from
an external sensor or from built-in test pattern generator.

This patch adds support for VI and CSI and enables them in Tegra210
device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 10 ++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 45 +++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 313a4c2..b57d837 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -14,6 +14,16 @@
 			status = "okay";
 		};
 
+		vi@54080000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&vdd_dsi_csi>;
+
+			csi@838 {
+				status = "okay";
+			};
+		};
+
 		sor@54580000 {
 			status = "okay";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 5b1dfd8..2deba87 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -137,9 +137,43 @@
 
 		vi@54080000 {
 			compatible = "nvidia,tegra210-vi";
-			reg = <0x0 0x54080000 0x0 0x00040000>;
+			reg = <0x0 0x54080000 0x0 0x700>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			assigned-clocks = <&tegra_car TEGRA210_CLK_VI>;
+			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+
+			clocks = <&tegra_car TEGRA210_CLK_VI>;
+			clock-names = "vi";
+			power-domains = <&pd_venc>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x0 0x54080000 0x2000>;
+
+			csi@838 {
+				compatible = "nvidia,tegra210-csi";
+				reg = <0x838 0x1300>;
+				status = "disabled";
+				assigned-clocks = <&tegra_car TEGRA210_CLK_CILAB>,
+						  <&tegra_car TEGRA210_CLK_CILCD>,
+						  <&tegra_car TEGRA210_CLK_CILE>;
+				assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_P>,
+							 <&tegra_car TEGRA210_CLK_PLL_P>,
+							 <&tegra_car TEGRA210_CLK_PLL_P>;
+				assigned-clock-rates = <102000000>,
+						       <102000000>,
+						       <102000000>;
+
+				clocks = <&tegra_car TEGRA210_CLK_CSI>,
+					 <&tegra_car TEGRA210_CLK_CILAB>,
+					 <&tegra_car TEGRA210_CLK_CILCD>,
+					 <&tegra_car TEGRA210_CLK_CILE>;
+				clock-names = "csi", "cilab", "cilcd", "cile";
+				power-domains = <&pd_sor>;
+			};
+
 		};
 
 		tsec@54100000 {
@@ -839,6 +873,15 @@
 				reset-names = "vic";
 				#power-domain-cells = <0>;
 			};
+
+			pd_venc: venc {
+				clocks = <&tegra_car TEGRA210_CLK_VI>,
+					 <&tegra_car TEGRA210_CLK_CSI>;
+				resets = <&mc TEGRA210_MC_RESET_VI>,
+					 <&tegra_car TEGRA210_RST_VI>,
+					 <&tegra_car TEGRA210_CLK_CSI>;
+				#power-domain-cells = <0>;
+			};
 		};
 
 		sdmmc1_3v3: sdmmc1-3v3 {
-- 
2.7.4

