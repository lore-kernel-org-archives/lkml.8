Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28AC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA925246AF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC09I+Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgBMUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:20:02 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39357 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgBMUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:20:01 -0500
Received: by mail-lj1-f180.google.com with SMTP id o15so8104359ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mW6PukSxckGSUCke6VTFTCVByD+nJPm6k8mdLJlJUQ8=;
        b=RC09I+Bvk9BEGM312oV5NW7pG1aKQPts5wE1yDyMZ5aunmfCjtpj/ZtkVQfg5cc4kX
         n4rUd7Uw8Ed/epLUm9Gj7Q9rrTgeNaB7fA6T6msnWDT9n49NXzqbTh4gbBQ3D4ylyM2m
         Db9pfSfadEt1TPmiY25g7eQP5kfvza19ucaRwOBa4LoatztuIsBGKZCRLtsT1qGzqb+x
         3R1jApficdWMUC38I6zCdiYLKbYUeP7ewABAHw3uNkUlziHLUZmEa77C55CQ9fX5E8yR
         nhxT/uqgKTwmRXqalvyie7/fOEEnIe6JNxBaGyGoRwKVGvbXa2Gl0eaaV/pVBbzSbPgj
         WORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mW6PukSxckGSUCke6VTFTCVByD+nJPm6k8mdLJlJUQ8=;
        b=YIpBo3LTPF5v8jbRhELzzSg08DcLIEt5V8QxYIMJoLY+TCYsT+NB6Iwx/ZYWhcno4y
         lJqelOIY7MHEByULj1PWAhTCKPV9Ce1AHKKT78aeyY61Au27vt4yzphOpYJZiCXXETFA
         W/TDUGdy6dHhPIG6ZXFQteuV2D1ptk84x+6m7C+Xo8JVZLpOhadsSBH5+quLdYvzHNuZ
         Mc+wXgdyBsG6NXLp4rmG8ddnZ8Lxp9JbNXJFh+UP56DEV4Kw0x3uJWrOFOfAREb6QPsp
         mRcvz0SHx2tHhcAxJjXza7UlizrPIhqIq8x/3ibKkDCrBNasfjxq4vvfWa/KaP3b0wG3
         dzIA==
X-Gm-Message-State: APjAAAUFQrkYx4VOae++LyRb4rkSTRa3RXiWHKJ9TMwh5GRoYMzbXfeD
        dfqtjMVy46RLbLLJlUSXKG4=
X-Google-Smtp-Source: APXvYqxw0rZXUmiJIT9xq2xe3VuahXdAUOtscc4DdIG+xn5Y17KAhRRAUvyZVKqDwcbtKuS/oxnM5w==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr12844931ljk.179.1581625199519;
        Thu, 13 Feb 2020 12:19:59 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id s22sm2209470ljm.41.2020.02.13.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:19:59 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH v3 3/3] ARM: dts: sun7i: Add LVDS panel support on A20
Date:   Thu, 13 Feb 2020 22:18:57 +0200
Message-Id: <20200213201854.810-3-andrey.lebedev@gmail.com>
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
 arch/arm/boot/dts/sun7i-a20.dtsi | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 92b5be97085d..3b3c366a2bee 100644
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
+						allwinner,tcon-channel = <0>;
+					};
+
 					tcon0_out_hdmi: endpoint@1 {
 						reg = <1>;
 						remote-endpoint = <&hdmi_in_tcon0>;
@@ -1162,6 +1168,24 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			/omit-if-no-ref/
+			lcd_lvds0_pins: lcd-lvds0-pins {
+				pins =
+					"PD0", "PD1", "PD2", "PD3", "PD4",
+					"PD5", "PD6", "PD7", "PD8", "PD9";
+				function = "lvds0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+			};
+
+			/omit-if-no-ref/
+			lcd_lvds1_pins: lcd-lvds1-pins {
+				pins =
+					"PD10", "PD11", "PD12", "PD13", "PD14",
+					"PD15", "PD16", "PD17", "PD18", "PD19";
+				function = "lvds1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.20.1

