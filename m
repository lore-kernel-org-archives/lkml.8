Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44035C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1215322D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iyr12YsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHEQuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgHEQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D254C061A2D;
        Wed,  5 Aug 2020 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=YDX2dL3dA5DnPicWfPc6UxoSlo/ROXibu/4w9Wyspnk=; b=Iyr12YsJcO1QsAETO6CjuPY/zM
        tmWmBP037J/hBchf7ZFu5fQJbhPZM+CxoSC70l4K+dv55iTzk43a5LcoCGIj02QOkjSbHe+Z9e0j3
        Rn+iauWU9aRpErMR89PTODIK/zT+QEe9ba3/Ubx+YKzJV3C1IMlkRODCF2O1CD8Rs6Len2R0LPU/r
        qPKuoOf3wKEuXJogT1iwm3oCZBVZrK86eOcTZgccApTB0HVbSlZ+gq9udTl6w0szybhlC4A3rGApb
        QrGEhrWVdykBHA4YoPYWlXhPNtfEt93mw5H1MnEhjI6RMOyHPx6twAHqp/EpGB3mPaN9USYzUmYZz
        9CfbLv/A==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Hcc-0002bF-PC; Wed, 05 Aug 2020 11:30:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1k3Hcb-00BavX-Nw; Wed, 05 Aug 2020 12:30:13 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm: dts: mt7623: move MT7623N GPU to separate mt7623n.dtsi file
Date:   Wed,  5 Aug 2020 12:30:12 +0100
Message-Id: <20200805113013.2763510-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805113013.2763510-1-dwmw2@infradead.org>
References: <8ef96e4d02ef82e171409945ee6cc0348c4fe594.camel@infradead.org>
 <20200805113013.2763510-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

The MT7623A doesn't have a GPU; add it only for MT7623N boards.

Fixes: 1f6ed224594 ("arm: dts: mt7623: add Mali-450 device node")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 24 -------------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  2 +-
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  2 +-
 arch/arm/boot/dts/mt7623n.dtsi                | 35 +++++++++++++++++++
 4 files changed, 37 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n.dtsi

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 3a6b856e5b74..dcd2f5ba4e20 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -734,30 +734,6 @@ g3dsys: syscon@13000000 {
 		#reset-cells = <1>;
 	};
 
-	mali: gpu@13040000 {
-		compatible = "mediatek,mt7623-mali", "arm,mali-450";
-		reg = <0 0x13040000 0 0x30000>;
-		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 178 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 179 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
-				  "ppmmu1", "pp2", "ppmmu2", "pp3", "ppmmu3",
-				  "pp";
-		clocks = <&topckgen CLK_TOP_MMPLL>,
-			 <&g3dsys CLK_G3DSYS_CORE>;
-		clock-names = "bus", "core";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
-		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
-	};
-
 	mmsys: syscon@14000000 {
 		compatible = "mediatek,mt7623-mmsys",
 			     "mediatek,mt2701-mmsys",
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 2b760f90f38c..344f8c65c4aa 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 #include <dt-bindings/input/input.h>
-#include "mt7623.dtsi"
+#include "mt7623n.dtsi"
 #include "mt6323.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index 0447748f9fa0..f8efcc364bc3 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include <dt-bindings/input/input.h>
-#include "mt7623.dtsi"
+#include "mt7623n.dtsi"
 #include "mt6323.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
new file mode 100644
index 000000000000..7724a4d05b89
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n.dtsi
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright © 2017-2020 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *	   Ryder Lee <ryder.lee@mediatek.com>
+ *
+ */
+
+#include "mt7623.dtsi"
+
+/ {
+	mali: gpu@13040000 {
+		compatible = "mediatek,mt7623-mali", "arm,mali-450";
+		reg = <0 0x13040000 0 0x30000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
+				  "ppmmu1", "pp2", "ppmmu2", "pp3", "ppmmu3",
+				  "pp";
+		clocks = <&topckgen CLK_TOP_MMPLL>,
+			 <&g3dsys CLK_G3DSYS_CORE>;
+		clock-names = "bus", "core";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
+		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
+	};
+};
-- 
2.26.2

