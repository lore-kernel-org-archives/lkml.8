Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFCC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D920757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BNQi3+WW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCRRKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:10:22 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53050 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgCRRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:10:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1614503pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1txo4F9ZHXDlpSvCzNI2rmeFwQMzudpOKzit+Mhtr4=;
        b=BNQi3+WWW1X/Utl0cCgSjK1sOWY3vEw8v40vKUlsDIvCNT1rmyOP82HQE9iL5nPsw1
         BGTZRUAFdUvdIu7F0G92uMbXjKy+dfaipOiw63ksciL2ucX8+RcYbHB+trAE2wcKin4l
         hzZzBZ1h6WJNu1n7VUlx3ux6GxUOLTnwCcQUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1txo4F9ZHXDlpSvCzNI2rmeFwQMzudpOKzit+Mhtr4=;
        b=WF7/EEw3rXkHDx6Rim80P2pZ8MZwNxOc9zngKbYpAYUADc3pvqjY4jvcbnakc6Bdwv
         ODjNmXYDtV8CH44Ffq2jT6zsm12USI/CkPxdTJwPbxrQYkNWkAgP8gL1RkVyx0irMHvK
         Blv3JUIL5SfE06k1rO+hqJciJ678U3Wqa8jB8dwP5VONQv78f97LFpzrSP4JmUR1hLuz
         NOO6iHR4XryMMrqpfSTvi84U0O8YX4e+Kqxq50WG7bJEUx6PqT2a0+9gf8zqaRrUjWrv
         C94lb0pdS7PjDlneMQmCFRqZNn6y3Sp413DnllZziTSRTmhWE/l8QiC0/TEQ5qE6fmKX
         4oCg==
X-Gm-Message-State: ANhLgQ3i9Yy6uWYjYERVJa2gMInpUOcWpJQhWSwgclc/jfsVOGcJJjy8
        Hl/kkouV2uYR2LXAdGX2fcTTXQ==
X-Google-Smtp-Source: ADFU+vsJY5WZSXSIrsTt/Eo50ixmUTcpdqYddC8+qlo6uvDuwotxpF5Is8zBj6BT99cqQ1A3HiB/ng==
X-Received: by 2002:a17:902:7b87:: with SMTP id w7mr4994502pll.214.1584551420315;
        Wed, 18 Mar 2020 10:10:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:1998:878c:c26e:b8be])
        by smtp.gmail.com with ESMTPSA id e6sm6443869pgu.44.2020.03.18.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:10:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Convert sitronix,st7701 to DT schema
Date:   Wed, 18 Mar 2020 22:40:02 +0530
Message-Id: <20200318171003.5179-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318171003.5179-1-jagan@amarulasolutions.com>
References: <20200318171003.5179-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sitronix,st7701 panel bindings to DT schema.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- fix dt_binding_check 

 .../display/panel/sitronix,st7701.txt         | 30 --------
 .../display/panel/sitronix,st7701.yaml        | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
deleted file mode 100644
index ccd17597f1f6..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Sitronix ST7701 based LCD panels
-
-ST7701 designed for small and medium sizes of TFT LCD display, is
-capable of supporting up to 480RGBX864 in resolution. It provides
-several system interfaces like MIPI/RGB/SPI.
-
-Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
-inbuilt ST7701 chip.
-
-Required properties:
-- compatible: must be "sitronix,st7701" and one of
-  * "techstar,ts8550b"
-- reset-gpios: a GPIO phandle for the reset pin
-
-Required properties for techstar,ts8550b:
-- reg: DSI virtual channel used by that screen
-- VCC-supply: analog regulator for MIPI circuit
-- IOVCC-supply: I/O system regulator
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "techstar,ts8550b", "sitronix,st7701";
-	reg = <0>;
-	VCC-supply = <&reg_dldo2>;
-	IOVCC-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
new file mode 100644
index 000000000000..e02686dfd937
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7701.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7701 based LCD panels
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  ST7701 designed for small and medium sizes of TFT LCD display, is
+  capable of supporting up to 480RGBX864 in resolution. It provides
+  several system interfaces like MIPI/RGB/SPI.
+
+  Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+  inbuilt ST7701 chip.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - techstar,ts8550b
+      - const: sitronix,st7701
+
+  reg:
+    description: DSI virtual channel used by that screen
+
+  VCC-supply:
+    description: analog regulator for MIPI circuit
+
+  IOVCC-supply:
+    description: I/O system regulator
+
+  reset-gpios:
+    description: a GPIO phandle for the reset pin
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+  - reg
+  - VCC-supply
+  - IOVCC-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "techstar,ts8550b", "sitronix,st7701";
+            reg = <0>;
+            VCC-supply = <&reg_dldo2>;
+            IOVCC-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+        };
+    };
-- 
2.17.1

