Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F6122522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgAUKiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:38:21 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:38400 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id sydS2100A5USYZQ06ydSnu; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011K-4p; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000Tz-3H; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 06/20] ARM: bcm: Drop unneeded select of PCI_DOMAINS_GENERIC, HAVE_SMP, TIMER_OF
Date:   Tue, 21 Jan 2020 11:37:08 +0100
Message-Id: <20200121103722.1781-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Broadcom SoCs depends on ARCH_MULTI_V6_V7, and thus on
ARCH_MULTIPLATFORM, which selects PCI_DOMAINS_GENERIC and TIMER_OF.
Support for the various Broadcom IPROC architected SoCs depends on
ARCH_MULTI_V7, which selects HAVE_SMP.
Hence there is no need for the Broadcom-specific symbols to select any
of them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-bcm/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fcfe2a0e805896e9..6aa938b949db2fec 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -20,7 +20,6 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
-	select PCI_DOMAINS_GENERIC if PCI
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
@@ -54,7 +53,6 @@ config ARCH_BCM_NSP
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_ERRATA_764369 if SMP
-	select HAVE_SMP
 	select THERMAL
 	select THERMAL_OF
 	help
@@ -73,7 +71,6 @@ config ARCH_BCM_5301X
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_ERRATA_764369 if SMP
-	select HAVE_SMP
 
 	help
 	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
@@ -109,7 +106,6 @@ config ARCH_BCM_281XX
 	bool "Broadcom BCM281XX SoC family"
 	depends on ARCH_MULTI_V7
 	select ARCH_BCM_MOBILE
-	select HAVE_SMP
 	help
 	  Enable support for the BCM281XX family, which includes
 	  BCM11130, BCM11140, BCM11351, BCM28145 and BCM28155
@@ -119,7 +115,6 @@ config ARCH_BCM_21664
 	bool "Broadcom BCM21664 SoC family"
 	depends on ARCH_MULTI_V7
 	select ARCH_BCM_MOBILE
-	select HAVE_SMP
 	help
 	  Enable support for the BCM21664 family, which includes
 	  BCM21663 and BCM21664 variants.
@@ -128,7 +123,6 @@ config ARCH_BCM_23550
 	bool "Broadcom BCM23550 SoC"
 	depends on ARCH_MULTI_V7
 	select ARCH_BCM_MOBILE
-	select HAVE_SMP
 	help
 	  Enable support for the BCM23550.
 
@@ -165,7 +159,6 @@ config ARCH_BCM2835
 	select ZONE_DMA if ARCH_MULTI_V7
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
-	select TIMER_OF
 	select BCM2835_TIMER
 	select PINCTRL
 	select PINCTRL_BCM2835
@@ -201,7 +194,6 @@ config ARCH_BCM_63XX
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_TWD if SMP
 	select HAVE_ARM_SCU if SMP
-	select HAVE_SMP
 	help
 	  This enables support for systems based on Broadcom DSL SoCs.
 	  It currently supports the 'BCM63XX' ARM-based family, which includes
-- 
2.17.1

