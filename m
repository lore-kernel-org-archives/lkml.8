Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3C2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ENd49xo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgAOWA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:00:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43838 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579125621; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtIMb3JFSwTADsQXrqeQRTnzP1HYxEvX4EAo2GKiNIw=;
        b=ENd49xo0Fa3xksh/Ka5tR233pTD9BgR8xyHHdy1cqX4SPscnpPkANtrt0IGxDUpBueMYuq
        zFj6ZUlwDYRKmJH7bF6yxUmGAtph3DJuNhXog4Mf43V0KslxoiOiPmForhuhkVWS8bYuWR
        CPCJU78M4K9QWsGu4UUmOLs7N0DuTzY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] dt-bindings: usb: Convert jz4740-musb doc to YAML
Date:   Wed, 15 Jan 2020 19:00:04 -0300
Message-Id: <20200115220008.91445-2-paul@crapouillou.net>
In-Reply-To: <20200115220008.91445-1-paul@crapouillou.net>
References: <20200115220008.91445-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ingenic,jz4740-musb.txt to ingenic,musb.yaml, and add the
new ingenic,jz4770-musb compatible string in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/usb/ingenic,jz4740-musb.txt      | 32 ---------
 .../devicetree/bindings/usb/ingenic,musb.yaml | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,musb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
deleted file mode 100644
index 16808721f3ff..000000000000
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Ingenic JZ4740 MUSB driver
-
-Required properties:
-
-- compatible: Must be "ingenic,jz4740-musb"
-- reg: Address range of the UDC register set
-- interrupts: IRQ number related to the UDC hardware
-- interrupt-names: must be "mc"
-- clocks: phandle to the "udc" clock
-- clock-names: must be "udc"
-- phys: phandle to the USB PHY
-
-Example:
-
-usb_phy: usb-phy@0 {
-	compatible = "usb-nop-xceiv";
-	#phy-cells = <0>;
-};
-
-udc: usb@13040000 {
-	compatible = "ingenic,jz4740-musb";
-	reg = <0x13040000 0x10000>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <24>;
-	interrupt-names = "mc";
-
-	clocks = <&cgu JZ4740_CLK_UDC>;
-	clock-names = "udc";
-
-	phys = <&usb_phy>;
-};
diff --git a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
new file mode 100644
index 000000000000..f8902ee83e56
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ingenic,musb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic JZ47xx USB IP DT bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: '^usb@.*'
+
+  compatible:
+    oneOf:
+      - const: ingenic,jz4770-musb
+      - const: ingenic,jz4740-musb
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: udc
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: mc
+
+  phys:
+    description: PHY specifier for the USB PHY
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    usb_phy: usb-phy@0 {
+      compatible = "usb-nop-xceiv";
+      #phy-cells = <0>;
+    };
+
+    udc: usb@13040000 {
+      compatible = "ingenic,jz4740-musb";
+      reg = <0x13040000 0x10000>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <24>;
+      interrupt-names = "mc";
+
+      clocks = <&cgu JZ4740_CLK_UDC>;
+      clock-names = "udc";
+
+      phys = <&usb_phy>;
+    };
-- 
2.24.1

