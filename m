Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD7206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739000;
	bh=7U/b6d9kHgh1sTw0aRo983Iz2jKYs77wOZ9XOLE6MC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SD1ei9XgAZJlotbNhgIl4thJv/MNAvlBUfo8dx9jo5Pl1c8yY3ltzd2BlyJ5qWHJS
	 cJcmp8fBPlQq0PzOuVQbpqH7jtzqrsmJHdMTa92kombZlzdrslppN5X0d8z1lX7D9e
	 UwnYNS8vqY1aeWxtm1byKkXTgJCmYxdTa5s9PT9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgHFSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgHFSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4847422CF6;
        Thu,  6 Aug 2020 18:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738179;
        bh=7U/b6d9kHgh1sTw0aRo983Iz2jKYs77wOZ9XOLE6MC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nE46k3+T3n2X5t4JXuWsCeNViKtLZF2wwBL2U8Zo0X1txBBxWp48Z/fICvu09Q4Vq
         KaaEJ+4rd6OAB+Noig8MNqMyZ1vA3cIqcsAWRAWCnP9nunHVlYwrQH5VZ0Mco24ORO
         uJ2Rz8xyIm6gN2Mf/N26YwJAXGI5DCN4PegNgV5w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 20/41] ARM: s3c24xx: move regs-spi.h into spi driver
Date:   Thu,  6 Aug 2020 20:20:37 +0200
Message-Id: <20200806182059.2431-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The file is mostly specific to the driver, the few bits that
are actually used by the platform code get moved to mach/map.h
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/include/mach/map.h                 | 2 ++
 arch/arm/mach-s3c24xx/s3c2412.c                          | 1 -
 arch/arm/plat-samsung/devs.c                             | 1 -
 drivers/spi/spi-s3c24xx-fiq.S                            | 4 +++-
 .../plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h    | 9 +++------
 drivers/spi/spi-s3c24xx.c                                | 3 +--
 6 files changed, 9 insertions(+), 11 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h (89%)

diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index bca93112f57d..a20c9fd0d855 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -86,6 +86,8 @@
 #define S3C2410_PA_SPI	   (0x59000000)
 #define S3C2443_PA_SPI0		(0x52000000)
 #define S3C2443_PA_SPI1		S3C2410_PA_SPI
+#define S3C2410_SPI1		(0x20)
+#define S3C2412_SPI1		(0x100)
 
 /* SDI */
 #define S3C2410_PA_SDI	   (0x5A000000)
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 8fe4d4670dcb..c3fb3e6c0dd8 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -37,7 +37,6 @@
 #include <plat/cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
-#include <plat/regs-spi.h>
 
 #include "common.h"
 #include "nand-core.h"
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 0607d2984841..0ed3a4b9fc12 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -61,7 +61,6 @@
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/usb-phy.h>
-#include <plat/regs-spi.h>
 #include <linux/platform_data/asoc-s3c.h>
 #include <linux/platform_data/spi-s3c64xx.h>
 
diff --git a/drivers/spi/spi-s3c24xx-fiq.S b/drivers/spi/spi-s3c24xx-fiq.S
index e95d6282109e..9d5f8f1e5e81 100644
--- a/drivers/spi/spi-s3c24xx-fiq.S
+++ b/drivers/spi/spi-s3c24xx-fiq.S
@@ -12,10 +12,12 @@
 
 #include <mach/map.h>
 #include <mach/regs-irq.h>
-#include <plat/regs-spi.h>
 
 #include "spi-s3c24xx-fiq.h"
 
+#define S3C2410_SPTDAT           (0x10)
+#define S3C2410_SPRDAT           (0x14)
+
 	.text
 
 	@ entry to these routines is as follows, with the register names
diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/drivers/spi/spi-s3c24xx-regs.h
similarity index 89%
rename from arch/arm/plat-samsung/include/plat/regs-spi.h
rename to drivers/spi/spi-s3c24xx-regs.h
index 607844311566..f51464ab5677 100644
--- a/arch/arm/plat-samsung/include/plat/regs-spi.h
+++ b/drivers/spi/spi-s3c24xx-regs.h
@@ -5,11 +5,8 @@
  * S3C2410 SPI register definition
  */
 
-#ifndef __ASM_ARCH_REGS_SPI_H
-#define __ASM_ARCH_REGS_SPI_H
-
-#define S3C2410_SPI1		(0x20)
-#define S3C2412_SPI1		(0x100)
+#ifndef __SPI_S3C2410_H
+#define __SPI_S3C2410_H
 
 #define S3C2410_SPCON		(0x00)
 
@@ -41,4 +38,4 @@
 #define S3C2410_SPTDAT		(0x10)
 #define S3C2410_SPRDAT		(0x14)
 
-#endif /* __ASM_ARCH_REGS_SPI_H */
+#endif /* __SPI_S3C2410_H */
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 7742170fca91..92be0c6d798a 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -21,10 +21,9 @@
 #include <linux/spi/s3c24xx.h>
 #include <linux/module.h>
 
-#include <plat/regs-spi.h>
-
 #include <asm/fiq.h>
 
+#include "spi-s3c24xx-regs.h"
 #include "spi-s3c24xx-fiq.h"
 
 /**
-- 
2.17.1

