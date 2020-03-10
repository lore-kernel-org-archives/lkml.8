Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB221655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCJTjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:39:43 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:8328 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgCJTjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:39:42 -0400
X-IronPort-AV: E=Sophos;i="5.70,538,1574089200"; 
   d="scan'208";a="41516787"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Mar 2020 04:39:40 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC0A940E36FF;
        Wed, 11 Mar 2020 04:39:37 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8] dt-bindings: display: Add idk-2121wr binding
Date:   Tue, 10 Mar 2020 19:39:29 +0000
Message-Id: <1583869169-1006-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add binding for the idk-2121wr LVDS panel from Advantech.

Some panel-specific documentation can be found here:
https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---

Hi All,
This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
all the patches have been accepted from it except this one. I have fixed
Rob's comments in this version of the patch.

[1] https://patchwork.kernel.org/cover/11297589/

V7->8
 * Dropped ref to lvds.yaml, since the panel a dual channel LVDS, as a
   result the root port is called as ports instead of port and the child
   node port@0 and port@1 are used for even and odd pixels, hence binding
   has required property as ports instead of port.

v6->7
 * Added reference to lvds.yaml
 * Changed maintainer to myself
 * Switched to dual license
 * Dropped required properties except for ports as rest are already listed
   in lvds.panel
 * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
   be valid.

v5->v6:
 * No change

v4->v5:
* No change

v3->v4:
* Absorbed patch "dt-bindings: display: Add bindings for LVDS
  bus-timings"
* Big restructuring after Rob's and Laurent's comments

v2->v3:
* New patch

 .../display/panel/advantech,idk-2121wr.yaml        | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
new file mode 100644
index 0000000..6b7fddc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/advantech,idk-2121wr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Advantech IDK-2121WR 21.5" Full-HD dual-LVDS panel
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The IDK-2121WR from Advantech is a Full-HD dual-LVDS panel.
+  A dual-LVDS interface is a dual-link connection with even pixels traveling
+  on one link, and with odd pixels traveling on the other link.
+
+  The panel expects odd pixels on the first port, and even pixels on the
+  second port, therefore the ports must be marked accordingly (with either
+  dual-lvds-odd-pixels or dual-lvds-even-pixels).
+
+properties:
+  compatible:
+    items:
+      - const: advantech,idk-2121wr
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  width-mm:
+    const: 476
+
+  height-mm:
+    const: 268
+
+  data-mapping:
+    const: vesa-24
+
+  panel-timing: true
+
+  ports:
+    type: object
+    properties:
+      port@0:
+        type: object
+        description: The sink for odd pixels.
+        properties:
+          reg:
+            const: 0
+
+          dual-lvds-odd-pixels: true
+
+        required:
+          - reg
+          - dual-lvds-odd-pixels
+
+      port@1:
+        type: object
+        description: The sink for even pixels.
+        properties:
+          reg:
+            const: 1
+
+          dual-lvds-even-pixels: true
+
+        required:
+          - reg
+          - dual-lvds-even-pixels
+
+additionalProperties: false
+
+required:
+  - compatible
+  - width-mm
+  - height-mm
+  - data-mapping
+  - panel-timing
+  - ports
+
+examples:
+  - |+
+    panel-lvds {
+      compatible = "advantech,idk-2121wr", "panel-lvds";
+
+      width-mm = <476>;
+      height-mm = <268>;
+
+      data-mapping = "vesa-24";
+
+      panel-timing {
+        clock-frequency = <148500000>;
+        hactive = <1920>;
+        vactive = <1080>;
+        hsync-len = <44>;
+        hfront-porch = <88>;
+        hback-porch = <148>;
+        vfront-porch = <4>;
+        vback-porch = <36>;
+        vsync-len = <5>;
+      };
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          dual-lvds-odd-pixels;
+          panel_in0: endpoint {
+            remote-endpoint = <&lvds0_out>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          dual-lvds-even-pixels;
+          panel_in1: endpoint {
+            remote-endpoint = <&lvds1_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.7.4

