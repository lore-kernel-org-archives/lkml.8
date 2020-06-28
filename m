Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2831C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9131020738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgF1OFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:05:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgF1OFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8F3CAC91;
        Sun, 28 Jun 2020 14:05:29 +0000 (UTC)
Date:   Sun, 28 Jun 2020 16:05:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/entry for 5.8
Message-ID: <20200628140523.GA18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/entry urgent pile which has accumulated since the
merge window. It is not the smallest but considering the almost complete
entry core rewrite, the amount of fixes to follow is somewhat higher
than usual, which is to be expected.

Thx.

---
The following changes since commit 8be3a53e18e0e1a98f288f6c7f5e9da3adbe9c49:

  Merge tag 'erofs-for-5.8-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2020-06-24 17:39:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_5.8

for you to fetch changes up to 2c92d787cc9fad57d05c96bd117782183768258a:

  Merge branch 'linus' into x86/entry, to resolve conflicts (2020-06-26 12:24:42 +0200)

----------------------------------------------------------------
Peter Zijlstra says:

These patches address a number of instrumentation issues that were found after
the x86/entry overhaul. When combined with rcu/urgent and objtool/urgent, these
patches make UBSAN/KASAN/KCSAN happy again.

Part of making this all work is bumping the minimum GCC version for KASAN
builds to gcc-8.3, the reason for this is that the __no_sanitize_address
function attribute is broken in GCC releases before that.

No known GCC version has a working __no_sanitize_undefined, however because the
only noinstr violation that results from this happens when an UB is found, we
treat it like WARN. That is, we allow it to violate the noinstr rules in order
to get the warning out.

----------------------------------------------------------------
Ingo Molnar (1):
      Merge branch 'linus' into x86/entry, to resolve conflicts

Marco Elver (4):
      kasan: Bump required compiler version
      compiler_types.h: Add __no_sanitize_{address,undefined} to noinstr
      compiler_attributes.h: Support no_sanitize_undefined check with GCC 4
      kasan: Fix required compiler version

Peter Zijlstra (10):
      x86, kcsan: Remove __no_kcsan_or_inline usage
      kcsan: Remove __no_kcsan_or_inline
      x86, kcsan: Add __no_kcsan to noinstr
      x86/entry, cpumask: Provide non-instrumented variant of cpu_is_offline()
      x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
      x86/entry, bug: Comment the instrumentation_begin() usage for WARN()
      objtool: Don't consider vmlinux a C-file
      x86/entry: Fixup bad_iret vs noinstr
      x86/entry: Increase entry_stack size to a full page
      x86/entry: Fix #UD vs WARN more

 Documentation/dev-tools/kcsan.rst   |  6 ---
 arch/x86/include/asm/bitops.h       |  6 +--
 arch/x86/include/asm/bug.h          |  6 +++
 arch/x86/include/asm/cpumask.h      | 18 +++++++++
 arch/x86/include/asm/processor.h    |  2 +-
 arch/x86/kernel/cpu/mce/core.c      |  2 +-
 arch/x86/kernel/nmi.c               |  2 +-
 arch/x86/kernel/traps.c             | 78 +++++++++++++++++++------------------
 arch/x86/lib/memcpy_64.S            |  4 ++
 include/linux/compiler-clang.h      |  8 ++++
 include/linux/compiler-gcc.h        |  6 +++
 include/linux/compiler_attributes.h |  1 +
 include/linux/compiler_types.h      | 14 +++----
 lib/Kconfig.kasan                   |  4 ++
 tools/objtool/check.c               | 30 +++++++++++++-
 15 files changed, 126 insertions(+), 61 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
