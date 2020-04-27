Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CFC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8F206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgD0PIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:08:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50752 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0PIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:08:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C3D11A11C2;
        Mon, 27 Apr 2020 17:08:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F1BA1A11AF;
        Mon, 27 Apr 2020 17:08:05 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BD6382030E;
        Mon, 27 Apr 2020 17:08:04 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: freescale: Add the power domain node on imx8mp
Date:   Mon, 27 Apr 2020 18:07:55 +0300
Message-Id: <1588000075-4039-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add the power domain nodes on i.MX8MP to enable the power domain
support.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 173 ++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b1616e..deafb36 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -122,6 +122,179 @@
 		clock-output-names = "clk_ext4";
 	};
 
+	power-domains {
+		compatible = "simple-bus";
+
+		/* HSIO SS */
+		hsiomix_pd: hsiomix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			active-wakeup;
+			rpm-always-on;
+			#power-domain-cells = <0>;
+			domain-index = <0>;
+			domain-name = "hsiomix";
+		};
+
+		pcie_pd: pcie-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <1>;
+			domain-name = "pcie";
+			parent-domains = <&hsiomix_pd>;
+		};
+
+		usb_otg1_pd: usbotg1-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <2>;
+			domain-name = "usb_otg1";
+			parent-domains = <&hsiomix_pd>;
+		};
+
+		usb_otg2_pd: usbotg2-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <3>;
+			domain-name = "usb_otg2";
+			parent-domains = <&hsiomix_pd>;
+		};
+
+		/* MLMIX */
+		mlmix_pd: mlmix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <4>;
+			domain-name = "mlmix";
+			clocks = <&clk IMX8MP_CLK_ML_AXI>,
+				 <&clk IMX8MP_CLK_ML_AHB>,
+				 <&clk IMX8MP_CLK_NPU_ROOT>;
+		};
+
+		audiomix_pd: audiomix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <5>;
+			domain-name = "audiomix";
+			clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
+				 <&clk IMX8MP_CLK_AUDIO_AXI_DIV>;
+		};
+
+		gpumix_pd: gpumix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <6>;
+			domain-name = "gpumix";
+			clocks = <&clk IMX8MP_CLK_GPU_ROOT>, <&clk IMX8MP_CLK_GPU_AHB>,
+				 <&clk IMX8MP_CLK_GPU_AXI>;
+		};
+
+		gpu2d_pd: gpu2d-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <7>;
+			domain-name = "gpu2d";
+			parent-domains = <&gpumix_pd>;
+			clocks = <&clk IMX8MP_CLK_GPU2D_ROOT>;
+		};
+
+		gpu3d_pd: gpu3d-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <8>;
+			domain-name = "gpu3d";
+			parent-domains = <&gpumix_pd>;
+			clocks = <&clk IMX8MP_CLK_GPU3D_ROOT>,
+				 <&clk IMX8MP_CLK_GPU3D_SHADER_DIV>;
+		};
+
+		vpumix_pd: vpumix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <9>;
+			domain-name = "vpumix";
+			clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+		};
+
+		vpu_g1_pd: vpug1-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <10>;
+			domain-name = "vpu_g1";
+			parent-domains = <&vpumix_pd>;
+			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+		};
+
+		vpu_g2_pd: vpug2-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <11>;
+			domain-name = "vpu_g2";
+			parent-domains = <&vpumix_pd>;
+			clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+		};
+
+		vpu_h1_pd: vpuh1-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <12>;
+			domain-name = "vpu_h1";
+			parent-domains = <&vpumix_pd>;
+			clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+		};
+
+		mediamix_pd: mediamix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <13>;
+			domain-name = "mediamix";
+			clocks = <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+				 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+		};
+
+		ispdwp_pd: power-domain@14 {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <14>;
+			domain-name = "ispdwp";
+			parent-domains = <&mediamix_pd>;
+			clocks = <&clk IMX8MP_CLK_MEDIA_ISP_DIV>;
+		};
+
+		mipi_phy1_pd: mipiphy1-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <15>;
+			domain-name = "mipi_phy1";
+			parent-domains = <&mediamix_pd>;
+		};
+
+		mipi_phy2_pd: mipiphy2-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <16>;
+			domain-name = "mipi_phy2";
+			parent-domains = <&mediamix_pd>;
+		};
+
+		hdmimix_pd: hdmimix-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <17>;
+			domain-name = "hdmimix";
+			clocks = <&clk IMX8MP_CLK_HDMI_ROOT>,
+				 <&clk IMX8MP_CLK_HDMI_APB>,
+				 <&clk IMX8MP_CLK_HDMI_REF_266M>;
+		};
+
+		hdmi_phy_pd: hdmiphy-pd {
+			compatible = "fsl,imx8m-pm-domain";
+			#power-domain-cells = <0>;
+			domain-index = <18>;
+			domain-name = "hdmi_phy";
+			parent-domains = <&hdmimix_pd>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.7.4

