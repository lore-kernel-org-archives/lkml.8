Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE012495B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgEEPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729893AbgEEPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:32 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FAC0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:31 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by baptiste.telenet-ops.be with bizsmtp
        id b37U2200h3VwRR30137UdS; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAO-00028c-7r; Tue, 05 May 2020 17:07:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAO-0000R5-5s; Tue, 05 May 2020 17:07:28 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 14/15] ARM: realview: Drop unneeded select of multi-platform features
Date:   Tue,  5 May 2020 17:07:21 +0200
Message-Id: <20200505150722.1575-15-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
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

