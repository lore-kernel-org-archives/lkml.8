Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B817C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A2B2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q52Y0Aru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgG1LTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:19:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:40445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgG1LTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935106;
        bh=V7oRKHspT8bz+DCILEYZfiQBm7br8j1f9O+VvLDkf7E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q52Y0ArufaHdGsvzQc6TVQd17WvUyhEJVwOgPL1IEMRxhdjZ37kcUnVq0NPMBygSG
         2rVHnJ6uvioXiAthij60xJMezf0kjbiuvCm0SyzQC0KNqU29V7inFkEBX8qYpqqra/
         6XXno87WG0G9S72b4XENCLSAFXY7pAyNBI2W+qoU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6DWi-1k6zKz3r9k-006bqj; Tue, 28 Jul 2020 13:18:26 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v2 5/5] arm: dts: mt7623: add display subsystem related device nodes
Date:   Tue, 28 Jul 2020 13:18:00 +0200
Message-Id: <20200728111800.77641-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728111800.77641-1-frank-w@public-files.de>
References: <20200728111800.77641-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BrlD/lpiH2E3b3b7Becre33Vm8cjszLu/2SD+JYKvyLrs5fZW/h
 kxbCfpXSSlfEGZq5VpCGShfMXv+iVQQrIS+V1wEWHld/I4s8vtt4eOH50aDDgHcCvvIaARD
 zs/xJX53X4i7mv4Z/kKkAHbUeuiuw+y9ghx5nAB+bWxcAhobOFAyeCnYuKlqj9b3XHZz+zR
 /TEOY+Q/bnB/CIVfl1BSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BVkf93G43zQ=:KlzLPO/jav59S0ROnmbWdv
 qZWHge+631AY1hLkzCEDpyVRaslLskbkWkOFFyJ6JJtit8q28u7snKMzvL03kONKuBWw7Ldpw
 CPbxKc3jNNRDqa0du4cEmhQ+Bhqs9iOx/dx5JZtqqaZZq4zURIEn10wMu1SYExKjHxoNFiVnv
 ARW6WjjuLTLOpMCn/vspTIP/iS8dTFB2HS8fouc9qpaWg/myGF1YmZbTSf1sOqqJ4vYNWSYCW
 0gKgSrWmRE/MdoAKi9Evix27o4MrlBoYuktf9axtfhY9XGBkpToJKEugrmKMolpZEp4fTy67h
 zTBCaknBukuJsMB8qEbx0pQ8Ev7tAuaTu3GyaniPnKgHVK7mUwi5SkTtRkcemRW6XRKeWhtaV
 QDGOpm3vpYO/z+TNBTdndhnMzt4CpXBvQnYyjkiHnpmxLAalsdPLYkyZj35jZebBOgZmCDtBg
 F8KcXCLa5PFcJ/AXuF0vilcgW5VuIdGHZHNFdz8N9NduHtko28asnIAVlTZ7n5OyiJylQ198T
 +xVfsz+1A01pgsChCnEk7EMcIahM+tIf+kshw5bL67FqWGcZh6367Gu880ZmMC/32OhDB0Ect
 CSs4csPuDua8YARxIgQ08hNPlSbL9x5Gz2ACNGXJJD/iclqEno8jZOCNZJWqc35heCG8w2Gns
 hw5ULkmT/rcDX+yDVCjfyREOMbK1/V+KEnE9JxdByx0i5tth3Trq5r0+Hy6PpVz/o7TFl0USz
 ei6uGXXWfICmt1sUT/sigRuKdHtZaqPQIEp51kcq2KgAaIAk1jiZ/cqCh0ZjfvOLV0jt5d5Nf
 9pT9SiRuAbjXewY3sC2kMTaz5oxCo67Wb7AW14OskS8hlFiyRiZn6XhzpBOBRzkeVM4sOPblZ
 xlTMTfJUT8xkTVyFUrNT+jZNCoMrcM5b3FNkw5rY6+aMNxuy6QlxqY8gtNLuR/HPqGIqdQmLY
 Goj011R+v4liOhPjjMnIRV7Ba+69qR+WhCbs0FB9vUfbuBPZKkBbXv1o75Ix+mZXVtLHPLVWf
 s4d9C3c8Y1E2G2d+8w1oHdeP+yA57jpSJH2nn2M6Avi3v6vZLnmLp6WdFrSbDD9w4b7jgp4xI
 nsXu9RMTgbxLqA0Scf1FGriQZCkoygGZ33cYK1yHWgR7JPMff/sorpBIag679U760a8zDj8tY
 mLAwBKb3de1DrDbwOucFRTiUmvOyCsepmAjrkpZkOoNplLJd5WV3AcC1oPzvSaJzR0DYqPYJs
 wxgIc/9ZWTEYqoQYD9g9qJRxQygJovuh94LVDYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Add display subsystem related device nodes for MT7623.

Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  85 +++++++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  85 +++++++++
 3 files changed, 347 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a106c0d90a52..d584a3d678ba 100644
=2D-- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -24,6 +24,11 @@ / {
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;

+	aliases {
+		rdma0 =3D &rdma0;
+		rdma1 =3D &rdma1;
+	};
+
 	cpu_opp_table: opp-table {
 		compatible =3D "operating-points-v2";
 		opp-shared;
@@ -321,6 +326,25 @@ pwrap: pwrap@1000d000 {
 		clock-names =3D "spi", "wrap";
 	};

+	mipi_tx0: mipi-dphy@10010000 {
+		compatible =3D "mediatek,mt7623-mipi-tx",
+			     "mediatek,mt2701-mipi-tx";
+		reg =3D <0 0x10010000 0 0x90>;
+		clocks =3D <&clk26m>;
+		clock-output-names =3D "mipi_tx0_pll";
+		#clock-cells =3D <0>;
+		#phy-cells =3D <0>;
+	};
+
+	cec: cec@10012000 {
+		compatible =3D "mediatek,mt7623-cec",
+			     "mediatek,mt8173-cec";
+		reg =3D <0 0x10012000 0 0xbc>;
+		interrupts =3D <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&infracfg CLK_INFRA_CEC>;
+		status =3D "disabled";
+	};
+
 	cir: cir@10013000 {
 		compatible =3D "mediatek,mt7623-cir";
 		reg =3D <0 0x10013000 0 0x1000>;
@@ -369,6 +393,18 @@ apmixedsys: syscon@10209000 {
 		#clock-cells =3D <1>;
 	};

+	hdmi_phy: phy@10209100 {
+		compatible =3D "mediatek,mt7623-hdmi-phy",
+			     "mediatek,mt2701-hdmi-phy";
+		reg =3D <0 0x10209100 0 0x24>;
+		clocks =3D <&apmixedsys CLK_APMIXED_HDMI_REF>;
+		clock-names =3D "pll_ref";
+		clock-output-names =3D "hdmitx_dig_cts";
+		#clock-cells =3D <0>;
+		#phy-cells =3D <0>;
+		status =3D "disabled";
+	};
+
 	rng: rng@1020f000 {
 		compatible =3D "mediatek,mt7623-rng";
 		reg =3D <0 0x1020f000 0 0x1000>;
@@ -568,6 +604,16 @@ bch: ecc@1100e000 {
 		status =3D "disabled";
 	};

+	hdmiddc0: i2c@11013000 {
+		compatible =3D "mediatek,mt7623-hdmi-ddc",
+			     "mediatek,mt8173-hdmi-ddc";
+		interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+		reg =3D <0 0x11013000 0 0x1C>;
+		clocks =3D <&pericfg CLK_PERI_I2C3>;
+		clock-names =3D "ddc-i2c";
+		status =3D "disabled";
+	};
+
 	nor_flash: spi@11014000 {
 		compatible =3D "mediatek,mt7623-nor",
 			     "mediatek,mt8173-nor";
@@ -766,6 +812,84 @@ mmsys: syscon@14000000 {
 		#clock-cells =3D <1>;
 	};

+	display_components: dispsys@14000000 {
+		compatible =3D "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys";
+		reg =3D <0 0x14000000 0 0x1000>;
+		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
+	ovl@14007000 {
+		compatible =3D "mediatek,mt7623-disp-ovl",
+			     "mediatek,mt2701-disp-ovl";
+		reg =3D <0 0x14007000 0 0x1000>;
+		interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_OVL>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	rdma0: rdma@14008000 {
+		compatible =3D "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg =3D <0 0x14008000 0 0x1000>;
+		interrupts =3D <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_RDMA>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	wdma@14009000 {
+		compatible =3D "mediatek,mt7623-disp-wdma",
+			     "mediatek,mt2701-disp-wdma";
+		reg =3D <0 0x14009000 0 0x1000>;
+		interrupts =3D <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_WDMA>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_WDMA>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	bls: pwm@1400a000 {
+		compatible =3D "mediatek,mt7623-disp-pwm",
+			     "mediatek,mt2701-disp-pwm";
+		reg =3D <0 0x1400a000 0 0x1000>;
+		#pwm-cells =3D <2>;
+		clocks =3D <&mmsys CLK_MM_MDP_BLS_26M>,
+			 <&mmsys CLK_MM_DISP_BLS>;
+		clock-names =3D "main", "mm";
+		status =3D "disabled";
+	};
+
+	color@1400b000 {
+		compatible =3D "mediatek,mt7623-disp-color",
+			     "mediatek,mt2701-disp-color";
+		reg =3D <0 0x1400b000 0 0x1000>;
+		interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_COLOR>;
+	};
+
+	dsi: dsi@1400c000 {
+		compatible =3D "mediatek,mt7623-dsi",
+			     "mediatek,mt2701-dsi";
+		reg =3D <0 0x1400c000 0 0x1000>;
+		interrupts =3D <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DSI_ENGINE>,
+			 <&mmsys CLK_MM_DSI_DIG>,
+			 <&mipi_tx0>;
+		clock-names =3D "engine", "digital", "hs";
+		phys =3D <&mipi_tx0>;
+		phy-names =3D "dphy";
+		status =3D "disabled";
+	};
+
+	mutex: mutex@1400e000 {
+		compatible =3D "mediatek,mt7623-disp-mutex",
+			     "mediatek,mt2701-disp-mutex";
+		reg =3D <0 0x1400e000 0 0x1000>;
+		interrupts =3D <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_MUTEX_32K>;
+	};
+
 	larb0: larb@14010000 {
 		compatible =3D "mediatek,mt7623-smi-larb",
 			     "mediatek,mt2701-smi-larb";
@@ -778,6 +902,44 @@ larb0: larb@14010000 {
 		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
 	};

+	rdma1: rdma@14012000 {
+		compatible =3D "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg =3D <0 0x14012000 0 0x1000>;
+		interrupts =3D <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	dpi0: dpi@14014000 {
+		compatible =3D "mediatek,mt7623-dpi",
+			     "mediatek,mt2701-dpi";
+		reg =3D <0 0x14014000 0 0x1000>;
+		interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DPI1_DIGL>,
+			 <&mmsys CLK_MM_DPI1_ENGINE>,
+			 <&apmixedsys CLK_APMIXED_TVDPLL>;
+		clock-names =3D "pixel", "engine", "pll";
+		status =3D "disabled";
+	};
+
+	hdmi0: hdmi@14015000 {
+		compatible =3D "mediatek,mt7623-hdmi",
+			     "mediatek,mt8173-hdmi";
+		reg =3D <0 0x14015000 0 0x400>;
+		clocks =3D <&mmsys CLK_MM_HDMI_PIXEL>,
+			 <&mmsys CLK_MM_HDMI_PLL>,
+			 <&mmsys CLK_MM_HDMI_AUDIO>,
+			 <&mmsys CLK_MM_HDMI_SPDIF>;
+		clock-names =3D "pixel", "pll", "bclk", "spdif";
+		phys =3D <&hdmi_phy>;
+		phy-names =3D "hdmi";
+		mediatek,syscon-hdmi =3D <&mmsys 0x900>;
+		cec =3D <&cec>;
+		status =3D "disabled";
+	};
+
 	imgsys: syscon@15000000 {
 		compatible =3D "mediatek,mt7623-imgsys",
 			     "mediatek,mt2701-imgsys",
@@ -1102,6 +1264,21 @@ pins-cir {
 		};
 	};

+	hdmi_pins_a: hdmi-default {
+		pins-hdmi {
+			pinmux =3D <MT7623_PIN_123_HTPLG_FUNC_HTPLG>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	hdmi_ddc_pins_a: hdmi_ddc-default {
+		pins-hdmi-ddc {
+			pinmux =3D <MT7623_PIN_124_GPIO124_FUNC_HDMISCK>,
+				 <MT7623_PIN_125_GPIO125_FUNC_HDMISD>;
+		};
+	};
+
 	i2c0_pins_a: i2c0-default {
 		pins-i2c0 {
 			pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot=
/dts/mt7623n-bananapi-bpi-r2.dts
index 2b760f90f38c..7a1763472018 100644
=2D-- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -21,6 +21,19 @@ chosen {
 		stdout-path =3D "serial2:115200n8";
 	};

+	connector {
+		compatible =3D "hdmi-connector";
+		label =3D "hdmi";
+		type =3D "d";
+		ddc-i2c-bus =3D <&hdmiddc0>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint =3D <&hdmi0_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu@0 {
 			proc-supply =3D <&mt6323_vproc_reg>;
@@ -114,10 +127,24 @@ memory@80000000 {
 	};
 };

+&bls {
+	status =3D "okay";
+
+	port {
+		bls_out: endpoint {
+			remote-endpoint =3D <&dpi0_in>;
+		};
+	};
+};
+
 &btif {
 	status =3D "okay";
 };

+&cec {
+	status =3D "okay";
+};
+
 &cir {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cir_pins_a>;
@@ -128,6 +155,28 @@ &crypto {
 	status =3D "okay";
 };

+&dpi0 {
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			dpi0_out: endpoint {
+				remote-endpoint =3D <&hdmi0_in>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			dpi0_in: endpoint {
+				remote-endpoint =3D <&bls_out>;
+			};
+		};
+	};
+};
+
 &eth {
 	status =3D "okay";

@@ -199,6 +248,42 @@ fixed-link {
 	};
 };

+&hdmi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_pins_a>;
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			hdmi0_in: endpoint {
+				remote-endpoint =3D <&dpi0_out>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			hdmi0_out: endpoint {
+				remote-endpoint =3D <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmiddc0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_ddc_pins_a>;
+	status =3D "okay";
+};
+
+&hdmi_phy {
+	mediatek,ibias =3D <0xa>;
+	mediatek,ibias_up =3D <0x1c>;
+	status =3D "okay";
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt=
7623n-rfb-emmc.dts
index 0447748f9fa0..c86807a676fc 100644
=2D-- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -24,6 +24,19 @@ chosen {
 		stdout-path =3D "serial2:115200n8";
 	};

+	connector {
+		compatible =3D "hdmi-connector";
+		label =3D "hdmi";
+		type =3D "d";
+		ddc-i2c-bus =3D <&hdmiddc0>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint =3D <&hdmi0_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu@0 {
 			proc-supply =3D <&mt6323_vproc_reg>;
@@ -106,10 +119,24 @@ sound {
 	};
 };

+&bls {
+	status =3D "okay";
+
+	port {
+		bls_out: endpoint {
+			remote-endpoint =3D <&dpi0_in>;
+		};
+	};
+};
+
 &btif {
 	status =3D "okay";
 };

+&cec {
+	status =3D "okay";
+};
+
 &cir {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cir_pins_a>;
@@ -120,6 +147,28 @@ &crypto {
 	status =3D "okay";
 };

+&dpi0 {
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			dpi0_out: endpoint {
+				remote-endpoint =3D <&hdmi0_in>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			dpi0_in: endpoint {
+				remote-endpoint =3D <&bls_out>;
+			};
+		};
+	};
+};
+
 &eth {
 	status =3D "okay";

@@ -203,6 +252,42 @@ fixed-link {
 	};
 };

+&hdmi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_pins_a>;
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			hdmi0_in: endpoint {
+				remote-endpoint =3D <&dpi0_out>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			hdmi0_out: endpoint {
+				remote-endpoint =3D <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmiddc0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_ddc_pins_a>;
+	status =3D "okay";
+};
+
+&hdmi_phy {
+	mediatek,ibias =3D <0xa>;
+	mediatek,ibias_up =3D <0x1c>;
+	status =3D "okay";
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins_a>;
=2D-
2.25.1

