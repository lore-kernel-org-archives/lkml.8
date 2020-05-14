Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5E7206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgENLaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:30:11 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C2C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:30:10 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:4185:4144:add6:db37])
        by laurent.telenet-ops.be with bizsmtp
        id ebW7220042fnlSd01bW7yt; Thu, 14 May 2020 13:30:07 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jZC3z-0003fp-1v; Thu, 14 May 2020 13:30:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jZC3y-0004yV-Vk; Thu, 14 May 2020 13:30:07 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: auxdisplay: hd44780: Convert to json-schema
Date:   Thu, 14 May 2020 13:30:02 +0200
Message-Id: <20200514113003.19067-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hitachi HD44780 Character LCD Controller Device Tree binding
documentation to json-schema.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../bindings/auxdisplay/hit,hd44780.txt       | 45 ---------
 .../bindings/auxdisplay/hit,hd44780.yaml      | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
deleted file mode 100644
index 2aa24b8899236882..0000000000000000
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-DT bindings for the Hitachi HD44780 Character LCD Controller
-
-The Hitachi HD44780 Character LCD Controller is commonly used on character LCDs
-that can display one or more lines of text. It exposes an M6800 bus interface,
-which can be used in either 4-bit or 8-bit mode.
-
-Required properties:
-  - compatible: Must contain "hit,hd44780",
-  - data-gpios: Must contain an array of either 4 or 8 GPIO specifiers,
-    referring to the GPIO pins connected to the data signal lines DB0-DB7
-    (8-bit mode) or DB4-DB7 (4-bit mode) of the LCD Controller's bus interface,
-  - enable-gpios: Must contain a GPIO specifier, referring to the GPIO pin
-    connected to the "E" (Enable) signal line of the LCD Controller's bus
-    interface,
-  - rs-gpios: Must contain a GPIO specifier, referring to the GPIO pin
-    connected to the "RS" (Register Select) signal line of the LCD Controller's
-    bus interface,
-  - display-height-chars: Height of the display, in character cells,
-  - display-width-chars: Width of the display, in character cells.
-
-Optional properties:
-  - rw-gpios: Must contain a GPIO specifier, referring to the GPIO pin
-    connected to the "RW" (Read/Write) signal line of the LCD Controller's bus
-    interface,
-  - backlight-gpios: Must contain a GPIO specifier, referring to the GPIO pin
-    used for enabling the LCD's backlight,
-  - internal-buffer-width: Internal buffer width (default is 40 for displays
-    with 1 or 2 lines, and display-width-chars for displays with more than 2
-    lines).
-
-Example:
-
-	auxdisplay {
-		compatible = "hit,hd44780";
-
-		data-gpios = <&hc595 0 GPIO_ACTIVE_HIGH>,
-			     <&hc595 1 GPIO_ACTIVE_HIGH>,
-			     <&hc595 2 GPIO_ACTIVE_HIGH>,
-			     <&hc595 3 GPIO_ACTIVE_HIGH>;
-		enable-gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
-		rs-gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
-
-		display-height-chars = <2>;
-		display-width-chars = <16>;
-	};
diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
new file mode 100644
index 0000000000000000..9222b06e93a042e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/hit,hd44780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hitachi HD44780 Character LCD Controller
+
+maintainers:
+  - Geert Uytterhoeven <geert@linux-m68k.org>
+
+description:
+  The Hitachi HD44780 Character LCD Controller is commonly used on character
+  LCDs that can display one or more lines of text. It exposes an M6800 bus
+  interface, which can be used in either 4-bit or 8-bit mode.
+
+properties:
+  compatible:
+    const: hit,hd44780
+
+  data-gpios:
+    description:
+      GPIO pins connected to the data signal lines DB0-DB7 (8-bit mode) or
+      DB4-DB7 (4-bit mode) of the LCD Controller's bus interface.
+    oneOf:
+      - maxItems: 4
+      - maxItems: 8
+
+  enable-gpios:
+    description:
+      GPIO pin connected to the "E" (Enable) signal line of the LCD
+      Controller's bus interface.
+    maxItems: 1
+
+  rs-gpios:
+    description:
+      GPIO pin connected to the "RS" (Register Select) signal line of the LCD
+      Controller's bus interface.
+    maxItems: 1
+
+  rw-gpios:
+    description:
+      GPIO pin connected to the "RW" (Read/Write) signal line of the LCD
+      Controller's bus interface.
+    maxItems: 1
+
+  backlight-gpios:
+    description: GPIO pin used for enabling the LCD's backlight.
+    maxItems: 1
+
+  display-height-chars:
+    description: Height of the display, in character cells,
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  display-width-chars:
+    description: Width of the display, in character cells.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 64
+
+  internal-buffer-width:
+    description:
+      Internal buffer width (default is 40 for displays with 1 or 2 lines, and
+      display-width-chars for displays with more than 2 lines).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 64
+
+required:
+  - compatible
+  - data-gpios
+  - enable-gpios
+  - rs-gpios
+  - display-height-chars
+  - display-width-chars
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    auxdisplay {
+            compatible = "hit,hd44780";
+
+            data-gpios = <&hc595 0 GPIO_ACTIVE_HIGH>,
+                         <&hc595 1 GPIO_ACTIVE_HIGH>,
+                         <&hc595 2 GPIO_ACTIVE_HIGH>,
+                         <&hc595 3 GPIO_ACTIVE_HIGH>;
+            enable-gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
+            rs-gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
+
+            display-height-chars = <2>;
+            display-width-chars = <16>;
+    };
-- 
2.17.1

