Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2482720885
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFASm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgFASmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853AC00863F;
        Mon,  1 Jun 2020 11:35:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfpHH-001XK3-QH; Mon, 01 Jun 2020 18:35:16 +0000
Date:   Mon, 1 Jun 2020 19:35:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] set_fs() removal in coredump-related area
Message-ID: <20200601183515.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Mostly Christoph's stuff...

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs-exec

for you to fetch changes up to 38cdabb7d83522394aaf2de82c3af017ad94e5d8:

  binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in elf_fdpic_core_dump (2020-05-05 16:46:10 -0400)

----------------------------------------------------------------
Christoph Hellwig (5):
      powerpc/spufs: stop using access_ok
      powerpc/spufs: simplify spufs core dumping
      signal: refactor copy_siginfo_to_user32
      binfmt_elf: remove the set_fs(KERNEL_DS) in elf_core_dump
      binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in elf_fdpic_core_dump

Eric W. Biederman (1):
      binfmt_elf: remove the set_fs in fill_siginfo_note

Jeremy Kerr (1):
      powerpc/spufs: fix copy_to_user while atomic

 arch/powerpc/platforms/cell/spufs/coredump.c |  87 +++----
 arch/powerpc/platforms/cell/spufs/file.c     | 330 +++++++++++++--------------
 arch/powerpc/platforms/cell/spufs/spufs.h    |   3 +-
 arch/x86/ia32/ia32_signal.c                  |   2 +-
 arch/x86/include/asm/compat.h                |   8 +-
 arch/x86/kernel/signal.c                     |  28 ++-
 fs/binfmt_elf.c                              |  21 +-
 fs/binfmt_elf_fdpic.c                        |  21 +-
 fs/compat_binfmt_elf.c                       |   2 +-
 include/linux/compat.h                       |  11 +-
 include/linux/signal.h                       |   8 +
 kernel/signal.c                              | 106 ++++-----
 12 files changed, 300 insertions(+), 327 deletions(-)
