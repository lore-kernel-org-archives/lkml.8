Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B23206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jf3OVh8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGCHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:44:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52912 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGCHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:43:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0637ho2Q013451;
        Fri, 3 Jul 2020 02:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593762230;
        bh=GKhaCbHVbI4+Y/2kOzzOfVPb8HPfGmDB0coQ3pUUwiY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jf3OVh8n4iJ4KBkJJs3zT8ewo8OMsVhZDpGC1YBHG2XfVR+maFUDKOCWIhcatH0Zt
         Xo81/efiKBQ36hRgK4cckjD3pawhPoCOdyK9ZyRVIDZUg0qYJowzdzmhtUI5xwMZJ7
         FKTbcr855RaYA2k2rOg69LK/yH66SKrMD4bC2bgI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0637hoEs101933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 02:43:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 02:43:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 02:43:49 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637hhdq098446;
        Fri, 3 Jul 2020 02:43:47 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: j721e-common-proc-board: Analog audio support
Date:   Fri, 3 Jul 2020 10:44:43 +0300
Message-ID: <20200703074443.27142-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703074443.27142-1-peter.ujfalusi@ti.com>
References: <20200703074443.27142-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec is wired in multi DIN/DOUT setup (DIN1/2/3/4/DOUT1/2/3 is
connected to McASP serializer).

To support wide range of audio features a generic sound card can not be
used since we need to use different reference clock source for 44.1 and
48 KHz family of sampling rates.
Depending on the sample size we also need to use different slot width to
be able to support 16 and 24 bits.

There are couple of notable difference compared to DIN1/DOUT1 mode:
the channel mapping is 'random' for first look compared to the single
serializer setup:
        _      _      _
       |o|c1  |o|p1  |o|p3
 _     | |    | |    | |
|o|c3  |o|c2  |o|p4  |o|p2
------------------------

c1/2/3 - capture jacks (3rd is line)
p1/2/3/4 - playback jacks (4th is line)

2 channel audio (stereo):
0 (left):  p1/c1 left
1 (right): p1/c1 right

4 channel audio:
0: p1/c1 left
1: p2/c2 left
2: p1/c1 right
3: p2/c2 right

6 channel audio
0: p1/c1 left
1: p2/c2 left
2: p3/c3 left
3: p1/c1 right
4: p2/c2 right
5: p3/c3 right

8 channel audio
0: p1/c1 left
1: p2/c2 left
2: p3/c3 left
3: p4 left
4: p1/c1 right
5: p2/c2 right
6: p3/c3 right
7: p4 right

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 1f1fee85acca..165907fe1b0f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -34,6 +34,55 @@ sw11: sw11 {
 			gpios = <&wkup_gpio0 7 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	evm_12v0: fixedregulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: fixedregulator-vsys3v3 {
+		/* Output of LMS140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	sound0: sound@0 {
+		compatible = "ti,j721e-cpb-audio";
+		model = "j721e-cpb";
+
+		ti,cpb-mcasp = <&mcasp10>;
+		ti,cpb-codec = <&pcm3168a_1>;
+
+		clocks = <&k3_clks 184 1>,
+			 <&k3_clks 184 2>, <&k3_clks 184 4>,
+			 <&k3_clks 157 371>,
+			 <&k3_clks 157 400>, <&k3_clks 157 401>;
+		clock-names = "cpb-mcasp-auxclk",
+			      "cpb-mcasp-auxclk-48000", "cpb-mcasp-auxclk-44100",
+			      "cpb-codec-scki",
+			      "cpb-codec-scki-48000", "cpb-codec-scki-44100";
+	};
 };
 
 &main_pmx0 {
@@ -102,6 +151,26 @@ J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
 			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
 		>;
 	};
+
+	mcasp10_pins_default: mcasp10_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x158, PIN_OUTPUT_PULLDOWN, 12) /* (U23) RGMII5_TX_CTL.MCASP10_ACLKX */
+			J721E_IOPAD(0x15c, PIN_OUTPUT_PULLDOWN, 12) /* (U26) RGMII5_RX_CTL.MCASP10_AFSX */
+			J721E_IOPAD(0x160, PIN_OUTPUT_PULLDOWN, 12) /* (V28) RGMII5_TD3.MCASP10_AXR0 */
+			J721E_IOPAD(0x164, PIN_OUTPUT_PULLDOWN, 12) /* (V29) RGMII5_TD2.MCASP10_AXR1 */
+			J721E_IOPAD(0x170, PIN_OUTPUT_PULLDOWN, 12) /* (U29) RGMII5_TXC.MCASP10_AXR2 */
+			J721E_IOPAD(0x174, PIN_OUTPUT_PULLDOWN, 12) /* (U25) RGMII5_RXC.MCASP10_AXR3 */
+			J721E_IOPAD(0x198, PIN_INPUT_PULLDOWN, 12) /* (V25) RGMII6_TD1.MCASP10_AXR4 */
+			J721E_IOPAD(0x19c, PIN_INPUT_PULLDOWN, 12) /* (W27) RGMII6_TD0.MCASP10_AXR5 */
+			J721E_IOPAD(0x1a0, PIN_INPUT_PULLDOWN, 12) /* (W29) RGMII6_TXC.MCASP10_AXR6 */
+		>;
+	};
+
+	audi_ext_refclk2_pins_default: audi_ext_refclk2_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1a4, PIN_OUTPUT, 3) /* (W26) RGMII6_RXC.AUDIO_EXT_REFCLK2 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -401,6 +470,22 @@ exp2: gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		p09 {
+			/* P11 - MCASP/TRACE_MUX_S0 */
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "MCASP/TRACE_MUX_S0";
+		};
+
+		p10 {
+			/* P12 - MCASP/TRACE_MUX_S1 */
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MCASP/TRACE_MUX_S1";
+		};
 	};
 };
 
@@ -423,6 +508,12 @@ exp4: gpio@20 {
 	};
 };
 
+&k3_clks {
+	/* Confiure AUDIO_EXT_REFCLK2 pin as output */
+	pinctrl-names = "default";
+	pinctrl-0 = <&audi_ext_refclk2_pins_default>;
+};
+
 &main_i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c3_pins_default>;
@@ -434,6 +525,31 @@ exp3: gpio@20 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	pcm3168a_1: audio-codec@44 {
+		compatible = "ti,pcm3168a";
+		reg = <0x44>;
+
+		#sound-dai-cells = <1>;
+
+		reset-gpios = <&exp3 0 GPIO_ACTIVE_LOW>;
+
+		/* C_AUDIO_REFCLK2 -> RGMII6_RXC (W26) */
+		clocks = <&k3_clks 157 371>;
+		clock-names = "scki";
+
+		/* HSDIV3_16FFT_MAIN_4_HSDIVOUT2_CLK -> REFCLK2 */
+		assigned-clocks = <&k3_clks 157 371>;
+		assigned-clock-parents = <&k3_clks 157 400>;
+		assigned-clock-rates = <24576000>; /* for 48KHz */
+
+		VDD1-supply = <&vsys_3v3>;
+		VDD2-supply = <&vsys_3v3>;
+		VCCAD1-supply = <&vsys_5v0>;
+		VCCAD2-supply = <&vsys_5v0>;
+		VCCDA1-supply = <&vsys_5v0>;
+		VCCDA2-supply = <&vsys_5v0>;
+	};
 };
 
 &main_i2c6 {
@@ -486,3 +602,23 @@ &dss {
 				 <&k3_clks 152 11>,	/* PLL18_HSDIV0 */
 				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
 };
+
+&mcasp10 {
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp10_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	auxclk-fs-ratio = <256>;
+
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+		1 1 1 1
+		2 2 2 0
+	>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
+
+	status = "okay";
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

