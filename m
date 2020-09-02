Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C150C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1804820678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061123;
	bh=o1+f1VE6GmaJGLFVxsn/LXv0486ZWZM/lSBDhI/DcQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJl3nop5rYwSVpvU0xo5hzS8/r2/T6U0/p7HQOcqXthVZqx4KPqKwSKe342gZYGqw
	 ic1N/SfEuVaFrCwTJFw5ANu95OsqXLjKRvUqp/Ke/jSlSZoaB98mx8FpwxRaW4RDhb
	 lvbdOZHkHMDlc3MSGQdZj2Chupb9CGpdr2vkzjZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIBPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgIBPC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:02:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B83208DB;
        Wed,  2 Sep 2020 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599058977;
        bh=o1+f1VE6GmaJGLFVxsn/LXv0486ZWZM/lSBDhI/DcQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zg+6VwVGKf4mF2qRwQjz9VYm5W+DTbCkyv+71FnEQMjt9Szaox0c8IVC1UvO5Keyh
         l9619t/V8TjSfvztxcHQlmegZbzL74BrDRS/IMEIaq+DNhGyAH4KUGlG9GVkydlddt
         vls4Q4zQKB/L5RZC9MLuXjb0lILiFsew+khx83A0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] ARM: imx: Include global clock header
Date:   Wed,  2 Sep 2020 17:02:43 +0200
Message-Id: <20200902150244.14347-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150244.14347-1-krzk@kernel.org>
References: <20200902150244.14347-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not declare in mach-imx functions defined in clock drivers but
include the respective header.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-imx/common.h                  | 4 ----
 arch/arm/mach-imx/mach-armadillo5x0.c       | 1 +
 arch/arm/mach-imx/mach-bug.c                | 1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 1 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c       | 1 +
 arch/arm/mach-imx/mach-mx21ads.c            | 1 +
 arch/arm/mach-imx/mach-mx27_3ds.c           | 1 +
 arch/arm/mach-imx/mach-mx27ads.c            | 1 +
 arch/arm/mach-imx/mach-mx31_3ds.c           | 1 +
 arch/arm/mach-imx/mach-mx31ads.c            | 1 +
 arch/arm/mach-imx/mach-mx31lilly.c          | 1 +
 arch/arm/mach-imx/mach-mx31lite.c           | 1 +
 arch/arm/mach-imx/mach-mx31moboard.c        | 1 +
 arch/arm/mach-imx/mach-mx35_3ds.c           | 1 +
 arch/arm/mach-imx/mach-pca100.c             | 1 +
 arch/arm/mach-imx/mach-pcm037.c             | 1 +
 arch/arm/mach-imx/mach-pcm043.c             | 1 +
 arch/arm/mach-imx/mach-qong.c               | 1 +
 arch/arm/mach-imx/mach-vpr200.c             | 1 +
 19 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 72c3fcc32910..fd80cdc9a479 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -34,10 +34,6 @@ void imx21_soc_init(void);
 void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
-int mx21_clocks_init(unsigned long lref, unsigned long fref);
-int mx27_clocks_init(unsigned long fref);
-int mx31_clocks_init(unsigned long fref);
-int mx35_clocks_init(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 4d9a56fb6989..e01411d4c53e 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
index 3929208600f2..acd333245c04 100644
--- a/arch/arm/mach-imx/mach-bug.c
+++ b/arch/arm/mach-imx/mach-bug.c
@@ -6,6 +6,7 @@
  * Copyright 2011 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
  */
 
+#include <linux/clk/imx.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 3da4c0920198..a334d2908b17 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 63f7f78a77af..1835f6edd9b4 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -9,6 +9,7 @@
  *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
+#include <linux/clk/imx.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index ec011e89eb9e..f77efe2b1de7 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -5,6 +5,7 @@
  *  Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 2db4475b7f85..c64c4dddbdce 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -11,6 +11,7 @@
  *  - i.MX27 Platform Development Kit (i.MX27 PDK)
  */
 
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index ba202f95bcdf..8a1fc8c23c48 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
  *  Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  */
+#include <linux/clk/imx.h>
 #include <linux/gpio/driver.h>
 /* Needed for gpio_to_irq() */
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 23e63d3b4c6a..13739a474e5e 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -3,6 +3,7 @@
  *  Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
+#include <linux/clk/imx.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 49783385bccf..5b1cde2b25e1 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/clk/imx.h>
 #include <linux/serial_8250.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 4b955ccc92cd..211564e332fb 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/clk/imx.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index aaccf52f7ac1..fa58eff1dbff 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2009 Daniel Mack <daniel@caiaq.de>
  */
 
+#include <linux/clk/imx.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 96845a4eaf57..f32173bb15ee 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2008 Valentin Longchamp, EPFL Mobots group
  */
 
+#include <linux/clk/imx.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 802e0abe4568..2d369e1b5123 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -17,6 +17,7 @@
  *  - i.MX35 Platform Development Kit (i.MX35 PDK)
  */
 
+#include <linux/clk/imx.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 27a3678e0658..5c90b11fe554 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2009 Sascha Hauer (kernel@pengutronix.de)
  */
 
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index c7d23e9d4f8b..924052e52fc7 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2008 Sascha Hauer, Pengutronix
  */
 
+#include <linux/clk/imx.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 017a50113005..6bff62566ed6 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
+#include <linux/clk/imx.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/plat-ram.h>
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 5b362da2dc09..d2a607ced1ce 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2009 Ilya Yanok, Emcraft Systems Ltd, <yanok@emcraft.com>
  */
 
+#include <linux/clk/imx.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index fae5a41b5f6c..2218d66b947e 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -8,6 +8,7 @@
  * Original author: Fabio Estevam <fabio.estevam@freescale.com>
  */
 
+#include <linux/clk/imx.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-- 
2.17.1

