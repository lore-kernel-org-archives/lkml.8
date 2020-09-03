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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A7EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DD12071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrcUCU2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgICUkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgICUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C19C06124F;
        Thu,  3 Sep 2020 13:30:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m6so4619172wrn.0;
        Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61amrDy5MhVE+L2rXjmfQqPe1Fgk9roDotW+tBGquxU=;
        b=ZrcUCU2rzfGPrkL3bbQNF8DE7OpIgaYNnar8j2g9wWhP4VdZntrKae6ZQ0ZPazUjRM
         eFKhK66OIFB0nuIv4ASSdj5MzMNz3W0ULtFiLyIJU9J3/q277LYB4JgN8B2vsKwQQrFd
         mYoSScXD6VEwvIo3oHEqlHeDJ8QzMtKvTQu/XVd6/K+uFbJ40L5ylAuoXUVazQsrJlZ5
         2KgSu9557Xiq5rDvPrtGAlRn2xQGjuwPxEEa7zG/xNBtInUASSPTzrgYHoeVXIzmVWxj
         JTC07EtAPJCbNkUMp5aoMXDbK5uS1lJlVTpL1t5kRkuB1DmqVabf/VcfFGTXYbWOYeKA
         zqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61amrDy5MhVE+L2rXjmfQqPe1Fgk9roDotW+tBGquxU=;
        b=booxX5kZZmJ1425KTpEszEwGTVppiKYxWU1fHdiAmB2A8xqJVnbT3U0+MhBzY018LO
         QdJijcVEC56THLEXlLitF9WKqMHXryT8bH2AynGDnOunq3Rhk423sEe1SrMeJcx1ronU
         8BHNYR7mOPk7EGHiMDVHiGs0ViQdNybCt41W6y0FS8zKzudSM+hvEMOXHbP37a0ym1P7
         20cPC+x9PVVKKasfhlwPsl8Dw3nk86k3ceAMSN2kxmlpnCivXtCFGZh91Bae19hNZnNg
         a9wnVumIESZ8clrHdMMxejOLSoX74/dGKGWwzcEsolSyUPBd/XTCOrPeiRLGsyLW0JAh
         XN/w==
X-Gm-Message-State: AOAM530P93E5H9Yb2A0UpdKzQ8uMaZv4LwrqtnrG1PNUXdNtWlhu0b9S
        HAcyf4drd2INiw8pURXac5U=
X-Google-Smtp-Source: ABdhPJyTLPXx1dlhvyfiiXcGUGwjig79KiFo40tbRDlZq1pHE3VShxvp2x4u4kvSkE/SLK6496JQwg==
X-Received: by 2002:a5d:6111:: with SMTP id v17mr4249734wrt.265.1599165052954;
        Thu, 03 Sep 2020 13:30:52 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:52 -0700 (PDT)
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
Subject: [PATCH v2 08/20] arm64: dts: allwinner: h6: Add HDMI audio node
Date:   Thu,  3 Sep 2020 22:30:22 +0200
Message-Id: <20200903203034.1057334-9-peron.clem@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 9ce78a7b117d..9597f40b25a9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -67,6 +67,24 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-h6-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		status = "disabled";
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
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -608,6 +626,19 @@ mdio: mdio {
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
+			status = "disabled";
+		};
+
 		spdif: spdif@5093000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-spdif";
@@ -738,6 +769,7 @@ ohci3: usb@5311400 {
 		};
 
 		hdmi: hdmi@6000000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-dw-hdmi";
 			reg = <0x06000000 0x10000>;
 			reg-io-width = <1>;
-- 
2.25.1

