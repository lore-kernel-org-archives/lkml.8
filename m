Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5266BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25E1206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738988;
	bh=eC8+pdiOP0SN41WUeXwn8RHaqXAyWuLR/6yLOdAxbuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uO6CwW7N0yWXS3KVkf6WQ1QN/tLDRIjiHvDwbkBoJtR0yBbQ8q/w+9WUUx2C/Cwo6
	 q13SLQMswgClVxdm1IhL5cwbFERePh5FrIaNOqNOagNXUgZ28xST5LNOZgseKj+Ala
	 2tAQ54ByqVcRtm1sHrh9qsb4MwCOurQPd7A28eLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgHFSgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgHFSgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459DD22D72;
        Thu,  6 Aug 2020 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738167;
        bh=eC8+pdiOP0SN41WUeXwn8RHaqXAyWuLR/6yLOdAxbuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHn+t9EEdJVdosmd7F/izmV/f/BVJ2cqpO/rOXPJA+hkWnTb+ZcHGrmO09n3zqq00
         cEZgOxnbH50Oz/fzhKpLLQL6S+SfioSMmFDm6iI8IBuS9MA7Eev/PZZ7uyPmHDHbnC
         Kp5ilhF0X14zo6b3c/21m8qfQP2BgvBkw8gI1mIY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 17/41] ARM: s5pv210: use private pm save/restore
Date:   Thu,  6 Aug 2020 20:20:34 +0200
Message-Id: <20200806182059.2431-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The pm save/restore code is fairly small, so in order to
separate the s3c and s5p platforms, adding an s5p specific
copy instead of sharing it is actually easier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s5pv210/Makefile     |  7 -----
 arch/arm/mach-s5pv210/pm.c         | 45 ++++++++++++++++++++++++++++--
 arch/arm/mach-s5pv210/regs-clock.h |  4 ++-
 arch/arm/mach-s5pv210/s5pv210.c    |  2 --
 arch/arm/plat-samsung/Makefile     |  3 +-
 5 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index e7b551e18e5c..aa0a1f091daf 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -3,12 +3,5 @@
 # Copyright (c) 2010 Samsung Electronics Co., Ltd.
 # 		http://www.samsung.com/
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/arch/arm/plat-samsung/include
-
-# Core
-
 obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
-
-# machine support
-
 obj-y				+= s5pv210.o
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index efdb5a27c060..d59c094cdea8 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -13,15 +13,56 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 #include "regs-clock.h"
 
+/* helper functions to save and restore register state */
+struct sleep_save {
+	void __iomem	*reg;
+	unsigned long	val;
+};
+
+#define SAVE_ITEM(x) \
+	{ .reg = (x) }
+
+/**
+ * s3c_pm_do_save() - save a set of registers for restoration on resume.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Run through the list of registers given, saving their contents in the
+ * array for later restoration when we wakeup.
+ */
+static void s3c_pm_do_save(struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++) {
+		ptr->val = readl_relaxed(ptr->reg);
+		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
+	}
+}
+
+/**
+ * s3c_pm_do_restore() - restore register values from the save list.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Restore the register values saved from s3c_pm_do_save().
+ *
+ * WARNING: Do not put any debug in here that may effect memory or use
+ * peripherals, as things may be changing!
+*/
+
+static void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++)
+		writel_relaxed(ptr->val, ptr->reg);
+}
+
 static struct sleep_save s5pv210_core_save[] = {
 	/* Clock ETC */
 	SAVE_ITEM(S5P_MDNIE_SEL),
diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
index 2a35c831a9b0..9cad2306e470 100644
--- a/arch/arm/mach-s5pv210/regs-clock.h
+++ b/arch/arm/mach-s5pv210/regs-clock.h
@@ -9,7 +9,9 @@
 #ifndef __ASM_ARCH_REGS_CLOCK_H
 #define __ASM_ARCH_REGS_CLOCK_H __FILE__
 
-#include <plat/map-base.h>
+#define S3C_ADDR_BASE		0xF6000000
+#define S3C_ADDR(x)		((void __iomem __force *)S3C_ADDR_BASE + (x))
+#define S3C_VA_SYS		S3C_ADDR(0x00100000)
 
 #define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
 
diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index 868f9c20419d..a21ed3bb992a 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -13,8 +13,6 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 
-#include <plat/map-base.h>
-
 #include "common.h"
 #include "regs-clock.h"
 
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index c47f58ed83e2..feddb42cae51 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -24,8 +24,7 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
 
 # PM support
 
-obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
-obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
+obj-$(CONFIG_SAMSUNG_PM)	+= pm.o pm-common.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
-- 
2.17.1

