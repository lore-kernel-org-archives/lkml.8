Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38890C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EC021D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cazk43It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgDRWoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgDRWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA5C061A10;
        Sat, 18 Apr 2020 15:44:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so5907824wmg.1;
        Sat, 18 Apr 2020 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71OS66q5+Ejt0CVM9F9Xc2Ppa++y7UNFVHd3OthRIGY=;
        b=cazk43It3j2VdzZjFL3s/sYFp7HDN8tiCVlcUbB2/Mcdn4gLPLX0Th07O6It2OyJNL
         wvYcmUrpj68HUl7zlkTFUCO8RrYoT6YPtkgTy5VLmhNIQNAR7Yl7ZTFRWyvNc73q2pTP
         YBdzrGKG/wvFBmCdObfAV47RhsUflbPCXCVT5lRe8LSNWjyusUO5slrrTWkV9VVMFK/F
         ivpF4lDwN9U+i+eM/i0NShQX7YOjFRgP8GcNPvSiQbF6PEt6Juw1cSv5roEJYsZgS6Mk
         3jOzcZqCgZN51zTPWnlaZ4AbBJszYNJHqEK/xHa/sTPpCY0iSkZOMQufceMz93YgkEBU
         xy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71OS66q5+Ejt0CVM9F9Xc2Ppa++y7UNFVHd3OthRIGY=;
        b=cn46t9DlPowOx+uaFyO5cr6CUKtBxVzFStd6alAeKCrK1MttacpB9QuoCTWeYyskA1
         FJH1sbcM2iRN8x38HCxkdAKTZZ47Cm+h2xOIgjxLu/7Us886VTtzw+XFARuAAbboE30r
         enKebtvyz+LP3+CkLZMF3y734ROoV6psorEyIs74lIeW0xEoLrFrmJJ1iPXioCVyLJZQ
         D8nvma6c3WL6Gdl1RhVLGZL9nQho8R22EK79/zmEHN6lI7PtJpxX2vbTdrOisSDgWkMo
         Z1fC411EMaj7emxdFnQYQDwoi+2fxSvwymLtXs62VocQl19DGmT8avJv54pxEzapoFd8
         MMfQ==
X-Gm-Message-State: AGi0PuZ7v5qfBmtuw8tT3uw0zqZsdJjJkeL86Fq9bya44Zvv10S17IWS
        tvAxqx3vzQMCba5mguUgjhjRju2QvAs=
X-Google-Smtp-Source: APiQypKPyTgIPou2Ic2zKdJoZZ5OAlZ2VKspz5p2AZgsdlNKecb9pgI1aFJzAkUSz8IpYtJTgIpMJQ==
X-Received: by 2002:a1c:384:: with SMTP id 126mr10040767wmd.58.1587249889094;
        Sat, 18 Apr 2020 15:44:49 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:48 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
Date:   Sun, 19 Apr 2020 00:44:35 +0200
Message-Id: <20200418224435.23672-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418224435.23672-1-peron.clem@gmail.com>
References: <20200418224435.23672-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index a5ee68388bd3..558fe63739cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -88,6 +88,24 @@
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	sound_hdmi: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "allwinner-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -581,6 +599,18 @@
 			};
 		};
 
+		i2s1: i2s@5091000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-i2s";
+			reg = <0x05091000 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+		};
+
 		spdif: spdif@5093000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-spdif";
@@ -711,6 +741,7 @@
 		};
 
 		hdmi: hdmi@6000000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-dw-hdmi";
 			reg = <0x06000000 0x10000>;
 			reg-io-width = <1>;
-- 
2.20.1

