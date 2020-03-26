Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC5C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB55A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCZWDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:03:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38999 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgCZWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:02:57 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaP-0006Dh-MO; Thu, 26 Mar 2020 23:02:49 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaO-00088r-6A; Thu, 26 Mar 2020 23:02:48 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] ARM: dts: stm32: enable stm32mp157's &gpu by default
Date:   Thu, 26 Mar 2020 23:02:05 +0100
Message-Id: <20200326220213.28632-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the original stm32mp157c.dtsi, the GPU was disabled as some SoC
variants lacked a GPU. We now have separate a dtsi for each SoC
variant and variants without a GPU lack the node altogether.

As we need no board support for using the GPU, enable it by default
and while at it remove the now redundant status = "okay" in existing
board device trees.

Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  - New Patch
---
 arch/arm/boot/dts/stm32mp157.dtsi            | 1 -
 arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi | 4 ----
 arch/arm/boot/dts/stm32mp157c-ed1.dts        | 1 -
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi       | 1 -
 4 files changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157.dtsi b/arch/arm/boot/dts/stm32mp157.dtsi
index 3f0a4a91cce6..5e733cd16ff9 100644
--- a/arch/arm/boot/dts/stm32mp157.dtsi
+++ b/arch/arm/boot/dts/stm32mp157.dtsi
@@ -15,7 +15,6 @@ gpu: gpu@59000000 {
 			clocks = <&rcc GPU>, <&rcc GPU_K>;
 			clock-names = "bus" ,"core";
 			resets = <&rcc GPU_R>;
-			status = "disabled";
 		};
 
 		dsi: dsi@5a000000 {
diff --git a/arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi
index f81dc3134135..f97e0d2ecf17 100644
--- a/arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi
@@ -97,10 +97,6 @@ &dts {
 	status = "okay";
 };
 
-&gpu {
-	status = "okay";
-};
-
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4_pins_a>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9d2592db630c..e9aad3e101ac 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -126,7 +126,6 @@ &dts {
 
 &gpu {
 	contiguous-area = <&gpu_reserved>;
-	status = "okay";
 };
 
 &i2c4 {
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index d946e0a02f5c..558a91a6962b 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -137,7 +137,6 @@ phy0: ethernet-phy@0 {
 
 &gpu {
 	contiguous-area = <&gpu_reserved>;
-	status = "okay";
 };
 
 &i2c1 {
-- 
2.26.0.rc2

