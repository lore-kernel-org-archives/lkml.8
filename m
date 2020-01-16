Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F7C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71EA24680
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="G5hY/H3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgAPDhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:37:24 -0500
Received: from hermes.aosc.io ([199.195.250.187]:57142 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgAPDhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:37:23 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 5BEF147720;
        Thu, 16 Jan 2020 03:37:17 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 2/5] dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI panel
Date:   Thu, 16 Jan 2020 11:36:33 +0800
Message-Id: <20200116033636.512461-3-icenowy@aosc.io>
In-Reply-To: <20200116033636.512461-1-icenowy@aosc.io>
References: <20200116033636.512461-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1579145843;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=lHS6Swr03XduvTqv2QteW+VB+Hxp6wJDnUuUYIsTnfk=;
        b=G5hY/H3UtY5cx1AC1m/L0XknFiHJy2q3+6cWrpWEYHvTDUjTctI1xd5Va6bK3IhIxksf/f
        trCzZDgBRfws2+9M+iRIqRYDf3EEwqOhCQz0+UH2TzHx0lSSJiFXqIu73KAsTKyblwuliE
        2KTURuu8T24SrZg1OS7SXnZQ3I0hXVo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feixin K101 IM2BA02 is a 10.1" 800x1280 4-lane MIPI-DSI panel.

Add device tree binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Set backlight property to optional. (Technically this panel requires
  backlight, but theortically it can be not adjustable.)
- Tweaked the example to pass schema check.

 .../display/panel/feixin,k101-im2ba02.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
new file mode 100644
index 000000000000..be1ecce9c3c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/feixin,k101-im2ba02.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Feixin K101 IM2BA02 10.1" MIPI-DSI LCD panel
+
+maintainers:
+  - Icenowy Zheng <icenowy@aosc.io>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: feixin,k101-im2ba02
+  reg: true
+  backlight: true
+  reset-gpios: true
+  avdd-supply:
+     description: regulator that supplies the AVDD voltage
+  dvdd-supply:
+     description: regulator that supplies the DVDD voltage
+  cvdd-supply:
+     description: regulator that supplies the CVDD voltage
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - cvdd-supply
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
+        panel@0 {
+            compatible = "feixin,k101-im2ba02";
+            reg = <0>;
+            avdd-supply = <&reg_dc1sw>;
+            dvdd-supply = <&reg_dc1sw>;
+            cvdd-supply = <&reg_ldo_io1>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.23.0

