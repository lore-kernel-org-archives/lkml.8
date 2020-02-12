Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8DC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726A21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWCgfyya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgBLWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:25:39 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46227 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgBLWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:39 -0500
Received: by mail-lf1-f48.google.com with SMTP id z26so2719837lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2sufO4LLXac8EpPRG82WEu62FbVXGdtrzG0LXHZeOc=;
        b=qWCgfyyaZcVlwnASB423iewuwd4fmtQcfKUkenO0oPI3pkWLGoRCTD9Fk/kaJW0CjH
         //r1Yth+Eqaq0+HtY38lAOhJQ69YyTEGFlnVRffyeb7AmMJdvsL9PELN35JM6nB2cKuy
         Y3cja1QMzIOqJxVK6+4lAHDuXG02HNegLzdn5G0ycXzutBpdU9qEPbU+H09ZGnSR6wE4
         X2OqusGjh1VDDNjsn2bsVIA2CLJ30WysxmJKeYafXTNFWGS3dHb7zOqcN1i/V0Ht2GGt
         KlMAhWNJShkvfwdlVpgEHu7/by0Jkq0c3SCAUr7SFH4lRfVFrFFBqjiUZobk1UOQcN1c
         90UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2sufO4LLXac8EpPRG82WEu62FbVXGdtrzG0LXHZeOc=;
        b=asHSH9WL1GHxRgu7eSjxCJhyyDr09ve54xf/IszID0jnIYXYfK7p2mzgXWM0y4ED2B
         HsWr/npaLggJUQCtr2upy2Zb+6jYiNmgB+gW6zn/fzR/OFEysTokVIzrwlsI5IcQl0VA
         w/rcW2jud6dULurNPkG9rASfZStaScXNrbcquwyZR4qEKAiYGoUHFYQQD4EcuQ8PxWid
         ZJuWNmFT53yMnXqrZcCc3QQV6s+Kn47GAqTe2hKIq7hLcIwT2ZnGr4px/xmtsWrcN/lB
         Hz0z5di0gS+7jsCjY7U6fvhbbxzi0BPqtNbk0X+5zKJp3PC2guFdmpFm7ThFjBT5vtTR
         4slA==
X-Gm-Message-State: APjAAAW4U1YjJOBmky1Bg4GFjaY6fFbghbA+riohEDSXIF3gkQAW7Uah
        lPW89ow6VJhbNzivPisgZy8=
X-Google-Smtp-Source: APXvYqzbSsCCf3UaK7PD3uxjPodMUnmbNyBSe6Xyg4gzlkdOwnEbZsG8gzDBCSwmJ7KSr76ZxQ1kNA==
X-Received: by 2002:ac2:523c:: with SMTP id i28mr7610773lfl.104.1581546337071;
        Wed, 12 Feb 2020 14:25:37 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 126sm188008lfm.38.2020.02.12.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:25:36 -0800 (PST)
From:   andrey.lebedev@gmail.com
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Date:   Thu, 13 Feb 2020 00:23:57 +0200
Message-Id: <20200212222355.17141-2-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210195633.GA21832@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Lebedev <andrey@lebedev.lt>

Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
provide sample LVDS panel, connected to tcon0.

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 45 +++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 92b5be97085d..b05fdf8df32e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/clock/sun7i-a20-ccu.h>
 #include <dt-bindings/reset/sun4i-a10-ccu.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -407,8 +408,8 @@
 			compatible = "allwinner,sun7i-a20-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&ccu RST_TCON0>;
-			reset-names = "lcd";
+			resets = <&ccu RST_TCON0>, <&ccu RST_LVDS>;
+			reset-names = "lcd", "lvds";
 			clocks = <&ccu CLK_AHB_LCD0>,
 				 <&ccu CLK_TCON0_CH0>,
 				 <&ccu CLK_TCON0_CH1>;
@@ -444,6 +445,11 @@
 					#size-cells = <0>;
 					reg = <1>;
 
+					tcon0_out_lvds: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&lvds_in_tcon0>;
+						allwinner,tcon-channel = <0>;
+					};
 					tcon0_out_hdmi: endpoint@1 {
 						reg = <1>;
 						remote-endpoint = <&hdmi_in_tcon0>;
@@ -686,6 +692,19 @@
 			};
 		};
 
+		lvds_panel: panel@1c16500 {
+			compatible = "panel-lvds";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			port {
+				lvds_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_lvds>;
+				};
+			};
+		};
+
 		spi2: spi@1c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
@@ -872,7 +891,7 @@
 			gmac_rgmii_pins: gmac-rgmii-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
-				        "PA7", "PA8", "PA10",
+					"PA7", "PA8", "PA10",
 				       "PA11", "PA12", "PA13",
 				       "PA15", "PA16";
 				function = "gmac";
@@ -1162,6 +1181,26 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			/omit-if-no-ref/
+			lcd_lvds0_pins: lcd_lvds0_pins {
+				allwinner,pins =
+					"PD0", "PD1", "PD2", "PD3", "PD4",
+					"PD5", "PD6", "PD7", "PD8", "PD9";
+				allwinner,function = "lvds0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			/omit-if-no-ref/
+			lcd_lvds1_pins: lcd_lvds1_pins {
+				allwinner,pins =
+					"PD10", "PD11", "PD12", "PD13", "PD14",
+					"PD15", "PD16", "PD17", "PD18", "PD19";
+				allwinner,function = "lvds1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.20.1

