Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1217EC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEA721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Seo3WcNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgCKNvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:51:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36772 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgCKNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583934702; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=1kpQTc/BnIRMN7rLXb27AAycasWYbKztTQg5Nu/o7xw=;
        b=Seo3WcNJymsKriUB32h2Y5oHcgVkfpcRjIOCaxuE5Jg+TkTnbeXj7fiU4eQCvvEgv3/1nl
        kR5Jonf4XgklOwoL5/Ae9Bw4z31QlRWmodGTfgrDtIg379vJBS99A+Z7CdRG4xwyDZ1bV5
        ULIU1or60xC0mY1M3w6eBmZrJR9pAOQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: usb: Convert jz4740-musb doc to YAML
Date:   Wed, 11 Mar 2020 14:51:29 +0100
Message-Id: <20200311135133.16392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ingenic,jz4740-musb.txt to ingenic,musb.yaml, and add the
new ingenic,jz4770-musb and ingenic,jz4725b-musb compatible strings
in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
        v2: Changed oneOf+const to enum
        v3: Add ingenic,jz4725b-musb compatible string with fallback to jz4740-musb

 .../bindings/usb/ingenic,jz4740-musb.txt      | 32 --------
 .../devicetree/bindings/usb/ingenic,musb.yaml | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 32 deletions(-)
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
index 000000000000..1d6877875077
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
@@ -0,0 +1,76 @@
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
+      - enum:
+        - ingenic,jz4770-musb
+        - ingenic,jz4740-musb
+      - items:
+        - const: ingenic,jz4725b-musb
+        - const: ingenic,jz4740-musb
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
2.25.1

