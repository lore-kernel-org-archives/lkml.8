Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5746EC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385AF206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgBLPws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:52:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgBLPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:52:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 2FACD293C13
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH v3] dt-bindings: extcon: usbc-cros-ec: convert extcon-usbc-cros-ec.txt to yaml format
Date:   Wed, 12 Feb 2020 16:51:55 +0100
Message-Id: <20200212155155.14210-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert the binding file extcon-usbc-cros-ec.txt to
yaml format extcon-usbc-cros-ec.yaml

This was tested and verified on ARM with:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
Changes since v1:
1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
2 - changing the maintainers
3 - changing the google,usb-port-id property to have minimum 0 and maximum 255

Changes since v2:
1 - Changing the patch subject to start with "dt-bindings: extcon: usbc-cros-ec:"
2 - In the example, adding a parent isp node, a reg field to cros-ec@0
and adding nodes 'extcon0/1' instead of one node 'extcon'.

 .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 --------
 .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
deleted file mode 100644
index 8e8625c00dfa..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-ChromeOS EC USB Type-C cable and accessories detection
-
-On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
-able to detect the state of external accessories such as display adapters
-or USB devices when said accessories are attached or detached.
-
-The node for this device must be under a cros-ec node like google,cros-ec-spi
-or google,cros-ec-i2c.
-
-Required properties:
-- compatible:		Should be "google,extcon-usbc-cros-ec".
-- google,usb-port-id:	Specifies the USB port ID to use.
-
-Example:
-	cros-ec@0 {
-		compatible = "google,cros-ec-i2c";
-
-		...
-
-		extcon {
-			compatible = "google,extcon-usbc-cros-ec";
-			google,usb-port-id = <0>;
-		};
-	}
diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
new file mode 100644
index 000000000000..d7a2fc544c4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC USB Type-C cable and accessories detection
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
+  able to detect the state of external accessories such as display adapters
+  or USB devices when said accessories are attached or detached.
+  The node for this device must be under a cros-ec node like google,cros-ec-spi
+  or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const: google,extcon-usbc-cros-ec
+
+  google,usb-port-id:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description: the port id
+    minimum: 0
+    maximum: 255
+
+required:
+  - compatible
+  - google,usb-port-id
+
+additionalProperties: false
+
+examples:
+  - |
+    isp1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;
+
+            usbc_extcon0: extcon0 {
+                compatible = "google,extcon-usbc-cros-ec";
+                google,usb-port-id = <0>;
+            };
+
+            usbc_extcon1: extcon1 {
+                compatible = "google,extcon-usbc-cros-ec";
+                google,usb-port-id = <1>;
+            };
+        };
+    };
-- 
2.17.1

