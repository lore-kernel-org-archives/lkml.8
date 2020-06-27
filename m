Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D675920672
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ddLfQ6Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgF0E40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:56:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17453 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0E4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:56:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d1680000>; Fri, 26 Jun 2020 21:56:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:56:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 26 Jun 2020 21:56:21 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:56:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:56:21 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d1700001>; Fri, 26 Jun 2020 21:56:20 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 23/23] arm64: tegra: Add support for APE sound card on Jetson Nano and TX1
Date:   Sat, 27 Jun 2020 10:23:45 +0530
Message-ID: <1593233625-14961-24-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233769; bh=taGJx4bnloUgV2sDI2d4cd/qcV9qYym60K4y+pWho+I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=ddLfQ6ZqgcJjKddkhaXM+i6RtbI0Dj80XmVHjRcUwn0osUbF1Cu38zjubnmUFsLH2
         uEiAeafhsLn3CkzUVJB69CHPogvF7dMtAa5e4qCg84Y8kB0x19mr/lerMbRfCQJXaX
         7BOLLueVWOH/vnWTwd2FCySGciMOD4n63HOPUMVVk1Qw0sLkvw2fXvKBc7Kkc2UJTc
         NM0nuWCVNxLDz8QUS7LE0FFo3/QxfmXFphZdpgHlknF8xpl8vIFpUuJqnFQ5PHw0AB
         qTGDZuiN5RqpEHLO3x+m6kYy/wgFz46gHrSX3UXYmRtskm+VlJuUPsPtw3JJhOG+Tl
         6Bagn6CFRAwbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds APE sound card support on Jetson Nano and TX1 which is based
on simple-card driver. Earlier in the series simple-card driver is
enhanced to work with multiple ASoC components. Based on board design
required I/O interfaces are exposed for I2S and DMIC. More complicated
audio paths will be added going forward.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 94 ++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 49 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 67 +++++++++++++++
 3 files changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 3c21137..7c4b521 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -166,4 +166,98 @@
 			};
 		};
 	};
+
+	tegra_sound {
+		status = "okay";
+
+		simple-audio-card,name = "jetson-tx1-ape";
+
+		simple-audio-card,widgets =
+			"Microphone",   "MIC",
+			"Speaker",	"SPK";
+
+		simple-audio-card,routing =
+			"SPK",		  "I2S1 Playback",
+			"SPK",		  "I2S2 Playback",
+			"SPK",		  "I2S3 Playback",
+			"SPK",		  "I2S4 Playback",
+			"SPK",		  "I2S5 Playback",
+			"I2S1 Capture",   "MIC",
+			"I2S2 Capture",   "MIC",
+			"I2S3 Capture",   "MIC",
+			"I2S4 Capture",   "MIC",
+			"I2S5 Capture",   "MIC",
+			"DMIC1 Capture",  "MIC",
+			"DMIC2 Capture",  "MIC",
+			"DMIC3 Capture",  "MIC";
+
+		/* BE links */
+		simple-audio-card,dai-link@1 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s1>;
+			frame-master = <&cpu_i2s1>;
+
+			cpu_i2s1: cpu@0 {
+				sound-dai = <&tegra_i2s1 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@2 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s2>;
+			frame-master = <&cpu_i2s2>;
+
+			cpu_i2s2: cpu@0 {
+				sound-dai = <&tegra_i2s2 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@3 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s3>;
+			frame-master = <&cpu_i2s3>;
+
+			cpu_i2s3: cpu@0 {
+				sound-dai = <&tegra_i2s3 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@4 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s4>;
+			frame-master = <&cpu_i2s4>;
+
+			cpu_i2s4: cpu@0 {
+				sound-dai = <&tegra_i2s4 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@5 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s5>;
+			frame-master = <&cpu_i2s5>;
+
+			cpu_i2s5: cpu@0 {
+				sound-dai = <&tegra_i2s5 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@6 {
+			cpu@0 {
+				sound-dai = <&tegra_dmic1 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@7 {
+			cpu@0 {
+				sound-dai = <&tegra_dmic2 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@8 {
+			cpu@0 {
+				sound-dai = <&tegra_dmic3 0>;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 721f66c..31994f6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -842,4 +842,53 @@
 			};
 		};
 	};
+
+	tegra_sound {
+		status = "okay";
+
+		simple-audio-card,name = "jetson-nano-ape";
+		simple-audio-card,widgets =
+			"Microphone",   "MIC",
+			"Speaker",	"SPK";
+		simple-audio-card,routing =
+			"SPK",		  "I2S3 Playback",
+			"SPK",		  "I2S4 Playback",
+			"I2S3 Capture",   "MIC",
+			"I2S4 Capture",   "MIC",
+			"DMIC1 Capture",  "MIC",
+			"DMIC2 Capture",  "MIC";
+
+		/* BE links */
+		simple-audio-card,dai-link@1 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s1>;
+			frame-master = <&cpu_i2s1>;
+
+			cpu_i2s1: cpu@0 {
+				sound-dai = <&tegra_i2s3 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@2 {
+			format = "i2s";
+			bitclock-master = <&cpu_i2s2>;
+			frame-master = <&cpu_i2s2>;
+
+			cpu_i2s2: cpu@0 {
+				sound-dai = <&tegra_i2s4 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@3 {
+			cpu@0 {
+				sound-dai = <&tegra_dmic1 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@4 {
+			cpu@0 {
+				sound-dai = <&tegra_dmic2 0>;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 73ae58f..f1925f1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1841,4 +1841,71 @@
 			};
 		};
 	};
+
+	tegra_sound {
+		status = "disabled";
+
+		compatible = "simple-cc-audio-card";
+
+		clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+			 <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA210_CLK_EXTERN1>;
+		clock-names = "pll_a", "plla_out0", "aud_mclk";
+		assigned-clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
+				  <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
+				  <&tegra_car TEGRA210_CLK_EXTERN1>;
+		assigned-clock-parents = <0>, <0>, <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+		assigned-clock-rates = <368640000>, <49152000>, <12288000>;
+
+		simple-audio-card,aux-devs = <&tegra_ahub>;
+
+		/* FE links */
+		simple-audio-card,dai-link@0 {
+			cpu@0 {
+				sound-dai = <&tegra_admaif 0>;
+			};
+
+			cpu@1 {
+				sound-dai = <&tegra_admaif 1>;
+			};
+
+			cpu@2 {
+				sound-dai = <&tegra_admaif 2>;
+			};
+
+			cpu@3 {
+				sound-dai = <&tegra_admaif 3>;
+			};
+
+			cpu@4 {
+				sound-dai = <&tegra_admaif 4>;
+			};
+
+			cpu@5 {
+				sound-dai = <&tegra_admaif 5>;
+			};
+
+			cpu@6 {
+				sound-dai = <&tegra_admaif 6>;
+			};
+
+			cpu@7 {
+				sound-dai = <&tegra_admaif 7>;
+			};
+
+			cpu@8 {
+				sound-dai = <&tegra_admaif 8>;
+			};
+
+			cpu@9 {
+				sound-dai = <&tegra_admaif 9>;
+			};
+
+			/*
+			 * Empty codec list.
+			 * Router MUX controls take care of audio path by
+			 * connecting multiple components.
+			 */
+		};
+	};
 };
-- 
2.7.4

