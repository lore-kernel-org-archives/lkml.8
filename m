Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BFC20826
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593765561;
	bh=MvXrb6r67qib7/+nzgg82KcxzQJ/w/+5fImFL7ixVXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEssOJGxj7u/LtPPnX9+h4SzBQlIcttjJ53hl7uYCW+6Bpaxi7ga5oCfuvWnjySeZ
	 TgqCshEHEIdSAdi51YIfgwxoQ+AoQD/a3iJBJhbiHNZ83b+vUwAcJjvA/Ngy2uqw1x
	 JH5jwQTtGZqf3hrvaLJIBGbpyJ6rPHMVJwDHtze8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGCIjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCIjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:39:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E57206DF;
        Fri,  3 Jul 2020 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593765559;
        bh=MvXrb6r67qib7/+nzgg82KcxzQJ/w/+5fImFL7ixVXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1odqj4HK1/iPAdyy6hPR85RJNmhvOSqeJj0AoSlxcxvwXLmgdDm4KVPy2NoOPuhKD
         ZfzXhNoNv9YqTrL8/QU9WZe35bgzjVj3yyuKx04MjDdx9j1JZh7EWr2MBiP4lo76LM
         ryzdngx7FCwDMwXW/NtAxhCxP0c+eklbSHDza558=
Date:   Fri, 3 Jul 2020 09:39:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200703083914.GA18516@willie-the-truck>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keno,

On Fri, May 22, 2020 at 09:01:01PM -0400, Keno Fischer wrote:
> I'm seeing the following while porting a ptracer from
> x86_64 to arm64 (cc'ing arm64 folks, but in this case
> x86_64 is the odd one out, I think other archs would
> be consistent with arm64).
> 
> Consider userspace code like the following:
> ```
> int ret = syscall(-10, 0);
> assert(ret == -ENOSYS);
> ```
> 
> (Never mind the fact that this is something userspace
> shouldn't do, I saw this in our test suite that tests
> corner cases where the ptracer shouldn't affect behavior).
> 
> Now, if we have a seccomp filter that simply does
> SECCOMP_RET_TRACE, and a ptracer that simply
> does PTRACE_CONT

Ok, so this means that we're _skipping_ the system call, right?

> then the assert will fire/fail on arm64, but not on x86_64.

It feels weird to me that skipping the system call has any effect on the
tracee registers...

> Interestingly, arm64 does do something different
> if the syscall is -1 rather than -10, where early
> in the ptrace stop it does.
> ```
> /* set default errno for user-issued syscall(-1) */
> if (scno == NO_SYSCALL)
>     regs->regs[0] = -ENOSYS;

... so I think this should be fixed too. How about the diff below?

Will

--->8

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 68b7f34a08f5..cb3f653c9688 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1833,12 +1833,12 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 		if (!in_syscall(regs) || (flags & _TIF_SYSCALL_EMU))
-			return -1;
+			return -ENOSYS;
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
 	if (secure_computing() == -1)
-		return -1;
+		return -ENOSYS;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
@@ -1846,7 +1846,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
-	return regs->syscallno;
+	return 0;
 }
 
 void syscall_trace_exit(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5f5b868292f5..a13661f44818 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	user_exit();
 
 	if (has_syscall_work(flags)) {
-		/* set default errno for user-issued syscall(-1) */
-		if (scno == NO_SYSCALL)
-			regs->regs[0] = -ENOSYS;
-		scno = syscall_trace_enter(regs);
-		if (scno == NO_SYSCALL)
+		if (syscall_trace_enter(regs))
 			goto trace_exit;
+
+		scno = regs->syscallno;
 	}
 
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
