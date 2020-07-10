Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9982065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJARz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:17:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35430 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:17:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C01A72A2520
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH v2] kernel: Implement selective syscall userspace redirection
Organization: Collabora
References: <20200709043840.4189530-1-krisman@collabora.com>
        <202007091549.1E457D4@keescook>
Date:   Thu, 09 Jul 2020 20:17:49 -0400
In-Reply-To: <202007091549.1E457D4@keescook> (Kees Cook's message of "Thu, 9
        Jul 2020 16:33:57 -0700")
Message-ID: <874kqg6x5e.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jul 09, 2020 at 12:38:40AM -0400, Gabriel Krisman Bertazi wrote:
>> [...]
>> +config SYSCALL_USER_DISPATCH
>> +	bool "Support rejecting syscalls not coming from a dispatcher"
>
> bike shed: this doesn't really describe why it's useful. Maybe:
>
> 	bool "Support syscall redirection to userspace dispatcher"
>
>> +	depends on HAVE_ARCH_SYSCALL_USER_DISPATCH
>> +	help
>> +	  Enable tasks to ask the kernel to redirect syscalls not
>> +	  issued from a predefined dispatcher back to userspace,
>> +	  depending on a userspace selector.
>
> 	depending on a userspace memory selector.
>
> ?
>
>> [...]
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -138,6 +138,11 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>  			return -1L;
>>  	}
>>  
>> +	if (work & _TIF_SYSCALL_USER_DISPATCH) {
>> +		if (do_syscall_user_dispatch(regs))
>> +			return -1L;
>> +	}
>> +
>
> Nice; I like this! It's very small, and now I want to refactor seccomp
> to be so pretty. :)
>
>> [...]
>> diff --git a/fs/exec.c b/fs/exec.c
>> index e6e8a9a70327..44f0ce352a0d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1502,6 +1502,8 @@ void setup_new_exec(struct linux_binprm * bprm)
>>  
>>  	arch_setup_new_exec();
>>  
>> +	clear_tsk_syscall_user_dispatch(me);
>> +
>
> To keep this as arch-agnostic as possible, I actually think this belongs
> in begin_new_exec() instead, after the personality clearing. If it were
> to be less arch-agnostic, I'd recommend it live in arch_setup_new_exec()
> (which most other TIF flags get cleared), but I'd like to have this
> feature as a good example of an "easy" refactor into arch-agnostic in
> the future. :P
>
>> [...]
>> @@ -285,6 +285,7 @@ typedef struct siginfo {
>>   */
>>  #define SYS_SECCOMP	1	/* seccomp triggered */
>>  #define NSIGSYS		1
>> +#define SYS_USER_REDIRECT 2
>
> More than just what willy suggested, but you also need to bump NSIGSYS
> (I missed that in the RFC). This should read as:
>
> #define SYS_SECCOMP		1	/* seccomp triggered */
> #define SYS_USER_REDIRECT	2
> #define NSIGSYS			2
>
> (i.e. NSIGSYS is "how many si codes are there for sigsys?")

Hey Kees,

Thanks for the very detailed feedback.

I was actually asking myself what NSIGSYS was and, if it meant something
else, whether it was a bug to have the same value as SYS_SECCOMP.  The
name isn't very meaningful to me :).  I'll slip in a comment here in my
next version.


>> [...]
>> +int do_syscall_user_dispatch(struct pt_regs *regs)
>> +{
>> +	int state;
>> +
>> +	if (current->syscall_dispatch.dispatcher == instruction_pointer(regs))
>> +		return 0;
>
> Just to clarify what willy was talking about -- since you're using
> "dispatcher" as a scalar (and not dereferencing it, etc), it can just
> stay "unsigned long" without __user.

Thanks, i think I got the __user flag correctly now.

I was actually wondering more if this should be (void*), (uintptr) or
some other type, and if ulong was the right call, but looking at other
code in the kernel ulong seems fine.

> In the documentation for the future "range inclusive" check, maybe also
> note that it's the inclusive ranger covering the _starting_ address of
> the syscall entry, in case anyone thinks they need to decode instruction
> lengths to get the right range, which they don't and I imagine you don't
> care about.

This is something I was wondering.  For the end of the range, shouldn't
we document it must include exactly the __end__ of the syscall
instruction, i.e., the start of the next instruction, instead of the
start?  If syscall is in the last address of the range, we get IP for
whatever is next and in that case, a syscall issued from a "valid"
address is rejected.  This is a corner case, for sure, but for
simplicity I think we could just let the kernel reject the syscall,
otherwise we need to find the actual syscall address when checking the
range.  Is that fine?
>
>> +
>> +	if (current->syscall_dispatch.selector) {
>> +		if (__get_user(state, current->syscall_dispatch.selector))
>> +			do_exit(SIGSEGV);
>> +
>> +		switch (state) {
>> +		case PR_SYSCALL_DISPATCH_DISABLE:
>> +			return 0;
>> +		case PR_SYSCALL_DISPATCH_ENABLE:
>> +			break;
>> +		default:
>> +			do_exit(SIGSEGV);
>> +		}
>> +	}
>> +
>> +	syscall_rollback(current, regs);
>> +	trigger_sigsys(regs);
>> +
>> +	return 1;
>
> How should do_syscall_user_dispatch() approach branch hinting? For example,
> is dispatcher == instruction_pointer going to be the common case for
> users of this? I would expect not. So maybe, at the top:
>
> 	if (unlikely(current->syscall_dispatch.dispatcher == instruction_pointer(regs)))
> 		return 0;
>
> and what about the selector? I assume it would be common for the selector
> to be set, and enabled:
>
> 	if (likely(current->syscall_dispatch.selector)) {
> 		if (__get_user(state, current->syscall_dispatch.selector))
> 			do_exit(SIGSEGV);
>
> 		if (unlikely(state != PR_SYSCALL_DISPATCH_ENABLE)) {
> 			if (likely(state == PR_SYSCALL_DISPATCH_DISABLE))
> 				return 0;
> 			do_exit(SIGSEGV);
> 		}
> 	}
>
> 	syscall_rollback...

My first version had all the unlikely/likely added, but I didn't observe
high branch misses when profiling so I dropped before sending the
RFC. The fast path, considering the new range scheme (specially when you
allow the glibc range), is entering the first 'if' condition, so that
should be made likely. Once we are reading selector then __get_user has
such a high cost with SMAP that I didn't notice any difference in the
wall-clock time.

Also, I think placing the DISABLE check before ENABLE might be
better, since we won't pay the high cost of SIGSYS in that case.  Once
we know that we will either SIGSEGV or SIGSYS, a branch miss won't do
much difference..  Does the following sound good?

if (likely(current->syscall_dispatch.dispatcher == instruction_pointer(regs)))
	return 0;

if (likely(current->syscall_dispatch.selector)) {
	if (__get_user(state, current->syscall_dispatch.selector))
		do_exit(SIGSEGV);

	if (likely(state == PR_SYSCALL_DISPATCH_DISABLE)
		return 0;

	if (state != PR_SYSCALL_DISPATCH_ENABLE)
		do_exit(SIGSEGV);
}

// syscall_rollback


>
> Or, perhaps micro-optimization doesn't matter at all here give the
> overhead of signal delivery, and you can just ignore me and leave this
> as-is, which is fine too. :)
>
> This continues to look really nice. Very simple, very powerful. I think
> I'd like to see one more thing: a selftest! I think it should be very
> easy to add; model it after the seccomp selftests:
>
> tools/testing/selftests/seccomp/seccomp_bpf.c
>
> The testing harness there should make it very easy to produce a test,
> and it's easy to wire up to the Makefiles. I'm happy to help point you
> in the right directions. If you want, you could even share seccomp's
> directory, but maybe you want your own. :)

Definitely. Added to my todo list for the next iteration.

Thanks!

-- 
Gabriel Krisman Bertazi
