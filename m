Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B763C5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EB92076A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCRHHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:07:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:07:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3FA6A2928C5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, icenowy@aosc.io,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        megous@megous.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/4] dt-bindings: Add ANX7688 HDMI to DP bridge binding
Date:   Wed, 18 Mar 2020 08:07:29 +0100
Message-Id: <20200318070730.4012371-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318070730.4012371-1-enric.balletbo@collabora.com>
References: <20200318070730.4012371-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

Add documentation for DT properties supported by the ANX7688 HDMI-DP
converter.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4: None
Changes in v3:
- Adapt the bridge bindings for the multi-function device.

Changes in v2:
- Improve a bit the descriptions using the info from the datasheet.
- Convert binding to yaml.
- Use dual licensing.

 .../bridge/analogix,anx7688-bridge.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml
new file mode 100644
index 000000000000..c56da3f39dd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/analogix,anx7688-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7688 HDMI to DisplayPort Bridge
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  The ANX7688 bridge describes the HDMI 2.0 to DisplayPort 1.3 bridge block
+  included in the ANX7688 chip controller. These are meant to be used for
+  controlling display-related signals.
+
+  The node of this device should be under an analogix,anx7866 node. Please refer
+  to Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml for the ANX7688
+  core bindings.
+
+properties:
+  compatible:
+    const: analogix,anx7688-bridge
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
+  - ports
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7688: anx7688@2c {
+            compatible = "analogix,anx7688";
+            reg = <0x2c>;
+
+            bridge {
+                compatible = "analogix,anx7688-bridge";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        anx7688_in: endpoint {
+                            remote-endpoint = <&hdmi0_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        anx7688_out: endpoint {
+                            remote-endpoint = <&typec0_connector>;
+                       };
+                    };
+                };
+            };
+        };
+    };
-- 
2.25.1

