Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFFBC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0DA2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkoO+MHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZMEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FBC061A0E;
        Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so7789496wmj.3;
        Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIU92tFnbM5F4GsZxfyBvjNoAK6MdY4fHHnGiOLjInY=;
        b=tkoO+MHUDgKE2W2y6Vwh3dRnEyCcyLv/zkEQrzs/FwHfhTpbHQP0iKeYrQ4wMLckWT
         JIEXVvi/NI/sgohW4tyaa6rGnX6l2ql+TBtATuktrJ/V71CFJ8APzipcoiIvkGsYkXQ/
         Hqd2YinT9n9VLspN83dS59ix5n/DfUBVV4RmpHwraP6FdMbIq+5Aml8akBG0FS1TP1S7
         X1c9ajGo2PJ3YIlvcSHTZeibGqacs2RJxOfauMjT8ZDE8x6u0qQFXyOpYG1SWMeXJFJY
         DlDL2IUFqZTzzSVeyw9gnRFo3GncRtxzjc+9+d1GuZWY47xt+VR5fIovX93az8Q68AgG
         sLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIU92tFnbM5F4GsZxfyBvjNoAK6MdY4fHHnGiOLjInY=;
        b=jdOySZmHiEVY/PfJA64uUVA1bJe/m2oy9PLrvNcarlNbjPSGFXZLLWXZ2PktW+tuKz
         kwVsrYsiQBZajFbYCNZOA5H9vEmBnPuQqgMQUopL3N8B/OMk7wza3lSNjhSwRiE2NgEb
         QtcgmtEUe7bnkZBzcdVfjqbDhEEsl49qhGombn6HalOgqjJEvzcaSBZpyOLm9yIBfjiH
         5aqkdbDgvNlQ2FYMlqpb4zBtfU+WdCKG9PPVsIPtOqHbHmSuwL8UD2bLSNoByVrZMqlD
         fORfxSa0nkBIEQiYW8oe2RXdUiNKBEXEXHanzeCuaLQrJvsxCb8vT/dMBIndCS8d0rLE
         dtbw==
X-Gm-Message-State: AGi0PuZXBWZYxNL3UXDEDX3HXPKotkOYjRofAildcG0fKEup5Gpr+u8K
        wo/13kAM/7dXa+mqaThU99U=
X-Google-Smtp-Source: APiQypJQivLKtZXp/OmZXZ5Izse0wCnqEyHEKmH7wBdtOiTI+IQ0H8Prs5Pn5dUr68966e52DjPNlw==
X-Received: by 2002:a1c:4989:: with SMTP id w131mr21647354wma.137.1587902691211;
        Sun, 26 Apr 2020 05:04:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:50 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 4/7] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Sun, 26 Apr 2020 14:04:39 +0200
Message-Id: <20200426120442.11560-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e56e1e3d4b73..08ab6b5e72a5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,25 @@
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "allwinner,hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
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
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -874,6 +893,7 @@
 			resets = <&ccu RST_BUS_I2S2>;
 			dma-names = "tx";
 			dmas = <&dma 27>;
+			allwinner,playback-channels = <8>;
 			status = "disabled";
 		};
 
@@ -1171,6 +1191,7 @@
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.20.1

