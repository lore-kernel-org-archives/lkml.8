Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD56C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A2D207EA
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QdXOS+uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgGSFL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:11:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18214 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSFLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:11:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f13d5f00001>; Sat, 18 Jul 2020 22:11:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 18 Jul 2020 22:11:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:11:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:11:24 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:11:24 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f13d5f70002>; Sat, 18 Jul 2020 22:11:24 -0700
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
Subject: [PATCH 09/10] arm64: tegra: Audio graph header for Tegra210
Date:   Sun, 19 Jul 2020 10:40:16 +0530
Message-ID: <1595135417-16589-10-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595135472; bh=BoqMFeYeBIo2NN4Un+oGYe1Z1EDA0N/2i1ZnSzyjBec=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QdXOS+uA1JlhOToyqsSc9yVmKtupqvdYyiyANhpm9E0N2+ei2QWjbpuqJiAwqREI7
         bVq7O8xZ3Pzow7QYxn+B5dNKS6XquCaI/cdooiKCbJl5OCmGMK4gqco9oQ4etJlrD0
         OteEhDsrq7G7rEwsyfn2I8SltHhCXw96LGZYU4IR2bF2ncljOhP3NykUVsImA5exmx
         dlAAIXrew186U0uA7LhlJQB7DgkileL0k5Z1NR2gIp5yzET9qwQrInCLltzof0FdIj
         CTuwDTXQ/cE7I21GWVvD+AcOBU8NKk/GyAiiR4nWTlBqRn/cmXhpogd/NeGejdM8gx
         0qQiylvmBIhXw==
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
 .../boot/dts/nvidia/tegra210-audio-graph.dtsi      | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi
new file mode 100644
index 0000000..1cf2c87
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi
@@ -0,0 +1,120 @@
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
+	admaif_port: port {
+		admaif0: endpoint@0 {
+			remote-endpoint = <&xbar_admaif0>;
+		};
+		admaif1: endpoint@1 {
+			remote-endpoint = <&xbar_admaif1>;
+		};
+		admaif2: endpoint@2 {
+			remote-endpoint = <&xbar_admaif2>;
+		};
+		admaif3: endpoint@3 {
+			remote-endpoint = <&xbar_admaif3>;
+		};
+		admaif4: endpoint@4 {
+			remote-endpoint = <&xbar_admaif4>;
+		};
+		admaif5: endpoint@5 {
+			remote-endpoint = <&xbar_admaif5>;
+		};
+		admaif6: endpoint@6 {
+			remote-endpoint = <&xbar_admaif6>;
+		};
+		admaif7: endpoint@7 {
+			remote-endpoint = <&xbar_admaif7>;
+		};
+		admaif8: endpoint@8 {
+			remote-endpoint = <&xbar_admaif8>;
+		};
+		admaif9: endpoint@9 {
+			remote-endpoint = <&xbar_admaif9>;
+		};
+	};
+};
+
+&tegra_ahub {
+	port@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * Audio Crossbar Codec endpoints.
+		 * Connected with FE endpoints.
+		 */
+
+		xbar_admaif0: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&admaif0>;
+		};
+		xbar_admaif1: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&admaif1>;
+		};
+		xbar_admaif2: endpoint@2 {
+			reg = <2>;
+			remote-endpoint = <&admaif2>;
+		};
+		xbar_admaif3: endpoint@3 {
+			reg = <3>;
+			remote-endpoint = <&admaif3>;
+		};
+		xbar_admaif4: endpoint@4 {
+			reg = <4>;
+			remote-endpoint = <&admaif4>;
+		};
+		xbar_admaif5: endpoint@5 {
+			reg = <5>;
+			remote-endpoint = <&admaif5>;
+		};
+		xbar_admaif6: endpoint@6 {
+			reg = <6>;
+			remote-endpoint = <&admaif6>;
+		};
+		xbar_admaif7: endpoint@7 {
+			reg = <7>;
+			remote-endpoint = <&admaif7>;
+		};
+		xbar_admaif8: endpoint@8 {
+			reg = <8>;
+			remote-endpoint = <&admaif8>;
+		};
+		xbar_admaif9: endpoint@9 {
+			reg = <9>;
+			remote-endpoint = <&admaif9>;
+		};
+	};
+
+	xbar_port: port@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * Audio crossbar CPU endpoints:
+		 * Describe connections to HW accelerators (which will
+		 * be addded going forward) and I/O interfaces (which
+		 * are specified in Platform DT files).
+		 */
+	};
+};
-- 
2.7.4

