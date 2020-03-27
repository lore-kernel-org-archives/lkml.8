Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E4C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F082082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgC0CYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:24:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgC0CYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:24:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHefe-003h2O-T0; Fri, 27 Mar 2020 02:24:30 +0000
Date:   Fri, 27 Mar 2020 02:24:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCHSET v2] x86 uaccess cleanups
Message-ID: <20200327022430.GQ23230@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323183620.GD23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Repost of x86 uaccess patchset; changes since the previous
variant:
	* setup_sigcontext() ends up renamed to __unsafe_setup_sigcontext(),
with unsafe_put_sigcontext() defined as a wrapper for it
	* ia32_setup_sigcontext() ends up renamed to __unsafe_setup_sigcontext32(),
with unsafe_put_sigcontext32() added.

Branch is still 5.6-rc1-based, in
	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #next.uaccess-2

Individual patches will be in followups.  Please, review.  It's 5.6-rc1-based;
diffstat:
 Documentation/x86/exception-tables.rst |   6 -
 arch/x86/events/core.c                 |  27 +--
 arch/x86/ia32/ia32_signal.c            | 304 +++++++++++--------------
 arch/x86/include/asm/asm.h             |   6 -
 arch/x86/include/asm/processor.h       |   1 -
 arch/x86/include/asm/sigframe.h        |   6 +-
 arch/x86/include/asm/sighandling.h     |   3 -
 arch/x86/include/asm/uaccess.h         | 140 ------------
 arch/x86/include/asm/uaccess_32.h      |  27 ---
 arch/x86/include/asm/uaccess_64.h      | 108 +--------
 arch/x86/kernel/signal.c               | 399 +++++++++++++++------------------
 arch/x86/kernel/stacktrace.c           |   6 +-
 arch/x86/kernel/vm86_32.c              | 115 +++++-----
 arch/x86/kvm/mmu/paging_tmpl.h         |   2 +-
 arch/x86/mm/extable.c                  |  12 -
 include/linux/compat.h                 |   9 +-
 include/linux/signal.h                 |   8 +-
 17 files changed, 401 insertions(+), 778 deletions(-)

part 1: getting rid of constant size cases in raw_copy_{to,from}_user() (x86)

        raw_copy_{to,from}_user() recognizes some small constant sizes
and turns those into a sequence of __get_user()/__put_user().  Very few
call chains these days hit those - most are not getting the constant
sizes or get the size not among the recognized sets.  And out of the
few that do hit those cases, not all are hot enough to bother.
So let's convert those that are to explicit __get_user()/__put_user()
and drop that logics in raw_copy_{to,from}_user().  That gets rid of
quite a bit of complexity in there.
        Note: I'm not sure about one chain - vhost_scsi_do_evt_work()
copyout of 16byte struct virtio_scsi_event; if we see slowdowns there,
we probably ought to switch it to unsafe_put_user().

1/22	x86 user stack frame reads: switch to explicit __get_user()
2/22	x86 kvm page table walks: switch to explicit __get_user()
3/22	x86: switch sigframe sigset handling to explict __get_user()/__put_user()
4/22	x86: get rid of small constant size cases in raw_copy_{to,from}_user()

part 2: getting rid of get_user_ex/put_user_ex mess.

        copyin side is easy - we are on shallow stack in all cases,
and we can just do a bulk copyin instead.  copyout is more interesting.
In principle, it's all straightforward - those put_user_{try,catch}
blocks turn into user_access_{begin,end}() ones, with unsafe_put_user()
used instead of put_user_ex().  It does take some massage, though.
5/22	vm86: get rid of get_user_ex() use
6/22	x86: get rid of get_user_ex() in ia32_restore_sigcontext()
7/22	x86: get rid of get_user_ex() in restore_sigcontext()
8/22	x86: kill get_user_{try,catch,ex}
9/22	x86: switch save_v86_state() to unsafe_put_user()
10/22	x86: switch setup_sigcontext() to unsafe_put_user()
11/22	x86: switch ia32_setup_sigcontext() to unsafe_put_user()
12/22	x86: get rid of put_user_try in {ia32,x32}_setup_rt_frame()
13/22	x86: ia32_setup_sigcontext(): lift user_access_{begin,end}() into the callers
14/22	x86: ia32_setup_frame(): consolidate uaccess areas
15/22	x86: ia32_setup_rt_frame(): consolidate uaccess areas
16/22	x86: get rid of put_user_try in __setup_rt_frame() (both 32bit and 64bit)
17/22	x86: setup_sigcontext(): list user_access_{begin,end}() into callers
18/22	x86: __setup_frame(): consolidate uaccess areas
19/22	x86: __setup_rt_frame(): consolidate uaccess areas
20/22	x86: x32_setup_rt_frame(): consolidate uaccess areas
21/22	x86: unsafe_put_... macros for sigcontext and sigmask
22/22   kill uaccess_try()
