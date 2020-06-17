Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66D020CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFQLJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:09:13 -0400
Received: from v6.sk ([167.172.42.174]:50044 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFQLJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:09:10 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AB3F961635;
        Wed, 17 Jun 2020 11:08:38 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: mfd: Add ENE KB3930 Embedded Controller binding
Date:   Wed, 17 Jun 2020 13:08:28 +0200
Message-Id: <20200617110829.1036898-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617110829.1036898-1-lkundrak@v3.sk>
References: <20200617110829.1036898-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the ENE KB3930 Embedded Controller.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v4:
- Collected Rob's Reviewed-by

Changes since v1:
- Addressed binding validation failure

 .../devicetree/bindings/mfd/ene-kb3930.yaml   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
new file mode 100644
index 0000000000000..005f5cb59ab12
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ene-kb3930.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENE KB3930 Embedded Controller bindings
+
+description: |
+  This binding describes the ENE KB3930 Embedded Controller attached to a
+  I2C bus.
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - dell,wyse-ariel-ec  # Dell Wyse Ariel board (3020)
+      - const: ene,kb3930
+  reg:
+    maxItems: 1
+
+  off-gpios:
+    description: GPIO used with the shutdown protocol on Ariel
+    maxItems: 2
+
+  system-power-controller: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@58 {
+        compatible = "dell,wyse-ariel-ec", "ene,kb3930";
+        reg = <0x58>;
+        system-power-controller;
+
+        off-gpios = <&gpio 126 GPIO_ACTIVE_HIGH>,
+                    <&gpio 127 GPIO_ACTIVE_HIGH>;
+      };
+    };
+
+...
-- 
2.26.2

