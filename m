Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDD6C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E33321927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDSRgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:36:04 -0400
Received: from v6.sk ([167.172.42.174]:44752 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDSRgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:36:02 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 6723A610CC;
        Sun, 19 Apr 2020 17:36:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v4 2/3] dt-bindings: display: Add Chrontel CH7033 Video Encoder binding
Date:   Sun, 19 Apr 2020 19:35:51 +0200
Message-Id: <20200419173552.675098-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419173552.675098-1-lkundrak@v3.sk>
References: <20200419173552.675098-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the Chrontel CH7033 VGA/DVI/HDMI Encoder.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v3:
- Fixed the example so that it validates

Changes since v1:
- Dual licensed with BSD-2-Clause
- Collected Rob's reviewed-by tag

 .../display/bridge/chrontel,ch7033.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml
new file mode 100644
index 0000000000000..9f38f55fc9904
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/chrontel,ch7033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chrontel CH7033 Video Encoder Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: chrontel,ch7033
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
+          Video port for RGB input.
+
+      port@1:
+        type: object
+        description: |
+          DVI port, should be connected to a node compatible with the
+          dvi-connector binding.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vga-dvi-encoder@76 {
+            compatible = "chrontel,ch7033";
+            reg = <0x76>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    endpoint {
+                        remote-endpoint = <&lcd0_rgb_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                        remote-endpoint = <&dvi_in>;
+                    };
+                };
+
+            };
+        };
+    };
-- 
2.26.0

