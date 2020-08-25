Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E736C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F305D20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgHYKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:41:39 -0400
Received: from mx.socionext.com ([202.248.49.38]:29669 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgHYKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:41:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Aug 2020 19:41:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 770831800AA;
        Tue, 25 Aug 2020 19:41:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 25 Aug 2020 19:41:17 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E793E1A0507;
        Tue, 25 Aug 2020 19:41:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [RESEND PATCH v4 1/2] dt-bindings: phy: Add UniPhier AHCI PHY description
Date:   Tue, 25 Aug 2020 19:41:10 +0900
Message-Id: <1598352071-26675-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598352071-26675-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1598352071-26675-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PHY interface built into ahci controller implemented
in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
new file mode 100644
index 0000000..bab2ff4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-ahci-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier AHCI PHY
+
+description: |
+  This describes the deivcetree bindings for PHY interfaces built into
+  AHCI controller implemented on Socionext UniPhier SoCs.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pxs2-ahci-phy
+      - socionext,uniphier-pxs3-ahci-phy
+
+  reg:
+    description: PHY register region (offset and length)
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:          # for PXs2
+        - const: link
+      - items:          # for others
+        - const: link
+        - const: phy
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: link
+      - const: phy
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ahci-glue@65700000 {
+        compatible = "socionext,uniphier-pxs3-ahci-glue",
+                     "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65700000 0x100>;
+
+        ahci_phy: phy@10 {
+            compatible = "socionext,uniphier-pxs3-ahci-phy";
+            reg = <0x10 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 28>, <&sys_clk 30>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 28>, <&sys_rst 30>;
+        };
+    };
-- 
2.7.4

