Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C461C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AC92192A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HfTPlUp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBVGpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:45:38 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58915 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgBVGpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:33 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01M6ik5P005982;
        Sat, 22 Feb 2020 15:44:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01M6ik5P005982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582353887;
        bh=pw80puZqFh3HIHozKVPIxQUqE9lmyrEYJKdro2WSFao=;
        h=From:To:Cc:Subject:Date:From;
        b=HfTPlUp6gRIDOM5AHjHcEoJbHhsA6IQ8dnxS7J5KrSP/Ez3Vwzsj/ZT8dooUjJI3p
         qbk1DKyeDhD6acKXMrPMkudpMKXIWHJ5CPQq8whHCcr352EEqebWpibBPgEsukJ3lx
         iSfNvle3Vz+9+Y4P2q7O03gcKCV9OluLy4YZedWnwsxKCAECgPd3VuuhHkQz3m/3Yk
         WCkSxasMFRqdTRjdppN9Zoib6+rt7sWRtvj/odAsW0kyOdppfhxOB6H9VCMTzaenTa
         fcpmAA64MfEIRPcfCuzWkXbXKs9K5DieDc9B00+6NXZO7M7X0IIUy+9n1jiAW1EXjP
         2b2Xv7oXiZeVw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/4] ARM: dts: uniphier: change SD/eMMC node names to follow json-schema
Date:   Sat, 22 Feb 2020 15:44:42 +0900
Message-Id: <20200222064445.14903-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern "^mmc(@.*)?$" defined in
Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 4 ++--
 arch/arm/boot/dts/uniphier-pro4.dtsi | 6 +++---
 arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-sld8.dtsi | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 64ec46c72a4c..f3a20dc0b22b 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -245,7 +245,7 @@
 			#dma-cells = <1>;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
@@ -265,7 +265,7 @@
 			sd-uhs-sdr50;
 		};
 
-		emmc: sdhc@5a500000 {
+		emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 2ec04d7972ef..e96b5796f0f8 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -279,7 +279,7 @@
 			#dma-cells = <1>;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
@@ -299,7 +299,7 @@
 			sd-uhs-sdr50;
 		};
 
-		emmc: sdhc@5a500000 {
+		emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
@@ -317,7 +317,7 @@
 			non-removable;
 		};
 
-		sd1: sdhc@5a600000 {
+		sd1: mmc@5a600000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a600000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index ea3961f920a0..f794a0676760 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -469,7 +469,7 @@
 			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 
-		emmc: sdhc@68400000 {
+		emmc: mmc@68400000 {
 			compatible = "socionext,uniphier-sd-v3.1";
 			status = "disabled";
 			reg = <0x68400000 0x800>;
@@ -485,7 +485,7 @@
 			non-removable;
 		};
 
-		sd: sdhc@68800000 {
+		sd: mmc@68800000 {
 			compatible = "socionext,uniphier-sd-v3.1";
 			status = "disabled";
 			reg = <0x68800000 0x800>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 13b0d4a7741f..04d6bef3a00f 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -446,7 +446,7 @@
 			};
 		};
 
-		emmc: sdhc@5a000000 {
+		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a000000 0x800>;
@@ -462,7 +462,7 @@
 			non-removable;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 4fc6676f5486..beb1eac85436 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -249,7 +249,7 @@
 			#dma-cells = <1>;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
@@ -269,7 +269,7 @@
 			sd-uhs-sdr50;
 		};
 
-		emmc: sdhc@5a500000 {
+		emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
-- 
2.17.1

