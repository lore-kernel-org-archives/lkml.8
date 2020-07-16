Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E039DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9152065E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UNQhsv6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgGPQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:39:11 -0400
Received: from crapouillou.net ([89.234.176.41]:49896 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917534; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yfps6zJTHRjLHKhT7ej722q1fZZeWk7kGex+GBCz5ic=;
        b=UNQhsv6dbbeFw050Bnzp8j+Cg1NaNTKGKhqN0l0uOpBiZfvzgk09TTft7OictnLlhtKBym
        gDwltSCqIJ6INz4nhYcjTHM2Li8t1snyjqgeuPtJ1ZzOTym8x8zKH0ZPyemExCMUXebAFu
        E5VShWUFjoQ+LAx0W+GQfz35cISFU7s=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/12] dt-bindings: display: Add ingenic,ipu.yaml
Date:   Thu, 16 Jul 2020 18:38:37 +0200
Message-Id: <20200716163846.174790-3-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of the Device Tree bindings for the Image Processing
Unit (IPU) found in most Ingenic SoCs.

v2: Add missing 'const' in items list
v3: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/ingenic,ipu.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,ipu.yaml

diff --git a/Documentation/devicetree/bindings/display/ingenic,ipu.yaml b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
new file mode 100644
index 000000000000..5bfc33eb32c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ingenic,ipu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs Image Processing Unit (IPU) devicetree bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+        - ingenic,jz4725b-ipu
+        - ingenic,jz4760-ipu
+      - items:
+        - const: ingenic,jz4770-ipu
+        - const: ingenic,jz4760-ipu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ipu
+
+patternProperties:
+  "^ports?$":
+    description: OF graph bindings (specified in bindings/graph.txt).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4770-cgu.h>
+    ipu@13080000 {
+      compatible = "ingenic,jz4770-ipu", "ingenic,jz4760-ipu";
+      reg = <0x13080000 0x800>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <29>;
+
+      clocks = <&cgu JZ4770_CLK_IPU>;
+      clock-names = "ipu";
+
+      port {
+        ipu_ep: endpoint {
+          remote-endpoint = <&lcdc_ep>;
+        };
+      };
+    };
-- 
2.27.0

