Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B605EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082D4221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739321;
	bh=uTq56Rd/BLEMRLRt2a4oFDY8yngnlcDiHPMoyXV8GIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2IRmXAe0WeEKQAZCZHr4w9PD8aNw0w0vY50NYwe3XFPxzvVsi7WhE6Qm8TI8Dt+Cq
	 sbMJVdH65FP0j8QClqoo/ctPhXy0Qh2RqWh47uEKZGLI2oYoBcluw+faMeYCdLMXwf
	 NI1RDlSsxKkvvYXNsQRTmXTJxV8Gd/b3GEzzAyjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgHFSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgHFSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741DE22D02;
        Thu,  6 Aug 2020 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738127;
        bh=uTq56Rd/BLEMRLRt2a4oFDY8yngnlcDiHPMoyXV8GIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0ViwZBXaFQbX362Dpv2JFrMYMI5J1wOw2cwslKuXc+tZj/TKJXPBQXzjxka3jFE+
         vZ8o27tl3/wsKhN5EVICaurW9DCiSzca4wy/PnhzernJs6DaORwPzdoPTlIg/04N7T
         uBt+HXxvWTPrOKwVHhjxAsYmwChdVeBMFhS9QdOc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 06/41] ARM: s3c24xx: pass pointer to clk driver via platform data
Date:   Thu,  6 Aug 2020 20:20:23 +0200
Message-Id: <20200806182059.2431-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing pointers directly as platform data is fragile and undocumented.
Better to create a platform data structure which explicitly documents
what is passed to the driver.

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
[krzk: Update maintainer's entry]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Update maintainer's entry.
---
 MAINTAINERS                               |  1 +
 arch/arm/mach-s3c24xx/common.c            |  7 ++++++-
 drivers/clk/samsung/clk-s3c2410-dclk.c    |  7 ++++++-
 include/linux/platform_data/clk-s3c2410.h | 19 +++++++++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/platform_data/clk-s3c2410.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5675fc9bfa00..81046738cba9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15295,6 +15295,7 @@ F:	Documentation/devicetree/bindings/clock/samsung,s5p*
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
 F:	include/linux/clk/samsung.h
+F:	include/linux/platform_data/clk-s3c2410.h
 
 SAMSUNG SPI DRIVERS
 M:	Kukjin Kim <kgene@kernel.org>
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 222238e8acbb..c476a673d07f 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-s3c2410.h>
 #include <linux/platform_data/dma-s3c24xx.h>
 #include <linux/dmaengine.h>
 #include <linux/clk/samsung.h>
@@ -663,13 +664,17 @@ static struct resource s3c2410_dclk_resource[] = {
 	[0] = DEFINE_RES_MEM(0x56000084, 0x4),
 };
 
+static struct s3c2410_clk_platform_data s3c_clk_platform_data = {
+	.modify_misccr = s3c2410_modify_misccr,
+};
+
 struct platform_device s3c2410_device_dclk = {
 	.name		= "s3c2410-dclk",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s3c2410_dclk_resource),
 	.resource	= s3c2410_dclk_resource,
 	.dev		= {
-		.platform_data = s3c2410_modify_misccr,
+		.platform_data = &s3c_clk_platform_data,
 	},
 };
 #endif
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 3e0f23e8ec21..f5e0a6ba2d12 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -11,6 +11,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/clk-s3c2410.h>
 #include <linux/module.h>
 #include "clk.h"
 
@@ -89,10 +90,14 @@ static struct clk_hw *s3c24xx_register_clkout(struct device *dev,
 		const char *name, const char **parent_names, u8 num_parents,
 		u8 shift, u32 mask)
 {
+	struct s3c2410_clk_platform_data *pdata = dev_get_platdata(dev);
 	struct s3c24xx_clkout *clkout;
 	struct clk_init_data init;
 	int ret;
 
+	if (!pdata)
+		return ERR_PTR(-EINVAL);
+
 	/* allocate the clkout */
 	clkout = kzalloc(sizeof(*clkout), GFP_KERNEL);
 	if (!clkout)
@@ -107,7 +112,7 @@ static struct clk_hw *s3c24xx_register_clkout(struct device *dev,
 	clkout->shift = shift;
 	clkout->mask = mask;
 	clkout->hw.init = &init;
-	clkout->modify_misccr = dev->platform_data;
+	clkout->modify_misccr = pdata->modify_misccr;
 
 	ret = clk_hw_register(dev, &clkout->hw);
 	if (ret)
diff --git a/include/linux/platform_data/clk-s3c2410.h b/include/linux/platform_data/clk-s3c2410.h
new file mode 100644
index 000000000000..7eb1cfa5409b
--- /dev/null
+++ b/include/linux/platform_data/clk-s3c2410.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_CLK_S3C2410_H_
+#define __LINUX_PLATFORM_DATA_CLK_S3C2410_H_
+
+/**
+ * struct s3c2410_clk_platform_data - platform data for S3C2410 clock driver
+ *
+ * @modify_misccr: Function to modify the MISCCR and return the new value
+ */
+struct s3c2410_clk_platform_data {
+	unsigned int (*modify_misccr)(unsigned int clr, unsigned int chg);
+};
+
+#endif /* __LINUX_PLATFORM_DATA_CLK_S3C2410_H_ */
+
-- 
2.17.1

