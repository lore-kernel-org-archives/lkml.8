Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DBAC2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E63206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSzV1aYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgICUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgICUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BAC061264;
        Thu,  3 Sep 2020 13:30:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so4134286wmi.1;
        Thu, 03 Sep 2020 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I49qX4p3R5f0D/cfuMt37KBf23v3/L+E2eSH2MZxqyM=;
        b=CSzV1aYjyXMA+ThlgRn7cci8rIEX5STM39i8LXl6eAR1hk+g6v2+sjurymyzXj24DW
         DAlAXhSTKhhRfJzIiXxpCm3+liwUA9WU2Hlt0wgo8zpCJuHYz0CMp6A1zdqNttc8/hxP
         TC7NSVfH/eC07z5O8fcYwYCHDth71yq4Rna0Mr43QWesC6z/jxHcThvh8ZNOfPHdFBxm
         f3ZtZO+ZMLeaJXgLwePVuL3xqfrGlU5MrexfNI/5uUylzH4svGhmVzCGJ8jVSalB4UDJ
         koiSWTLUhBf6IWMBM5kMUiZtolpSDuhuk1nBMCgU5CaLLCfktoxw7ShE0dGCNGvLZ9Dk
         cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I49qX4p3R5f0D/cfuMt37KBf23v3/L+E2eSH2MZxqyM=;
        b=NkMl+JxuF0uAUlxMr1gP9jAAOuZaFdK5Qmy+qKVJ08MOX98Oo9a8+RgjvheO+7PQFM
         Bg/YKVnszP3mAwfjLUOS+UBv07T+cRUi52MCYD5B00ABp9sz8kSsAtv5zJZQj8b7J1gy
         v/MQ/UXuZGxEBq7omVUUTpU7P3DaTMJ1E0rRBR44QNL9fiGXf2SvXbM1Or9wPXDM8KWt
         wROUcZYvXrDST4EaYU2uN61hst+FnKJvbO3xDc7bNJBf5eyC622MrEh8IlQScA9aklVM
         dBlUWWYMJS2W4MoP0VqcagX3Picx7vv/j7tAJGg9Tn+ozFI4+8IZho5VLp7ublmYtFNG
         se1g==
X-Gm-Message-State: AOAM531HM9IdIZRUEflUVFoPqfcXLtMo66nGI9OSvpPiYOvNhUq5k2FM
        PMcTg6Grrz2WVjYMVU+ja74=
X-Google-Smtp-Source: ABdhPJy5CGi5+Z8rjupOyEJsdtu5n4tI7FD43iDEcopKLSxFhEJ+qzOIV5ZHmtekurdvtvJycDajQw==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr4214447wmg.50.1599165056187;
        Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 11/20] arm: dts: sunxi: h3/h5: Add HDMI audio
Date:   Thu,  3 Sep 2020 22:30:25 +0200
Message-Id: <20200903203034.1057334-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3dca6d89cab9..ebb109c828d9 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,24 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -806,6 +824,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

