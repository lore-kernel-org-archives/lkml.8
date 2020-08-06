Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F9A22C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739097;
	bh=hAZLCO5WhHq3DyAI5oEkcdHEncWOCsm/3pyKHSow4CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZffucxthPf1DN63h/2CJ1LWVXtUemmENMq354IBtkds3rJ6HEQxQK8AuHpbewfyYJ
	 KMhWUUFZVlsBkjdS8Fh5scrZI2JGUhDt28gyJIj4YqOponM5+t5ghqox/eWc3VkyAB
	 SzfGERsmRSehL5+yuePp1z3xAd7FdkyZwSKvdDVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgHFSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgHFSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C31922D6E;
        Thu,  6 Aug 2020 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738158;
        bh=hAZLCO5WhHq3DyAI5oEkcdHEncWOCsm/3pyKHSow4CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i20+XqhKqtkDacJuZspJ6tcG7ONKYaXHJ/0mWgWzYxb44M1KnkLYqtAkpvIiqjTYb
         4xBjxyKnTv3bP25MrP47ED+Wx+HnPJznrYf9243U7YSpPhqwv4V7LAEqZppaDGonQw
         kgr1A6QuuhUczhF1GiC/Iyf2rRZKhcz6SEeDHuM0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 16/41] ARM: samsung: move pm check code to drivers/soc
Date:   Thu,  6 Aug 2020 20:20:33 +0200
Message-Id: <20200806182059.2431-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is the only part of plat-samsung that is really
shared between the s3c and s5p ports. Moving it to
drivers/soc/ lets us make them completely independent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s5pv210/Kconfig                 |  1 +
 arch/arm/plat-samsung/Kconfig                 | 49 +----------
 arch/arm/plat-samsung/Makefile                |  2 -
 .../arm/plat-samsung/include/plat/pm-common.h | 70 +---------------
 drivers/soc/samsung/Kconfig                   | 48 ++++++++++-
 drivers/soc/samsung/Makefile                  |  3 +
 .../soc/samsung/s3c-pm-check.c                |  2 +-
 .../soc/samsung/s3c-pm-debug.c                |  3 +-
 include/linux/soc/samsung/s3c-pm.h            | 84 +++++++++++++++++++
 9 files changed, 139 insertions(+), 123 deletions(-)
 rename arch/arm/plat-samsung/pm-check.c => drivers/soc/samsung/s3c-pm-check.c (99%)
 rename arch/arm/plat-samsung/pm-debug.c => drivers/soc/samsung/s3c-pm-debug.c (97%)
 create mode 100644 include/linux/soc/samsung/s3c-pm.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index b3db1191e437..95d4e8284866 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -17,6 +17,7 @@ config ARCH_S5PV210
 	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
 	select PINCTRL_EXYNOS
+	select SOC_SAMSUNG
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 920931c3fefd..a7cb0db1d5cc 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -8,6 +8,7 @@ config PLAT_SAMSUNG
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
+	select SOC_SAMSUNG
 	help
 	  Base platform code for all Samsung SoC based systems
 
@@ -234,54 +235,6 @@ config SAMSUNG_PM_GPIO
 	  pinctrl-samsung driver.
 endif
 
-comment "Power management"
-
-config SAMSUNG_PM_DEBUG
-	bool "Samsung PM Suspend debug"
-	depends on PM && DEBUG_KERNEL
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
-	help
-	  Say Y here if you want verbose debugging from the PM Suspend and
-	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
-	  for more information.
-
-config S3C_PM_DEBUG_LED_SMDK
-       bool "SMDK LED suspend/resume debugging"
-       depends on PM && (MACH_SMDK6410)
-       help
-         Say Y here to enable the use of the SMDK LEDs on the baseboard
-	 for debugging of the state of the suspend and resume process.
-
-	 Note, this currently only works for S3C64XX based SMDK boards.
-
-config SAMSUNG_PM_CHECK
-	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
-	select CRC32
-	help
-	  Enable the PM code's memory area checksum over sleep. This option
-	  will generate CRCs of all blocks of memory, and store them before
-	  going to sleep. The blocks are then checked on resume for any
-	  errors.
-
-	  Note, this can take several seconds depending on memory size
-	  and CPU speed.
-
-	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
-
-config SAMSUNG_PM_CHECK_CHUNKSIZE
-	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
-	depends on PM && SAMSUNG_PM_CHECK
-	default 64
-	help
-	  Set the chunksize in Kilobytes of the CRC for checking memory
-	  corruption over suspend and resume. A smaller value will mean that
-	  the CRC data block will take more memory, but will identify any
-	  faults with better precision.
-
-	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
-
 config SAMSUNG_WAKEMASK
 	bool
 	depends on PM
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index d8a80fbcebb3..c47f58ed83e2 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -27,7 +27,5 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
 obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
 obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
-obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
-obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= pm-debug.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index 87fa97fd6e8b..18b9607e1e39 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -11,6 +11,7 @@
 #define __PLAT_SAMSUNG_PM_COMMON_H __FILE__
 
 #include <linux/irq.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 /* sleep save info */
 
@@ -36,73 +37,4 @@ extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
 extern void s3c_pm_do_restore(const struct sleep_save *ptr, int count);
 extern void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count);
 
-/* PM debug functions */
-
-/**
- * struct pm_uart_save - save block for core UART
- * @ulcon: Save value for S3C2410_ULCON
- * @ucon: Save value for S3C2410_UCON
- * @ufcon: Save value for S3C2410_UFCON
- * @umcon: Save value for S3C2410_UMCON
- * @ubrdiv: Save value for S3C2410_UBRDIV
- *
- * Save block for UART registers to be held over sleep and restored if they
- * are needed (say by debug).
-*/
-struct pm_uart_save {
-	u32	ulcon;
-	u32	ucon;
-	u32	ufcon;
-	u32	umcon;
-	u32	ubrdiv;
-	u32	udivslot;
-};
-
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-/**
- * s3c_pm_dbg() - low level debug function for use in suspend/resume.
- * @msg: The message to print.
- *
- * This function is used mainly to debug the resume process before the system
- * can rely on printk/console output. It uses the low-level debugging output
- * routine printascii() to do its work.
- */
-extern void s3c_pm_dbg(const char *msg, ...);
-
-#define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
-
-extern void s3c_pm_save_uarts(bool is_s3c24xx);
-extern void s3c_pm_restore_uarts(bool is_s3c24xx);
-
-#ifdef CONFIG_ARCH_S3C64XX
-extern void s3c_pm_arch_update_uart(void __iomem *regs,
-				    struct pm_uart_save *save);
-#else
-static inline void
-s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
-{
-}
-#endif
-
-#else
-#define S3C_PMDBG(fmt...) pr_debug(fmt)
-
-static inline void s3c_pm_save_uarts(bool is_s3c24xx) { }
-static inline void s3c_pm_restore_uarts(bool is_s3c24xx) { }
-#endif
-
-/* suspend memory checking */
-
-#ifdef CONFIG_SAMSUNG_PM_CHECK
-extern void s3c_pm_check_prepare(void);
-extern void s3c_pm_check_restore(void);
-extern void s3c_pm_check_cleanup(void);
-extern void s3c_pm_check_store(void);
-#else
-#define s3c_pm_check_prepare() do { } while (0)
-#define s3c_pm_check_restore() do { } while (0)
-#define s3c_pm_check_cleanup() do { } while (0)
-#define s3c_pm_check_store()   do { } while (0)
-#endif
-
 #endif
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 264185664594..5abe82079d2e 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -35,7 +35,53 @@ config EXYNOS_PMU_ARM_DRIVERS
 
 config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
-	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
+	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
+
+config SAMSUNG_PM_DEBUG
+	bool "Samsung PM Suspend debug"
+	depends on PM && DEBUG_KERNEL
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
+	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
+	help
+	  Say Y here if you want verbose debugging from the PM Suspend and
+	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
+	  for more information.
+
+config S3C_PM_DEBUG_LED_SMDK
+       bool "SMDK LED suspend/resume debugging"
+       depends on PM && (MACH_SMDK6410)
+       help
+         Say Y here to enable the use of the SMDK LEDs on the baseboard
+	 for debugging of the state of the suspend and resume process.
+
+	 Note, this currently only works for S3C64XX based SMDK boards.
+
+config SAMSUNG_PM_CHECK
+	bool "S3C2410 PM Suspend Memory CRC"
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
+	select CRC32
+	help
+	  Enable the PM code's memory area checksum over sleep. This option
+	  will generate CRCs of all blocks of memory, and store them before
+	  going to sleep. The blocks are then checked on resume for any
+	  errors.
+
+	  Note, this can take several seconds depending on memory size
+	  and CPU speed.
+
+	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
+
+config SAMSUNG_PM_CHECK_CHUNKSIZE
+	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
+	depends on PM && SAMSUNG_PM_CHECK
+	default 64
+	help
+	  Set the chunksize in Kilobytes of the CRC for checking memory
+	  corruption over suspend and resume. A smaller value will mean that
+	  the CRC data block will take more memory, but will identify any
+	  faults with better precision.
+
+	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
 
 config EXYNOS_REGULATOR_COUPLER
 	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index ecc3a32f6406..59e8e9453f27 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -10,3 +10,6 @@ obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
 obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
+
+obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o
+obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= s3c-pm-debug.o
diff --git a/arch/arm/plat-samsung/pm-check.c b/drivers/soc/samsung/s3c-pm-check.c
similarity index 99%
rename from arch/arm/plat-samsung/pm-check.c
rename to drivers/soc/samsung/s3c-pm-check.c
index cd2c02c68bc3..ff3e099fc208 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/drivers/soc/samsung/s3c-pm-check.c
@@ -15,7 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 
-#include <plat/pm-common.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #if CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE < 1
 #error CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE must be a positive non-zero value
diff --git a/arch/arm/plat-samsung/pm-debug.c b/drivers/soc/samsung/s3c-pm-debug.c
similarity index 97%
rename from arch/arm/plat-samsung/pm-debug.c
rename to drivers/soc/samsung/s3c-pm-debug.c
index 482d53753e93..b5ce0e9a41e5 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/drivers/soc/samsung/s3c-pm-debug.c
@@ -15,8 +15,7 @@
 
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
-#include <plat/pm-common.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 static struct pm_uart_save uart_save;
 
diff --git a/include/linux/soc/samsung/s3c-pm.h b/include/linux/soc/samsung/s3c-pm.h
new file mode 100644
index 000000000000..730bd1d3d09a
--- /dev/null
+++ b/include/linux/soc/samsung/s3c-pm.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *	Tomasz Figa <t.figa@samsung.com>
+ * Copyright (c) 2004 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Written by Ben Dooks, <ben@simtec.co.uk>
+ */
+
+#ifndef __LINUX_SOC_SAMSUNG_S3C_PM_H
+#define __LINUX_SOC_SAMSUNG_S3C_PM_H __FILE__
+
+#include <linux/types.h>
+
+/* PM debug functions */
+
+/**
+ * struct pm_uart_save - save block for core UART
+ * @ulcon: Save value for S3C2410_ULCON
+ * @ucon: Save value for S3C2410_UCON
+ * @ufcon: Save value for S3C2410_UFCON
+ * @umcon: Save value for S3C2410_UMCON
+ * @ubrdiv: Save value for S3C2410_UBRDIV
+ *
+ * Save block for UART registers to be held over sleep and restored if they
+ * are needed (say by debug).
+*/
+struct pm_uart_save {
+	u32	ulcon;
+	u32	ucon;
+	u32	ufcon;
+	u32	umcon;
+	u32	ubrdiv;
+	u32	udivslot;
+};
+
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
+/**
+ * s3c_pm_dbg() - low level debug function for use in suspend/resume.
+ * @msg: The message to print.
+ *
+ * This function is used mainly to debug the resume process before the system
+ * can rely on printk/console output. It uses the low-level debugging output
+ * routine printascii() to do its work.
+ */
+extern void s3c_pm_dbg(const char *msg, ...);
+
+#define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
+
+extern void s3c_pm_save_uarts(bool is_s3c24xx);
+extern void s3c_pm_restore_uarts(bool is_s3c24xx);
+
+#ifdef CONFIG_ARCH_S3C64XX
+extern void s3c_pm_arch_update_uart(void __iomem *regs,
+				    struct pm_uart_save *save);
+#else
+static inline void
+s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
+{
+}
+#endif
+
+#else
+#define S3C_PMDBG(fmt...) pr_debug(fmt)
+
+static inline void s3c_pm_save_uarts(bool is_s3c24xx) { }
+static inline void s3c_pm_restore_uarts(bool is_s3c24xx) { }
+#endif
+
+/* suspend memory checking */
+
+#ifdef CONFIG_SAMSUNG_PM_CHECK
+extern void s3c_pm_check_prepare(void);
+extern void s3c_pm_check_restore(void);
+extern void s3c_pm_check_cleanup(void);
+extern void s3c_pm_check_store(void);
+#else
+#define s3c_pm_check_prepare() do { } while (0)
+#define s3c_pm_check_restore() do { } while (0)
+#define s3c_pm_check_cleanup() do { } while (0)
+#define s3c_pm_check_store()   do { } while (0)
+#endif
+
+#endif
-- 
2.17.1

