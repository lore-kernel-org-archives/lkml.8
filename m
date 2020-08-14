Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D239C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CE12068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgHNNgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:36:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43846 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgHNNgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:36:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BCE07FB04;
        Fri, 14 Aug 2020 15:36:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zK71oykmh5Vx; Fri, 14 Aug 2020 15:36:28 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 098AA457CD; Fri, 14 Aug 2020 15:36:24 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: Add Mantix MLAF057WE51-X panel bindings
Date:   Fri, 14 Aug 2020 15:36:22 +0200
Message-Id: <9345739df02b8b8630e7dccb61a80a7a7f692526.1597412076.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597412076.git.agx@sigxcpu.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel uses a Focaltech FT8006p, the touch part is handled by the
already existing edt-ft5x06.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../display/panel/mantix,mlaf057we51-x.yaml   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
new file mode 100644
index 0000000000000..349f3380ac940
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/mantix,mlaf057we51-x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mantix MLAF057WE51-X 5.7" 720x1440 TFT LCD panel
+
+maintainers:
+  - Guido Günther <agx@sigxcpu.org>
+
+description: |
+             Mantix MLAF057WE51 X is a 720x1440 TFT LCD panel
+             connected using a MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mantix,mlaf057we51-x
+
+  port: true
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  avdd-supply:
+    description: Positive analog power supply
+
+  avee-supply:
+    description: Negative analog power supply
+
+  vddi-supply:
+    description: 1.8V I/O voltage supply
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
+  - avdd-supply
+  - avee-supply
+  - vddi-supply
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
+        compatible = "mantix,mlaf057we51-x";
+        reg = <0>;
+        avdd-supply = <&reg_avdd>;
+        avee-supply = <&reg_avee>;
+        vddi-supply = <&reg_1v8_p>;
+        reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+        backlight = <&backlight>;
+      };
+    };
+...
-- 
2.26.2

