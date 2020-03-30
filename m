Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA259C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B09620732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgC3KFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:05:41 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:35624 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgC3KFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:05:40 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id La5c2200X5USYZQ01a5cqJ; Mon, 30 Mar 2020 12:05:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jIrIW-0004JP-Rw; Mon, 30 Mar 2020 12:05:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jIrIW-0001Iv-P7; Mon, 30 Mar 2020 12:05:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.7
Date:   Mon, 30 Mar 2020 12:05:35 +0200
Message-Id: <20200330100535.4967-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v5.7-tag1

for you to fetch changes up to 86cded5fc52567774b596827544874499532b8ae:

  m68k: defconfig: Update defconfigs for v5.6-rc4 (2020-03-09 11:12:29 +0100)

----------------------------------------------------------------
m68k updates for v5.7

  - Pagetable layout rewrite, to facilitate global READ_ONCE() rework,
  - Zorro (Amiga) and DIO (HP 9000/300) bus cleanups,
  - Defconfig updates,
  - Minor cleanups and fixes.

Thanks for pulling!

Note that:
  - The pagetable layout rewrite has its own immutable branch, but it
    was not pulled by Peter/Will yet.  The READ_ONCE() rework on top was
    postponed, due to newly discovered issues on sparc32 that need
    fixing first.
  - The base is v5.6-rc4, due to late Kconfig changes impacting the
    defconfigs.

----------------------------------------------------------------
Geert Uytterhoeven (12):
      Merge branch 'pgtable-layout-rewrite' into for-v5.7
      zorro: Make zorro_match_device() static
      zorro: Fix zorro_bus_match() kerneldoc
      zorro: Use zorro_match_device() helper in zorro_bus_match()
      zorro: Remove unused zorro_dev_driver()
      zorro: Move zorro_bus_type to bus-private header file
      dio: Make dio_match_device() static
      dio: Fix dio_bus_match() kerneldoc
      dio: Remove unused dio_dev_driver()
      fbdev: c2p: Use BUILD_BUG() instead of custom solution
      m68k: Switch to asm-generic/hardirq.h
      m68k: defconfig: Update defconfigs for v5.6-rc4

Gustavo A. R. Silva (1):
      zorro: Replace zero-length array with flexible-array member

Krzysztof Kozlowski (1):
      m68k: Fix Kconfig indentation

Peter Zijlstra (8):
      m68k: mm: Remove stray nocache in ColdFire pgalloc
      m68k: mm: Unify Motorola MMU page setup
      m68k: mm: Move the pointer table allocator to motorola.c
      m68k: mm: Restructure Motorola MMU page-table layout
      m68k: mm: Improve kernel_page_table()
      m68k: mm: Use table allocator for pgtables
      m68k: mm: Extend table allocator for multiple sizes
      m68k: mm: Fully initialize the page-table allocator

Will Deacon (2):
      m68k: mm: Fix ColdFire pgd_alloc()
      m68k: mm: Change ColdFire pgtable_t

 arch/m68k/Kconfig.bus                    |   2 +-
 arch/m68k/Kconfig.debug                  |  16 +--
 arch/m68k/Kconfig.machine                |   8 +-
 arch/m68k/configs/amiga_defconfig        |   5 +-
 arch/m68k/configs/apollo_defconfig       |   5 +-
 arch/m68k/configs/atari_defconfig        |   5 +-
 arch/m68k/configs/bvme6000_defconfig     |   5 +-
 arch/m68k/configs/hp300_defconfig        |   5 +-
 arch/m68k/configs/mac_defconfig          |   5 +-
 arch/m68k/configs/multi_defconfig        |   5 +-
 arch/m68k/configs/mvme147_defconfig      |   5 +-
 arch/m68k/configs/mvme16x_defconfig      |   5 +-
 arch/m68k/configs/q40_defconfig          |   5 +-
 arch/m68k/configs/sun3_defconfig         |   5 +-
 arch/m68k/configs/sun3x_defconfig        |   5 +-
 arch/m68k/include/asm/Kbuild             |   1 +
 arch/m68k/include/asm/hardirq.h          |  29 ----
 arch/m68k/include/asm/mcf_pgalloc.h      |  31 ++---
 arch/m68k/include/asm/motorola_pgalloc.h |  74 ++++------
 arch/m68k/include/asm/motorola_pgtable.h |  36 +++--
 arch/m68k/include/asm/page.h             |  16 ++-
 arch/m68k/include/asm/pgtable_mm.h       |  10 +-
 arch/m68k/mm/init.c                      |  34 +++--
 arch/m68k/mm/kmap.c                      |  36 +++--
 arch/m68k/mm/memory.c                    | 103 --------------
 arch/m68k/mm/motorola.c                  | 228 +++++++++++++++++++++++++------
 drivers/dio/dio-driver.c                 |   9 +-
 drivers/video/fbdev/c2p_core.h           |  12 +-
 drivers/zorro/zorro-driver.c             |  16 +--
 drivers/zorro/zorro.c                    |   2 +-
 drivers/zorro/zorro.h                    |   7 +
 include/linux/dio.h                      |   5 -
 include/linux/zorro.h                    |  12 --
 33 files changed, 351 insertions(+), 396 deletions(-)
 delete mode 100644 arch/m68k/include/asm/hardirq.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
