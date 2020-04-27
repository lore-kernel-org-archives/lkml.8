Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047BC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42284214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD0IWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:22:39 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:3257 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0IWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:22:39 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583161200"; 
   d="scan'208";a="45602852"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Apr 2020 17:22:37 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [172.29.51.26])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 22F4A41D9F73;
        Mon, 27 Apr 2020 17:22:32 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/db9000: Add bindings documentation for LCD controller
Date:   Mon, 27 Apr 2020 09:21:48 +0100
Message-Id: <1587975709-2092-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings information for the Digital Blocks DB9000 LCD
controller. Also include documentation for the Renesas RZN1 specific
compatible string.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 .../devicetree/bindings/display/db9000,du.yaml     | 87 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/db9000,du.yaml

diff --git a/Documentation/devicetree/bindings/display/db9000,du.yaml b/Documentation/devicetree/bindings/display/db9000,du.yaml
new file mode 100644
index 0000000..73a9311
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/db9000,du.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/db9000,du.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DB9000 LCD Controller
+
+maintainers:
+    - Gareth Williams <gareth.williams.jx@renesas.com>
+
+description: |
+  This is an LCD controller by Digital Blocks available for SoCs. The DB9000
+  controller reads from the framebuffer to display on a single RGB interface.
+  Output may be formatted in RGB or BGR. The driver also supports the PWM
+  logic that is included with the controller.
+
+properties:
+
+  compatible:
+    oneOf:
+      - const: digital-blocks,drm-db9000
+      - const: digital-blocks,drm-rzn1
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: |
+          A phandle and clock-specifier pair to be used as a pixel clock.
+
+  clock-names:
+   items:
+      - const: lcd_eclk
+
+  port:
+    type: object
+    description: The panel endpoint connection.
+
+  bits-per-pixel:
+    description: |
+            Default is 24. This selects the number of bits used to represent
+            a single pixel within the controller.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [8, 16, 24, 32]
+
+  bus-width:
+    description: |
+       The width of the interface to the LCD panel. This is needed
+       if the bits-per-pixel property is set to 16 or less, but the board
+       connects to a 24-bit panel. In which case, the controller will shift the
+       16-bit data to the most significant bits of the device. Default is 24.
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#pwm-cells"
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+examples:
+  - |+
+    drm@53004000 {
+      compatible = "digital-blocks,drm-db9000";
+      reg = <0x53004000 0x1000>;
+      interrupts = <10 97 120>;
+      clocks = <&sysctrl 26>;
+      clock-names = "clk_slcd";
+      bus-width = <24>;
+      pinctrl-0 = <&pins_lcd>;
+      #pwm-cells = <2>;
+
+      port {
+        drm_point: endpoint@0 {
+          remote-endpoint = <&display_in>;
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..138f76e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -235,6 +235,8 @@ patternProperties:
     description: Shenzhen Yagu Electronic Technology Co., Ltd.
   "^digi,.*":
     description: Digi International Inc.
+  "^digital-blocks,.*":
+    description: Digital Blocks, Inc.
   "^digilent,.*":
     description: Diglent, Inc.
   "^dioo,.*":
-- 
2.7.4

