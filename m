Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ABDC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1824649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBMOy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:54:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33816 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:54:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9267B295246
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] Documentation: bindings: Add ANX7688 HDMI to DP bridge binding
Date:   Thu, 13 Feb 2020 15:54:15 +0100
Message-Id: <20200213145416.890080-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

Add documentation for DT properties supported by anx7688 HDMI-DP
converter.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Improve a bit the descriptions using the info from the datasheet.
- Convert binding to yaml.
- Use dual licensing.

 .../bindings/display/bridge/anx7688.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
new file mode 100644
index 000000000000..c1b4b5191d44
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/anx7688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7688 HDMI to USB Type-C Bridge (Port Controller with MUX)
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
+  second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
+  resolution from a smartphone or tablet with full function USB-C.
+
+  This binding only describes the HDMI to DP display bridge.
+
+properties:
+  compatible:
+    const: analogix,anx7688
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for HDMI input
+
+      port@1:
+        type: object
+        description: |
+          Video port for DP output
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - ports
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7688: dp-bridge@2c {
+            compatible = "analogix,anx7688";
+            reg = <0x2c>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    anx7866_in: endpoint {
+                        remote-endpoint = <&hdmi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    anx7866_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                   };
+                };
+            };
+        };
+    };
-- 
2.25.0

