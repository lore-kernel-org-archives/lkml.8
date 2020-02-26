Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC82C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6D24680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CJlgzOGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBZOdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:33:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBZOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:33:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so2572682wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4urQS/1di8YmhdYz7EDXbcoOguLI1Co0XJrTjZXktY=;
        b=CJlgzOGLmX7eVpdAJh7haQvpLpyvdibkSRs5pb/rbeu2iGcr72Qv/yi+2ZglMHwn1Z
         iZbnUUHf6aSBAQgSMODO9BOL/I8/RqAO0G/lROpCr572B3kWc7T3RFlWCkKaOB1INTLx
         2ICl/7P1d0XrgGpgNzto5LMEWk8oqSzal+7bg5xQc/g/9U6qHguu6ohVoi0+bDWGFv3O
         SowwHKpyj1Zb5SXNF8ypvpd7EDL/JwGky9u+V3SU3+SvbPVVDAML8uMfHL8UflZoUMhf
         JbgM5/O2ZZR6P2yWn7I1hNNelv9QC+ynXj08W+t+TZCBH0N6DtWVLI6kbcQeV9ANMFc9
         yo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4urQS/1di8YmhdYz7EDXbcoOguLI1Co0XJrTjZXktY=;
        b=rl2Xiga45cofjMg2RTyBjG1JfZsF2igX6lqERACoptu6Slge2sFAAgEKL991Ct6VTb
         m4MDXTw7X3JgThNHtis7cmDQedQZ8M+BAbcNElzvbAW6rehIAa9vzRA77FT6XgpxB5c0
         Ey3aH3iPxpMIwP9yEGjqLBLxXGxRvrFuNMHop/ZBhGWdxorNIUmwwCQEp+0ncZGMwbjc
         0qZlpcSYraZ2s97afDtMqZdYgmkLeoXl0nKPvfgslHkW5mTKjd21CLqaL43afQ65Q13E
         n4em16Zr8ClceFgjai+4Nbz57MpTpEjPK7f+cBIuy2VaCnsLbYbOFXlWD3I1Nt6WbMYl
         GR7Q==
X-Gm-Message-State: APjAAAVz1wmqsvLX6wbwEBNHStrBngl0jKn2Wb1R0l0LR2LBViWeKbui
        pricpJRIOssXuKkMUg94boU1U3mUQW0=
X-Google-Smtp-Source: APXvYqzZhzXkPXkp4kcfqNuTKsJrGYg75KuvuO5nb9ej/GtIo7tvL1eIrRG8KbF4CKK5or8tgGV4OQ==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr5868713wmi.124.1582727616685;
        Wed, 26 Feb 2020 06:33:36 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10sm3204198wml.18.2020.02.26.06.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 06:33:36 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io, Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH RFC v2 2/3] dt-bindings: leds: Shiji Lighting APA102C LED driver
Date:   Wed, 26 Feb 2020 15:33:11 +0100
Message-Id: <1582727592-4510-3-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
References: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Shiji Lighting APA102C LED driver device tree bindings.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 .../devicetree/bindings/leds/leds-apa102c.yaml     | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-apa102c.yaml b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
new file mode 100644
index 000000000000..90c827ab5a5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-apa102c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for Shiji Lighting - APA102C
+
+maintainers:
+  - Nicolas Belin <nbelin@baylibre.com>
+
+description:
+  Each RGB LED is represented as a multi-led sub-node of the leds-apa102c
+  device.  Each LED
+  is a three color rgb LED with 32 levels brightness adjustment that can be
+  cascaded so that multiple LEDs can be set with a single command.
+
+properties:
+  compatible:
+    const: shiji,apa102c
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-9]+$":
+    type: object
+    description: |
+      Properties for an array of connected LEDs.
+
+    properties:
+      reg:
+        description: |
+          This property corresponds to the led index. It has to be between 0
+          and the number of managed leds minus 1
+        maxItems: 1
+
+      label:
+        description: |
+          This property corresponds to the name of the led. If not set,
+          the led index will be used to create the led name instead
+        maxItems: 1
+
+      color:
+        const: 8
+
+      linux,default-trigger: true
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-9]+$":
+        type: object
+        description: |
+          Properties for the LED color components.
+
+        properties:
+          reg:
+            maxItems: 1
+
+          color:
+            oneOf:
+              - enum: [ 1, 2, 3 ]
+
+        required:
+          - reg
+          - color
+
+    required:
+      - reg
+      - color
+      - '#address-cells'
+      - '#size-cells'
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        led-controller@0 {
+            compatible = "shiji,apa102c";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            multi-led@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+                color = <LED_COLOR_ID_MULTI>;
+                label = "rgb_led1";
+
+                led@0 {
+                reg = <0>;
+                color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                reg = <1>;
+                color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                reg = <2>;
+                color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+            multi-led@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+                color = <LED_COLOR_ID_MULTI>;
+                label = "rgb_led2";
+
+                led@3 {
+                reg = <3>;
+                color = <LED_COLOR_ID_RED>;
+                };
+
+                led@4 {
+                reg = <4>;
+                color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@5 {
+                reg = <5>;
+                color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+        };
+    };
-- 
2.7.4

