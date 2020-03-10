Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD5C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36572222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCJUmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:42:09 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21932 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgCJUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:42:08 -0400
X-IronPort-AV: E=Sophos;i="5.70,538,1574089200"; 
   d="scan'208";a="41519232"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Mar 2020 05:42:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 49B9140F8AD4;
        Wed, 11 Mar 2020 05:42:04 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/2] dt-bindings: display: Add idk-1110wr binding
Date:   Tue, 10 Mar 2020 20:41:58 +0000
Message-Id: <1583872919-7757-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583872919-7757-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1583872919-7757-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add binding for the idk-1110wr LVDS panel from Advantech.

Some panel-specific documentation can be found here:
https://buy.advantech.eu/Displays/Embedded-LCD-Kits-LCD-Kit-Modules/model-IDK-1110WR-55WSA1E.htm

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../display/panel/advantech,idk-1110wr.yaml        | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
new file mode 100644
index 0000000..93878c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/advantech,idk-1110wr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Advantech IDK-1110WR 10.1" WSVGA LVDS Display Panel
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: advantech,idk-1110wr
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  data-mapping:
+    const: jeida-24
+
+  width-mm:
+    const: 223
+
+  height-mm:
+    const: 125
+
+  panel-timing: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |+
+    panel {
+      compatible = "advantech,idk-1110wr", "panel-lvds";
+
+      width-mm = <223>;
+      height-mm = <125>;
+
+      data-mapping = "jeida-24";
+
+      panel-timing {
+        /* 1024x600 @60Hz */
+        clock-frequency = <51200000>;
+        hactive = <1024>;
+        vactive = <600>;
+        hsync-len = <240>;
+        hfront-porch = <40>;
+        hback-porch = <40>;
+        vsync-len = <10>;
+        vfront-porch = <15>;
+        vback-porch = <10>;
+      };
+
+      port {
+        panel_in: endpoint {
+          remote-endpoint = <&lvds_encoder>;
+        };
+      };
+    };
+
+...
-- 
2.7.4

