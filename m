Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE48A20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XIm9XgIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgG0Qqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:46:38 -0400
Received: from crapouillou.net ([89.234.176.41]:36810 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgG0Qqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595868389; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mA0DRhoXYfyoP4lmizj2glYU71M+JBHynLFFki0MJG8=;
        b=XIm9XgIArDbF4XmISOig7RvqAcx2s2zsdQ/st5sKUc3lnzQLwZGgWB2dnrlViJ29MyFxjH
        5++A+qejU3P8LvWhrRnc1te9rNuHOWdv4oO1kS01RJ137rB8EVNyTYPnqe+bEkzlOkgHez
        D2mA/+gq9Eovh2JDYJochFF/yY3rK0k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] dt-bindings: display: Document NewVision NV3052C DT node
Date:   Mon, 27 Jul 2020 18:46:08 +0200
Message-Id: <20200727164613.19744-2-paul@crapouillou.net>
In-Reply-To: <20200727164613.19744-1-paul@crapouillou.net>
References: <20200727164613.19744-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the Device Tree node for LCD panels based on the
NewVision NV3052C controller.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../display/panel/newvision,nv3052c.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
new file mode 100644
index 000000000000..751a28800fc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
@@ -0,0 +1,69 @@
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
+  This is a driver for 320x240 TFT panels, accepting a variety of input
+  streams that get adapted and scaled to the panel. The panel output has
+  960 TFT source driver pins and 240 TFT gate driver pins, VCOM, VCOML and
+  VCOMH outputs.
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
+  port: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      display@0 {
+        compatible = "leadtek,ltk035c5444t-spi", "newvision,nv3052c";
+        reg = <0>;
+
+        spi-max-frequency = <15000000>;
+        spi-3wire;
+        reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+        backlight = <&backlight>;
+        power-supply = <&vcc>;
+
+        port {
+          panel_input: endpoint {
+              remote-endpoint = <&panel_output>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.27.0

