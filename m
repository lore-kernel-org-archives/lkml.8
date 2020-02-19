Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5DC3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50E24686
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSmb5C/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBSSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:12 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:32864 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgBSSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:05 -0500
Received: by mail-lj1-f181.google.com with SMTP id y6so1386973lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXy/lin2Xh1wX40VjvzK4N5EhPUQ7F76cQqtDhuzdAw=;
        b=ZSmb5C/cZRYqsLdPN5VclmwPUdQnDwDtrA7+GzYBWb84Svro7eD8Goee9p+QyRNffa
         lpqAyFWy+OjRvu2rpmV7A4Jmhdsc+5LuASif2bPB98oAKK8SAwcn+GtOJIG8ms9rTe/N
         RP4ciMh5Oz0za8q1UrrAdZnxI7sqVIsyXhU/gxjc2NDufE8aa+dHG/ouZuOl4lxk5/xs
         PNhGSDzRpOqOb5liAqynz+yB+24F4ZZtRq81KpAGlGd+fDNr3x49k47xudxaB+T9qNIU
         PHdveJ7Khmi/0PaqciofTOm9bLWPWJ953WvudgraUKFCfqbcNtpMhezDXeFq8Ab8SS8K
         lGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXy/lin2Xh1wX40VjvzK4N5EhPUQ7F76cQqtDhuzdAw=;
        b=b029zSJzCRqdbM4RHperVwKUHW6qj8n4xIiJq/2xMObYmZ8QIMJ4X7Tc0WTNPSnc4O
         CBGG8R3iIQJMXLlWx9FVz60AJdgv08JR62/G7vR7W3XkQ4fxnYQUphugiOMY5JpxYvz7
         P7CckNmr7BI4xlZabdu0WOmChtwbmgYrC7Dxbgvu+8L++73A2ElQf0mo1iPgg2QS4fpt
         1PsZklO0UZX3J86WELovInZYXOKjDfj7pP/Gsa5qcBUP9S6H8pxDbdxjSBbExE9mmaaX
         ZTV8Bv5dX4F0JzJijXSovxpKrtq17PgQiKXYOJKZd14oEJWN8iFHHqfL9tKWBlY+m/0A
         oV2A==
X-Gm-Message-State: APjAAAWpaKm1++zPdMnH2f6jVQ2tfW/GVVu1/tXq6A7CZB2fexHNlLm9
        TvgyF1DCIMye3mtt6KiD9AWwK749uxJ69Q==
X-Google-Smtp-Source: APXvYqwZu3/RGiLTbpL0Zcsi2lbhwfT1xxLVM2mwlQE0Ir+J5oDWNK91WxTAezMAOPajhF/43rFOuw==
X-Received: by 2002:a2e:7e11:: with SMTP id z17mr16664008ljc.279.1582135801686;
        Wed, 19 Feb 2020 10:10:01 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 14sm183942lfz.47.2020.02.19.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:10:00 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH 3/5] ARM: dts: sun7i: Add LVDS panel support on A20
Date:   Wed, 19 Feb 2020 20:08:56 +0200
Message-Id: <20200219180858.4806-4-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219180858.4806-1-andrey.lebedev@gmail.com>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
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
 arch/arm/boot/dts/sun7i-a20.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 92b5be97085d..d50263c1ca9a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/clock/sun7i-a20-ccu.h>
 #include <dt-bindings/reset/sun4i-a10-ccu.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -404,11 +405,12 @@
 		};
 
 		tcon0: lcd-controller@1c0c000 {
-			compatible = "allwinner,sun7i-a20-tcon";
+			compatible = "allwinner,sun7i-a20-tcon0",
+				     "allwinner,sun7i-a20-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&ccu RST_TCON0>;
-			reset-names = "lcd";
+			resets = <&ccu RST_TCON0>, <&ccu RST_LVDS>;
+			reset-names = "lcd", "lvds";
 			clocks = <&ccu CLK_AHB_LCD0>,
 				 <&ccu CLK_TCON0_CH0>,
 				 <&ccu CLK_TCON0_CH1>;
@@ -444,6 +446,11 @@
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
@@ -454,7 +461,8 @@
 		};
 
 		tcon1: lcd-controller@1c0d000 {
-			compatible = "allwinner,sun7i-a20-tcon";
+			compatible = "allwinner,sun7i-a20-tcon1",
+				     "allwinner,sun7i-a20-tcon";
 			reg = <0x01c0d000 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&ccu RST_TCON1>;
@@ -931,6 +939,20 @@
 				function = "ir1";
 			};
 
+			/omit-if-no-ref/
+			lcd_lvds0_pins: lcd-lvds0-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9";
+				function = "lvds0";
+			};
+
+			/omit-if-no-ref/
+			lcd_lvds1_pins: lcd-lvds1-pins {
+				pins = "PD10", "PD11", "PD12", "PD13", "PD14",
+				       "PD15", "PD16", "PD17", "PD18", "PD19";
+				function = "lvds1";
+			};
+
 			/omit-if-no-ref/
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
-- 
2.20.1

