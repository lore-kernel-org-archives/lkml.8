Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C6B221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739058;
	bh=pG1MboF8wBXISDiULzH8o82ZTtVx8IQwYibmbEjCkVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohqOveHjqCSrH7JRMsWduFCT03gfDUecDzn3xETzI8UX1gwFf0X89JdQM/IkhSaJS
	 Tb7Ai3u4LTHXpUhRVhqR87SJYnR8YhO7vY969lxN1OrtBI1Gj4BchBZgd/ydlxzbiK
	 vqpgiNxWqOehri2SqL41Bc1rnOFvdyGUxytxfhnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgHFShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgHFSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E6C22D73;
        Thu,  6 Aug 2020 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738182;
        bh=pG1MboF8wBXISDiULzH8o82ZTtVx8IQwYibmbEjCkVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEnc8CMfHBKNgXuR4UcoX7Y8DV1CrAjiplAv0RiLVN59kmo15s7NwCxanfHok5Qt4
         Mpq5IW2plSmQS7nby0x+knH5yA4CNQMZiVyJJZj26mx+0+HLnh4axxciMBIBXiLoRr
         9WWPdvXKdDFL5WLNH2iIgtfyMSE9rs4MmsKyiX9c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 21/41] ARM: s3c24xx: move irqchip driver back into platform
Date:   Thu,  6 Aug 2020 20:20:38 +0200
Message-Id: <20200806182059.2431-21-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It was a good idea to move it out at first, but the irqchip code
is still tightly connected to the s3c24xx platform code and uses
multiple internal header files, so just move it back for the
time being to avoid those dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/Makefile                           | 1 +
 {drivers/irqchip => arch/arm/mach-s3c24xx}/irq-s3c24xx.c | 0
 drivers/irqchip/Makefile                                 | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {drivers/irqchip => arch/arm/mach-s3c24xx}/irq-s3c24xx.c (100%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 6692f2de71b2..8c31f84f8c97 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -8,6 +8,7 @@
 # core
 
 obj-y				+= common.o
+obj-y				+= irq-s3c24xx.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
diff --git a/drivers/irqchip/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
similarity index 100%
rename from drivers/irqchip/irq-s3c24xx.c
rename to arch/arm/mach-s3c24xx/irq-s3c24xx.c
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..8c983ad774f6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
-obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OMPIC)			+= irq-ompic.o
-- 
2.17.1

