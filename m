Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EBDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86EE22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgAUKhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:37:54 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:41136 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgAUKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:29 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id sydS2100R5USYZQ01ydSJe; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011t-FO; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000Ua-E9; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 18/20] ARM: realview: Drop unneeded select of multi-platform features
Date:   Tue, 21 Jan 2020 11:37:20 +0100
Message-Id: <20200121103722.1781-18-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for ARM Ltd. RealView systems depends on ARCH_MULTIPLATFORM,
which selects USE_OF.
Support for ARMv6 and ARMv7 variants depends on ARCH_MULTI_V6 or
ARCH_MULTI_V7, which both select ARCH_MULTI_V6_V7 and thus
MIGHT_HAVE_CACHE_L2X0.
Support for ARMv7 variants depends on ARCH_MULTI_V7, which selects
HAVE_SMP.
Hence there is no need for the affected RealView-specific symbols to
select any of them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-realview/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 44ebbf9ec67364db..0f139a20e113d6c3 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -21,7 +21,6 @@ menuconfig ARCH_REALVIEW
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
 	select SOC_REALVIEW
-	select USE_OF
 	help
 	  This enables support for ARM Ltd RealView boards.
 
@@ -56,8 +55,6 @@ config REALVIEW_EB_ARM1176
 config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Enable support for the Cortex-A9MPCore tile fitted to the
 	  Realview(R) Emulation Baseboard platform.
@@ -66,7 +63,6 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
 	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
 	  Emulation Baseboard platform.
@@ -75,7 +71,6 @@ config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	depends on ARCH_MULTI_V6
 	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
@@ -87,7 +82,6 @@ config MACH_REALVIEW_PB1176
 	depends on ARCH_MULTI_V6
 	select CPU_V6
 	select HAVE_TCM
-	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  ARM1176JZF-S.
@@ -103,8 +97,6 @@ config MACH_REALVIEW_PBA8
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
 	depends on ARCH_MULTI_V7
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select ZONE_DMA
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
-- 
2.17.1

