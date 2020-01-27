Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1642C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D314222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgA0JSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:18:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56666 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0JSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:18:17 -0500
Received: from localhost.localdomain (p200300CB87166A002102C4F03A4721D7.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:2102:c4f0:3a47:21d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 561FB29142A;
        Mon, 27 Jan 2020 09:18:15 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     alsa-devel@alsa-project.org
Cc:     cychiang@chromium.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com, devicetree@vger.kernel.org,
        groeck@chromium.org, enric.balletbo@collabora.com,
        broonie@kernel.org, lgirdwood@gmail.com, bleung@chromium.org
Subject: [PATCH] dt-bindings: Convert the binding file google,cros-ec-codec.txt to yaml format.
Date:   Mon, 27 Jan 2020 10:18:06 +0100
Message-Id: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was tested and verified with:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 44 -------------
 .../bindings/sound/google,cros-ec-codec.yaml  | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
deleted file mode 100644
index 8ca52dcc5572..000000000000
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Audio codec controlled by ChromeOS EC
-
-Google's ChromeOS EC codec is a digital mic codec provided by the
-Embedded Controller (EC) and is controlled via a host-command interface.
-
-An EC codec node should only be found as a sub-node of the EC node (see
-Documentation/devicetree/bindings/mfd/cros-ec.txt).
-
-Required properties:
-- compatible: Must contain "google,cros-ec-codec"
-- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
-
-Optional properties:
-- reg: Pysical base address and length of shared memory region from EC.
-       It contains 3 unsigned 32-bit integer.  The first 2 integers
-       combine to become an unsigned 64-bit physical address.  The last
-       one integer is length of the shared memory.
-- memory-region: Shared memory region to EC.  A "shared-dma-pool".  See
-                 ../reserved-memory/reserved-memory.txt for details.
-
-Example:
-
-{
-	...
-
-	reserved_mem: reserved_mem {
-		compatible = "shared-dma-pool";
-		reg = <0 0x52800000 0 0x100000>;
-		no-map;
-	};
-}
-
-cros-ec@0 {
-	compatible = "google,cros-ec-spi";
-
-	...
-
-	cros_ec_codec: ec-codec {
-		compatible = "google,cros-ec-codec";
-		#sound-dai-cells = <1>;
-		reg = <0x0 0x10500000 0x80000>;
-		memory-region = <&reserved_mem>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
new file mode 100644
index 000000000000..94a85d0cbf43
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,cros-ec-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio codec controlled by ChromeOS EC
+
+maintainers:
+  - Cheng-Yi Chiang <cychiang@chromium.org>
+
+description: |
+  Google's ChromeOS EC codec is a digital mic codec provided by the
+  Embedded Controller (EC) and is controlled via a host-command interface.
+  An EC codec node should only be found as a sub-node of the EC node (see
+  Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+properties:
+  compatible:
+    const: google,cros-ec-codec
+
+  "#sound-dai-cells":
+    const: 1
+
+  reg:
+    items:
+      - description: |
+          Physical base address and length of shared memory region from EC.
+          It contains 3 unsigned 32-bit integer. The first 2 integers
+          combine to become an unsigned 64-bit physical address.
+          The last one integer is the length of the shared memory.
+
+  memory-region:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Shared memory region to EC.  A "shared-dma-pool".
+      See ../reserved-memory/reserved-memory.txt for details.
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    reserved_mem: reserved_mem {
+        compatible = "shared-dma-pool";
+        reg = <0 0x52800000 0 0x100000>;
+        no-map;
+    };
+    cros-ec@0 {
+        compatible = "google,cros-ec-spi";
+        #address-cells = <2>;
+        #size-cells = <1>;
+        cros_ec_codec: ec-codec {
+            compatible = "google,cros-ec-codec";
+            #sound-dai-cells = <1>;
+            reg = <0x0 0x10500000 0x80000>;
+            memory-region = <&reserved_mem>;
+        };
+    };
-- 
2.17.1

