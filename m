Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBBFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2913320674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:59:52 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:13504 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:59:52 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06OFxeV6081820;
        Sat, 25 Jul 2020 00:59:40 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Sat, 25 Jul 2020 00:59:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06OFxaYw081779
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Jul 2020 00:59:39 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] dt-bindings: sound: convert Everest ES8316 binding to yaml
Date:   Sat, 25 Jul 2020 00:59:33 +0900
Message-Id: <20200724155933.1040501-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts Everest Semiconductor ES8316 low power audio
CODEC binding to DT schema.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes in v2:
  - Change maintainers from Mark to Daniel and me
---
 .../bindings/sound/everest,es8316.txt         | 23 ---------
 .../bindings/sound/everest,es8316.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
deleted file mode 100644
index 1bf03c5f2af4..000000000000
--- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Everest ES8316 audio CODEC
-
-This device supports both I2C and SPI.
-
-Required properties:
-
-  - compatible  : should be "everest,es8316"
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-
-  - clocks : a list of phandle, should contain entries for clock-names
-  - clock-names : should include as follows:
-         "mclk" : master clock (MCLK) of the device
-
-Example:
-
-es8316: codec@11 {
-	compatible = "everest,es8316";
-	reg = <0x11>;
-	clocks = <&clks 10>;
-	clock-names = "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
new file mode 100644
index 000000000000..3b752bba748b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES8316 audio CODEC
+
+maintainers:
+  - Daniel Drake <drake@endlessm.com>
+  - Katsuhiro Suzuki <katsuhiro@katsuster.net>
+
+properties:
+  compatible:
+    const: everest,es8316
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for master clock (MCLK)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      es8316: codec@11 {
+        compatible = "everest,es8316";
+        reg = <0x11>;
+        clocks = <&clks 10>;
+        clock-names = "mclk";
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.27.0

