Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BEAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4851F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgHDRMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:12:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:57368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgHDRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:12:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6119FB59B;
        Tue,  4 Aug 2020 17:12:26 +0000 (UTC)
Date:   Tue, 4 Aug 2020 19:12:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] printk for 5.9
Message-ID: <20200804171209.GF24529@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.9

===============================

- Herbert Xu made printk header file self-contained.

- Andy Shevchenko and Sergey Senozhatsky cleaned up console->setup()
  error handling.

- Andy Shevchenko did some cleanups (e.g. sparse warning) in vsprintf code.

- Minor documentation updates.

===============================

The patch from Herbert Xu, fixing an include hell, caused some build
breakages in linux-next. All of those were resolved, the fixup patches
landed in tip/locking tree (which you have pulled already), so everything
should be fine now.

----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: vsprintf

Andy Shevchenko (9):
      mips: Return proper error code from console ->setup() hook
      serial: sunsab: Return proper error code from console ->setup() hook
      serial: sunzilog: Return proper error code from console ->setup() hook
      tty: hvc: Return proper error code from console ->setup() hook
      console: Propagate error code from console ->setup()
      console: Fix trivia typo 'change' -> 'chance'
      lib/vsprintf: Replace hidden BUILD_BUG_ON() with static_assert()
      lib/vsprintf: Replace custom spec to print decimals with generic one
      lib/vsprintf: Force type of flags value for gfp_t

Bruno Meneguele (1):
      doc:kmsg: explicitly state the return value in case of SEEK_CUR

Herbert Xu (1):
      printk: Make linux/printk.h self-contained

Petr Mladek (1):
      Merge branch 'for-5.9-console-return-codes' into for-linus

Sergey Senozhatsky (1):
      hvc: unify console setup naming

 Documentation/ABI/testing/dev-kmsg        | 11 ++++++++
 Documentation/core-api/printk-formats.rst |  4 +--
 arch/mips/fw/arc/arc_con.c                |  4 ++-
 arch/s390/include/asm/bug.h               |  2 +-
 drivers/tty/hvc/hvc_xen.c                 |  4 +--
 drivers/tty/hvc/hvsi.c                    |  2 +-
 drivers/tty/serial/sunsab.c               |  2 +-
 drivers/tty/serial/sunzilog.c             |  2 +-
 include/linux/printk.h                    |  1 +
 include/linux/ratelimit.h                 | 36 +-------------------------
 include/linux/ratelimit_types.h           | 43 +++++++++++++++++++++++++++++++
 kernel/printk/printk.c                    | 16 +++++++++---
 lib/vsprintf.c                            | 17 +++++-------
 13 files changed, 86 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/ratelimit_types.h
