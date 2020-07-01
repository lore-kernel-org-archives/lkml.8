Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4502AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C8420781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fgzEhIfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgGAQaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:30:19 -0400
Received: from vps.xff.cz ([195.181.215.36]:52048 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbgGAQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593620971; bh=upSyzpnnbVkpTdRY0PC/Syu6g+q/lTfw6eNj6l37uLk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fgzEhIfL17W4Rd0XU4n4QEC/RpbKfoaRfuFbuI7l9gSwow1GxR0TwqwP3RkqEp9b5
         M/bSgFtA2lEcQabp76n8p4Z6vwmPv79m1vNZuMLiunyzlbPm7x9EsgbUEyCWiY3if9
         b6WkWZCb8k8Td5t1RCzivhtZ8zYn3n7HrjEfrBuM=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v7 02/13] dt-bindings: panel: Convert rocktech,jh057n00900 to yaml
Date:   Wed,  1 Jul 2020 18:29:17 +0200
Message-Id: <20200701162928.1638874-3-megous@megous.com>
In-Reply-To: <20200701162928.1638874-1-megous@megous.com>
References: <20200701162928.1638874-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../display/panel/rocktech,jh057n00900.txt    | 23 -------
 .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
deleted file mode 100644
index a372c5d84695..000000000000
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
-
-Required properties:
-- compatible: should be "rocktech,jh057n00900"
-- reg: DSI virtual channel of the peripheral
-- reset-gpios: panel reset gpio
-- backlight: phandle of the backlight device attached to the panel
-- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
-- iovcc-supply: phandle of the regulator that provides the iovcc supply
-  voltage.
-
-Example:
-
-	&mipi_dsi {
-		panel@0 {
-			compatible = "rocktech,jh057n00900";
-			reg = <0>;
-			backlight = <&backlight>;
-			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
-			vcc-supply = <&reg_2v8_p>;
-			iovcc-supply = <&reg_1v8_p>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
new file mode 100644
index 000000000000..928ba42e7f8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
+
+maintainers:
+  - Ondrej Jirman <megi@xff.cz>
+
+description: |
+             Rocktech JH057N00900 is a 720x1440 TFT LCD panel
+             connected using a MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: rocktech,jh057n00900
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vcc-supply:
+    description: Panel power supply
+
+  iovcc-supply:
+    description: I/O voltage supply
+
+  reset-gpios:
+    description: GPIO used for the reset pin
+    maxItems: 1
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - iovcc-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel@0 {
+        compatible = "rocktech,jh057n00900";
+        reg = <0>;
+        vcc-supply = <&reg_2v8_p>;
+        iovcc-supply = <&reg_1v8_p>;
+        reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+        backlight = <&backlight>;
+      };
+    };
+...
-- 
2.27.0

