Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD20C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A1E206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Qw+OiyWN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VopLKxvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGHRob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:31 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35667 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbgGHRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1F3C31092;
        Wed,  8 Jul 2020 13:44:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Pr2wD0aIesVA7
        VhHrZ3ZAGxgmjMS1TPzBhQ+Exq5jlg=; b=Qw+OiyWNTDl6OxGhGmECmnyPn7W0T
        wxXn307c/f3sAnK6JkArJ7CHiTK6zFxZ2xASI5I2KaigPa1Cb+X4Dx1FZhUUsvSD
        k/7uOkcjcUdgSerpeJxmy9ihG9GQVbbLdJ+tr1ndL9cgbsMX7wSCCUU07j0McrlT
        jheo5k/vAFwygN0wn9NfjpjqaEoR7QoCKie6HZvimC6bHVDI2VHHN9JZDUB+WrVC
        cnZRPP90kha08oO334KT7Eqi+1Glfbxyr4fJjGZMw9PIWegtAbgX8nR1nQ2GcaYr
        GbiJrlNm3KaZ/EanWMa6vMYNzD6KvAS6MGSifs2HlQoFHv4S/XUbQrghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Pr2wD0aIesVA7VhHrZ3ZAGxgmjMS1TPzBhQ+Exq5jlg=; b=VopLKxvN
        ONr5XEdbMDdQUUTKH16UoYAlvvy51keqrTMGFmcPdlgYrFHxvzK/Cm+A1rybMeH/
        4B0vxAKmHOpeXC0tVNzjHlrkqB9ilo8XMjtMgb40chhS6lF7yrgFclZVr6C4ociU
        c5e9GHN6LzP4PPXhxcJtNLKQr2dv3ULD2yCJEfu/hMCluY2MSdT8lg/rG+2sl47G
        bzrqmIIhp6D2pslVGAxs3K/hkRdArl5KgXIKtMtazX8AWssgAb/Hv4AeY+ScAo8E
        e/PSLvfcnFyrXJZYI4LFy8NNVy/fPbbQKHaQeodp9dOZEGkewNXKFaQ5J76zL0CB
        uvUguDxfUWwyTg==
X-ME-Sender: <xms:9wUGXz-isU-bgUVbTzCWPcybICCc0bkiSA2NDyw1XpGnx4YkdJrw7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9wUGX_vKcAKVKmhvL1uGLBQDQOH4JJRCFlAPr7pcYvh3TKoUBUTgAw>
    <xmx:9wUGXxBHKCFOjSV-lZnhnj8a6G_bm1LuplO3d3GMCGJsDg8_Ik7lig>
    <xmx:9wUGX_cNovU2u_7YcQgHkTjE6tfxI2FDOAzklD23EKMobO55WNQhtQ>
    <xmx:9wUGX_cJX4z-iIuZ17e7MSWgm0xLEtM-XkkMddIWHbQEcsPaoMOxgrY740c>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5CE3B328005E;
        Wed,  8 Jul 2020 13:44:23 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 78/78] ARM: dts: bcm2711: Enable the display pipeline
Date:   Wed,  8 Jul 2020 19:42:26 +0200
Message-Id: <768aa056fded89f2ee59b4bdc32223955bb8ffe2.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the drivers have been adjusted for it, let's bring in the
necessary device tree changes.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  46 +++++++++++-
 arch/arm/boot/dts/bcm2711.dtsi        | 115 ++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 222d7825e1ab..b93eb30e1ddb 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -68,6 +68,14 @@
 	};
 };
 
+&ddc0 {
+	status = "okay";
+};
+
+&ddc1 {
+	status = "okay";
+};
+
 &firmware {
 	firmware_clocks: clocks {
 		compatible = "raspberrypi,firmware-clocks";
@@ -163,6 +171,36 @@
 			  "RGMII_TXD3";
 };
 
+&hdmi0 {
+	clocks = <&firmware_clocks 13>, <&dvp 0>;
+	status = "okay";
+};
+
+&hdmi1 {
+	clocks = <&firmware_clocks 13>, <&dvp 1>;
+	status = "okay";
+};
+
+&hvs {
+	clocks = <&firmware_clocks 4>;
+};
+
+&pixelvalve0 {
+	status = "okay";
+};
+
+&pixelvalve1 {
+	status = "okay";
+};
+
+&pixelvalve2 {
+	status = "okay";
+};
+
+&pixelvalve4 {
+	status = "okay";
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm1_0_gpio40 &pwm1_1_gpio41>;
@@ -231,3 +269,11 @@
 &vchiq {
 	interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&vc4 {
+	status = "okay";
+};
+
+&vec {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 00bcaed1be32..e637378650f6 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -12,6 +12,11 @@
 
 	interrupt-parent = <&gicv2>;
 
+	vc4: gpu {
+		compatible = "brcm,bcm2711-vc5";
+		status = "disabled";
+	};
+
 	clk_108MHz: clk-108M {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -238,6 +243,27 @@
 			status = "disabled";
 		};
 
+		pixelvalve0: pixelvalve@7e206000 {
+			compatible = "brcm,bcm2711-pixelvalve0";
+			reg = <0x7e206000 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pixelvalve1: pixelvalve@7e207000 {
+			compatible = "brcm,bcm2711-pixelvalve1";
+			reg = <0x7e207000 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pixelvalve2: pixelvalve@7e20a000 {
+			compatible = "brcm,bcm2711-pixelvalve2";
+			reg = <0x7e20a000 0x100>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		pwm1: pwm@7e20c800 {
 			compatible = "brcm,bcm2835-pwm";
 			reg = <0x7e20c800 0x28>;
@@ -248,10 +274,25 @@
 			status = "disabled";
 		};
 
-		hvs@7e400000 {
+		pixelvalve4: pixelvalve@7e216000 {
+			compatible = "brcm,bcm2711-pixelvalve4";
+			reg = <0x7e216000 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		hvs: hvs@7e400000 {
+			compatible = "brcm,bcm2711-hvs";
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pixelvalve3: pixelvalve@7ec12000 {
+			compatible = "brcm,bcm2711-pixelvalve3";
+			reg = <0x7ec12000 0x100>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		dvp: clock@7ef00000 {
 			compatible = "brcm,brcm2711-dvp";
 			reg = <0x7ef00000 0x10>;
@@ -259,6 +300,78 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		hdmi0: hdmi@7ef00700 {
+			compatible = "brcm,bcm2711-hdmi0";
+			reg = <0x7ef00700 0x300>,
+			      <0x7ef00300 0x200>,
+			      <0x7ef00f00 0x80>,
+			      <0x7ef00f80 0x80>,
+			      <0x7ef01b00 0x200>,
+			      <0x7ef01f00 0x400>,
+			      <0x7ef00200 0x80>,
+			      <0x7ef04300 0x100>,
+			      <0x7ef20000 0x100>;
+			reg-names = "hdmi",
+				    "dvp",
+				    "phy",
+				    "rm",
+				    "packet",
+				    "metadata",
+				    "csc",
+				    "cec",
+				    "hd";
+			clock-names = "hdmi", "clk-108M";
+			resets = <&dvp 0>;
+			ddc = <&ddc0>;
+			dmas = <&dma 10>;
+			dma-names = "audio-rx";
+			status = "disabled";
+		};
+
+		ddc0: i2c@7ef04500 {
+			compatible = "brcm,bcm2711-hdmi-i2c";
+			reg = <0x7ef04500 0x100>, <0x7ef00b00 0x300>;
+			reg-names = "bsc", "auto-i2c";
+			clock-frequency = <97500>;
+			status = "disabled";
+		};
+
+		hdmi1: hdmi@7ef05700 {
+			compatible = "brcm,bcm2711-hdmi1";
+			reg = <0x7ef05700 0x300>,
+			      <0x7ef05300 0x200>,
+			      <0x7ef05f00 0x80>,
+			      <0x7ef05f80 0x80>,
+			      <0x7ef06b00 0x200>,
+			      <0x7ef06f00 0x400>,
+			      <0x7ef00280 0x80>,
+			      <0x7ef09300 0x100>,
+			      <0x7ef20000 0x100>;
+			reg-names = "hdmi",
+				    "dvp",
+				    "phy",
+				    "rm",
+				    "packet",
+				    "metadata",
+				    "csc",
+				    "cec",
+				    "hd";
+			ddc = <&ddc1>;
+			clock-names = "hdmi", "clk-108M";
+			resets = <&dvp 1>;
+			dmas = <&dma 17>;
+			dma-names = "audio-rx";
+			status = "disabled";
+		};
+
+		ddc1: i2c@7ef09500 {
+			compatible = "brcm,bcm2711-hdmi-i2c";
+			reg = <0x7ef09500 0x100>, <0x7ef05b00 0x300>;
+			reg-names = "bsc", "auto-i2c";
+			clock-frequency = <97500>;
+			status = "disabled";
+		};
 	};
 
 	/*
-- 
git-series 0.9.1
