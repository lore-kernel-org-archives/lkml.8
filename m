Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C8D207BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="NRRp3FXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEMVZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:25:00 -0400
Received: from vps.xff.cz ([195.181.215.36]:33780 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgEMVY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1589405095; bh=gvSRm0rmQ7W+MSQqWiSzV31k3+eFDx+2BX8HfaNKv+o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NRRp3FXFRr6+JDPCv93mEyKR4cWbL4cCSQmwvGLKLoduDFsYwh1vOTtJUq0XlbHm+
         Zg6KGIJ9ii8UQlUxsPRjV89ludJxM3Sv3jaQNfrMN5F/XTQ7UqrAcorWf9Ptjg887M
         QOnxFZhPb5rKTwnEdCHYBtin7lFc72rVfcSRPGu8=
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
        Bhushan Shah <bshah@kde.org>, Ondrej Jirman <megous@megous.com>
Subject: [PATCH v3 2/5] dt-bindings: panel: Add binding for Xingbangda XBD599 panel
Date:   Wed, 13 May 2020 23:24:48 +0200
Message-Id: <20200513212451.1919013-3-megous@megous.com>
In-Reply-To: <20200513212451.1919013-1-megous@megous.com>
References: <20200513212451.1919013-1-megous@megous.com>
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
2.26.2

