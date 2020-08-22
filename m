Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35043C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFE206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ikS9LtxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgHVQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:33:17 -0400
Received: from crapouillou.net ([89.234.176.41]:48424 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbgHVQdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598113986; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpSFEylgpgBKh2P6uwfTBIT/WcJC6e5Uy+yuu1dkY14=;
        b=ikS9LtxXMYk4VZ/d4VFVzK/DGbochn/rlwxY2WcP3BfuhmvW113EUnZ23LGqlDNwLIF8H7
        kNwhaZ9PHllpr4B7eA8ZcuNLmOuxOElZW3TG90zmU/QdtKnzOSKGCozbJypCrD3i6pc1wC
        1RhWxZ1UoY2SKyVmyQTEF2CevnWTfJw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/6] dt-bindings: display: Document NewVision NV3052C DT node
Date:   Sat, 22 Aug 2020 18:32:45 +0200
Message-Id: <20200822163250.63664-2-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-1-paul@crapouillou.net>
References: <20200822163250.63664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the Device Tree node for LCD panels based on the
NewVision NV3052C controller.

v2: - Support backlight property
    - Add *-supply properties for the 5 different power supplies.
      Either they must all be present, or 'power-supply' must be
      present.
    - Reword description to avoid confusion about 'driver'
    - Use 4-space indent in example

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../display/panel/newvision,nv3052c.yaml      | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
new file mode 100644
index 000000000000..0468ddeaff2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/newvision,nv3052c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NewVision NV3052C TFT LCD panel driver with SPI control bus
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+description: |
+  This is a IC driver for TFT panels, accepting a variety of input
+  streams that get adapted and scaled to the panel.
+
+  The panel must obey the rules for a SPI slave device as specified in
+  spi/spi-controller.yaml
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - leadtek,ltk035c5444t-spi
+
+      - const: newvision,nv3052c
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+  power-supply: true
+  backlight: true
+  port: true
+
+  vci-supply:
+    description:
+      Power supply for analog circuits (VCI=2.5V to 6V)
+
+  vddam-supply:
+    description:
+      Power Supply for MIPI regulator circuits (VDDAM=1.75V to 6V)
+
+  iovcc-supply:
+    description: |
+      External Power Supply for IO pads and other logic circuits
+      (IOVCC=1.65 to 3.6V)
+
+  pprech-supply:
+    description:
+      Pre-charge power for source (can be connected to IOVCC or VCI)
+
+  vpp-supply:
+    description:
+      Input power for NV memory programming (8.0V ~ 8.5V, typical=8.25V)
+
+required:
+  - compatible
+  - reg
+
+oneOf:
+  - required:
+    - power-supply
+  - required:
+    - vci-supply
+    - vddam-supply
+    - iovcc-supply
+    - pprech-supply
+    - vpp-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "leadtek,ltk035c5444t-spi", "newvision,nv3052c";
+            reg = <0>;
+
+            spi-max-frequency = <15000000>;
+            spi-3wire;
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.28.0

