Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BABCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EA622CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGRVMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:12:51 -0400
Received: from v6.sk ([167.172.42.174]:37910 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgGRVMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:12:50 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 4557560D3C;
        Sat, 18 Jul 2020 21:12:49 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: misc: Convert olpc,xo1.75-ec to json-schema
Date:   Sat, 18 Jul 2020 23:12:44 +0200
Message-Id: <20200718211244.187938-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the OLPC XO-1.75 Embedded Controller binding to DT schema format
using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Hi,

please consider enqueueing this patch for 5.9. It is a straightforward
conversion of the olpc,xo1.75-ec binding doc to YAML.

It applies on top of v5.8-rc4 (where a fix into olpc,xo1.75-ec.txt
landed).

Thanks
Lubo

 .../bindings/misc/olpc,xo1.75-ec.txt          | 23 --------
 .../bindings/misc/olpc,xo1.75-ec.yaml         | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
deleted file mode 100644
index 2d7cdf19a0d0f..0000000000000
--- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-OLPC XO-1.75 Embedded Controller
-
-Required properties:
-- compatible: Should be "olpc,xo1.75-ec".
-- cmd-gpios: gpio specifier of the CMD pin
-
-The embedded controller requires the SPI controller driver to signal readiness
-to receive a transfer (that is, when TX FIFO contains the response data) by
-strobing the ACK pin with the ready signal. See the "ready-gpios" property of the
-SSP binding as documented in:
-<Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml>.
-
-Example:
-	&ssp3 {
-		spi-slave;
-		ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
-
-		slave {
-			compatible = "olpc,xo1.75-ec";
-			spi-cpha;
-			cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
new file mode 100644
index 0000000000000..e75d77beec6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/olpc,xo1.75-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OLPC XO-1.75 Embedded Controller bindings
+
+description: |
+  This binding describes the Embedded Controller acting as a SPI bus master
+  on a OLPC XO-1.75 laptop computer.
+
+  The embedded controller requires the SPI controller driver to signal
+  readiness to receive a transfer (that is, when TX FIFO contains the
+  response data) by strobing the ACK pin with the ready signal. See the
+  "ready-gpios" property of the SSP binding as documented in:
+  <Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml>.
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: olpc,xo1.75-ec
+
+  cmd-gpios:
+    description: GPIO uspecifier of the CMD pin
+    maxItems: 1
+
+required:
+  - compatible
+  - cmd-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      spi-slave;
+      ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+      slave {
+        compatible = "olpc,xo1.75-ec";
+        spi-cpha;
+        cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
+      };
+    };
+
+...
-- 
2.26.2

