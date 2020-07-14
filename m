Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91D220672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNJAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:00:24 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:28073 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:00:24 -0400
X-Greylist: delayed 3004 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2020 05:00:23 EDT
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06E8A6nX049094;
        Tue, 14 Jul 2020 17:10:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Tue, 14 Jul 2020 17:10:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06E8A1Zq049060
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 14 Jul 2020 17:10:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] dt-bindings: sound: convert ROHM BD28623 amplifier binding to yaml
Date:   Tue, 14 Jul 2020 17:09:59 +0900
Message-Id: <20200714081000.177914-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ROHM BD28623UMV class D speaker amplifier binding
to DT schema.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/rohm,bd28623.txt           | 29 ---------
 .../bindings/sound/rohm,bd28623.yaml          | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.yaml

diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
deleted file mode 100644
index d84557c2686e..000000000000
--- a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-ROHM BD28623MUV Class D speaker amplifier for digital input
-
-This codec does not have any control buses such as I2C, it detect format and
-rate of I2S signal automatically. It has two signals that can be connected
-to GPIOs: reset and mute.
-
-Required properties:
-- compatible      : should be "rohm,bd28623"
-- #sound-dai-cells: should be 0.
-- VCCA-supply     : regulator phandle for the VCCA supply
-- VCCP1-supply    : regulator phandle for the VCCP1 supply
-- VCCP2-supply    : regulator phandle for the VCCP2 supply
-
-Optional properties:
-- reset-gpios     : GPIO specifier for the active low reset line
-- mute-gpios      : GPIO specifier for the active low mute line
-
-Example:
-
-	codec {
-		compatible = "rohm,bd28623";
-		#sound-dai-cells = <0>;
-
-		VCCA-supply = <&vcc_reg>;
-		VCCP1-supply = <&vcc_reg>;
-		VCCP2-supply = <&vcc_reg>;
-		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
-		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
new file mode 100644
index 000000000000..acd8609252b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rohm,bd28623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD28623MUV Class D speaker amplifier for digital input
+
+description:
+  This codec does not have any control buses such as I2C, it detect
+  format and rate of I2S signal automatically. It has two signals
+  that can be connected to GPIOs reset and mute.
+
+maintainers:
+  - Katsuhiro Suzuki <katsuhiro@katsuster.net>
+
+properties:
+  compatible:
+    const: rohm,bd28623
+
+  "#sound-dai-cells":
+    const: 0
+
+  VCCA-supply:
+    description:
+      regulator phandle for the VCCA (for analog) power supply
+
+  VCCP1-supply:
+    description:
+      regulator phandle for the VCCP1 (for ch1) power supply
+
+  VCCP2-supply:
+    description:
+      regulator phandle for the VCCP2 (for ch2) power supply
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the active low reset line
+
+  mute-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the active low mute line
+
+required:
+  - compatible
+  - VCCA-supply
+  - VCCP1-supply
+  - VCCP2-supply
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    codec {
+      compatible = "rohm,bd28623";
+      #sound-dai-cells = <0>;
+
+      VCCA-supply = <&vcc_reg>;
+      VCCP1-supply = <&vcc_reg>;
+      VCCP2-supply = <&vcc_reg>;
+      reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+      mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+    };
-- 
2.27.0

