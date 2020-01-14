Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC7C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D63207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FR4gQE4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgANHZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:25:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6473 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgANHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6ca50000>; Mon, 13 Jan 2020 23:24:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 23:24:41 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:41 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:41 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:40 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cb80000>; Mon, 13 Jan 2020 23:24:40 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 15/22] ARM: tegra: Update sound node clocks in device tree
Date:   Mon, 13 Jan 2020 23:24:20 -0800
Message-ID: <1578986667-16041-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986661; bh=FN4ZiQi/2hJBTxgG+wfpARAjBcj3lxvrxBiMdHaXFdA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FR4gQE4ZXXzSd3v3y3Xem/+ZioyQTuvKw0bgnsoXh/fc8rqT5wcJjMc6iNTbXpoHc
         YbGNnwc5m7xpRLgAzzQ3Tg4dni4vUDoaZmLhkGxXXft7lKn/QXl0CB0wyI6RL2SghH
         ZVDj7CjT+uUaRSWb4xt7vqpIKJ2XAV0TMrgOzcRjMP7IXdZ8WcEKmIuxHyR/al6geg
         RXPnxNlhuBar9aPWOvHmlnNtZiHqH9ViyqGiNhywymPPrlLCWzmDa1u9if1EqibjP/
         psNf+pyyvW8bDTykSnMLyPjtJtkotY/v5+tWIjttfccxvhBwpLb8F7ojFcdu2usjcZ
         XrcNNEyujUgVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_1, clk_out_2, and clk_out_3 are part of Tegra PMC block
and are moved from clock driver to pmc driver with pmc as clock
provider.

clk_out_1 is dedicated for audio mclk on Tegra30 through Tegra210.

This patch updates device tree sound node to use clk_out_1 from
pmc provider as mclk and uses assigned-clock properties to specify
clock parents for clk_out_1 and extern1.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts      | 8 +++++++-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 8 +++++++-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 8 +++++++-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 8 +++++++-
 arch/arm/boot/dts/tegra124-nyan.dtsi        | 8 +++++++-
 arch/arm/boot/dts/tegra124-venice2.dts      | 8 +++++++-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi  | 8 +++++++-
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 8 +++++++-
 arch/arm/boot/dts/tegra30-beaver.dts        | 8 +++++++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       | 8 +++++++-
 arch/arm/boot/dts/tegra30-colibri.dtsi      | 8 +++++++-
 11 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 97a5c3504bbe..d3e032e7d21a 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1296,7 +1296,13 @@
 
 		clocks = <&tegra_car TEGRA114_CLK_PLL_A>,
 			 <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA114_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA114_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA114_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 0462ed2dd8b8..de499f736bda 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -2009,8 +2009,14 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index d1e8593ef0d9..d70a86da4ee4 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2001,8 +2001,14 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index d5fd642f8b77..aaf8f6a56ca8 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -2058,8 +2058,14 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 3b10f475037f..9b1af50cd4b8 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -788,9 +788,15 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
+
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(I, 7) GPIO_ACTIVE_HIGH>;
 		nvidia,mic-det-gpios =
 				<&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 7309393bfced..8c2ee6e7d6f1 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1266,8 +1266,14 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 8b7a827d604d..387b17458e22 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -1189,7 +1189,13 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index c18f6f61d764..6648506f3aa4 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1171,7 +1171,13 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a3b0f3555cd2..45ef6002b225 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -2111,7 +2111,13 @@
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 7ce61edd52f5..4b4f49a49394 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -619,8 +619,14 @@
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 1f9198bb24ff..adba554381c7 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1030,8 +1030,14 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
 
-- 
2.7.4

