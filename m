Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4045C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BBA20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkfMcBUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgHTRVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgHTRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:20:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D4C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:20:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so2329517wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SljKUfS5ax9MOGGrNnly5mm1ecRcaD54nacdT1bfsY8=;
        b=GkfMcBUnFuop+lQNKvJEnU3WX2lX6bkHqtGitRdhCJf0InKUDCUDhTGX68yAhiEOXn
         DbHVHrRnF8SQj6bYMTUxJKsqESKNb+R0hCsrp9TQBKJTxjKoHun1u0d20rg/NhsZsum2
         71lmkgQoVgsnvfr5Z7bafPCLQLHlkZ0dqJlGwyBKVcPkSvTNvN95wgsQYMMxHiTY3jaK
         rcGUJvri+VQAUj/unMr0hMxuWD/dqClwTnwKjQ0tWEOINtlma9Il7gY8C2W1lLkhqVc2
         mqiK26xlJbOdWQ4/RKbuisUH7TLwtSsc6mV+v0lkHvdDQ6lgT9YGuRh/Wdp4lggJ9fZD
         +n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SljKUfS5ax9MOGGrNnly5mm1ecRcaD54nacdT1bfsY8=;
        b=BZ/WqJ9FqbkIKiwpgxqxNcixYVqvf5qsAl4zBCDLrMs9Dx1uHHcZnhAgKe1diwoMDA
         JG42tj6KNHSuNDorlsucFb8jbNEjpN8lZPn59qnEzmxWop0L64RQilE3diqcIUwoRKm2
         pfI6nmY0ysDE/xadqHjnChcodj/kI2uUcIph41We5oXgNdVhuYAdRvMwlGheHzkBTSwG
         10gkcvLRlq+JhihvlwdIxzFyW0U+37e7fB0f2Qc+S1qZsTQQHGtyjzAQZqVSYv4QTt96
         RdxC/yUK4ShWVOzp7WFGodB7bLFz+r9XCo2pe1pVb1zPeAVRclVcOhmB75lJz7XKCRrg
         Ni4Q==
X-Gm-Message-State: AOAM53110rID8TdIMAVq3i7Y6G7hvOCi+GkL2KnoP8Sg7I2DJCKE3UJJ
        8fc0NzOBLPqEUQ6HROaYNhwuaSgNFvZARw==
X-Google-Smtp-Source: ABdhPJwfAMa+1jWgIhOnd46hnLWdBTLTRR3lINkXcpnA/VQu7wqeJdGGHYtnjeXdcF5fPHLzajViyw==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr4648537wmi.38.1597944052193;
        Thu, 20 Aug 2020 10:20:52 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k4sm5883972wrd.72.2020.08.20.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:20:51 -0700 (PDT)
Date:   Thu, 20 Aug 2020 19:20:46 +0200
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will@kernel.org, npiggin@gmail.com,
        jgross@suse.com, paulmck@kernel.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200820172046.GA177701@elver.google.com>
References: <20200820073031.886217423@infradead.org>
 <20200820103643.1b9abe88@oasis.local.home>
 <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 04:58PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 20, 2020 at 10:36:43AM -0400, Steven Rostedt wrote:
> >=20
> > I tested this series on top of tip/master and triggered the below
> > warning when running the irqsoff tracer boot up test (config attached).
> >=20
> > -- Steve
> >=20
> >  Testing tracer irqsoff:=20
> > =20
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  WARNING: suspicious RCU usage
> >  5.9.0-rc1-test+ #92 Not tainted
> >  -----------------------------
> >  include/trace/events/lock.h:13 suspicious rcu_dereference_check() usag=
e!
=2E..
>=20
> Shiny, I think that wants something like the below, but let me go frob
> my config and test it.
>=20
> ---
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
=2E..

With that applied (manually, due to conflicts), I still get warnings for
certain call locations with KCSAN on (that is with my fix from the other
email):

| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
| WARNING: suspicious RCU usage
| 5.9.0-rc1+ #23 Tainted: G        W       =20
| -----------------------------
| include/trace/events/random.h:310 suspicious rcu_dereference_check() usag=
e!
|=20
| other info that might help us debug this:
|=20
|=20
| rcu_scheduler_active =3D 2, debug_locks =3D 0
| RCU used illegally from extended quiescent state!
| no locks held by swapper/1/0.
|=20
| stack backtrace:
| CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.9.0-rc1+ #23
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/0=
1/2014
| Call Trace:
|  __dump_stack lib/dump_stack.c:77 [inline]
|  dump_stack+0xf1/0x14d lib/dump_stack.c:118
|  trace_prandom_u32 include/trace/events/random.h:310 [inline]
|  prandom_u32+0x1ee/0x200 lib/random32.c:86
|  prandom_u32_max include/linux/prandom.h:46 [inline]
|  reset_kcsan_skip kernel/kcsan/core.c:277 [inline]
|  kcsan_setup_watchpoint+0x9b/0x600 kernel/kcsan/core.c:424
|  is_idle_task+0xd/0x20 include/linux/sched.h:1671 		<=3D=3D=3D=3D inline,=
 but not noinstr
|  irqentry_enter+0x17/0x50 kernel/entry/common.c:293 		<=3D=3D=3D=3D noins=
tr function

We can fix that with the patch below.

That leaves me with this, still due to prandom_u32(). :-/

| ------------[ cut here ]------------
| DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
| WARNING: CPU: 4 PID: 1861 at kernel/locking/lockdep.c:4875 check_flags.pa=
rt.0+0x157/0x160 kernel/locking/lockdep.c:4875
| Modules linked in:
| CPU: 4 PID: 1861 Comm: kworker/u16:4 Not tainted 5.9.0-rc1+ #24
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/0=
1/2014
| RIP: 0010:check_flags.part.0+0x157/0x160 kernel/locking/lockdep.c:4875
| Code: c0 0f 84 70 5d 00 00 44 8b 0d fd 11 5f 06 45 85 c9 0f 85 60 5d 00 0=
0 48 c7 c6 3e d0 f4 86 48 c7 c7 b2 49 f3 86 e8 8d 49 f6 ff <0f> 0b e9 46 5d=
 00 00 66 90 41 57 41 56 49 89 fe 41 55 41 89 d5 41
| RSP: 0000:ffffc900034bfcb0 EFLAGS: 00010082
| RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8136161c
| RDX: ffff88881a9dcb00 RSI: ffffffff81363835 RDI: 0000000000000006
| RBP: ffffc900034bfd00 R08: 0000000000000000 R09: 0000ffffffffffff
| R10: 0000000000000104 R11: 0000ffff874efd6b R12: ffffffff874f26c0
| R13: 0000000000000244 R14: 0000000000000000 R15: 0000000000000046
| FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000=
000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 0000000000000000 CR3: 0000000007489001 CR4: 0000000000770ee0
| DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
| DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
| PKRU: 55555554
| Call Trace:
|  check_flags kernel/locking/lockdep.c:4871 [inline]
|  lock_is_held_type+0x42/0x100 kernel/locking/lockdep.c:5042
|  lock_is_held include/linux/lockdep.h:267 [inline]
|  rcu_read_lock_sched_held+0x41/0x80 kernel/rcu/update.c:136
|  trace_prandom_u32 include/trace/events/random.h:310 [inline]
|  prandom_u32+0x1bb/0x200 lib/random32.c:86
|  prandom_u32_max include/linux/prandom.h:46 [inline]
|  reset_kcsan_skip kernel/kcsan/core.c:277 [inline]
|  kcsan_setup_watchpoint+0x9b/0x600 kernel/kcsan/core.c:424
|  perf_lock_task_context+0x5e3/0x6e0 kernel/events/core.c:1491
|  perf_pin_task_context kernel/events/core.c:1506 [inline]
|  perf_event_exit_task_context kernel/events/core.c:12284 [inline]
|  perf_event_exit_task+0x1e2/0x910 kernel/events/core.c:12364
|  do_exit+0x70e/0x18b0 kernel/exit.c:815
|  call_usermodehelper_exec_async+0x2e2/0x2f0 kernel/umh.c:114
|  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
| irq event stamp: 107
| hardirqs last  enabled at (107): [<ffffffff815532ab>] perf_lock_task_cont=
ext+0x5db/0x6e0 kernel/events/core.c:1491
| hardirqs last disabled at (106): [<ffffffff81552f12>] perf_lock_task_cont=
ext+0x242/0x6e0 kernel/events/core.c:1459
| softirqs last  enabled at (0): [<ffffffff8129b95e>] copy_process+0xe9e/0x=
3970 kernel/fork.c:2004
| softirqs last disabled at (0): [<0000000000000000>] 0x0
| ---[ end trace a3058d9b157af5c4 ]---
| possible reason: unannotated irqs-off.
| irq event stamp: 107
| hardirqs last  enabled at (107): [<ffffffff815532ab>] perf_lock_task_cont=
ext+0x5db/0x6e0 kernel/events/core.c:1491
| hardirqs last disabled at (106): [<ffffffff81552f12>] perf_lock_task_cont=
ext+0x242/0x6e0 kernel/events/core.c:1459
| softirqs last  enabled at (0): [<ffffffff8129b95e>] copy_process+0xe9e/0x=
3970 kernel/fork.c:2004
| softirqs last disabled at (0): [<0000000000000000>] 0x0

Suggestions?

Thanks,
-- Marco

------ >8 ------

=46rom 4ec9dd472c978e1eba622fb22bc04e4357f10421 Mon Sep 17 00:00:00 2001
=46rom: Marco Elver <elver@google.com>
Date: Thu, 20 Aug 2020 19:06:09 +0200
Subject: [PATCH] sched: Turn inline into __always_inline due to noinstr use

is_idle_task() may be used from noinstr functions such as
irqentry_enter(). Since the compiler is free to not inline regular
inline functions, switch to using __always_inline.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..afe01e232935 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1666,7 +1666,7 @@ extern struct task_struct *idle_task(int cpu);
  *
  * Return: 1 if @p is an idle task. 0 otherwise.
  */
-static inline bool is_idle_task(const struct task_struct *p)
+static __always_inline bool is_idle_task(const struct task_struct *p)
 {
 	return !!(p->flags & PF_IDLE);
 }
--=20
2.28.0.297.g1956fa8f8d-goog
