Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C220738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGSP1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:27:33 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:38064 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:27:32 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 50710BC053;
        Sun, 19 Jul 2020 15:27:28 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        jaswinder.singh@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] ARM: dts: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 17:27:22 +0200
Message-Id: <20200719152722.59701-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
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


 Documentation/devicetree/bindings/arm/xen.txt                 | 2 +-
 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt     | 2 +-
 .../devicetree/bindings/memory-controllers/ti-aemif.txt       | 4 ++--
 .../bindings/memory-controllers/ti-da8xx-ddrctl.txt           | 2 +-
 Documentation/devicetree/bindings/usb/gr-udc.txt              | 2 +-
 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml  | 2 +-
 Documentation/devicetree/bindings/usb/usb-device.txt          | 2 +-
 Documentation/devicetree/booting-without-of.txt               | 2 +-
 arch/arm/boot/dts/keystone.dtsi                               | 2 +-
 arch/arm/boot/dts/tps6507x.dtsi                               | 4 ++--
 arch/arm/boot/dts/tps65217.dtsi                               | 4 ++--
 arch/arm/boot/dts/tps65910.dtsi                               | 4 ++--
 arch/arm/boot/dts/twl4030.dtsi                                | 2 +-
 arch/arm/boot/dts/twl6030.dtsi                                | 4 ++--
 include/dt-bindings/pinctrl/dra.h                             | 2 +-
 include/dt-bindings/pinctrl/keystone.h                        | 2 +-
 16 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index db5c56db30ec..1c75e45baaf2 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -57,4 +57,4 @@ The format and meaning of the "xen,uefi-*" parameters are similar to those in
 Documentation/arm/uefi.rst, which are provided by the regular UEFI stub. However
 they differ because they are provided by the Xen hypervisor, together with a set
 of UEFI runtime services implemented via hypercalls, see
-http://xenbits.xen.org/docs/unstable/hypercall/x86_64/include,public,platform.h.html.
+https://xenbits.xen.org/docs/unstable/hypercall/x86_64/include,public,platform.h.html.
diff --git a/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt b/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
index 72daefc6b4a1..8e3c95de9a96 100644
--- a/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
+++ b/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
@@ -5,7 +5,7 @@ DA8XX SoCs feature a set of registers allowing to change the priority of all
 peripherals classified as masters.
 
 Documentation:
-OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+OMAP-L138 (DA850) - https://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt b/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
index 190437a0c146..808591a0b322 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
@@ -8,9 +8,9 @@ per chip select. Synchronous memories such as DDR1 SD RAM, SDR SDRAM
 and Mobile SDR are not supported.
 
 Documentation:
-Davinci DM646x - http://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
+Davinci DM646x - https://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
 OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
-Kestone - http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
+Kestone - https://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
index ec1dd408d573..f5b3a46e6074 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
@@ -4,7 +4,7 @@ The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs features
 a set of registers which allow to tweak the controller's behavior.
 
 Documentation:
-OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+OMAP-L138 (DA850) - https://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/usb/gr-udc.txt b/Documentation/devicetree/bindings/usb/gr-udc.txt
index e9445224fabd..45ebeec6e33c 100644
--- a/Documentation/devicetree/bindings/usb/gr-udc.txt
+++ b/Documentation/devicetree/bindings/usb/gr-udc.txt
@@ -31,4 +31,4 @@ Optional properties:
 	only for as many endpoints as the array contains.
 
 For further information look in the documentation for the GLIB IP core library:
-http://www.gaisler.com/products/grlib/grip.pdf
+https://www.gaisler.com/products/grlib/grip.pdf
diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
index 4241d38d5864..b6db83bb5055 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
@@ -14,7 +14,7 @@ description: |
   implementation over the SPI interface.
 
   Specifications about the part can be found at:
-    http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
+    https://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 036be172b1ae..dbc0fc452afb 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -2,7 +2,7 @@ Generic USB Device Properties
 
 Usually, we only use device tree for hard wired USB device.
 The reference binding doc is from:
-http://www.devicetree.org/open-firmware/bindings/usb/usb-1_0.ps
+https://www.devicetree.org/open-firmware/bindings/usb/usb-1_0.ps
 
 Four types of device-tree nodes are defined: "host-controller nodes"
 representing USB host controllers, "device nodes" representing USB devices,
diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 4660ccee35a3..d53dcea71028 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -1282,7 +1282,7 @@ hierarchy and routing of interrupts in the hardware.
 The interrupt tree model is fully described in the
 document "Open Firmware Recommended Practice: Interrupt
 Mapping Version 0.9".  The document is available at:
-<http://www.devicetree.org/open-firmware/practice/>
+<https://www.devicetree.org/open-firmware/practice/>
 
 1) interrupts property
 ----------------------
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c298675a29a5..73196470d49b 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/tps6507x.dtsi b/arch/arm/boot/dts/tps6507x.dtsi
index db4809d308f9..6749d3f3d585 100644
--- a/arch/arm/boot/dts/tps6507x.dtsi
+++ b/arch/arm/boot/dts/tps6507x.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65070.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65070.pdf
  */
 
 &tps {
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 0d463de5650f..262e0bb3eaac 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65217.pdf
  */
 
 &tps {
diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
index a941d1e62328..ab3a4ffd1298 100644
--- a/arch/arm/boot/dts/tps65910.dtsi
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/tps65910.pdf
+ * https://www.ti.com/lit/ds/symlink/tps65910.pdf
  */
 
 &tps {
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 93e07c18781b..a5d9c5738317 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 9d588cfaa5cb..8da969035c41 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+ * https://www.ti.com/lit/ds/symlink/twl6030.pdf
  */
 &twl {
 	compatible = "ti,twl6030";
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 252cdfd0d83e..d926987aea22 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -2,7 +2,7 @@
 /*
  * This header provides constants for DRA pinctrl bindings.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Rajendra Nayak <rnayak@ti.com>
  */
 
diff --git a/include/dt-bindings/pinctrl/keystone.h b/include/dt-bindings/pinctrl/keystone.h
index 7f97d776a8ff..7a48a13e229d 100644
--- a/include/dt-bindings/pinctrl/keystone.h
+++ b/include/dt-bindings/pinctrl/keystone.h
@@ -1,7 +1,7 @@
 /*
  * This header provides constants for Keystone pinctrl bindings.
  *
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
2.27.0

