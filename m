Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D15C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977321569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA0JyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:54:15 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:55920 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0JyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:54:15 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id vMuD210045USYZQ06MuDBF; Mon, 27 Jan 2020 10:54:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw15w-0003l6-Un; Mon, 27 Jan 2020 10:54:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw15w-0000x1-Qq; Mon, 27 Jan 2020 10:54:12 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.6
Date:   Mon, 27 Jan 2020 10:54:10 +0100
Message-Id: <20200127095410.3611-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.6-tag1

for you to fetch changes up to 6aabc1facdb24e837cfea755ba46a6be22a8860f:

  m68k: Implement copy_thread_tls() (2020-01-14 10:43:38 +0100)

----------------------------------------------------------------
m68k updates for v5.6

  - Wire up clone3() syscall,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (2):
      m68k: defconfig: Update defconfigs for v5.5-rc3
      m68k: Implement copy_thread_tls()

Kars de Jong (1):
      m68k: Wire up clone3() syscall

 arch/m68k/Kconfig                     |  1 +
 arch/m68k/configs/amiga_defconfig     |  8 +++++--
 arch/m68k/configs/apollo_defconfig    |  8 +++++--
 arch/m68k/configs/atari_defconfig     |  8 +++++--
 arch/m68k/configs/bvme6000_defconfig  |  8 +++++--
 arch/m68k/configs/hp300_defconfig     |  8 +++++--
 arch/m68k/configs/mac_defconfig       |  8 +++++--
 arch/m68k/configs/multi_defconfig     |  8 +++++--
 arch/m68k/configs/mvme147_defconfig   |  8 +++++--
 arch/m68k/configs/mvme16x_defconfig   |  8 +++++--
 arch/m68k/configs/q40_defconfig       |  8 +++++--
 arch/m68k/configs/sun3_defconfig      |  6 ++++-
 arch/m68k/configs/sun3x_defconfig     |  8 +++++--
 arch/m68k/include/asm/unistd.h        |  1 +
 arch/m68k/kernel/entry.S              |  7 ++++++
 arch/m68k/kernel/process.c            | 44 +++++++++++++++++++++++++++--------
 arch/m68k/kernel/syscalls/syscall.tbl |  2 +-
 17 files changed, 115 insertions(+), 34 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
