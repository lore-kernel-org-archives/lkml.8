Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD064C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5192253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgAUKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:34:23 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:50380 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:34:21 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id syaJ210175USYZQ01yaJ3s; Tue, 21 Jan 2020 11:34:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itqrS-0000wf-RQ; Tue, 21 Jan 2020 11:34:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itqrS-0000ML-PG; Tue, 21 Jan 2020 11:34:18 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/20] ARM: Drop unneeded select of multi-platform selected options
Date:   Tue, 21 Jan 2020 11:34:13 +0100
Message-Id: <20200121103413.1337-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series drops select statements from the various
platform-specific Kconfig files, for symbols that are already selected
by the various multi-platform related config options
(ARCH_MULTIPLATFORM, ARCH_MULTI_V*, and ARM_SINGLE_ARMV7M).
This makes it easier to e.g. identify platforms that are not yet part of
multi-platform builds, but already use some multi-platform features
(e.g. "COMMON_CLK" is used by multi-platform + s3c24xx).

All patches in this series are independent of each other.

This has been tested by running "make oldconfig" on .config files
expanded before from all defconfig files, which triggered no changes.

Thanks!

Geert Uytterhoeven (20):
  ARM: actions: Drop unneeded select of COMMON_CLK
  ARM: alpine: Drop unneeded select of HAVE_SMP
  ARM: asm9260: Drop unneeded select of GENERIC_CLOCKEVENTS
  ARM: aspeed: Drop unneeded select of HAVE_SMP
  ARM: at91: Drop unneeded select of COMMON_CLK
  ARM: bcm: Drop unneeded select of PCI_DOMAINS_GENERIC, HAVE_SMP,
    TIMER_OF
  ARM: berlin: Drop unneeded select of HAVE_SMP
  ARM: clps711x: Drop unneeded select of multi-platform selected options
  ARM: davinci: Drop unneeded select of TIMER_OF
  ARM: exynos: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
  ARM: integrator: Drop unneeded select of SPARSE_IRQ
  ARM: meson: Drop unneeded select of COMMON_CLK
  ARM: mmp: Drop unneeded select of COMMON_CLK
  ARM: mvebu: Drop unneeded select of HAVE_SMP
  ARM: omap2plus: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
  ARM: orion5x: Drop unneeded select of PCI_DOMAINS_GENERIC
  ARM: prima2: Drop unneeded select of HAVE_SMP
  ARM: realview: Drop unneeded select of multi-platform features
  ARM: s3c64xx: Drop unneeded select of TIMER_OF
  ARM: socfpga: Drop unneeded select of PCI_DOMAINS_GENERIC

 arch/arm/mach-actions/Kconfig    | 1 -
 arch/arm/mach-alpine/Kconfig     | 1 -
 arch/arm/mach-asm9260/Kconfig    | 1 -
 arch/arm/mach-aspeed/Kconfig     | 1 -
 arch/arm/mach-at91/Kconfig       | 1 -
 arch/arm/mach-bcm/Kconfig        | 8 --------
 arch/arm/mach-berlin/Kconfig     | 1 -
 arch/arm/mach-clps711x/Kconfig   | 5 -----
 arch/arm/mach-davinci/Kconfig    | 1 -
 arch/arm/mach-exynos/Kconfig     | 1 -
 arch/arm/mach-integrator/Kconfig | 1 -
 arch/arm/mach-meson/Kconfig      | 1 -
 arch/arm/mach-mmp/Kconfig        | 1 -
 arch/arm/mach-mvebu/Kconfig      | 3 ---
 arch/arm/mach-omap2/Kconfig      | 1 -
 arch/arm/mach-orion5x/Kconfig    | 2 --
 arch/arm/mach-prima2/Kconfig     | 1 -
 arch/arm/mach-realview/Kconfig   | 8 --------
 arch/arm/mach-s3c64xx/Kconfig    | 1 -
 arch/arm/mach-socfpga/Kconfig    | 1 -
 20 files changed, 41 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
