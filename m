Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6546920724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895516;
	bh=VskZVlzCVfwcrdujhoR+9SV47TmDUZYlg12JJaEiP3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsVX5JzIx1in0JtmsXma4fF4WCq0ZuRAilISZrCKFL/WHfJZN/IxVKImE7CcE1KpW
	 VF52lVVhL24ABc3SxsVOLo+/TKpaZRfhUgcT1hJtVIhFebpVcmHYLpQkhHbodGEEZa
	 RPDyUHvamca+b06JNycYsrYlg0Uv1AwLHnD1+b4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgFWG6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbgFWG6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:12 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5352207D0;
        Tue, 23 Jun 2020 06:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895491;
        bh=VskZVlzCVfwcrdujhoR+9SV47TmDUZYlg12JJaEiP3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtvVfpKfrXUDnGVY4S6gaM6KXlQg0Yqj2hsLF5/bluuEA2HLLAfDWPINjnL6sPU9E
         iHdTYNrnb7i3m24CFxb6q28l2bRtgqUHjqvwNbAQu0RpvnegpehmHFntMWGngZloBe
         CRDCfdNCQVDDEeypr9tByGLvRYFLXs4Bc8J4EFF0=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 7/8] rtc: remove fb-puv3  driver
Date:   Tue, 23 Jun 2020 09:57:43 +0300
Message-Id: <20200623065744.18393-8-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
References: <20200623065744.18393-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The unicore32 port is removed from the kernel.
There is no point to keep stale RTC driver for this architecture.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 MAINTAINERS            |   1 -
 drivers/rtc/Kconfig    |   9 --
 drivers/rtc/Makefile   |   1 -
 drivers/rtc/rtc-puv3.c | 286 -----------------------------------------
 4 files changed, 297 deletions(-)
 delete mode 100644 drivers/rtc/rtc-puv3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b0da9ee8c027..f347469e4891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13585,7 +13585,6 @@ M:	Guan Xuetao <gxt@pku.edu.cn>
 S:	Maintained
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 T:	git git://github.com/gxt/linux.git
-F:	drivers/rtc/rtc-puv3.c
 
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b54d87d45c89..f3b8e6dcd879 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1729,15 +1729,6 @@ config RTC_DRV_TEGRA
 	  This drive can also be built as a module. If so, the module
 	  will be called rtc-tegra.
 
-config RTC_DRV_PUV3
-	tristate "PKUnity v3 RTC support"
-	depends on ARCH_PUV3
-	help
-	  This enables support for the RTC in the PKUnity-v3 SoCs.
-
-	  This drive can also be built as a module. If so, the module
-	  will be called rtc-puv3.
-
 config RTC_DRV_LOONGSON1
 	tristate "loongson1 RTC support"
 	depends on MACH_LOONGSON32
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0721752c6ed4..880e08a409c3 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -128,7 +128,6 @@ obj-$(CONFIG_RTC_DRV_PL030)	+= rtc-pl030.o
 obj-$(CONFIG_RTC_DRV_PL031)	+= rtc-pl031.o
 obj-$(CONFIG_RTC_DRV_PM8XXX)	+= rtc-pm8xxx.o
 obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
-obj-$(CONFIG_RTC_DRV_PUV3)	+= rtc-puv3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
 obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
deleted file mode 100644
index 954b88d2485f..000000000000
--- a/drivers/rtc/rtc-puv3.c
+++ /dev/null
@@ -1,286 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * RTC driver code specific to PKUnity SoC and UniCore ISA
- *
- *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
- *	Copyright (C) 2001-2010 Guan Xuetao
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/clk.h>
-#include <linux/log2.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <linux/io.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-
-static struct resource *puv3_rtc_mem;
-
-static int puv3_rtc_alarmno = IRQ_RTCAlarm;
-static int puv3_rtc_tickno  = IRQ_RTC;
-
-static DEFINE_SPINLOCK(puv3_rtc_pie_lock);
-
-/* IRQ Handlers */
-static irqreturn_t puv3_rtc_alarmirq(int irq, void *id)
-{
-	struct rtc_device *rdev = id;
-
-	writel(readl(RTC_RTSR) | RTC_RTSR_AL, RTC_RTSR);
-	rtc_update_irq(rdev, 1, RTC_AF | RTC_IRQF);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t puv3_rtc_tickirq(int irq, void *id)
-{
-	struct rtc_device *rdev = id;
-
-	writel(readl(RTC_RTSR) | RTC_RTSR_HZ, RTC_RTSR);
-	rtc_update_irq(rdev, 1, RTC_PF | RTC_IRQF);
-	return IRQ_HANDLED;
-}
-
-/* Update control registers */
-static void puv3_rtc_setaie(struct device *dev, int to)
-{
-	unsigned int tmp;
-
-	dev_dbg(dev, "%s: aie=%d\n", __func__, to);
-
-	tmp = readl(RTC_RTSR) & ~RTC_RTSR_ALE;
-
-	if (to)
-		tmp |= RTC_RTSR_ALE;
-
-	writel(tmp, RTC_RTSR);
-}
-
-static int puv3_rtc_setpie(struct device *dev, int enabled)
-{
-	unsigned int tmp;
-
-	dev_dbg(dev, "%s: pie=%d\n", __func__, enabled);
-
-	spin_lock_irq(&puv3_rtc_pie_lock);
-	tmp = readl(RTC_RTSR) & ~RTC_RTSR_HZE;
-
-	if (enabled)
-		tmp |= RTC_RTSR_HZE;
-
-	writel(tmp, RTC_RTSR);
-	spin_unlock_irq(&puv3_rtc_pie_lock);
-
-	return 0;
-}
-
-/* Time read/write */
-static int puv3_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
-{
-	rtc_time64_to_tm(readl(RTC_RCNR), rtc_tm);
-
-	dev_dbg(dev, "read time %ptRr\n", rtc_tm);
-
-	return 0;
-}
-
-static int puv3_rtc_settime(struct device *dev, struct rtc_time *tm)
-{
-	dev_dbg(dev, "set time %ptRr\n", tm);
-
-	writel(rtc_tm_to_time64(tm), RTC_RCNR);
-
-	return 0;
-}
-
-static int puv3_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct rtc_time *alm_tm = &alrm->time;
-
-	rtc_time64_to_tm(readl(RTC_RTAR), alm_tm);
-
-	alrm->enabled = readl(RTC_RTSR) & RTC_RTSR_ALE;
-
-	dev_dbg(dev, "read alarm: %d, %ptRr\n", alrm->enabled, alm_tm);
-
-	return 0;
-}
-
-static int puv3_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct rtc_time *tm = &alrm->time;
-
-	dev_dbg(dev, "set alarm: %d, %ptRr\n", alrm->enabled, tm);
-
-	writel(rtc_tm_to_time64(tm), RTC_RTAR);
-
-	puv3_rtc_setaie(dev, alrm->enabled);
-
-	if (alrm->enabled)
-		enable_irq_wake(puv3_rtc_alarmno);
-	else
-		disable_irq_wake(puv3_rtc_alarmno);
-
-	return 0;
-}
-
-static int puv3_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-	seq_printf(seq, "periodic_IRQ\t: %s\n",
-		     (readl(RTC_RTSR) & RTC_RTSR_HZE) ? "yes" : "no");
-	return 0;
-}
-
-static const struct rtc_class_ops puv3_rtcops = {
-	.read_time	= puv3_rtc_gettime,
-	.set_time	= puv3_rtc_settime,
-	.read_alarm	= puv3_rtc_getalarm,
-	.set_alarm	= puv3_rtc_setalarm,
-	.proc	        = puv3_rtc_proc,
-};
-
-static void puv3_rtc_enable(struct device *dev, int en)
-{
-	if (!en) {
-		writel(readl(RTC_RTSR) & ~RTC_RTSR_HZE, RTC_RTSR);
-	} else {
-		/* re-enable the device, and check it is ok */
-		if ((readl(RTC_RTSR) & RTC_RTSR_HZE) == 0) {
-			dev_info(dev, "rtc disabled, re-enabling\n");
-			writel(readl(RTC_RTSR) | RTC_RTSR_HZE, RTC_RTSR);
-		}
-	}
-}
-
-static int puv3_rtc_remove(struct platform_device *dev)
-{
-	puv3_rtc_setpie(&dev->dev, 0);
-	puv3_rtc_setaie(&dev->dev, 0);
-
-	release_resource(puv3_rtc_mem);
-	kfree(puv3_rtc_mem);
-
-	return 0;
-}
-
-static int puv3_rtc_probe(struct platform_device *pdev)
-{
-	struct rtc_device *rtc;
-	struct resource *res;
-	int ret;
-
-	dev_dbg(&pdev->dev, "%s: probe=%p\n", __func__, pdev);
-
-	/* find the IRQs */
-	puv3_rtc_tickno = platform_get_irq(pdev, 1);
-	if (puv3_rtc_tickno < 0)
-		return -ENOENT;
-
-	puv3_rtc_alarmno = platform_get_irq(pdev, 0);
-	if (puv3_rtc_alarmno < 0)
-		return -ENOENT;
-
-	dev_dbg(&pdev->dev, "PKUnity_rtc: tick irq %d, alarm irq %d\n",
-		 puv3_rtc_tickno, puv3_rtc_alarmno);
-
-	rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	ret = devm_request_irq(&pdev->dev, puv3_rtc_alarmno, puv3_rtc_alarmirq,
-			       0, "pkunity-rtc alarm", rtc);
-	if (ret) {
-		dev_err(&pdev->dev, "IRQ%d error %d\n", puv3_rtc_alarmno, ret);
-		return ret;
-	}
-
-	ret = devm_request_irq(&pdev->dev, puv3_rtc_tickno, puv3_rtc_tickirq,
-			       0, "pkunity-rtc tick", rtc);
-	if (ret) {
-		dev_err(&pdev->dev, "IRQ%d error %d\n", puv3_rtc_tickno, ret);
-		return ret;
-	}
-
-	/* get the memory region */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get memory region resource\n");
-		return -ENOENT;
-	}
-
-	puv3_rtc_mem = request_mem_region(res->start, resource_size(res),
-					  pdev->name);
-
-	if (puv3_rtc_mem == NULL) {
-		dev_err(&pdev->dev, "failed to reserve memory region\n");
-		ret = -ENOENT;
-		goto err_nores;
-	}
-
-	puv3_rtc_enable(&pdev->dev, 1);
-
-	/* register RTC and exit */
-	rtc->ops = &puv3_rtcops;
-	rtc->range_max = U32_MAX;
-	ret = rtc_register_device(rtc);
-	if (ret)
-		goto err_nortc;
-
-	/* platform setup code should have handled this; sigh */
-	if (!device_can_wakeup(&pdev->dev))
-		device_init_wakeup(&pdev->dev, 1);
-
-	platform_set_drvdata(pdev, rtc);
-	return 0;
-
- err_nortc:
-	puv3_rtc_enable(&pdev->dev, 0);
-	release_resource(puv3_rtc_mem);
-
- err_nores:
-	return ret;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int ticnt_save;
-
-static int puv3_rtc_suspend(struct device *dev)
-{
-	/* save RTAR for anyone using periodic interrupts */
-	ticnt_save = readl(RTC_RTAR);
-	puv3_rtc_enable(dev, 0);
-	return 0;
-}
-
-static int puv3_rtc_resume(struct device *dev)
-{
-	puv3_rtc_enable(dev, 1);
-	writel(ticnt_save, RTC_RTAR);
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(puv3_rtc_pm_ops, puv3_rtc_suspend, puv3_rtc_resume);
-
-static struct platform_driver puv3_rtc_driver = {
-	.probe		= puv3_rtc_probe,
-	.remove		= puv3_rtc_remove,
-	.driver		= {
-		.name	= "PKUnity-v3-RTC",
-		.pm	= &puv3_rtc_pm_ops,
-	}
-};
-
-module_platform_driver(puv3_rtc_driver);
-
-MODULE_DESCRIPTION("RTC Driver for the PKUnity v3 chip");
-MODULE_AUTHOR("Hu Dongliang");
-MODULE_LICENSE("GPL v2");
-- 
2.26.2

