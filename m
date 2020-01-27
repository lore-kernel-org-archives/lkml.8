Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF20214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgA0QNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:13:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgA0QNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:13:09 -0500
Received: from localhost.localdomain (p200300CB87166A002102C4F03A4721D7.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:2102:c4f0:3a47:21d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DF01628CAE7;
        Mon, 27 Jan 2020 16:13:05 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-i2c@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        dafna.hirschfeld@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] dt-bindings: convert i2c-cros-ec-tunnel.txt to yaml
Date:   Mon, 27 Jan 2020 17:12:13 +0100
Message-Id: <20200127161213.13339-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding file i2c-cros-ec-tunnel.txt to yaml format.

This was tested and verified on ARM and ARM64 with:

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/i2c/i2c-cros-ec-tunnel.txt       | 39 ------------
 .../bindings/i2c/i2c-cros-ec-tunnel.yaml      | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
deleted file mode 100644
index 898f030eba62..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-I2C bus that tunnels through the ChromeOS EC (cros-ec)
-======================================================
-On some ChromeOS board designs we've got a connection to the EC (embedded
-controller) but no direct connection to some devices on the other side of
-the EC (like a battery and PMIC).  To get access to those devices we need
-to tunnel our i2c commands through the EC.
-
-The node for this device should be under a cros-ec node like google,cros-ec-spi
-or google,cros-ec-i2c.
-
-
-Required properties:
-- compatible: google,cros-ec-i2c-tunnel
-- google,remote-bus: The EC bus we'd like to talk to.
-
-Optional child nodes:
-- One node per I2C device connected to the tunnelled I2C bus.
-
-
-Example:
-	cros-ec@0 {
-		compatible = "google,cros-ec-spi";
-
-		...
-
-		i2c-tunnel {
-			compatible = "google,cros-ec-i2c-tunnel";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			google,remote-bus = <0>;
-
-			battery: sbs-battery@b {
-				compatible = "sbs,sbs-battery";
-				reg = <0xb>;
-				sbs,poll-retry-count = <1>;
-			};
-		};
-	}
diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
new file mode 100644
index 000000000000..c1383e607f47
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-cros-ec-tunnel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C bus that tunnels through the ChromeOS EC (cros-ec)
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+  - Guenter Roeck <groeck@chromium.org>
+
+description: |
+  On some ChromeOS board designs we've got a connection to the EC (embedded
+  controller) but no direct connection to some devices on the other side of
+  the EC (like a battery and PMIC). To get access to those devices we need
+  to tunnel our i2c commands through the EC.
+  The node for this device should be under a cros-ec node like google,cros-ec-spi
+  or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const:
+      google,cros-ec-i2c-tunnel
+
+  google,remote-bus:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The EC bus we'd like to talk to.
+
+  "#address-cells": true
+  "#size-cells": true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: One node per I2C device connected to the tunnelled I2C bus.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - google,remote-bus
+
+examples:
+  - |
+    cros-ec@0 {
+        compatible = "google,cros-ec-spi";
+        i2c-tunnel {
+            compatible = "google,cros-ec-i2c-tunnel";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            google,remote-bus = <0>;
+
+            battery: sbs-battery@b {
+                compatible = "sbs,sbs-battery";
+                reg = <0xb>;
+                sbs,poll-retry-count = <1>;
+            };
+        };
+    };
-- 
2.17.1

