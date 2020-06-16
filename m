Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59890C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B76208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgFPSYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:24:44 -0400
Received: from v6.sk ([167.172.42.174]:47594 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbgFPSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:12 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AF3F86162F;
        Tue, 16 Jun 2020 18:24:10 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/13] ARM: dts: mmp2-olpc-xo-1-75: Enable audio support
Date:   Tue, 16 Jun 2020 20:23:37 +0200
Message-Id: <20200616182341.944473-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the audio SRAM, DMA engine, I2S interface, and codec, hooks
them together and adds a audio-graph-card instance.

It also removes the jack gpios from the gpio-keys instance, because the
audio jack driver registers an input device.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 65 ++++++++++++++++++-------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
index 392f546f7915b..5f1da58550987 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -57,24 +57,6 @@ tablet_mode {
 			linux,code = <SW_TABLET_MODE>;
 			wakeup-source;
 		};
-
-		microphone_insert {
-			label = "Microphone Plug";
-			gpios = <&gpio 96 GPIO_ACTIVE_HIGH>;
-			linux,input-type = <EV_SW>;
-			linux,code = <SW_MICROPHONE_INSERT>;
-			debounce-interval = <100>;
-			wakeup-source;
-		};
-
-		headphone_insert {
-			label = "Headphone Plug";
-			gpios = <&gpio 97 GPIO_ACTIVE_HIGH>;
-			linux,input-type = <EV_SW>;
-			linux,code = <SW_HEADPHONE_INSERT>;
-			debounce-interval = <100>;
-			wakeup-source;
-		};
 	};
 
 	i2c {
@@ -123,6 +105,18 @@ wlan_pwrseq: pwrseq0 {
 		reset-gpios = <&gpio 58 GPIO_ACTIVE_HIGH>;
 	};
 
+	sound-card {
+		compatible = "audio-graph-card";
+		label = "OLPC XO";
+		dais = <&sspa0_dai>;
+		routing = "Headphones", "HPOL",
+			  "Headphones", "HPOR",
+			  "MIC2", "Mic Jack";
+		widgets = "Headphone", "Headphones", "Microphone", "Mic Jack";
+		hp-det-gpio = <&gpio 97 GPIO_ACTIVE_HIGH>;
+		mic-det-gpio = <&gpio 96 GPIO_ACTIVE_HIGH>;
+	};
+
 	soc {
 		axi@d4200000 {
 			ap-sp@d4290000 {
@@ -197,6 +191,14 @@ audio-codec@1a {
 		compatible = "realtek,alc5631";
 		reg = <0x1a>;
 		status = "okay";
+
+		port {
+			rt5631_0: endpoint {
+				mclk-fs = <256>;
+				clocks = <&audio_clk 0>;
+				remote-endpoint = <&sspa0_0>;
+			};
+		};
 	};
 };
 
@@ -243,3 +245,30 @@ camera0_0: endpoint {
 		};
 	};
 };
+
+&asram {
+	status = "okay";
+};
+
+&adma0 {
+	status = "okay";
+};
+
+&audio_clk {
+	status = "okay";
+};
+
+&sspa0 {
+	status = "okay";
+	dmas = <&adma0 0>, <&adma0 1>;
+	dma-names = "tx", "rx";
+
+	sspa0_dai: port {
+		sspa0_0: endpoint {
+			remote-endpoint = <&rt5631_0>;
+			frame-master;
+			bitclock-master;
+			dai-format = "i2s";
+		};
+	};
+};
-- 
2.26.2

