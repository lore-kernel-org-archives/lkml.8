Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154E02072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHBPmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:42:54 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:16270 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:42:54 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 072Fgb3C098877;
        Mon, 3 Aug 2020 00:42:37 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Mon, 03 Aug 2020 00:42:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 072FgW67098844
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Aug 2020 00:42:37 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64
Date:   Mon,  3 Aug 2020 00:42:31 +0900
Message-Id: <20200802154231.2639186-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables HDMI sound (I2S0) and Analog sound (I2S1) which
are defined in rk3328.dtsi, and replace SPDIF nodes.

We can use SPDIF pass-through with suitable ALSA settings and on
mpv or other media players.
  - Settings: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
  - Ex.: mpv foo.ac3 --audio-spdif=ac3 --audio-device='alsa/SPDIF.pcm.iec958.0:SPDIF'

[Why use simple-audio-card for SPDIF?]

For newly adding nodes, ASoC guys recommend to use audio-graph-card.
But all other sound nodes for rk3328 have already been defined by
simple-audio-card. In this time, I chose for consistent sound nodes.

[DMA allocation problem]

After this patch is applied, UART2 will fail to allocate DMA resources
but UART driver can work fine without DMA.

This error is related to the DMAC of rk3328 (pl330 or compatible).
DMAC connected to 16 DMA sources. Each sources have ID number that is
called 'Req number' in rk3328 TRM. After this patch is applied total 7
of DMA sources will be activated as follows:

| Req number | Source | Required  |
|            |        | channels  |
|------------+--------+-----------|
|  8,  9     | SPI0   | 2ch       |
| 11, 12     | I2S0   | 2ch       |
| 14, 15     | I2S1   | 2ch       |
|     10     | SPDIF  | 1ch       |
|------------+--------+-----------|
|            | Total  | 7ch       |
|------------+--------+-----------|
|  6,  7     | UART2  | 2ch       | -> cannot get DMA channels

Due to rk3328 DMAC specification we can use max 8 channels at same
time. If SPI0/I2S0/I2S1/SPDIF will be activated by this patch,
required DMAC channels reach to 7. So the last two channels (for
UART2) cannot get DMA resources.

Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 56 ++++++++-----------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 86cfb5c50a94..c984662043da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -84,34 +84,32 @@ standby_led: led-1 {
 		};
 	};
 
-	sound {
-		compatible = "audio-graph-card";
-		label = "rockchip,rk3328";
-		dais = <&i2s1_p0
-			&spdif_p0>;
+	spdif_sound: spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_dit>;
+		};
 	};
 
-	spdif-dit {
+	spdif_dit: spdif-dit {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;
-
-		port {
-			dit_p0_0: endpoint {
-				remote-endpoint = <&spdif_p0_0>;
-			};
-		};
 	};
 };
 
+&analog_sound {
+	status = "okay";
+};
+
 &codec {
 	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	port@0 {
-		codec_p0_0: endpoint {
-			remote-endpoint = <&i2s1_p0_0>;
-		};
-	};
 };
 
 &cpu0 {
@@ -163,6 +161,10 @@ &hdmi {
 	status = "okay";
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &hdmiphy {
 	status = "okay";
 };
@@ -278,16 +280,12 @@ regulator-state-mem {
 	};
 };
 
-&i2s1 {
+&i2s0 {
 	status = "okay";
+};
 
-	i2s1_p0: port {
-		i2s1_p0_0: endpoint {
-			dai-format = "i2s";
-			mclk-fs = <256>;
-			remote-endpoint = <&codec_p0_0>;
-		};
-	};
+&i2s1 {
+	status = "okay";
 };
 
 &io_domains {
@@ -337,12 +335,6 @@ &sdmmc {
 &spdif {
 	pinctrl-0 = <&spdifm0_tx>;
 	status = "okay";
-
-	spdif_p0: port {
-		spdif_p0_0: endpoint {
-			remote-endpoint = <&dit_p0_0>;
-		};
-	};
 };
 
 &spi0 {
-- 
2.27.0

