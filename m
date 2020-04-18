Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14653C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E555C21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNGWlj7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgDROjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgDROjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C51C061A0C;
        Sat, 18 Apr 2020 07:39:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so6372721wrp.5;
        Sat, 18 Apr 2020 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcU18dKgyioxh46jA7FvWsYL58s8h58864kxaD9p5qo=;
        b=FNGWlj7vcsHWXXSK6xC+raY2VaK8WujFpWxUCLPM7g3A5Kjc1LEx4eHBGUHXW1BQMJ
         n/asEVPQE/32PXIAOhunBM7j/BsT7tgd9woCdhleKcUtVNC3J/sc17p0S+qAv67qVBCq
         LEA6a0LyRTcUWGJ8cXP5LhW/TzMjL3aaijmCXu+VUCfV3pG9WgG9iy+ergc6LNHBXJ8Y
         6UGmJFrd3kzfjqCtdbarrb3I5Pw7XCivgb9n3ONfGh49tH9ulciCiQ7lBGj2mBE0UxH6
         jfSxWkhpUmzxFy2FlXR2LEiLHvXn+t8kZN8+g0BIBG3FF4n4im2qHNhhipUy8PCTJHG5
         nLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcU18dKgyioxh46jA7FvWsYL58s8h58864kxaD9p5qo=;
        b=fAfNpNkHF+Vr2rf2LJRaiXUw5KTSMOQhCMFGhuO1Tc5xMS7e2opRr01PVKFxC7tHSK
         8uwhNRF1VmRIyt30fMY0aKgRkLWRhnO/zCwLbdYZjwA9VO3d/D7tYfTxvrNmHjeg0uXD
         tkSAQL0Wk1y3tyYLObpU2INmjfrYaPjlNUt0N0ySJKyBksK+rM789lOcoGbZkPU/Ogl3
         weYa4ge2EGF0IZSnn0JQ0XVSXwoLe7xSBt1pU9Uc5SIO69KWNvV5YZrE+Rus3nfsyK7n
         XodKegq7rnFUwMWIf+nl4WwaX6ILyThtK0J/OwASbG7jyooywkl/La6hdSt08J55qDCe
         p86g==
X-Gm-Message-State: AGi0PuZANF9LUhzSHYvZeM1qR5wtMmGeBwj6tjky9gPVIIZIaJAYZG2W
        sYsBPEbjcywkDj43jL0WYsU=
X-Google-Smtp-Source: APiQypKJlHwpQpKN7XlW70JN2DZ17rcbc6rk8jOc1krkjdakqmOSks4L/YFTXs9xyLmITSrlVkM7hg==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr10073857wru.403.1587220774636;
        Sat, 18 Apr 2020 07:39:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:34 -0700 (PDT)
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
Subject: [PATCH 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
Date:   Sat, 18 Apr 2020 16:39:23 +0200
Message-Id: <20200418143923.19608-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418143923.19608-1-peron.clem@gmail.com>
References: <20200418143923.19608-1-peron.clem@gmail.com>
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
index b9ab7d8fa8af..47c657d6237b 100644
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
@@ -571,6 +589,18 @@
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
@@ -701,6 +731,7 @@
 		};
 
 		hdmi: hdmi@6000000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-dw-hdmi";
 			reg = <0x06000000 0x10000>;
 			reg-io-width = <1>;
-- 
2.20.1

