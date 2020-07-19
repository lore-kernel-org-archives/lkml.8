Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C55CC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E200F208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgGSKUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:20:31 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0153C0619D2;
        Sun, 19 Jul 2020 03:20:30 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 339CDBC062;
        Sun, 19 Jul 2020 10:20:27 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     nsekhar@ti.com, bgolaszewski@baylibre.com, robh+dt@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] ARM: mach-davinci: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 12:20:20 +0200
Message-Id: <20200719102020.57779-1-grandmaster@al2klimov.de>
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


 arch/arm/boot/dts/da850-evm.dts             | 2 +-
 arch/arm/mach-davinci/Kconfig               | 4 ++--
 arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/cpuidle.c             | 2 +-
 arch/arm/mach-davinci/cpuidle.h             | 2 +-
 arch/arm/mach-davinci/da850.c               | 2 +-
 arch/arm/mach-davinci/da8xx-dt.c            | 2 +-
 arch/arm/mach-davinci/include/mach/pm.h     | 2 +-
 arch/arm/mach-davinci/pm.c                  | 2 +-
 arch/arm/mach-davinci/sleep.S               | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f2e7609e5346..87c517d65f62 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree for DA850 EVM board
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 #include "da850.dtsi"
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index d028d38a44bf..5b0125f1265c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -201,7 +201,7 @@ config MACH_MITYOMAPL138
 	help
 	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
 	  System on Module.  Information on this SoM may be found at
-	  http://www.mitydsp.com
+	  https://www.mitydsp.com
 
 config MACH_OMAPL138_HAWKBOARD
 	bool "TI AM1808 / OMAPL-138 Hawkboard platform"
@@ -209,7 +209,7 @@ config MACH_OMAPL138_HAWKBOARD
 	help
 	  Say Y here to select the TI AM1808 / OMAPL-138 Hawkboard platform .
 	  Information of this board may be found at
-	  http://www.hawkboard.org/
+	  https://www.hawkboard.org/
 
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 5b3549f1236c..6751292e5f8f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1,7 +1,7 @@
 /*
  * TI DA850/OMAP-L138 EVM board
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Derived from: arch/arm/mach-davinci/board-da830-evm.c
  * Original Copyrights follow:
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index dfce421c0579..3382b93d9a2a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -1,7 +1,7 @@
 /*
  * Critical Link MityOMAP-L138 SoM
  *
- * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
+ * Copyright (C) 2010 Critical Link LLC - https://www.criticallink.com
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index ce99f782811a..6cf46bbc7e1d 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -214,7 +214,7 @@ static __init void davinci_ntosd2_init(void)
 	 * Mux the pins to be GPIOs, VLYNQEN is already done at startup.
 	 * The AEAWx are five new AEAW pins that can be muxed by separately.
 	 * They are a bitmask for GPIO management. According TI
-	 * documentation (http://www.ti.com/lit/gpn/tms320dm6446) to employ
+	 * documentation (https://www.ti.com/lit/gpn/tms320dm6446) to employ
 	 * gpio(10,11,12,13) for leds any combination of bits works except
 	 * four last. So we are to reset all five.
 	 */
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 5390a8630cf0..6c79039002c9 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -3,7 +3,7 @@
  *
  * Initial code: Syed Mohammed Khasim
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index b795f671bd03..dd38785536d5 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -2,7 +2,7 @@
 /*
  * CPU idle for DaVinci SoCs
  *
- * Copyright (C) 2009 Texas Instruments Incorporated. http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated. https://www.ti.com/
  *
  * Derived from Marvell Kirkwood CPU idle code
  * (arch/arm/mach-kirkwood/cpuidle.c)
diff --git a/arch/arm/mach-davinci/cpuidle.h b/arch/arm/mach-davinci/cpuidle.h
index 74f088b0edfb..0d9193aefab5 100644
--- a/arch/arm/mach-davinci/cpuidle.h
+++ b/arch/arm/mach-davinci/cpuidle.h
@@ -1,7 +1,7 @@
 /*
  * TI DaVinci cpuidle platform support
  *
- * 2009 (C) Texas Instruments, Inc. http://www.ti.com/
+ * 2009 (C) Texas Instruments, Inc. https://www.ti.com/
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 73b7cc53f966..68156e7239a6 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1,7 +1,7 @@
 /*
  * TI DA850/OMAP-L138 chip specific setup
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Derived from: arch/arm/mach-davinci/da830.c
  * Original Copyrights follow:
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 9c0dd028d5ad..0cd2f30aeb9c 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Modified from mach-omap/omap2/board-generic.c
  */
diff --git a/arch/arm/mach-davinci/include/mach/pm.h b/arch/arm/mach-davinci/include/mach/pm.h
index 37b19bf35a85..5a5f0ecc0704 100644
--- a/arch/arm/mach-davinci/include/mach/pm.h
+++ b/arch/arm/mach-davinci/include/mach/pm.h
@@ -1,7 +1,7 @@
 /*
  * TI DaVinci platform support for power management.
  *
- * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments, Inc. https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index e33c6bcb4598..323ee4e657c4 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -2,7 +2,7 @@
 /*
  * DaVinci Power Management Routines
  *
- * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments, Inc. https://www.ti.com/
  */
 
 #include <linux/pm.h>
diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index 71262dcdbca3..d5affab4396d 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * (C) Copyright 2009, Texas Instruments, Inc. http://www.ti.com/
+ * (C) Copyright 2009, Texas Instruments, Inc. https://www.ti.com/
  */
 
 /* replicated define because linux/bitops.h cannot be included in assembly */
-- 
2.27.0

