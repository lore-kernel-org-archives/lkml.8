Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F6AC35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5732206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgA3Gw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:52:56 -0500
Received: from mx.socionext.com ([202.248.49.38]:26335 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgA3Gw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:52:56 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jan 2020 15:52:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D82DD603AB;
        Thu, 30 Jan 2020 15:52:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 Jan 2020 15:53:58 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 89A631A01BB;
        Thu, 30 Jan 2020 15:52:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 2/7] dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from usb3-hsphy
Date:   Thu, 30 Jan 2020 15:52:40 +0900
Message-Id: <1580367165-16760-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds compatible string for Pro5 SoC that needs to manage gio clock
and reset. And Pro4 SoC uses USB2 PHY instead of USB3 HS-PHY, so this
removes Pro4 description from usb3-hsphy.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt | 13 +++++++++----
 .../devicetree/bindings/phy/uniphier-usb3-hsphy.txt         |  6 +++---
 .../devicetree/bindings/phy/uniphier-usb3-ssphy.txt         |  5 +++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
index 1889d3b..3cee372 100644
--- a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
+++ b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
@@ -5,14 +5,19 @@ PCIe controller implemented on Socionext UniPhier SoCs.
 
 Required properties:
 - compatible: Should contain one of the following:
+    "socionext,uniphier-pro5-pcie-phy" - for Pro5 PHY
     "socionext,uniphier-ld20-pcie-phy" - for LD20 PHY
     "socionext,uniphier-pxs3-pcie-phy" - for PXs3 PHY
 - reg: Specifies offset and length of the register set for the device.
 - #phy-cells: Must be zero.
-- clocks: A phandle to the clock gate for PCIe glue layer including
-	this phy.
-- resets: A phandle to the reset line for PCIe glue layer including
-	this phy.
+- clocks: A list of phandles to the clock gate for PCIe glue layer
+	including this phy.
+- clock-names: For Pro5 only, should contain the following:
+    "gio", "link" - for Pro5 SoC
+- resets: A list of phandles to the reset line for PCIe glue layer
+	including this phy.
+- reset-names: For Pro5 only, should contain the following:
+    "gio", "link" - for Pro5 SoC
 
 Optional properties:
 - socionext,syscon: A phandle to system control to set configurations
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
index e8d8086..093d4f0 100644
--- a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
@@ -7,7 +7,7 @@ this describes about High-Speed PHY.
 
 Required properties:
 - compatible: Should contain one of the following:
-    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
+    "socionext,uniphier-pro5-usb3-hsphy" - for Pro5 SoC
     "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
     "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
     "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
@@ -16,13 +16,13 @@ Required properties:
 - clocks: A list of phandles to the clock gate for USB3 glue layer.
 	According to the clock-names, appropriate clocks are required.
 - clock-names: Should contain the following:
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro5 SoC
     "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
     "phy", "link" - for others
 - resets: A list of phandles to the reset control for USB3 glue layer.
 	According to the reset-names, appropriate resets are required.
 - reset-names: Should contain the following:
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro5 SoC
     "phy", "link" - for others
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
index 490b815..9df2bc2 100644
--- a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
@@ -8,6 +8,7 @@ this describes about Super-Speed PHY.
 Required properties:
 - compatible: Should contain one of the following:
     "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
+    "socionext,uniphier-pro5-usb3-ssphy" - for Pro5 SoC
     "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
     "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
     "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
@@ -16,13 +17,13 @@ Required properties:
 - clocks: A list of phandles to the clock gate for USB3 glue layer.
 	According to the clock-names, appropriate clocks are required.
 - clock-names:
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoC
     "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
     "phy", "link" - for others
 - resets: A list of phandles to the reset control for USB3 glue layer.
 	According to the reset-names, appropriate resets are required.
 - reset-names:
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoC
     "phy", "link" - for others
 
 Optional properties:
-- 
2.7.4

