Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E8FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B542220658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgGZLBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:01:34 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:43130 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:01:34 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id CFDA76F636;
        Sun, 26 Jul 2020 11:01:23 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, lokeshvutla@ti.com,
        tony@atomide.com, daniel.lezcano@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        davem@davemloft.net, hkallweit1@gmail.com, vkoul@kernel.org,
        grygorii.strashko@ti.com, peter.ujfalusi@ti.com,
        santosh.shilimkar@oracle.com, t-kristo@ti.com,
        zaslonko@linux.ibm.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, Dave.Martin@arm.com, broonie@kernel.org,
        keescook@chromium.org, yu-cheng.yu@intel.com,
        Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] include: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 13:01:17 +0200
Message-Id: <20200726110117.16346-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 include/clocksource/timer-ti-dm.h               | 2 +-
 include/linux/btree.h                           | 2 +-
 include/linux/delay.h                           | 2 +-
 include/linux/dma/k3-psil.h                     | 2 +-
 include/linux/dma/k3-udma-glue.h                | 2 +-
 include/linux/dma/ti-cppi5.h                    | 2 +-
 include/linux/irqchip/irq-omap-intc.h           | 2 +-
 include/linux/jhash.h                           | 2 +-
 include/linux/leds-ti-lmu-common.h              | 2 +-
 include/linux/platform_data/davinci-cpufreq.h   | 2 +-
 include/linux/platform_data/davinci_asp.h       | 2 +-
 include/linux/platform_data/elm.h               | 2 +-
 include/linux/platform_data/gpio-davinci.h      | 2 +-
 include/linux/platform_data/gpmc-omap.h         | 2 +-
 include/linux/platform_data/mtd-davinci-aemif.h | 2 +-
 include/linux/platform_data/omap-twl4030.h      | 2 +-
 include/linux/platform_data/uio_pruss.h         | 2 +-
 include/linux/platform_data/usb-omap.h          | 2 +-
 include/linux/soc/ti/k3-ringacc.h               | 2 +-
 include/linux/soc/ti/knav_qmss.h                | 2 +-
 include/linux/soc/ti/ti-msgmgr.h                | 2 +-
 include/linux/wkup_m3_ipc.h                     | 2 +-
 include/linux/xxhash.h                          | 2 +-
 include/linux/xz.h                              | 2 +-
 include/linux/zlib.h                            | 2 +-
 include/soc/arc/aux.h                           | 2 +-
 include/uapi/linux/elf.h                        | 2 +-
 include/uapi/linux/map_to_7segment.h            | 2 +-
 include/uapi/linux/types.h                      | 2 +-
 include/uapi/linux/usb/ch9.h                    | 2 +-
 30 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 531ca87fcd08..4c61dade8835 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -1,7 +1,7 @@
 /*
  * OMAP Dual-Mode Timers
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  * Tarun Kanti DebBarma <tarun.kanti@ti.com>
  * Thara Gopinath <thara@ti.com>
  *
diff --git a/include/linux/btree.h b/include/linux/btree.h
index 68f858c831b1..243ee544397a 100644
--- a/include/linux/btree.h
+++ b/include/linux/btree.h
@@ -10,7 +10,7 @@
  *
  * A B+Tree is a data structure for looking up arbitrary (currently allowing
  * unsigned long, u32, u64 and 2 * u64) keys into pointers. The data structure
- * is described at http://en.wikipedia.org/wiki/B-tree, we currently do not
+ * is described at https://en.wikipedia.org/wiki/B-tree, we currently do not
  * use binary search to find the key on lookups.
  *
  * Each B+Tree consists of a head, that contains bookkeeping information and
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 5e016a4029d9..1d0e2ce6b6d9 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -16,7 +16,7 @@
  *  3. CPU clock rate changes.
  *
  * Please see this thread:
- *   http://lists.openwall.net/linux-kernel/2011/01/09/56
+ *   https://lists.openwall.net/linux-kernel/2011/01/09/56
  */
 
 #include <linux/kernel.h>
diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
index 61d5cc0ad601..1962f75fa2d3 100644
--- a/include/linux/dma/k3-psil.h
+++ b/include/linux/dma/k3-psil.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_PSIL_H_
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index caadbab1632a..5eb34ad973a7 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef K3_UDMA_GLUE_H_
diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
index 579356ae447e..5896441ee604 100644
--- a/include/linux/dma/ti-cppi5.h
+++ b/include/linux/dma/ti-cppi5.h
@@ -2,7 +2,7 @@
 /*
  * CPPI5 descriptors interface
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef __TI_CPPI5_H__
diff --git a/include/linux/irqchip/irq-omap-intc.h b/include/linux/irqchip/irq-omap-intc.h
index 216e5adf80ce..dca379c0d7eb 100644
--- a/include/linux/irqchip/irq-omap-intc.h
+++ b/include/linux/irqchip/irq-omap-intc.h
@@ -2,7 +2,7 @@
 /**
  * irq-omap-intc.h - INTC Idle Functions
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Felipe Balbi <balbi@ti.com>
  */
diff --git a/include/linux/jhash.h b/include/linux/jhash.h
index ba2f6a9776b6..19ddd43aee68 100644
--- a/include/linux/jhash.h
+++ b/include/linux/jhash.h
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2006. Bob Jenkins (bob_jenkins@burtleburtle.net)
  *
- * http://burtleburtle.net/bob/hash/
+ * https://burtleburtle.net/bob/hash/
  *
  * These are the credits from Bob's sources:
  *
diff --git a/include/linux/leds-ti-lmu-common.h b/include/linux/leds-ti-lmu-common.h
index 5eb111f38803..420b61e5a213 100644
--- a/include/linux/leds-ti-lmu-common.h
+++ b/include/linux/leds-ti-lmu-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 // TI LMU Common Core
-// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+// Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
 
 #ifndef _TI_LMU_COMMON_H_
 #define _TI_LMU_COMMON_H_
diff --git a/include/linux/platform_data/davinci-cpufreq.h b/include/linux/platform_data/davinci-cpufreq.h
index 3fbf9f2793b5..bc208c64e3d7 100644
--- a/include/linux/platform_data/davinci-cpufreq.h
+++ b/include/linux/platform_data/davinci-cpufreq.h
@@ -2,7 +2,7 @@
 /*
  * TI DaVinci CPUFreq platform support.
  *
- * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments, Inc. https://www.ti.com/
  */
 
 #ifndef _MACH_DAVINCI_CPUFREQ_H
diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 7fe80f1c7e08..5d1fb0d78a22 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -1,7 +1,7 @@
 /*
  * TI DaVinci Audio Serial Port support
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index 0f491d8abfdd..3cc78f0447b1 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -2,7 +2,7 @@
 /*
  * BCH Error Location Module
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __ELM_H
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index a93841bfb9f7..e182a46e609f 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -1,7 +1,7 @@
 /*
  * DaVinci GPIO Platform Related Defines
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
index ef663e570552..c9cc4e32435d 100644
--- a/include/linux/platform_data/gpmc-omap.h
+++ b/include/linux/platform_data/gpmc-omap.h
@@ -2,7 +2,7 @@
 /*
  * OMAP GPMC Platform data
  *
- * Copyright (C) 2014 Texas Instruments, Inc. - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments, Inc. - https://www.ti.com
  *	Roger Quadros <rogerq@ti.com>
  */
 
diff --git a/include/linux/platform_data/mtd-davinci-aemif.h b/include/linux/platform_data/mtd-davinci-aemif.h
index a403dd51dacc..a49826214a39 100644
--- a/include/linux/platform_data/mtd-davinci-aemif.h
+++ b/include/linux/platform_data/mtd-davinci-aemif.h
@@ -1,7 +1,7 @@
 /*
  * TI DaVinci AEMIF support
  *
- * Copyright 2010 (C) Texas Instruments, Inc. http://www.ti.com/
+ * Copyright 2010 (C) Texas Instruments, Inc. https://www.ti.com/
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
index 8419c8caf54e..0dd851ea1c72 100644
--- a/include/linux/platform_data/omap-twl4030.h
+++ b/include/linux/platform_data/omap-twl4030.h
@@ -3,7 +3,7 @@
  * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl4030
  *		    codec, header.
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
  * All rights reserved.
  *
  * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
diff --git a/include/linux/platform_data/uio_pruss.h b/include/linux/platform_data/uio_pruss.h
index 3d47d219827f..31f2e22661bc 100644
--- a/include/linux/platform_data/uio_pruss.h
+++ b/include/linux/platform_data/uio_pruss.h
@@ -3,7 +3,7 @@
  *
  * Platform data for uio_pruss driver
  *
- * Copyright (C) 2010-11 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010-11 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index fa579b4c666b..5e70d667031c 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -1,7 +1,7 @@
 /*
  * usb-omap.h - Platform data for the various OMAP USB IPs
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
  *
  * This software is distributed under the terms of the GNU General Public
  * License ("GPL") version 2, as published by the Free Software Foundation.
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 26f73df0a524..b51385625e8a 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -2,7 +2,7 @@
 /*
  * K3 Ring Accelerator (RA) subsystem interface
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #ifndef __SOC_TI_K3_RINGACC_API_H_
diff --git a/include/linux/soc/ti/knav_qmss.h b/include/linux/soc/ti/knav_qmss.h
index 9745df6ed9d3..c75ef99c99ca 100644
--- a/include/linux/soc/ti/knav_qmss.h
+++ b/include/linux/soc/ti/knav_qmss.h
@@ -1,7 +1,7 @@
 /*
  * Keystone Navigator Queue Management Sub-System header
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  * Author:	Sandeep Nair <sandeep_n@ti.com>
  *		Cyril Chemparathy <cyril@ti.com>
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
diff --git a/include/linux/soc/ti/ti-msgmgr.h b/include/linux/soc/ti/ti-msgmgr.h
index eac8e0c6fe11..1f6e76d423cf 100644
--- a/include/linux/soc/ti/ti-msgmgr.h
+++ b/include/linux/soc/ti/ti-msgmgr.h
@@ -1,7 +1,7 @@
 /*
  * Texas Instruments' Message Manager
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index e497e621dbb7..3f496967b538 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -1,7 +1,7 @@
 /*
  * TI Wakeup M3 for AMx3 SoCs Power Management Routines
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
  * Dave Gerlach <d-gerlach@ti.com>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/include/linux/xxhash.h b/include/linux/xxhash.h
index 52b073fea17f..df42511438d0 100644
--- a/include/linux/xxhash.h
+++ b/include/linux/xxhash.h
@@ -34,7 +34,7 @@
  * ("BSD").
  *
  * You can contact the author at:
- * - xxHash homepage: http://cyan4973.github.io/xxHash/
+ * - xxHash homepage: https://cyan4973.github.io/xxHash/
  * - xxHash source repository: https://github.com/Cyan4973/xxHash
  */
 
diff --git a/include/linux/xz.h b/include/linux/xz.h
index 64cffa6ddfce..257d9be99015 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -2,7 +2,7 @@
  * XZ decompressor
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
- *          Igor Pavlov <http://7-zip.org/>
+ *          Igor Pavlov <https://7-zip.org/>
  *
  * This file has been put into the public domain.
  * You can do whatever you want with this file.
diff --git a/include/linux/zlib.h b/include/linux/zlib.h
index c757d848a758..78ede944c082 100644
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -23,7 +23,7 @@
 
 
   The data format used by the zlib library is described by RFCs (Request for
-  Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt
+  Comments) 1950 to 1952 in the files https://www.ietf.org/rfc/rfc1950.txt
   (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).
 */
 
diff --git a/include/soc/arc/aux.h b/include/soc/arc/aux.h
index e223c4ffa153..9c2eff6140b6 100644
--- a/include/soc/arc/aux.h
+++ b/include/soc/arc/aux.h
@@ -22,7 +22,7 @@ static inline int read_aux_reg(u32 r)
 
 /*
  * function helps elide unused variable warning
- * see: http://lists.infradead.org/pipermail/linux-snps-arc/2016-November/001748.html
+ * see: https://lists.infradead.org/pipermail/linux-snps-arc/2016-November/001748.html
  */
 static inline void write_aux_reg(u32 r, u32 v)
 {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c6dd0215482e..22220945a5fd 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -53,7 +53,7 @@ typedef __s64	Elf64_Sxword;
  *
  * - Oracle: Linker and Libraries.
  *   Part No: 817–1984–19, August 2011.
- *   http://docs.oracle.com/cd/E18752_01/pdf/817-1984.pdf
+ *   https://docs.oracle.com/cd/E18752_01/pdf/817-1984.pdf
  *
  * - System V ABI AMD64 Architecture Processor Supplement
  *   Draft Version 0.99.4,
diff --git a/include/uapi/linux/map_to_7segment.h b/include/uapi/linux/map_to_7segment.h
index f9ed18134b83..13a06e5e966e 100644
--- a/include/uapi/linux/map_to_7segment.h
+++ b/include/uapi/linux/map_to_7segment.h
@@ -24,7 +24,7 @@
  * of (ASCII) characters to a 7-segments notation.
  *
  * The 7 segment's wikipedia notation below is used as standard.
- * See: http://en.wikipedia.org/wiki/Seven_segment_display
+ * See: https://en.wikipedia.org/wiki/Seven_segment_display
  *
  * Notation:	+-a-+
  *		f   b
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 2fce8b6876e9..f6d2f83cbe29 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -7,7 +7,7 @@
 #ifndef __ASSEMBLY__
 #ifndef	__KERNEL__
 #ifndef __EXPORTED_HEADERS__
-#warning "Attempt to use kernel headers from user space, see http://kernelnewbies.org/KernelHeaders"
+#warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders"
 #endif /* __EXPORTED_HEADERS__ */
 #endif
 
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 2b623f36af6b..11e5dd2dcc98 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -1222,7 +1222,7 @@ struct usb_set_sel_req {
  * As per USB compliance update, a device that is actively drawing
  * more than 100mA from USB must report itself as bus-powered in
  * the GetStatus(DEVICE) call.
- * http://compliance.usb.org/index.asp?UpdateFile=Electrical&Format=Standard#34
+ * https://compliance.usb.org/index.asp?UpdateFile=Electrical&Format=Standard#34
  */
 #define USB_SELF_POWER_VBUS_MAX_DRAW		100
 
-- 
2.27.0

