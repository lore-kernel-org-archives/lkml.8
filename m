Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C847C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76655207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHQIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:14:50 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59792 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgHQIOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:14:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 92151FB02;
        Mon, 17 Aug 2020 10:14:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RbB1GIar5kar; Mon, 17 Aug 2020 10:14:39 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 47AAF457CC; Mon, 17 Aug 2020 10:14:36 +0200 (CEST)
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
Subject: [PATCH v3 2/3] dt-bindings: Add Mantix MLAF057WE51-X panel bindings
Date:   Mon, 17 Aug 2020 10:14:35 +0200
Message-Id: <b84c8c00ee1dcf545903a475872e1ae62b5f43ea.1597652012.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597652012.git.agx@sigxcpu.org>
References: <cover.1597652012.git.agx@sigxcpu.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/mantix,mlaf057we51-x.yaml   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
new file mode 100644
index 0000000000000..937323cc9aaac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -0,0 +1,70 @@
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
+description:
+  Mantix MLAF057WE51 X is a 720x1440 TFT LCD panel connected using
+  a MIPI-DSI video interface.
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
+  reset-gpios: true
+
+  backlight: true
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "mantix,mlaf057we51-x";
+            reg = <0>;
+            avdd-supply = <&reg_avdd>;
+            avee-supply = <&reg_avee>;
+            vddi-supply = <&reg_1v8_p>;
+            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.26.2

