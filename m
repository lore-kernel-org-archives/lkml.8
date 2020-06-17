Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13AD20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="o0vX8nMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgFQAcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:32:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:44182 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgFQAcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1592353934; bh=AevVvrXCG/6msnRbOhEC/03tKHisk5y4PX4d+SPQkuw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=o0vX8nMPVcUPUCHAfRZce4ecgwFJ6TrWo0+s5nAauhfo5cRU4lBnRswBWKaN7+twi
         jMrKSPl5KnNaduv4d2ZsR385eh/NO1UYrmbyyBHzfSUNhwktJw0/6lE58rDi5V1YEd
         RYuzuIoIQ3cYi2+4ZON79kX++pWVTsGYZ8Dk+MCc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: panel: Add binding for Xingbangda XBD599 panel
Date:   Wed, 17 Jun 2020 02:32:06 +0200
Message-Id: <20200617003209.670819-3-megous@megous.com>
In-Reply-To: <20200617003209.670819-1-megous@megous.com>
References: <20200617003209.670819-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
Sitronix ST7703 LCD controller.

Add its device tree binding.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/sitronix,st7703.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml
new file mode 100644
index 000000000000..6e1606db4ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7703 MIPI DSI panel
+
+maintainers:
+  - Icenowy Zheng <icenowy@aosc.io>
+  - Ondrej Jirman <megous@megous.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - xingbangda,xbd599
+      - const: sitronix,st7703
+
+  reg:
+    description: DSI virtual channel used by that screen
+    maxItems: 1
+
+  vcc-supply:
+    description: regulator that supplies the VCC voltage
+
+  iovcc-supply:
+    description: regulator that supplies the IOVCC voltage
+
+  reset-gpios: true
+
+  backlight: true
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "xingbangda,xbd599", "sitronix,st7703";
+            reg = <0>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            iovcc-supply = <&reg_dldo2>;
+            vcc-supply = <&reg_ldo_io0>;
+            backlight = <&backlight>;
+        };
+    };
+
-- 
2.27.0

