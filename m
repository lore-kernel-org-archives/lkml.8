Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD53020773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGMKOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:14:19 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FEEC061755;
        Mon, 13 Jul 2020 03:14:19 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0D8A2BC070;
        Mon, 13 Jul 2020 10:14:15 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     t-kristo@ti.com, nm@ti.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] arm64: dts: ti: k3-*: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 12:14:09 +0200
Message-Id: <20200713101409.33131-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 arch/arm64/boot/dts/ti/Makefile                       | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi              | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi               | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            | 2 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                   | 2 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am654.dtsi                  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                  | 2 +-
 include/dt-bindings/pinctrl/k3.h                      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index b397945fdf73..05c0bebf65d4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -3,7 +3,7 @@
 # Make file to build device tree binaries for boards based on
 # Texas Instruments Inc processors
 #
-# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
 #
 
 dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 61815228e230..940acc6cbf26 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for AM6 SoC Family Main Domain peripherals
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <dt-bindings/phy/phy-am654-serdes.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index ae5f813d0cac..8c1abcfe0860 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for AM6 SoC Family MCU Domain peripherals
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 54a133fa1bf2..dd75a5592539 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 5be75e430965..27c0406b10ba 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for AM6 SoC Family
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 2f3d3316a1cf..78084a507fcf 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
index b221abf43ac2..f0a6541b8042 100644
--- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for AM6 SoC family in Quad core configuration
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-am65.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 6df823aaa37c..7de37e8abfbb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 96c929da639d..bdeda701af7c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J721E SoC Family Main Domain peripherals
  *
- * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_main {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index dc31bd0434cb..4e1865d2d4b1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J721E SoC Family MCU/WAKEUP Domain peripherals
  *
- * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 7680109ca60a..8fa3361e5e45 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 2f9a56d9b114..d035b61e0e16 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J721E SoC Family
  *
- * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index 499de6216581..b0eea7cc6e23 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -3,7 +3,7 @@
  * This header provides constants for pinctrl bindings for TI's K3 SoC
  * family.
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
 #define _DT_BINDINGS_PINCTRL_TI_K3_H
-- 
2.27.0

