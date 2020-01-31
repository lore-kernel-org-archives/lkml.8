Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8620C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FC820CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgAaUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:49:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57468 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbgAaUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:49:31 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00VKnPKW013554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 15:49:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D963E420324; Fri, 31 Jan 2020 15:49:24 -0500 (EST)
Date:   Fri, 31 Jan 2020 15:49:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random: changes for 5.6
Message-ID: <20200131204924.GA455123@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

for you to fetch changes up to 4cb760b02419061209b9b4cc2557986a6bf93e73:

  s390x: Mark archrandom.h functions __must_check (2020-01-25 12:18:51 -0500)

----------------------------------------------------------------
Change /dev/random so that it uses the CRNG and only blocking if the
CRNG hasn't initialized, instead of the old blocking pool.  Also clean
up archrandom.h, and some other miscellaneous cleanups.

----------------------------------------------------------------
Andy Lutomirski (8):
      random: Don't wake crng_init_wait when crng_init == 1
      random: Add a urandom_read_nowait() for random APIs that don't warn
      random: add GRND_INSECURE to return best-effort non-cryptographic bytes
      random: ignore GRND_RANDOM in getentropy(2)
      random: make /dev/random be almost like /dev/urandom
      random: remove the blocking pool
      random: delete code to pull data into pools
      random: remove kernel.random.read_wakeup_threshold

Richard Henderson (10):
      x86: Remove arch_has_random, arch_has_random_seed
      powerpc: Remove arch_has_random, arch_has_random_seed
      s390: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Use false with bool
      linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
      x86: Mark archrandom.h functions __must_check
      powerpc: Use bool in archrandom.h
      powerpc: Mark archrandom.h functions __must_check
      s390x: Mark archrandom.h functions __must_check

Sergey Senozhatsky (1):
      char/random: silence a lockdep splat with printk()

Yangtao Li (5):
      random: remove unnecessary unlikely()
      random: convert to ENTROPY_BITS for better code readability
      random: Add and use pr_fmt()
      random: fix typo in add_timer_randomness()
      random: remove some dead code of poolinfo

 arch/powerpc/include/asm/archrandom.h |  27 +++----
 arch/s390/include/asm/archrandom.h    |  20 +----
 arch/x86/include/asm/archrandom.h     |  28 +++----
 drivers/char/random.c                 | 316 +++++++++++++-----------------------------------------------------------------
 include/linux/random.h                |  24 ++----
 include/uapi/linux/random.h           |   4 +-
 6 files changed, 89 insertions(+), 330 deletions(-)
