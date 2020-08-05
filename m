Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3A021744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gHCuLLx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHEFZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:25:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9219 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgHEFZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:25:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2a42b70001>; Tue, 04 Aug 2020 22:25:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Aug 2020 22:25:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Aug 2020 22:25:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug
 2020 05:25:24 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Aug 2020 05:25:24 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2a42c00000>; Tue, 04 Aug 2020 22:25:24 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 8/9] arm64: tegra: Audio graph header for Tegra210
Date:   Wed, 5 Aug 2020 10:54:23 +0530
Message-ID: <1596605064-27748-9-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
References: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596605112; bh=FXLn+v9mbQR0URf7XVIleTBonQwH9nB48J1uzJSxRqU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gHCuLLx53vKibilwS56rE3mMW/UO7W0mlIcRzKFhsUv+lZNP5wMiheA0RrpD4aDJ+
         iM/gY3NBZlsCPx2uwLdpheJvp1WxoepdlLv+GHx9Eo/Uxy476jPwnGAUQa+8zZBurG
         MyJ+gV5+OgtnKPxQH3Dh/pgeDMeF3XLBvofIQjlOsxqa1E+s50Fii9erRV6tPXfejz
         As/Si5cA5X0JMZcBhpS42Og7M+tPp3skwfPeubeYANp6KdU7jHneZn5bCLvf/xRHJ9
         Y6c4nFtJ3tlbe0djuxdZigEGavutF9gkCVs4Pj8KhNRmMWKEU/oHfG+sOC8ThFT1G2
         lNJLWEP+RK2WQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a header which describes DT bindings required to use audio-graph
based sound card. All Tegra210 based platforms can include this header
and add platform specific information. Currently, from SoC point of view,
all links are exposed for ADMAIF, AHUB, I2S and DMIC components.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../boot/dts/nvidia/tegra210-audio-graph.dtsi      | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi
new file mode 100644
index 0000000..23f524d
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	tegra_sound {
+		status = "disabled";
+
+		compatible = "audio-graph-cc-card";
+
+		clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+			 <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA210_CLK_EXTERN1>;
+		clock-names = "pll_a", "plla_out0", "aud_mclk";
+
+		assigned-clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+				  <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
+				  <&tegra_car TEGRA210_CLK_EXTERN1>;
+		assigned-clock-parents = <0>, <0>, <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+		assigned-clock-rates = <368640000>, <49152000>, <12288000>;
+	};
+};
+
+&tegra_admaif {
+	admaif1_port: port@0 {
+		admaif1_ep: endpoint {
+			remote-endpoint = <&xbar_admaif1_ep>;
+		};
+	};
+	admaif2_port: port@1 {
+		admaif2_ep: endpoint {
+			remote-endpoint = <&xbar_admaif2_ep>;
+		};
+	};
+	admaif3_port: port@2 {
+		admaif3_ep: endpoint {
+			remote-endpoint = <&xbar_admaif3_ep>;
+		};
+	};
+	admaif4_port: port@3 {
+		admaif4_ep: endpoint {
+			remote-endpoint = <&xbar_admaif4_ep>;
+		};
+	};
+	admaif5_port: port@4 {
+		admaif5_ep: endpoint {
+			remote-endpoint = <&xbar_admaif5_ep>;
+		};
+	};
+	admaif6_port: port@5 {
+		admaif6_ep: endpoint {
+			remote-endpoint = <&xbar_admaif6_ep>;
+		};
+	};
+	admaif7_port: port@6 {
+		admaif7_ep: endpoint {
+			remote-endpoint = <&xbar_admaif7_ep>;
+		};
+	};
+	admaif8_port: port@7 {
+		admaif8_ep: endpoint {
+			remote-endpoint = <&xbar_admaif8_ep>;
+		};
+	};
+	admaif9_port: port@8 {
+		admaif9_ep: endpoint {
+			remote-endpoint = <&xbar_admaif9_ep>;
+		};
+	};
+	admaif10_port: port@9 {
+		admaif10_ep: endpoint {
+			remote-endpoint = <&xbar_admaif10_ep>;
+		};
+	};
+};
+
+&tegra_ahub {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0x0>;
+			xbar_admaif1_ep: endpoint {
+				remote-endpoint = <&admaif1_ep>;
+			};
+		};
+		port@1 {
+			reg = <0x1>;
+			xbar_admaif2_ep: endpoint {
+				remote-endpoint = <&admaif2_ep>;
+			};
+		};
+		port@2 {
+			reg = <0x2>;
+			xbar_admaif3_ep: endpoint {
+				remote-endpoint = <&admaif3_ep>;
+			};
+		};
+		port@3 {
+			reg = <0x3>;
+			xbar_admaif4_ep: endpoint {
+				remote-endpoint = <&admaif4_ep>;
+			};
+		};
+		port@4 {
+			reg = <0x4>;
+			xbar_admaif5_ep: endpoint {
+				remote-endpoint = <&admaif5_ep>;
+			};
+		};
+		port@5 {
+			reg = <0x5>;
+			xbar_admaif6_ep: endpoint {
+				remote-endpoint = <&admaif6_ep>;
+			};
+		};
+		port@6 {
+			reg = <0x6>;
+			xbar_admaif7_ep: endpoint {
+				remote-endpoint = <&admaif7_ep>;
+			};
+		};
+		port@7 {
+			reg = <0x7>;
+			xbar_admaif8_ep: endpoint {
+				remote-endpoint = <&admaif8_ep>;
+			};
+		};
+		port@8 {
+			reg = <0x8>;
+			xbar_admaif9_ep: endpoint {
+				remote-endpoint = <&admaif9_ep>;
+			};
+		};
+		port@9 {
+			reg = <0x9>;
+			xbar_admaif10_ep: endpoint {
+				remote-endpoint = <&admaif10_ep>;
+			};
+		};
+	};
+};
-- 
2.7.4

