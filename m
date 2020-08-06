Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B970C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50047221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739331;
	bh=NRxqjOGqoPFTWLmHKMktE6m1euhpzWseKiiSJ0AcWmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHklLqSgMV5Zo9AW7z8JYiXrRWP1OK6hRcAIxvvJq74XU79b5rPah+oGs4/1OUGG5
	 iIeor1c7RqrTXBMKoMMkZFUHGeoE2DOyl3LBjyNL5Wq3++joVDINjWV/ht0c59+wAD
	 BTFaUb9rGisemGsgG2PLz4hs5GDULFvq45Yf7T9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgHFSmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgHFSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE7622D00;
        Thu,  6 Aug 2020 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738122;
        bh=NRxqjOGqoPFTWLmHKMktE6m1euhpzWseKiiSJ0AcWmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j35u3MXT45QA/tPevvXazqEanrPD2LI2UfrNwXKhljiD/b9HapLDz+kRmx9VdG9or
         jdvh70v5fZf8gKQ3wdxNfY0TAzO+yjGzdD3Hxp1pnTSz1l76MtdSzNJRaIfZOw6nWN
         D486RGZpDRuSJIfYdpl4/beyb7K4z41bT2N6tDR4=
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
Subject: [PATCH v2 05/41] ARM: s3c24xx: make S3C24XX_MISCCR access indirect
Date:   Thu,  6 Aug 2020 20:20:22 +0200
Message-Id: <20200806182059.2431-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The clk driver uses both a function call into an exported
platform file and a direct register access to a hardcoded
virtual address for accessing the MISCCR register, both
become are a problem for a multiplatform kernel because
of the header file dependency.

Make this an indirect function call through platform data
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/common.c         |  3 +++
 drivers/clk/samsung/clk-s3c2410-dclk.c | 10 ++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 0d55e88ee0a8..222238e8acbb 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -668,5 +668,8 @@ struct platform_device s3c2410_device_dclk = {
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s3c2410_dclk_resource),
 	.resource	= s3c2410_dclk_resource,
+	.dev		= {
+		.platform_data = s3c2410_modify_misccr,
+	},
 };
 #endif
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 7dad9098e897..3e0f23e8ec21 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -14,10 +14,6 @@
 #include <linux/module.h>
 #include "clk.h"
 
-/* legacy access to misccr, until dt conversion is finished */
-#include <mach/hardware.h>
-#include <mach/regs-gpio.h>
-
 #define MUX_DCLK0	0
 #define MUX_DCLK1	1
 #define DIV_DCLK0	2
@@ -52,6 +48,7 @@ struct s3c24xx_clkout {
 	struct clk_hw		hw;
 	u32			mask;
 	u8			shift;
+	unsigned int (*modify_misccr)(unsigned int clr, unsigned int chg);
 };
 
 #define to_s3c24xx_clkout(_hw) container_of(_hw, struct s3c24xx_clkout, hw)
@@ -62,7 +59,7 @@ static u8 s3c24xx_clkout_get_parent(struct clk_hw *hw)
 	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
-	val = readl_relaxed(S3C24XX_MISCCR) >> clkout->shift;
+	val = clkout->modify_misccr(0, 0) >> clkout->shift;
 	val >>= clkout->shift;
 	val &= clkout->mask;
 
@@ -76,7 +73,7 @@ static int s3c24xx_clkout_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct s3c24xx_clkout *clkout = to_s3c24xx_clkout(hw);
 
-	s3c2410_modify_misccr((clkout->mask << clkout->shift),
+	clkout->modify_misccr((clkout->mask << clkout->shift),
 			      (index << clkout->shift));
 
 	return 0;
@@ -110,6 +107,7 @@ static struct clk_hw *s3c24xx_register_clkout(struct device *dev,
 	clkout->shift = shift;
 	clkout->mask = mask;
 	clkout->hw.init = &init;
+	clkout->modify_misccr = dev->platform_data;
 
 	ret = clk_hw_register(dev, &clkout->hw);
 	if (ret)
-- 
2.17.1

