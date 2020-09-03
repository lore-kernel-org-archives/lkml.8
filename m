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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B2C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9010206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUUWA/3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgICUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgICUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F23C061231;
        Thu,  3 Sep 2020 13:30:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so4120155wmj.2;
        Thu, 03 Sep 2020 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Kzc7c8z/8BLZLzO00zFvlw0RIRscqiIQLsTxrgpdlY=;
        b=PUUWA/3DwOR0XZKrhD7f6l68tbk5P/o5FOQQmpRTCPHsPuDmBxR1cfmiCkIh4pRRkG
         ApgMa0YPGTXrqN27iHak3drv+otCQfhpzAKkRZCYFBMd53wBJf7hxZq1Llwj8GclQeVq
         jF7vB53l1KsMwSapXwKhrUa3rUAvhoH/j76DtlI3dWZnBKSCQGjzQ/oqM9rgQ8ouOtku
         rc31+b1AEwnwbvC5rQOvfV6CmsW+QT65UPHdOG6pOiIePlIyvHyVpJTZP0vq70aH85SE
         tXj7tUgKAcpnYhadrY5cppTrTw55hIZBpjLMcdyozMryAYrZFDFiEUrnEz3IQd+C1Pbu
         ao2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Kzc7c8z/8BLZLzO00zFvlw0RIRscqiIQLsTxrgpdlY=;
        b=NvbQCg3J/hg89CPz0Eu2L9F9JOY50zZ5xPecuMe7+G5zhqMfyZ1X1vOSt+/giMVkSp
         9m3bx1A+TmDYa9qTlXfzp5kLzq7lq5lvKonH7p0Y8YBuT268zGGa4RFRncNT73BwTtp6
         s9Kud3TtiLqCJM+s4erYNMWZXfdWUpG2Kcju1Uk+un+bx4vddqSDHNYNo6sT5oP6ECaD
         S3oaorn27DGYyxAaQXEO/2cEIdMYzw78F4dk9L0l/ovsknZXllM4M0wMh0hycxJTaRg1
         Xj5bMA/3HqsTpLB8wnlHrRWPpKV7pXaacCgTYkvd457WOxpIGXXWjJqpX+uLrJlRKI5R
         YXUA==
X-Gm-Message-State: AOAM530Ix1jqsakMU5Tw1GIAnyBj/2VX16k1rdJs7++UIcHHL65B2rzy
        743o2jxiltHlPeOhyCTH7ZA=
X-Google-Smtp-Source: ABdhPJw+tb3+WnIk1ktQolOHCtjM7VlSRebZKfzrpihaMF2DlFCRTa3VjYI21Dgt/yP0CFcatKXo0g==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4198374wmc.35.1599165058374;
        Thu, 03 Sep 2020 13:30:58 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:57 -0700 (PDT)
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
Subject: [PATCH v2 13/20] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Thu,  3 Sep 2020 22:30:27 +0200
Message-Id: <20200903203034.1057334-14-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index bcf808459edf..8c540f4f64b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,24 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun50i-a64-hdmi";
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
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -1155,6 +1173,7 @@ deinterlace: deinterlace@1e00000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

