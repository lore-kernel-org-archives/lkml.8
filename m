Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A99C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC532076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCLaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCLaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:30:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E609C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:30:13 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id AzWA2300S4C55Sk01zWAKr; Mon, 03 Aug 2020 13:30:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2YfS-0001gG-Qb; Mon, 03 Aug 2020 13:30:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2YfS-0002db-OM; Mon, 03 Aug 2020 13:30:10 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.9
Date:   Mon,  3 Aug 2020 13:30:04 +0200
Message-Id: <20200803113004.10098-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.9-tag1

for you to fetch changes up to 382f429bb559fe991b1ece2e5e58c812e28b3ad8:

  m68k: defconfig: Update defconfigs for v5.8-rc3 (2020-07-13 11:41:52 +0200)

----------------------------------------------------------------
m68k updates for v5.9

  - Several Kbuild improvements,
  - Several Mac fixes,
  - Minor cleanups and fixes,
  - Defconfig updates.

Note that the base is v5.8-rc3, due to late Kconfig changes impacting
the defconfigs.

Thanks for pulling!

----------------------------------------------------------------
Finn Thain (4):
      m68k: mac: Don't send IOP message until channel is idle
      m68k: mac: Fix IOP status/control register writes
      m68k: mac: Don't send uninitialized data in IOP message reply
      m68k: mac: Improve IOP debug messages

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.8-rc3

Gustavo A. R. Silva (1):
      m68k: Use sizeof_field() helper

Masahiro Yamada (5):
      m68k: Add arch/m68k/Kbuild
      m68k: sun3: Descend to prom from arch/m68k/sun3
      m68k: Optimize cc-option calls for cpuflags-y
      m68k: Pass -D options to KBUILD_CPPFLAGS instead of KBUILD_{A,C}FLAGS
      m68k: Use CLEAN_FILES to clean up files

Michael Schmitz (1):
      m68k: atari: Annotate dummy read in ROM port IO code as __maybe_unused

 arch/m68k/Kbuild                     | 19 ++++++++++
 arch/m68k/Makefile                   | 73 ++++++++++++++----------------------
 arch/m68k/configs/amiga_defconfig    |  3 ++
 arch/m68k/configs/apollo_defconfig   |  3 ++
 arch/m68k/configs/atari_defconfig    |  3 ++
 arch/m68k/configs/bvme6000_defconfig |  3 ++
 arch/m68k/configs/hp300_defconfig    |  3 ++
 arch/m68k/configs/mac_defconfig      |  3 ++
 arch/m68k/configs/multi_defconfig    |  3 ++
 arch/m68k/configs/mvme147_defconfig  |  3 ++
 arch/m68k/configs/mvme16x_defconfig  |  3 ++
 arch/m68k/configs/q40_defconfig      |  3 ++
 arch/m68k/configs/sun3_defconfig     |  3 ++
 arch/m68k/configs/sun3x_defconfig    |  3 ++
 arch/m68k/include/asm/raw_io.h       |  6 +--
 arch/m68k/kernel/signal.c            | 32 ++++++++--------
 arch/m68k/mac/iop.c                  | 60 +++++++++++++----------------
 arch/m68k/sun3/Makefile              |  2 +-
 18 files changed, 129 insertions(+), 99 deletions(-)
 create mode 100644 arch/m68k/Kbuild

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
