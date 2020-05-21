Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3432720759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgEUJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:14:19 -0400
Received: from v6.sk ([167.172.42.174]:34802 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgEUJOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:17 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id BECA161307;
        Thu, 21 May 2020 09:14:15 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 9/9] dt-bindings: usb: Convert ehci-mv to json-schema
Date:   Thu, 21 May 2020 11:13:56 +0200
Message-Id: <20200521091356.2211020-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A straightforward conversion of the ehci-mv binding to DT schema format
using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- s/GPL-2.0-or-later/GPL-2.0-only/

 .../devicetree/bindings/usb/ehci-mv.txt       | 23 -------
 .../bindings/usb/marvell,pxau2o-ehci.yaml     | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt
 create mode 100644 Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/ehci-mv.txt b/Documentation/devicetree/bindings/usb/ehci-mv.txt
deleted file mode 100644
index 335589895763..000000000000
--- a/Documentation/devicetree/bindings/usb/ehci-mv.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Marvell PXA/MMP EHCI controller.
-
-Required properties:
-
-- compatible: must be "marvell,pxau2o-ehci"
-- reg: physical base addresses of the controller and length of memory mapped region
-- interrupts: one EHCI controller interrupt should be described here
-- clocks: phandle list of usb clocks
-- clock-names: should be "USBCLK"
-- phys: phandle for the PHY device
-- phy-names: should be "usb"
-
-Example:
-
-	ehci0: usb-ehci@d4208000 {
-		compatible = "marvell,pxau2o-ehci";
-		reg = <0xd4208000 0x200>;
-		interrupts = <44>;
-		clocks = <&soc_clocks MMP2_CLK_USB>;
-		clock-names = "USBCLK";
-		phys = <&usb_otg_phy>;
-		phy-names = "usb";
-	};
diff --git a/Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml b/Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml
new file mode 100644
index 000000000000..eccd8cb45f77
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/marvell,pxau2o-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA/MMP EHCI bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+properties:
+  compatible:
+    const: marvell,pxau2o-ehci
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
+    const: USBCLK
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+    usb@d4208000 {
+        compatible = "marvell,pxau2o-ehci";
+        reg = <0xd4208000 0x200>;
+        interrupts = <44>;
+        clocks = <&soc_clocks MMP2_CLK_USB>;
+        clock-names = "USBCLK";
+        phys = <&usb_otg_phy>;
+        phy-names = "usb";
+    };
+
+...
-- 
2.26.2

