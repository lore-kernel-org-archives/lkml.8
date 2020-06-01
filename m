Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08ED52077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgFAM7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:59:41 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56069C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 05:59:41 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:ad3e:d8bd:2f43:60f1])
        by xavier.telenet-ops.be with bizsmtp
        id lozf220070bKQxm01ozfVy; Mon, 01 Jun 2020 14:59:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jfk2V-0001kW-2W; Mon, 01 Jun 2020 14:59:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jfk2U-00059Q-VV; Mon, 01 Jun 2020 14:59:38 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.8
Date:   Mon,  1 Jun 2020 14:59:37 +0200
Message-Id: <20200601125937.19759-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.8-tag1

for you to fetch changes up to 3381df0954199458fa3993db72fb427f0ed1e43b:

  m68k: tools: Replace zero-length array with flexible-array member (2020-05-25 10:55:56 +0200)

----------------------------------------------------------------
m68k updates for v5.8

  - Several Mac fixes,
  - Defconfig updates,
  - Minor cleanups and fixes.

----------------------------------------------------------------
Finn Thain (3):
      m68k: mac: Don't call via_flush_cache() on Mac IIfx
      m68k: mac: Remove misleading comment
      m68k: mac: Avoid stuck ISM IOP interrupt on Quadra 900/950

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.7-rc1

Gustavo A. R. Silva (3):
      m68k: amiga: config: Mark expected switch fall-through
      m68k: amiga: config: Replace zero-length array with flexible-array member
      m68k: tools: Replace zero-length array with flexible-array member

Jason Wang (1):
      m68k: Add missing __user annotation in get_user()

 arch/m68k/amiga/config.c             |  7 ++---
 arch/m68k/configs/amiga_defconfig    |  6 ++++-
 arch/m68k/configs/apollo_defconfig   |  6 ++++-
 arch/m68k/configs/atari_defconfig    |  6 ++++-
 arch/m68k/configs/bvme6000_defconfig |  6 ++++-
 arch/m68k/configs/hp300_defconfig    |  6 ++++-
 arch/m68k/configs/mac_defconfig      |  6 ++++-
 arch/m68k/configs/multi_defconfig    |  6 ++++-
 arch/m68k/configs/mvme147_defconfig  |  6 ++++-
 arch/m68k/configs/mvme16x_defconfig  |  6 ++++-
 arch/m68k/configs/q40_defconfig      |  6 ++++-
 arch/m68k/configs/sun3_defconfig     |  6 ++++-
 arch/m68k/configs/sun3x_defconfig    |  6 ++++-
 arch/m68k/include/asm/mac_via.h      |  1 +
 arch/m68k/include/asm/uaccess_mm.h   |  2 +-
 arch/m68k/mac/config.c               | 21 ++-------------
 arch/m68k/mac/iop.c                  | 51 ++++++++++++++++++++----------------
 arch/m68k/mac/via.c                  |  6 ++++-
 arch/m68k/tools/amiga/dmesg.c        |  2 +-
 19 files changed, 102 insertions(+), 60 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
