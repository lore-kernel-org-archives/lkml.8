Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360AC2BA18
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2AF20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgDBTUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:20:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389674AbgDBTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:20:37 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mwfeu-1j8iRq1ENO-00yAbN for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 21:20:36 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id BB9C46505D2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 19:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8hKHUg1nDWKM for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 21:20:35 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 1CF9564F51F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 21:20:35 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 21:20:34 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 4482E80506; Thu,  2 Apr 2020 20:35:13 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:35:13 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v5 9/9] arm64: dts: renesas: salvator: add a connection from
 adv748x codec (HDMI input) to the R-Car SoC
Message-ID: <90f2c14fcbe5d06eefdaeadbe8a6efc8c91523f3.1585852001.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:rgq2HY6vGqgdqs5QP8+lY/u+ujAgjWJqNkR8TzEC/GoVPA52kw/
 7pnE3Mde6IiDdD/X1cGWs5xfph4+R0xNS9BFRJJ/SqOCykkF8ArcxVUIVKglvDX811izVzi
 i1PXGqKDxoVFW6Rwoq950fsrNp7sS+Pj/RJtqGlU8WVrxbUdR0V5J3LG3F6313BHw9q8itK
 81I9aD3EEy+BdSEI0DqqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iSiW2aj/0AM=:Ot8NnxhycdNVxsUuw5P/yv
 iah2F07Zndh7FIWoSWxmx0pu74hQlcZbNUvwi8JzMV0gD/OnVoGGTwz+3XblTad5JBvDAbmhF
 kzkiK7GU2eQtB+ZBbTXTcEZnAff+m0jmXWziWL3lbwQJD9GRLwVY5uppdz35oFNwEzYfLTeI+
 +Ulu2Ey7VYMTxkwHzphngQDHAt5oEb0U1/YK3+n8igAATUIsOkg1O7eQ/BmeF/IHRVqBLEUP+
 htwAVpRd7AzSzyeSOKxQ5fMB3ooWoycAqq+/Tc57FFB/UvSrsKIhW50GoCPlNwEQmTNNJWXZ3
 MCZTYhymfiF37Z9zF6qMesabGgEd755tt26UuqwZIHE3E6ita1xmwWfp1dXpIzrcaLJSevkJt
 TLz7908x0qIdwf3nzjK+4AMThlN06U9X9A4Uh4Vv3oUIMVICybUsrgq0TWUdn3y+KJJwtbW5s
 J+nCKvt1KWCYsaKOiBsU2G9wZ2eEbsqM7PigdmQxHP2pJSGf7lAAKSco2/M25EP+YpvNPGLV4
 +kPA4E9UPARmQChqARAzIiL3C6kJFCwtYX5G+WYhOtga8I5WEeOcHK8j0+IruYyoy39gZ1xjA
 MXAOZ+hei9RHRyAKC3dFOQDXgq126nq3d0jmm1xhO5Gd1T8IGEi8uAHNdv4ZzhWu+iU2WRyQJ
 6LTguXwkJFBuw1xO+88fzIw+np3N+DSwHl56db80U0DKW8GYaPPyXYA8QzYlrf73M2iDGLrK9
 QPQdKqJpuBcvcczQRBQmyQHZMFfDF4LbJ7GKSVCx5ZAyyHkDlUrVV6Xogkj/7frmZy9dEDyu7
 KRioG57rRNVJnJYcYTXffucGB8Du/OUWXsXpou6IDUnCXGYWVsDF/pux1U/ncUIpbiohlOI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all known variants of the Salvator board have the HDMI decoder
chip (the ADV7482) connected to the SSI4 on R-Car SoC, the ADV7482
endpoint and the connection definitions are placed in the common board
file.

For the same reason, the CLK_C clock line and I2C configuration (similar
to the ak4613, on the same interface) are added into the common file.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>

--

v5: Add dummy ssi4 node to the rcar sound card in r8a77961, as the
    devices (Salvator-X 2nd version with R-Car M3 W+) also reference
    salvator-common.dtsi.
    Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

v2: Also add ssi4_ctrl pin group in the sound pins. The pins are
    responsible for SCK4 (sample clock) WS4 and (word boundary input),
    and are required for SSI audio input over I2S.

    The adv748x shall provide its own implementation of the output clock
    (MCLK), connected to the audio_clk_c line of the R-Car SoC.

    If the frequency of the ADV748x MCLK were fixed, the clock
    implementation were not necessary, but it does not seem so: the MCLK
    depends on the value in a speed multiplier register and the input sample
    rate (48kHz).

    Remove audio clock C from the clocks of adv7482.

    The clocks property of the video-receiver node lists the input
    clocks of the device, which is quite the opposite from the
    original intention: the adv7482 on Salvator X boards is a
    provide of the MCLK clock for I2S audio output.

    Remove old definition of &sound_card.dais and reduce size of changes
    in the Salvator-X specific device tree source.

    Declare video-receiver a clock producer, as the adv748x driver
    implements the master clock used I2S audio output.

    Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>

v2: The driver provides only MCLK clock, not the SCLK and LRCLK,
    which are part of the I2S protocol.

    Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../boot/dts/renesas/r8a77950-salvator-x.dts  |  3 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi     |  1 +
 .../boot/dts/renesas/salvator-common.dtsi     | 47 +++++++++++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
index 2438825c9b22..e16c146808b6 100644
--- a/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
@@ -146,7 +146,8 @@ &sata {
 &sound_card {
 	dais = <&rsnd_port0	/* ak4613 */
 		&rsnd_port1	/* HDMI0  */
-		&rsnd_port2>;	/* HDMI1  */
+		&rsnd_port2	/* HDMI1  */
+		&rsnd_port3>;	/* adv7482 hdmi-in  */
 };
 
 &usb2_phy2 {
diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index be3824bda632..b79907beaf31 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -861,6 +861,7 @@ rcar_sound,src {
 			rcar_sound,ssi {
 				ssi0: ssi-0 { };
 				ssi1: ssi-1 { };
+				ssi4: ssi-4 { };
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 98bbcafc8c0d..ead7f8d7a929 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -460,7 +460,7 @@ pca9654: gpio@20 {
 		#gpio-cells = <2>;
 	};
 
-	video-receiver@70 {
+	adv7482_hdmi_in: video-receiver@70 {
 		compatible = "adi,adv7482";
 		reg = <0x70 0x71 0x72 0x73 0x74 0x75
 		       0x60 0x61 0x62 0x63 0x64 0x65>;
@@ -469,6 +469,7 @@ video-receiver@70 {
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#clock-cells = <0>; /* the MCLK for I2S output */
 
 		interrupt-parent = <&gpio6>;
 		interrupt-names = "intrq1", "intrq2";
@@ -510,6 +511,15 @@ adv7482_txb: endpoint {
 				remote-endpoint = <&csi20_in>;
 			};
 		};
+
+		port@c {
+			reg = <12>;
+
+			adv7482_i2s: endpoint {
+				remote-endpoint = <&rsnd_endpoint3>;
+				system-clock-direction-out;
+			};
+		};
 	};
 
 	csa_vdd: adc@7c {
@@ -684,7 +694,8 @@ sdhi3_pins_uhs: sd3_uhs {
 	};
 
 	sound_pins: sound {
-		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
+		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a",
+			 "ssi4_data", "ssi4_ctrl";
 		function = "ssi";
 	};
 
@@ -733,8 +744,8 @@ &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
 
-	/* Single DAI */
-	#sound-dai-cells = <0>;
+	/* multi DAI */
+	#sound-dai-cells = <1>;
 
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
@@ -758,8 +769,19 @@ &rcar_sound {
 		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
 		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 		 <&audio_clk_a>, <&cs2000>,
-		 <&audio_clk_c>,
+		 <&adv7482_hdmi_in>,
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
+	clock-names = "ssi-all",
+		      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+		      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+		      "ssi.1", "ssi.0",
+		      "src.9", "src.8", "src.7", "src.6",
+		      "src.5", "src.4", "src.3", "src.2",
+		      "src.1", "src.0",
+		      "mix.1", "mix.0",
+		      "ctu.1", "ctu.0",
+		      "dvc.0", "dvc.1",
+		      "clk_a", "clk_b", "clk_c", "clk_i";
 
 	ports {
 		#address-cells = <1>;
@@ -777,6 +799,21 @@ rsnd_endpoint0: endpoint {
 				capture  = <&ssi1 &src1 &dvc1>;
 			};
 		};
+		rsnd_port3: port@3 {
+			reg = <3>;
+			rsnd_endpoint3: endpoint {
+				remote-endpoint = <&adv7482_i2s>;
+
+				dai-tdm-slot-num = <8>;
+				dai-tdm-slot-width = <32>;
+				dai-format = "left_j";
+				mclk-fs = <256>;
+				bitclock-master = <&adv7482_i2s>;
+				frame-master = <&adv7482_i2s>;
+
+				capture = <&ssi4>;
+			};
+		};
 	};
 };
 
-- 
2.25.1.25.g9ecbe7eb18

