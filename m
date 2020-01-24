Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA882075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392144AbgAXTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:12:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404058AbgAXTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MR-0007e4-GE; Fri, 24 Jan 2020 20:11:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3B25E1C1A67;
        Fri, 24 Jan 2020 20:11:11 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:10 -0000
From:   "tip-bot2 for Hyunki Koo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Define EXYNOS_IRQ_COMBINER
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224211108.7128-1-hyunki00.koo@gmail.com>
References: <20191224211108.7128-1-hyunki00.koo@gmail.com>
MIME-Version: 1.0
Message-ID: <157989307099.396.8907203815822945291.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b74416dba33be3ed934e21df8286076cbd85b97f
Gitweb:        https://git.kernel.org/tip/b74416dba33be3ed934e21df8286076cbd85b97f
Author:        Hyunki Koo <hyunki00.koo@samsung.com>
AuthorDate:    Wed, 25 Dec 2019 06:11:07 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

irqchip: Define EXYNOS_IRQ_COMBINER

This patch is written to clean up dependency of ARCH_EXYNOS
Not all exynos device have IRQ_COMBINER, especially aarch64 EXYNOS
but it is built for all exynos devices.
Thus add the config for EXYNOS_IRQ_COMBINER
remove direct dependency between ARCH_EXYNOS and exynos-combiner.c
and only selected on the aarch32 devices

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20191224211108.7128-1-hyunki00.koo@gmail.com
---
 arch/arm/mach-exynos/Kconfig | 1 +
 drivers/irqchip/Kconfig      | 7 +++++++
 drivers/irqchip/Makefile     | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4ef5657..6e7f10c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -12,6 +12,7 @@ menuconfig ARCH_EXYNOS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
+	select EXYNOS_IRQ_COMBINER
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_ASV
 	select EXYNOS_CHIPID
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bb89dfc..20c62d7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -500,4 +500,11 @@ config SIFIVE_PLIC
 
 	   If you don't know what to do here, say Y.
 
+config EXYNOS_IRQ_COMBINER
+	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
+	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
+	help
+	  Say yes here to add support for the IRQ combiner devices embedded
+	  in Samsung Exynos chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6c9262c..4b1c511 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
-obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
