Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC0C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A609A2467D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581551838;
	bh=8xewuo6BWjKVFCfLFAyswHuzHdfMQRHxgvLmr32DP2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=GhujYzCaTdk6fdz/ywcjSY2pyHzQKfEEitEtx12DFt30WtO2UiJ6FIwSALRnhDMuC
	 roCoPk2Kjw+CxeHVeLLZrh7CAEzIw7aWgtrfvdxeCwC5Defr46oFmgWoBXP2j/QYFG
	 blE+lgnNZPcAvWVLvbeFeHAFZuNyV5RGWoZuVXTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgBLX5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:57:17 -0500
Received: from foss.arm.com ([217.140.110.172]:39726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:57:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1009106F;
        Wed, 12 Feb 2020 15:57:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267453F68E;
        Wed, 12 Feb 2020 15:57:14 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:57:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     alsa-devel@alsa-project.org, bleung@chromium.org,
        broonie@kernel.org, cychiang@chromium.org, dafna3@gmail.com,
        dafna.hirschfeld@collabora.com, devicetree@vger.kernel.org,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        groeck@chromium.org, helen.koike@collabora.com,
        kernel@collabora.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format." to the asoc tree
In-Reply-To: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
Message-Id: <applied-20200127091806.11403-1-dafna.hirschfeld@collabora.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From eadd54c75f1ef1566a6fe004787c028eb095f8b4 Mon Sep 17 00:00:00 2001
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Mon, 27 Jan 2020 10:18:06 +0100
Subject: [PATCH] dt-bindings: Convert the binding file google,
 cros-ec-codec.txt to yaml format.

This was tested and verified with:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200127091806.11403-1-dafna.hirschfeld@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

