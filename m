Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67CA207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593641472;
	bh=BALQnrcnOIU/FJXKRrb2SYWT5Jkbat+pRGBTyFzJQjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=taufDD0UAnE2Ozgz8O9vpkwnuKMJNZVawvlYxdJThaYBT+PYVBoEU1ACs6VFuQb4D
	 zIUW/DYqe1rBaR1R9UNztzj8tTq+2+NaxfvVqkr3H8LeTuIpt7rRM6FKVuP7ve893J
	 FRqG3+nO7rD2E6lg8rlK4JBU56Zzx/UWR2w96H4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGAWLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGAWLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:11:09 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E93B20780;
        Wed,  1 Jul 2020 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593641469;
        bh=BALQnrcnOIU/FJXKRrb2SYWT5Jkbat+pRGBTyFzJQjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hhc0hmwvsJvR1D1FEsdNcdzp5JJRNlJoHq9dkqMzqPYYrtMTdo3Mi6FgzaeIHjHpa
         J9tDeFZjwXU1ETv3HKgIKlv1fsKFhaUo4C4MsQ3aVT3aHXwKkriXGEu2VUbCKenyz0
         Fon4TATXRbyW4WLcTl4Vda7b2TmKkKj2XC8lBeWM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: imx: Remove imx_add_imx_dma() unused irq_err argument
Date:   Wed,  1 Jul 2020 17:10:39 -0500
Message-Id: <20200701221040.3667868-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701221040.3667868-1-helgaas@kernel.org>
References: <20200701221040.3667868-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

No callers of imx_add_imx_dma() need an error IRQ, so they supply 0 as
"irq_err", which means we register a resource of IRQ 0, which is invalid
and causes a warning if used.

Remove the "irq_err" argument altogether so there's no chance of trying to
use the invalid IRQ 0.

Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-imx/devices/devices-common.h   | 2 +-
 arch/arm/mach-imx/devices/platform-imx-dma.c | 6 +-----
 arch/arm/mach-imx/mm-imx21.c                 | 3 +--
 arch/arm/mach-imx/mm-imx27.c                 | 3 +--
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 2a685adec1df..ae84c08e11fa 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -289,6 +289,6 @@ struct platform_device *__init imx_add_spi_imx(
 		const struct spi_imx_master *pdata);
 
 struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
-					int irq, int irq_err);
+					int irq);
 struct platform_device *imx_add_imx_sdma(char *name,
 	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
diff --git a/arch/arm/mach-imx/devices/platform-imx-dma.c b/arch/arm/mach-imx/devices/platform-imx-dma.c
index 26b47b36257b..12656f24ad0d 100644
--- a/arch/arm/mach-imx/devices/platform-imx-dma.c
+++ b/arch/arm/mach-imx/devices/platform-imx-dma.c
@@ -6,7 +6,7 @@
 #include "devices-common.h"
 
 struct platform_device __init __maybe_unused *imx_add_imx_dma(char *name,
-	resource_size_t iobase, int irq, int irq_err)
+	resource_size_t iobase, int irq)
 {
 	struct resource res[] = {
 		{
@@ -17,10 +17,6 @@ struct platform_device __init __maybe_unused *imx_add_imx_dma(char *name,
 			.start = irq,
 			.end = irq,
 			.flags = IORESOURCE_IRQ,
-		}, {
-			.start = irq_err,
-			.end = irq_err,
-			.flags = IORESOURCE_IRQ,
 		},
 	};
 
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 50a2edac8513..b834026e4615 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -78,8 +78,7 @@ void __init imx21_soc_init(void)
 	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
 
 	pinctrl_provide_dummies();
-	imx_add_imx_dma("imx21-dma", MX21_DMA_BASE_ADDR,
-			MX21_INT_DMACH0, 0); /* No ERR irq */
+	imx_add_imx_dma("imx21-dma", MX21_DMA_BASE_ADDR, MX21_INT_DMACH0);
 	platform_device_register_simple("imx21-audmux", 0, imx21_audmux_res,
 					ARRAY_SIZE(imx21_audmux_res));
 }
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 4e4125140025..2717614f101d 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -79,8 +79,7 @@ void __init imx27_soc_init(void)
 	mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
 
 	pinctrl_provide_dummies();
-	imx_add_imx_dma("imx27-dma", MX27_DMA_BASE_ADDR,
-			MX27_INT_DMACH0, 0); /* No ERR irq */
+	imx_add_imx_dma("imx27-dma", MX27_DMA_BASE_ADDR, MX27_INT_DMACH0);
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
 					ARRAY_SIZE(imx27_audmux_res));
-- 
2.25.1

