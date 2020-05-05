Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ADC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F5D21655
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgEEPHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729552AbgEEPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:50 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:50 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by baptiste.telenet-ops.be with bizsmtp
        id b37T2200Y3VwRR30137TdA; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-00027v-KP; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000QN-HZ; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 00/15] ARM: Drop unneeded select of multi-platform selected options
Date:   Tue,  5 May 2020 17:07:07 +0200
Message-Id: <20200505150722.1575-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi arm-soc folks,

This patch series drops select statements from the various
platform-specific Kconfig files, for symbols that are already selected
by the various multi-platform related config options
(ARCH_MULTIPLATFORM, ARCH_MULTI_V*, and ARM_SINGLE_ARMV7M).
This makes it easier to e.g. identify platforms that are not yet part of
multi-platform builds, but already use some multi-platform features
(e.g. "COMMON_CLK" is used by multi-platform + s3c24xx).

This series contains the patches from [1] and [2] that haven't been
applied yet.

Changes compared to v1:
  - Add Acked-by, Reviewed-by.

Thanks for applying!

[1] "[PATCH] ARM: arch timer: Drop unneeded select GENERIC_CLOCKEVENTS"
    https://lore.kernel.org/r/20200121100608.32218-1-geert+renesas@glider.be
[2] "[PATCH 00/20] ARM: Drop unneeded select of multi-platform selected
     options"
    https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

Geert Uytterhoeven (15):
  ARM: arch timer: Drop unneeded select GENERIC_CLOCKEVENTS
  ARM: actions: Drop unneeded select of COMMON_CLK
  ARM: alpine: Drop unneeded select of HAVE_SMP
  ARM: asm9260: Drop unneeded select of GENERIC_CLOCKEVENTS
  ARM: aspeed: Drop unneeded select of HAVE_SMP
  ARM: berlin: Drop unneeded select of HAVE_SMP
  ARM: clps711x: Drop unneeded select of multi-platform selected options
  ARM: davinci: Drop unneeded select of TIMER_OF
  ARM: integrator: Drop unneeded select of SPARSE_IRQ
  ARM: mmp: Drop unneeded select of COMMON_CLK
  ARM: mvebu: Drop unneeded select of HAVE_SMP
  ARM: omap2plus: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
  ARM: prima2: Drop unneeded select of HAVE_SMP
  ARM: realview: Drop unneeded select of multi-platform features
  ARM: socfpga: Drop unneeded select of PCI_DOMAINS_GENERIC

 arch/arm/Kconfig                 | 1 -
 arch/arm/mach-actions/Kconfig    | 1 -
 arch/arm/mach-alpine/Kconfig     | 1 -
 arch/arm/mach-asm9260/Kconfig    | 1 -
 arch/arm/mach-aspeed/Kconfig     | 1 -
 arch/arm/mach-berlin/Kconfig     | 1 -
 arch/arm/mach-clps711x/Kconfig   | 5 -----
 arch/arm/mach-davinci/Kconfig    | 1 -
 arch/arm/mach-integrator/Kconfig | 1 -
 arch/arm/mach-mmp/Kconfig        | 1 -
 arch/arm/mach-mvebu/Kconfig      | 3 ---
 arch/arm/mach-omap2/Kconfig      | 1 -
 arch/arm/mach-prima2/Kconfig     | 1 -
 arch/arm/mach-realview/Kconfig   | 8 --------
 arch/arm/mach-socfpga/Kconfig    | 1 -
 15 files changed, 28 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
