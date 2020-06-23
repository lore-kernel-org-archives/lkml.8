Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056612078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895487;
	bh=TqYhCSubNsW6TdLOrYGGEeogW88Vdyol0c/joeLYMak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgvS8VA3K+fVujeYJtUgGyGthsy8ba4duFO3xMoebrnRvN1x08X7PFVaVWlZhTH+V
	 e3DNWeEZpIuMZBd9u7MucC674sJmTqQ6LzkNFmXdv/s8dcHs9mowMnpegtSKDJDm7v
	 FNvgG6MAqaGqW60521kM/MEgohKsel+DQnpcOLGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgFWG6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbgFWG6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:02 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D484920772;
        Tue, 23 Jun 2020 06:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895481;
        bh=TqYhCSubNsW6TdLOrYGGEeogW88Vdyol0c/joeLYMak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfrWtKXyccbxPz9XBn3/EQgn9qV0Dbc3ROeiL4kcjPrf217rFXBMg304kF0vvbdEm
         CtcZ2m2eHLKf/Vj2nOMPTg7UzfLQja3S0UFmM5H9CTbLCutUfkvNTapvg6sZPiMrM1
         3iDQy06upAAAo0fr4qA1mAptg/EpHDMn8OEpFPC8=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/8] i2c/buses: remove i2c-puv3  driver
Date:   Tue, 23 Jun 2020 09:57:39 +0300
Message-Id: <20200623065744.18393-4-rppt@kernel.org>
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
There is no point to keep stale i2c bus driver for this architecture.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 MAINTAINERS                   |   1 -
 drivers/i2c/busses/Kconfig    |  11 --
 drivers/i2c/busses/Makefile   |   1 -
 drivers/i2c/busses/i2c-puv3.c | 275 ----------------------------------
 4 files changed, 288 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-puv3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 62b8105f1331..f36380d13014 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13585,7 +13585,6 @@ M:	Guan Xuetao <gxt@pku.edu.cn>
 S:	Maintained
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 T:	git git://github.com/gxt/linux.git
-F:	drivers/i2c/busses/i2c-puv3.c
 F:	drivers/input/serio/i8042-unicore32io.h
 F:	drivers/rtc/rtc-puv3.c
 F:	drivers/video/fbdev/fb-puv3.c
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 735bf31a3fdf..88639e52c73a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -866,17 +866,6 @@ config I2C_PNX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pnx.
 
-config I2C_PUV3
-	tristate "PKUnity v3 I2C bus support"
-	depends on UNICORE32 && ARCH_PUV3
-	select I2C_ALGOBIT
-	help
-	  This driver supports the I2C IP inside the PKUnity-v3 SoC.
-	  This I2C bus controller is under AMBA/AXI bus.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-puv3.
-
 config I2C_PXA
 	tristate "Intel PXA2XX I2C adapter"
 	depends on ARCH_PXA || ARCH_MMP || ARCH_MVEBU || (X86_32 && PCI && OF) || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 306d5dc3f417..19aff0e45cb5 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -88,7 +88,6 @@ obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
 obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
 obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
 obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
-obj-$(CONFIG_I2C_PUV3)		+= i2c-puv3.o
 obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
 obj-$(CONFIG_I2C_PXA_PCI)	+= i2c-pxa-pci.o
 obj-$(CONFIG_I2C_QCOM_CCI)	+= i2c-qcom-cci.o
diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
deleted file mode 100644
index 5cec5a36807d..000000000000
--- a/drivers/i2c/busses/i2c-puv3.c
+++ /dev/null
@@ -1,275 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I2C driver for PKUnity-v3 SoC
- * Code specific to PKUnity SoC and UniCore ISA
- *
- *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
- *	Copyright (C) 2001-2010 Guan Xuetao
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-
-/*
- * Poll the i2c status register until the specified bit is set.
- * Returns 0 if timed out (100 msec).
- */
-static short poll_status(unsigned long bit)
-{
-	int loop_cntr = 1000;
-
-	if (bit & I2C_STATUS_TFNF) {
-		do {
-			udelay(10);
-		} while (!(readl(I2C_STATUS) & bit) && (--loop_cntr > 0));
-	} else {
-		/* RXRDY handler */
-		do {
-			if (readl(I2C_TAR) == I2C_TAR_EEPROM)
-				msleep(20);
-			else
-				udelay(10);
-		} while (!(readl(I2C_RXFLR) & 0xf) && (--loop_cntr > 0));
-	}
-
-	return (loop_cntr > 0);
-}
-
-static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
-{
-	int i2c_reg = *buf;
-
-	/* Read data */
-	while (length--) {
-		if (!poll_status(I2C_STATUS_TFNF)) {
-			dev_dbg(&adap->dev, "Tx FIFO Not Full timeout\n");
-			return -ETIMEDOUT;
-		}
-
-		/* send addr */
-		writel(i2c_reg | I2C_DATACMD_WRITE, I2C_DATACMD);
-
-		/* get ready to next write */
-		i2c_reg++;
-
-		/* send read CMD */
-		writel(I2C_DATACMD_READ, I2C_DATACMD);
-
-		/* wait until the Rx FIFO have available */
-		if (!poll_status(I2C_STATUS_RFNE)) {
-			dev_dbg(&adap->dev, "RXRDY timeout\n");
-			return -ETIMEDOUT;
-		}
-
-		/* read the data to buf */
-		*buf = (readl(I2C_DATACMD) & I2C_DATACMD_DAT_MASK);
-		buf++;
-	}
-
-	return 0;
-}
-
-static int xfer_write(struct i2c_adapter *adap, unsigned char *buf, int length)
-{
-	int i2c_reg = *buf;
-
-	/* Do nothing but storing the reg_num to a static variable */
-	if (i2c_reg == -1) {
-		printk(KERN_WARNING "Error i2c reg\n");
-		return -ETIMEDOUT;
-	}
-
-	if (length == 1)
-		return 0;
-
-	buf++;
-	length--;
-	while (length--) {
-		/* send addr */
-		writel(i2c_reg | I2C_DATACMD_WRITE, I2C_DATACMD);
-
-		/* send write CMD */
-		writel(*buf | I2C_DATACMD_WRITE, I2C_DATACMD);
-
-		/* wait until the Rx FIFO have available */
-		msleep(20);
-
-		/* read the data to buf */
-		i2c_reg++;
-		buf++;
-	}
-
-	return 0;
-}
-
-/*
- * Generic i2c master transfer entrypoint.
- *
- */
-static int puv3_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *pmsg,
-		int num)
-{
-	int i, ret;
-	unsigned char swap;
-
-	/* Disable i2c */
-	writel(I2C_ENABLE_DISABLE, I2C_ENABLE);
-
-	/* Set the work mode and speed*/
-	writel(I2C_CON_MASTER | I2C_CON_SPEED_STD | I2C_CON_SLAVEDISABLE, I2C_CON);
-
-	writel(pmsg->addr, I2C_TAR);
-
-	/* Enable i2c */
-	writel(I2C_ENABLE_ENABLE, I2C_ENABLE);
-
-	dev_dbg(&adap->dev, "puv3_i2c_xfer: processing %d messages:\n", num);
-
-	for (i = 0; i < num; i++) {
-		dev_dbg(&adap->dev, " #%d: %sing %d byte%s %s 0x%02x\n", i,
-			pmsg->flags & I2C_M_RD ? "read" : "writ",
-			pmsg->len, pmsg->len > 1 ? "s" : "",
-			pmsg->flags & I2C_M_RD ? "from" : "to",	pmsg->addr);
-
-		if (pmsg->len && pmsg->buf) {	/* sanity check */
-			if (pmsg->flags & I2C_M_RD)
-				ret = xfer_read(adap, pmsg->buf, pmsg->len);
-			else
-				ret = xfer_write(adap, pmsg->buf, pmsg->len);
-
-			if (ret)
-				return ret;
-
-		}
-		dev_dbg(&adap->dev, "transfer complete\n");
-		pmsg++;		/* next message */
-	}
-
-	/* XXX: fixup be16_to_cpu in bq27x00_battery.c */
-	if (pmsg->addr == I2C_TAR_PWIC) {
-		swap = pmsg->buf[0];
-		pmsg->buf[0] = pmsg->buf[1];
-		pmsg->buf[1] = swap;
-	}
-
-	return i;
-}
-
-/*
- * Return list of supported functionality.
- */
-static u32 puv3_i2c_func(struct i2c_adapter *adapter)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-static const struct i2c_algorithm puv3_i2c_algorithm = {
-	.master_xfer	= puv3_i2c_xfer,
-	.functionality	= puv3_i2c_func,
-};
-
-/*
- * Main initialization routine.
- */
-static int puv3_i2c_probe(struct platform_device *pdev)
-{
-	struct i2c_adapter *adapter;
-	struct resource *mem;
-	int rc;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -ENODEV;
-
-	if (!request_mem_region(mem->start, resource_size(mem), "puv3_i2c"))
-		return -EBUSY;
-
-	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
-	if (adapter == NULL) {
-		dev_err(&pdev->dev, "can't allocate interface!\n");
-		rc = -ENOMEM;
-		goto fail_nomem;
-	}
-	snprintf(adapter->name, sizeof(adapter->name), "PUV3-I2C at 0x%08x",
-			mem->start);
-	adapter->algo = &puv3_i2c_algorithm;
-	adapter->class = I2C_CLASS_HWMON;
-	adapter->dev.parent = &pdev->dev;
-
-	platform_set_drvdata(pdev, adapter);
-
-	adapter->nr = pdev->id;
-	rc = i2c_add_numbered_adapter(adapter);
-	if (rc)
-		goto fail_add_adapter;
-
-	dev_info(&pdev->dev, "PKUnity v3 i2c bus adapter.\n");
-	return 0;
-
-fail_add_adapter:
-	kfree(adapter);
-fail_nomem:
-	release_mem_region(mem->start, resource_size(mem));
-
-	return rc;
-}
-
-static int puv3_i2c_remove(struct platform_device *pdev)
-{
-	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
-	struct resource *mem;
-
-	i2c_del_adapter(adapter);
-
-	put_device(&pdev->dev);
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
-
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int puv3_i2c_suspend(struct device *dev)
-{
-	int poll_count;
-	/* Disable the IIC */
-	writel(I2C_ENABLE_DISABLE, I2C_ENABLE);
-	for (poll_count = 0; poll_count < 50; poll_count++) {
-		if (readl(I2C_ENSTATUS) & I2C_ENSTATUS_ENABLE)
-			udelay(25);
-	}
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(puv3_i2c_pm, puv3_i2c_suspend, NULL);
-#define PUV3_I2C_PM	(&puv3_i2c_pm)
-
-#else
-#define PUV3_I2C_PM	NULL
-#endif
-
-static struct platform_driver puv3_i2c_driver = {
-	.probe		= puv3_i2c_probe,
-	.remove		= puv3_i2c_remove,
-	.driver		= {
-		.name	= "PKUnity-v3-I2C",
-		.pm	= PUV3_I2C_PM,
-	}
-};
-
-module_platform_driver(puv3_i2c_driver);
-
-MODULE_DESCRIPTION("PKUnity v3 I2C driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:puv3_i2c");
-- 
2.26.2

