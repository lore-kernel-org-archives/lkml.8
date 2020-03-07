Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BADC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9E2206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583577780;
	bh=pLNRX4IAg2dIEiox39DRnwsJniRxkH1/HhQensmtgdM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uvyLRG0EFMLAkQZq9sdGSoDSpnAlM5dVcfKmMJ4vrAR2o0zflUaGokPKsQPsJ8yVM
	 goIIE7wNDVz5VcO42kXQ0e5aqoPTMknswtD+6vUuwyY/QiFoirU/7j4gUkj14td1lf
	 6tmboaRReUI3wg7+yv5TOHehGE5wqM7dY3rAluZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGKm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCGKm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:42:58 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8D1206D5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Mar 2020 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583577777;
        bh=pLNRX4IAg2dIEiox39DRnwsJniRxkH1/HhQensmtgdM=;
        h=From:To:Cc:Subject:Date:From;
        b=oNZkJAhK36ICt9LxmAi8+M1+3NQVSP3Y1CuAWxkzWSmtmrYnzvoEQuYd2f0NAscMX
         3nEftn659oMjEwiEADQTq0iIXFL9XgkD0ObfJWCVZdNkgnSs0RJiM/OA++VAuhw/ga
         0OVkS2wIneAvV+bDNhwhvpJROhNsjSjUWF+m8BiI=
Received: by pali.im (Postfix)
        id EE4D011A1; Sat,  7 Mar 2020 11:42:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] =?UTF-8?q?Change=20email=20address=20for=20Pali=20Roh?= =?UTF-8?q?=C3=A1r?=
Date:   Sat,  7 Mar 2020 11:42:37 +0100
Message-Id: <20200307104237.8199-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security reasons I stopped using gmail account and kernel address is
now up-to-date alias to my personal address.

People periodically send me emails to address which they found in source
code of drivers, so this change reflects state where people can contact me.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../ABI/testing/sysfs-platform-dell-laptop       |  8 ++++----
 MAINTAINERS                                      | 16 ++++++++--------
 arch/arm/mach-omap2/omap-secure.c                |  2 +-
 arch/arm/mach-omap2/omap-secure.h                |  2 +-
 arch/arm/mach-omap2/omap-smc.S                   |  2 +-
 drivers/char/hw_random/omap3-rom-rng.c           |  4 ++--
 drivers/hwmon/dell-smm-hwmon.c                   |  4 ++--
 drivers/platform/x86/dell-laptop.c               |  4 ++--
 drivers/platform/x86/dell-rbtn.c                 |  4 ++--
 drivers/platform/x86/dell-rbtn.h                 |  2 +-
 drivers/platform/x86/dell-smbios-base.c          |  4 ++--
 drivers/platform/x86/dell-smbios-smm.c           |  2 +-
 drivers/platform/x86/dell-smbios.h               |  2 +-
 drivers/platform/x86/dell-smo8800.c              |  2 +-
 drivers/platform/x86/dell-wmi.c                  |  4 ++--
 drivers/power/supply/bq2415x_charger.c           |  4 ++--
 drivers/power/supply/bq27xxx_battery.c           |  2 +-
 drivers/power/supply/isp1704_charger.c           |  2 +-
 drivers/power/supply/rx51_battery.c              |  4 ++--
 fs/udf/ecma_167.h                                |  2 +-
 fs/udf/osta_udf.h                                |  2 +-
 include/linux/power/bq2415x_charger.h            |  2 +-
 tools/laptop/freefall/freefall.c                 |  2 +-
 23 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dell-laptop b/Documentation/ABI/testing/sysfs-platform-dell-laptop
index 8c6a0b8e1131..9b917c7453de 100644
--- a/Documentation/ABI/testing/sysfs-platform-dell-laptop
+++ b/Documentation/ABI/testing/sysfs-platform-dell-laptop
@@ -2,7 +2,7 @@ What:		/sys/class/leds/dell::kbd_backlight/als_enabled
 Date:		December 2014
 KernelVersion:	3.19
 Contact:	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
-		Pali Rohár <pali.rohar@gmail.com>
+		Pali Rohár <pali@kernel.org>
 Description:
 		This file allows to control the automatic keyboard
 		illumination mode on some systems that have an ambient
@@ -13,7 +13,7 @@ What:		/sys/class/leds/dell::kbd_backlight/als_setting
 Date:		December 2014
 KernelVersion:	3.19
 Contact:	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
-		Pali Rohár <pali.rohar@gmail.com>
+		Pali Rohár <pali@kernel.org>
 Description:
 		This file allows to specifiy the on/off threshold value,
 		as reported by the ambient light sensor.
@@ -22,7 +22,7 @@ What:		/sys/class/leds/dell::kbd_backlight/start_triggers
 Date:		December 2014
 KernelVersion:	3.19
 Contact:	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
-		Pali Rohár <pali.rohar@gmail.com>
+		Pali Rohár <pali@kernel.org>
 Description:
 		This file allows to control the input triggers that
 		turn on the keyboard backlight illumination that is
@@ -45,7 +45,7 @@ What:		/sys/class/leds/dell::kbd_backlight/stop_timeout
 Date:		December 2014
 KernelVersion:	3.19
 Contact:	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
-		Pali Rohár <pali.rohar@gmail.com>
+		Pali Rohár <pali@kernel.org>
 Description:
 		This file allows to specify the interval after which the
 		keyboard illumination is disabled because of inactivity.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..e8ebc20e18f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,7 +726,7 @@ L:	linux-alpha@vger.kernel.org
 F:	arch/alpha/
 
 ALPS PS/2 TOUCHPAD DRIVER
-R:	Pali Rohár <pali.rohar@gmail.com>
+R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
 ALTERA I2C CONTROLLER DRIVER
@@ -4725,7 +4725,7 @@ F:	drivers/media/platform/sunxi/sun8i-di/
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-h3-deinterlace.yaml
 
 DELL SMBIOS DRIVER
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 M:	Mario Limonciello <mario.limonciello@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -4751,18 +4751,18 @@ F:	drivers/net/fddi/defza.*
 
 DELL LAPTOP DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/dell-laptop.c
 
 DELL LAPTOP FREEFALL DRIVER
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell-smo8800.c
 
 DELL LAPTOP RBTN DRIVER
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell-rbtn.*
 
@@ -4773,7 +4773,7 @@ S:	Maintained
 F:	drivers/platform/x86/dell_rbu.c
 
 DELL LAPTOP SMM DRIVER
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	drivers/hwmon/dell-smm-hwmon.c
 F:	include/uapi/linux/i8k.h
@@ -4787,7 +4787,7 @@ F:	drivers/platform/x86/dcdbas.*
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-M:	Pali Rohár <pali.rohar@gmail.com>
+M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell-wmi.c
 
@@ -11838,7 +11838,7 @@ F:	drivers/media/i2c/et8ek8
 F:	drivers/media/i2c/ad5820.c
 
 NOKIA N900 POWER SUPPLY DRIVERS
-R:	Pali Rohár <pali.rohar@gmail.com>
+R:	Pali Rohár <pali@kernel.org>
 F:	include/linux/power/bq2415x_charger.h
 F:	include/linux/power/bq27xxx_battery.h
 F:	drivers/power/supply/bq2415x_charger.c
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d00e3c72e37d..f70d561f37f7 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011 Texas Instruments, Inc.
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
  * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
- * Copyright (C) 2013 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2013 Pali Rohár <pali@kernel.org>
  */
 
 #include <linux/arm-smccc.h>
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index ba8c486c0454..4aaa95706d39 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2011 Texas Instruments, Inc.
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
  * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
- * Copyright (C) 2013 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2013 Pali Rohár <pali@kernel.org>
  */
 #ifndef OMAP_ARCH_OMAP_SECURE_H
 #define OMAP_ARCH_OMAP_SECURE_H
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
index d4832845a4e8..7376f528034d 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -6,7 +6,7 @@
  * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
- * Copyright (C) 2013 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2013 Pali Rohár <pali@kernel.org>
  */
 
 #include <linux/linkage.h>
diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index e08a8887e718..67ef794ccabf 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2009 Nokia Corporation
  * Author: Juha Yrjola <juha.yrjola@solidboot.com>
  *
- * Copyright (C) 2013 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2013 Pali Rohár <pali@kernel.org>
  *
  * This file is licensed under  the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -177,5 +177,5 @@ module_platform_driver(omap3_rom_rng_driver);
 
 MODULE_ALIAS("platform:omap3-rom-rng");
 MODULE_AUTHOR("Juha Yrjola");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index d4c83009d625..ab719d372b0d 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -7,7 +7,7 @@
  * Hwmon integration:
  * Copyright (C) 2011  Jean Delvare <jdelvare@suse.de>
  * Copyright (C) 2013, 2014  Guenter Roeck <linux@roeck-us.net>
- * Copyright (C) 2014, 2015  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2014, 2015  Pali Rohár <pali@kernel.org>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -86,7 +86,7 @@ static unsigned int auto_fan;
 #define I8K_HWMON_HAVE_FAN3	(1 << 12)
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("i8k");
diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 74e988f839e8..f8d3e3bd1bb5 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (c) Red Hat <mjg@redhat.com>
  *  Copyright (c) 2014 Gabriele Mazzotta <gabriele.mzt@gmail.com>
- *  Copyright (c) 2014 Pali Rohár <pali.rohar@gmail.com>
+ *  Copyright (c) 2014 Pali Rohár <pali@kernel.org>
  *
  *  Based on documentation in the libsmbios package:
  *  Copyright (C) 2005-2014 Dell Inc.
@@ -2295,6 +2295,6 @@ module_exit(dell_exit);
 
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Dell laptop driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-rbtn.c b/drivers/platform/x86/dell-rbtn.c
index a6b856cd86bd..a89fad47ff13 100644
--- a/drivers/platform/x86/dell-rbtn.c
+++ b/drivers/platform/x86/dell-rbtn.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
     Dell Airplane Mode Switch driver
-    Copyright (C) 2014-2015  Pali Rohár <pali.rohar@gmail.com>
+    Copyright (C) 2014-2015  Pali Rohár <pali@kernel.org>
 
 */
 
@@ -495,5 +495,5 @@ MODULE_PARM_DESC(auto_remove_rfkill, "Automatically remove rfkill devices when "
 				     "(default true)");
 MODULE_DEVICE_TABLE(acpi, rbtn_ids);
 MODULE_DESCRIPTION("Dell Airplane Mode Switch driver");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-rbtn.h b/drivers/platform/x86/dell-rbtn.h
index 0fdc81644458..5e030f926c58 100644
--- a/drivers/platform/x86/dell-rbtn.h
+++ b/drivers/platform/x86/dell-rbtn.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
     Dell Airplane Mode Switch driver
-    Copyright (C) 2014-2015  Pali Rohár <pali.rohar@gmail.com>
+    Copyright (C) 2014-2015  Pali Rohár <pali@kernel.org>
 
 */
 
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index fe59b0ebff31..2e2cd565926a 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (c) Red Hat <mjg@redhat.com>
  *  Copyright (c) 2014 Gabriele Mazzotta <gabriele.mzt@gmail.com>
- *  Copyright (c) 2014 Pali Rohár <pali.rohar@gmail.com>
+ *  Copyright (c) 2014 Pali Rohár <pali@kernel.org>
  *
  *  Based on documentation in the libsmbios package:
  *  Copyright (C) 2005-2014 Dell Inc.
@@ -645,7 +645,7 @@ module_exit(dell_smbios_exit);
 
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Common functions for kernel modules using Dell SMBIOS");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
index d6854d1c4119..97c52a839a3e 100644
--- a/drivers/platform/x86/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell-smbios-smm.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (c) Red Hat <mjg@redhat.com>
  *  Copyright (c) 2014 Gabriele Mazzotta <gabriele.mzt@gmail.com>
- *  Copyright (c) 2014 Pali Rohár <pali.rohar@gmail.com>
+ *  Copyright (c) 2014 Pali Rohár <pali@kernel.org>
  *  Copyright (c) 2017 Dell Inc.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index a7ff9803f41a..75fa8ea0476d 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -4,7 +4,7 @@
  *
  *  Copyright (c) Red Hat <mjg@redhat.com>
  *  Copyright (c) 2014 Gabriele Mazzotta <gabriele.mzt@gmail.com>
- *  Copyright (c) 2014 Pali Rohár <pali.rohar@gmail.com>
+ *  Copyright (c) 2014 Pali Rohár <pali@kernel.org>
  *
  *  Based on documentation in the libsmbios package:
  *  Copyright (C) 2005-2014 Dell Inc.
diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/dell-smo8800.c
index bfcc1d1b9b96..b96ea6142290 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -3,7 +3,7 @@
  *  dell-smo8800.c - Dell Latitude ACPI SMO88XX freefall sensor driver
  *
  *  Copyright (C) 2012 Sonal Santan <sonal.santan@gmail.com>
- *  Copyright (C) 2014 Pali Rohár <pali.rohar@gmail.com>
+ *  Copyright (C) 2014 Pali Rohár <pali@kernel.org>
  *
  *  This is loosely based on lis3lv02d driver.
  */
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 6669db2555fb..86e8dd6a8b33 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -3,7 +3,7 @@
  * Dell WMI hotkeys
  *
  * Copyright (C) 2008 Red Hat <mjg@redhat.com>
- * Copyright (C) 2014-2015 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2014-2015 Pali Rohár <pali@kernel.org>
  *
  * Portions based on wistron_btns.c:
  * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
@@ -29,7 +29,7 @@
 #include "dell-wmi-descriptor.h"
 
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Dell laptop WMI hotkeys driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 532f6e4fcafb..a1f00ae1c180 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -2,7 +2,7 @@
 /*
  * bq2415x charger driver
  *
- * Copyright (C) 2011-2013  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2011-2013  Pali Rohár <pali@kernel.org>
  *
  * Datasheets:
  * http://www.ti.com/product/bq24150
@@ -1788,6 +1788,6 @@ static struct i2c_driver bq2415x_driver = {
 };
 module_i2c_driver(bq2415x_driver);
 
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("bq2415x charger driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 195c18c2f426..ba698b0af0ad 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2008 Rodolfo Giometti <giometti@linux.it>
  * Copyright (C) 2008 Eurotech S.p.A. <info@eurotech.it>
  * Copyright (C) 2010-2011 Lars-Peter Clausen <lars@metafoo.de>
- * Copyright (C) 2011 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2011 Pali Rohár <pali@kernel.org>
  * Copyright (C) 2017 Liam Breck <kernel@networkimprov.net>
  *
  * Based on a previous work by Copyright (C) 2008 Texas Instruments, Inc.
diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 4812ac1ff2df..b6efc454e4f0 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -3,7 +3,7 @@
  * ISP1704 USB Charger Detection driver
  *
  * Copyright (C) 2010 Nokia Corporation
- * Copyright (C) 2012 - 2013 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2012 - 2013 Pali Rohár <pali@kernel.org>
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index 8548b639ff2f..6e488ecf4dcb 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -2,7 +2,7 @@
 /*
  * Nokia RX-51 battery driver
  *
- * Copyright (C) 2012  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2012  Pali Rohár <pali@kernel.org>
  */
 
 #include <linux/module.h>
@@ -278,6 +278,6 @@ static struct platform_driver rx51_battery_driver = {
 module_platform_driver(rx51_battery_driver);
 
 MODULE_ALIAS("platform:rx51-battery");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Nokia RX-51 battery driver");
 MODULE_LICENSE("GPL");
diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 3fd85464abd5..736ebc5dc441 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -5,7 +5,7 @@
  * http://www.ecma.ch
  *
  * Copyright (c) 2001-2002  Ben Fennema
- * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (c) 2017-2019  Pali Rohár <pali@kernel.org>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
index 35e61b2cacfe..d5fbfab3ddb6 100644
--- a/fs/udf/osta_udf.h
+++ b/fs/udf/osta_udf.h
@@ -5,7 +5,7 @@
  * http://www.osta.org
  *
  * Copyright (c) 2001-2004  Ben Fennema
- * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (c) 2017-2019  Pali Rohár <pali@kernel.org>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/linux/power/bq2415x_charger.h b/include/linux/power/bq2415x_charger.h
index 7a91b357e3ac..4ca08321e251 100644
--- a/include/linux/power/bq2415x_charger.h
+++ b/include/linux/power/bq2415x_charger.h
@@ -2,7 +2,7 @@
 /*
  * bq2415x charger driver
  *
- * Copyright (C) 2011-2013  Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2011-2013  Pali Rohár <pali@kernel.org>
  */
 
 #ifndef BQ2415X_CHARGER_H
diff --git a/tools/laptop/freefall/freefall.c b/tools/laptop/freefall/freefall.c
index d29a86cda87f..d77d7861787c 100644
--- a/tools/laptop/freefall/freefall.c
+++ b/tools/laptop/freefall/freefall.c
@@ -4,7 +4,7 @@
  * Copyright 2008 Eric Piel
  * Copyright 2009 Pavel Machek <pavel@ucw.cz>
  * Copyright 2012 Sonal Santan
- * Copyright 2014 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright 2014 Pali Rohár <pali@kernel.org>
  */
 
 #include <stdio.h>
-- 
2.20.1

