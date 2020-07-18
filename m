Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F334C43457
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236CC2176B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGRUvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:51:39 -0400
Received: from v6.sk ([167.172.42.174]:37702 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgGRUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:51:38 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B15A360D37;
        Sat, 18 Jul 2020 20:51:06 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/13] ARM: dts: mmp2: Add the GPU
Date:   Sat, 18 Jul 2020 22:50:16 +0200
Message-Id: <20200718205019.184927-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718205019.184927-1-lkundrak@v3.sk>
References: <20200718205019.184927-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a GC860 2D + 3D core.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 31592acd3ef4f..445bdcd50b9ed 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/power/marvell,mmp2.h>
 
 / {
 	#address-cells = <1>;
@@ -38,6 +39,17 @@ axi@d4200000 {	/* AXI */
 			reg = <0xd4200000 0x00200000>;
 			ranges;
 
+			gpu: gpu@d420d000 {
+				compatible = "vivante,gc";
+				reg = <0xd420d000 0x4000>;
+				interrupts = <8>;
+				status = "disabled";
+				clocks = <&soc_clocks MMP2_CLK_GPU_3D>,
+					 <&soc_clocks MMP2_CLK_GPU_BUS>;
+				clock-names = "core", "bus";
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_GPU>;
+			};
+
 			intc: interrupt-controller@d4282000 {
 				compatible = "mrvl,mmp2-intc";
 				interrupt-controller;
-- 
2.26.2

