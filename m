Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4848C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D45C208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCEglnpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgGDLjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgGDLjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEFC08C5DE;
        Sat,  4 Jul 2020 04:39:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so34351308wme.5;
        Sat, 04 Jul 2020 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZa7juvxCNraX7yvPBOLr2zonCmAlaBXMRvkitzcE1A=;
        b=KCEglnpyhNmWqNqkJ/+JquXUQEMFiqvGsTWMUc+p4Dxgp4TE1emyB3jY012MFGoj0d
         L+aLNL2/GkMTeFM/7qX6AQScuaQShpdM3wOy1NUYQKPxaASltMFZfVP+v02PTpXPqTyy
         dsNRT1nVSAbwQ7jPLS3X2Z0n+oxRQAMQM9hmM1pFaXRlyuTDYLY0woO6j8WEUQwqCpXP
         qIdBVbUbyOJtjfvyth01DnHE6oobgdVuu38o6MtaOQDPSvqcPNQvdXTUyfHC0nC9eVSY
         P7+ojJIqNe9KxAEIqbG3Ck3UGr4+XOhewTkczhTOWaWG39ECeAk23r1PCOVFc7QRx4Rp
         qVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZa7juvxCNraX7yvPBOLr2zonCmAlaBXMRvkitzcE1A=;
        b=OPAcSLWXDbOhwRGPRxtk1/WKajTgb2zXS8gC6Py8Ep+M6uhRtbtyPpkJPWMLduCNgM
         sNDQ8VjTpWDQ0J4QBzIoWPlO7cIXazWcumY/pUIKwvHxK4njspmULyUddekCMk/qQGCU
         JiS5d9bW3zpYAzM/0wLaSda9d+wkiVKPOov3D9afto2/HoS6cl7sVHYNZLEiM/up+psh
         Sk2STFgZXLXGpSYZKxDGmi20CZR80zSww5ZEWcEDMYD9H3diVCO9L80rWKM2zSbnhtox
         aWpbLCdWRhgQVJaLT+lJLECrQIrDjtyi1uSnZFVOHP2TuVwMUvDMpvQHelDVjEiwatot
         zn3Q==
X-Gm-Message-State: AOAM531SfagoqH36pvoHo9lUkKlrTQYFGxJ6E1RtImW/CEYMdLft+g5s
        q1SKaUrOxxlNByYs2Srvkm0=
X-Google-Smtp-Source: ABdhPJxfcQdS+Umj/CHeClbECFuBf+fW1U4N3FItKLlj7UmAWRunzK5YIbAPJzh+k2FYo5STu5fXKg==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr34791236wme.107.1593862761215;
        Sat, 04 Jul 2020 04:39:21 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:20 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 13/16] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Sat,  4 Jul 2020 13:38:59 +0200
Message-Id: <20200704113902.336911-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
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
index c662f6a170ce..6a321fdc8e90 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
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
@@ -856,6 +875,7 @@ i2s2: i2s@1c22800 {
 			resets = <&ccu RST_BUS_I2S2>;
 			dma-names = "tx";
 			dmas = <&dma 27>;
+			allwinner,playback-channels = <8>;
 			status = "disabled";
 		};
 
@@ -1155,6 +1175,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

