Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68347C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E73820759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgEONMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:35 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53450 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgEONMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 52834FB02;
        Fri, 15 May 2020 15:12:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f2J9qBn8ahqL; Fri, 15 May 2020 15:12:16 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 686394458A; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/6] dt-bindings: display/bridge: Add binding for input mux bridge
Date:   Fri, 15 May 2020 15:12:10 +0200
Message-Id: <14a44a664f40584ffa25c1764aab5ebf97809c71.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1589548223.git.agx@sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge allows to select the input source via a mux controller.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../display/bridge/mux-input-bridge.yaml      | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
new file mode 100644
index 000000000000..4029cf63ee5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/mux-input-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DRM input source selection via multiplexer
+
+maintainers:
+  - Guido Gúnther <agx@sigxcpu.org>
+
+description: |
+  The input multiplexer bridge allows to select an input source
+  via an associated mux controller.
+
+properties:
+  compatible:
+    const: mux-input-bridge
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  default-input:
+    description: The default input to use
+
+  mux-controls:
+    description:
+      mux controller node to use for operating the input mux
+
+  ports:
+    type: object
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-9]+":
+        type: object
+        description:
+          At least three nodes containing endpoints connecting to the
+          pixel data inputs and outputs. The last port is always the
+          output port.
+
+        properties:
+          reg:
+            maxItems: 1
+
+          endpoint:
+            description: sub-node describing the input
+            type: object
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - port@0
+      - port@1
+      - port@2
+
+    additionalProperties: false
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+  - mux-controls
+  - ports
+
+additionalProperties: false
+
+examples:
+ - |
+   #include <dt-bindings/gpio/gpio.h>
+
+   mux: mux-controller {
+           compatible = "gpio-mux";
+           #mux-control-cells = <0>;
+
+           mux-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+   };
+
+   mipi-mux {
+           compatible = "mux-input-bridge";
+           default-input = <0>;
+           mux-controls = <&mux 0>;
+           #address-cells = <1>;
+           #size-cells = <0>;
+
+           ports {
+                   #address-cells = <1>;
+                   #size-cells = <0>;
+
+                   port@0 {
+                           reg = <0>;
+
+                           dpi_mux_from_lcdif: endpoint {
+                                   remote-endpoint = <&lcdif_dpi_out>;
+                           };
+                   };
+
+                   port@1 {
+                           reg = <1>;
+
+                           dpi_mux_from_dccss: endpoint {
+                                   remote-endpoint = <&dcss_dpi_out>;
+                           };
+                   };
+
+                   port@2 {
+                           reg = <2>;
+
+                           dpi_mux_out: endpoint {
+                                   remote-endpoint = <&nwl_dpi_in>;
+                           };
+                   };
+           };
+   };
-- 
2.26.1

