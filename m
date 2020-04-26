Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2DEC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B80C2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR+v67a5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgDZKld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbgDZKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33223C061A0E;
        Sun, 26 Apr 2020 03:41:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so16965327wrg.11;
        Sun, 26 Apr 2020 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71OS66q5+Ejt0CVM9F9Xc2Ppa++y7UNFVHd3OthRIGY=;
        b=FR+v67a5vKi3Hi1SzdTPcg1Q7Pe8jxEePGV1F1w9NbO6dK80/OuhFYLMpclxdb/1Q0
         6DynEz+yJoNi2ER6HHZKsk62dWeWeU7eYZ2slAYA8hJ4a8zyXBqdzH5TFfqPADg6i3uN
         1CysICUqjJ3O8dbKrljmN1MYDMv4iRUPRkDTadTa4U56L+cB2mEJ9k8SD4axMMWYib2T
         ceRmq9WsEG3pGS1H2nX0gRri/blZg4tueISMglmoQjRoELyXziX4NZGnLzztH7hW3wRt
         Ngrcd4mOSSnFAKzE4Gd35LQL5cPxyY8KWZFmbfEQExpo48splnDre75XOj5k7r8Q+eHD
         S9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71OS66q5+Ejt0CVM9F9Xc2Ppa++y7UNFVHd3OthRIGY=;
        b=dzXD9mxBP7TvmgOnXQkJLwKM6IVIWVxUsoHVrTx7xsU2vXIW2CXmPVpIu7FbeUDKYN
         JZ5KkoJNCpaRmP9Q3NnZUDL/i65iTLBsqb471ZsMjAJiCihVwnCXZREpft17BLT6U6JD
         GgD3ChN6zYz/rl+xpQJzqwXgAfuGM+k7xYKAPvj03tz0LQqC2OD7AnJhpzhOQpRVPN7O
         RjtoZOuqWf3nxRNiDq1FmmVuKWMgAwqhmQb0xxRfumOqnvpjt60U3luI8/0Of6bCiJHu
         zrF6vxBNSMK8Oh8ktj0lpo8LoG4VFJT5/s4eos27+8ldZVoqNBtrfY0QWK6G2kj+w+Fy
         pNng==
X-Gm-Message-State: AGi0Pub2haCj/Uz8RZJtNo+l+ksdefrF2iZkSSTWavz7n7zbDesFPdb8
        akBhmQxIh1a4/t2G5Z6NIoY=
X-Google-Smtp-Source: APiQypIrb0ZxEV1ggjSVaYJASumLobe3vmR2rfufWmAZ4oevbrbzCjEoc15o2VgveWQNLhbia1Eu4Q==
X-Received: by 2002:a5d:574b:: with SMTP id q11mr15947218wrw.324.1587897686721;
        Sun, 26 Apr 2020 03:41:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:26 -0700 (PDT)
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
Subject: [PATCH v3 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
Date:   Sun, 26 Apr 2020 12:41:15 +0200
Message-Id: <20200426104115.22630-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
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

