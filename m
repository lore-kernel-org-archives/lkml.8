Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562EB20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHUTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:50:43 -0400
Received: from chicot.dit.umontreal.ca ([132.204.13.19]:57270 "EHLO
        chicot.dit.umontreal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:50:41 -0400
X-Greylist: delayed 3590 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 15:50:40 EDT
Received: from lechon.iro.umontreal.ca (lechon.iro.umontreal.ca [132.204.27.242])
        by chene.dit.umontreal.ca (8.14.7/8.14.1) with ESMTP id 07LHIi5J013920;
        Fri, 21 Aug 2020 13:18:45 -0400
Received: by lechon.iro.umontreal.ca (Postfix, from userid 20848)
        id A54D82A9E; Fri, 21 Aug 2020 13:18:44 -0400 (EDT)
From:   Stefan Monnier <monnier@IRO.UMontreal.CA>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Stefan Monnier <monnier@IRO.UMontreal.CA>
Subject: [PATCH] ARM: dts: sun4i: Enable HDMI support on the Mele A1000
Date:   Fri, 21 Aug 2020 13:18:33 -0400
Message-Id: <20200821171833.28177-1-monnier@iro.umontreal.ca>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 5
X-NAI-Spam-Score: 0
X-NAI-Spam-Rules: 4 Rules triggered
        EDT_SA_DN_PASS=0, EDT_SDHA_ADR_FRG=0, EDT_SDHA_DMN_FRG=0, RV6856=0
X-NAI-Spam-Version: 2.3.0.9418 : core <6856> : inlines <7226> : streams
 <1865151> : uri <3107125>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the display pipeline and HDMI output.

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 8692b11a83c3..af8ab736fd3c 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -60,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -133,6 +144,20 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.20.1

