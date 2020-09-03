Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA35EC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970A920767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgICKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:14:56 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33433 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbgICKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:14:53 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kDmGX-0020wz-40; Thu, 03 Sep 2020 12:14:49 +0200
Received: from p57bd95bc.dip0.t-ipconnect.de ([87.189.149.188] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kDmGW-000dbe-PF; Thu, 03 Sep 2020 12:14:49 +0200
Subject: Re: [PATCH] sh: fix syscall tracing
To:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
Date:   Thu, 3 Sep 2020 12:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903054803.GX3265@brightrain.aerifal.cx>
Content-Type: multipart/mixed;
 boundary="------------312FB7917C728875E74D6DAF"
Content-Language: en-US
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.188
X-ZEDAT-Hint: A
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------312FB7917C728875E74D6DAF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Rich!

On 9/3/20 7:48 AM, Rich Felker wrote:
> Addition of SECCOMP_FILTER exposed a longstanding bug in
> do_syscall_trace_enter, whereby r0 (the 5th argument register) was
> mistakenly used where r3 (syscall_nr) was intended. By overwriting r0
> rather than r3 with -1 when attempting to block a syscall, the
> existing code would instead have caused the syscall to execute with an
> argument clobbered.
> 
> Commit 0bb605c2c7f2b4b3 then introduced skipping of the syscall when
> do_syscall_trace_enter returns -1, so that the return value set by
> seccomp filters would not be clobbered by -ENOSYS. This eliminated the
> clobbering of the 5th argument register, but instead caused syscalls
> made with a 5th argument of -1 to be misinterpreted as a request by
> do_syscall_trace_enter to suppress the syscall.
> 
> Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
> Fixes: ab99c733ae73cce3 ("sh: Make syscall tracer use tracehook notifiers, add TIF_NOTIFY_RESUME.")
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  arch/sh/kernel/entry-common.S |  1 -
>  arch/sh/kernel/ptrace_32.c    | 15 +++++----------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> index ad963104d22d..91ab2607a1ff 100644
> --- a/arch/sh/kernel/entry-common.S
> +++ b/arch/sh/kernel/entry-common.S
> @@ -370,7 +370,6 @@ syscall_trace_entry:
>  	 nop
>  	cmp/eq	#-1, r0
>  	bt	syscall_exit
> -	mov.l	r0, @(OFF_R0,r15)	! Save return value
>  	!			Reload R0-R4 from kernel stack, where the
>  	!   	    	    	parent may have modified them using
>  	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index b05bf92f9c32..5281685f6ad1 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -455,16 +455,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  
>  asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> -	long ret = 0;
> -
>  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -	    tracehook_report_syscall_entry(regs))
> -		/*
> -		 * Tracing decided this syscall should not happen.
> -		 * We'll return a bogus call number to get an ENOSYS
> -		 * error, but leave the original number in regs->regs[0].
> -		 */
> -		ret = -1L;
> +	    tracehook_report_syscall_entry(regs)) {
> +		regs->regs[0] = -ENOSYS;
> +		return -1;
> +	}
>  
>  	if (secure_computing() == -1)
>  		return -1;
> @@ -475,7 +470,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
>  			    regs->regs[6], regs->regs[7]);
>  
> -	return ret ?: regs->regs[0];
> +	return 0;
>  }
>  
>  asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
> 

I can confirm that this patch fixes both strace for me and does not break libseccomp,
I have run the libseccomp testsuite with my patch for SuperH support applied on top
of a rebased libseccomp with the 32-bit fixes. Attaching the testsuite log.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------312FB7917C728875E74D6DAF
Content-Type: text/x-log; charset=UTF-8;
 name="seccomp-live-test.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="seccomp-live-test.log"

=============== Thu 03 Sep 2020 11:57:57 AM CEST ===============
Regression Test Report ("regression -T live")
 batch name: 01-sim-allow
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 02-sim-basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 03-sim-basic_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 04-sim-multilevel_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 05-sim-long_jumps
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 06-sim-actions
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 07-sim-db_bug_looping
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 08-sim-subtree_checks
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 09-sim-syscall_priority_pre
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 10-sim-syscall_priority_post
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 11-basic-basic_errors
 test mode:  c
 test type:  basic
 batch name: 12-sim-basic_masked_ops
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 13-basic-attrs
 test mode:  c
 test type:  basic
 batch name: 14-sim-reset
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 15-basic-resolver
 test mode:  c
 test type:  basic
 batch name: 16-sim-arch_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 17-sim-arch_merge
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 18-sim-basic_allowlist
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 19-sim-missing_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 20-live-basic_die
 test mode:  c
 test type:  live
Test 20-live-basic_die%%001-00001 result:   SUCCESS
Test 20-live-basic_die%%002-00001 result:   SUCCESS
Test 20-live-basic_die%%003-00001 result:   SUCCESS
 batch name: 21-live-basic_allow
 test mode:  c
 test type:  live
Test 21-live-basic_allow%%001-00001 result:   SUCCESS
 batch name: 22-sim-basic_chains_array
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 23-sim-arch_all_le_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 24-live-arg_allow
 test mode:  c
 test type:  live
Test 24-live-arg_allow%%001-00001 result:   SUCCESS
 batch name: 25-sim-multilevel_chains_adv
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 26-sim-arch_all_be_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 27-sim-bpf_blk_state
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 28-sim-arch_x86
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 29-sim-pseudo_syscall
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 30-sim-socket_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 31-basic-version_check
 test mode:  c
 test type:  basic
 batch name: 32-live-tsync_allow
 test mode:  c
 test type:  live
Test 32-live-tsync_allow%%001-00001 result:   SUCCESS
 batch name: 33-sim-socket_syscalls_be
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 34-sim-basic_denylist
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 35-sim-negative_one
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 36-sim-ipc_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 37-sim-ipc_syscalls_be
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 38-basic-pfc_coverage
 test mode:  c
 test type:  basic
 batch name: 39-basic-api_level
 test mode:  c
 test type:  basic
 batch name: 40-sim-log
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 41-sim-syscall_priority_arch
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 42-sim-adv_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 43-sim-a2_order
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 44-live-a2_order
 test mode:  c
 test type:  live
Test 44-live-a2_order%%001-00001 result:   SUCCESS
 batch name: 45-sim-chain_code_coverage
 test mode:  c
 test type:  bpf-sim
 batch name: 46-sim-kill_process
 test mode:  c
 test type:  bpf-sim
 batch name: 47-live-kill_process
 test mode:  c
 test type:  live
Test 47-live-kill_process%%001-00001 result:   SUCCESS
 batch name: 48-sim-32b_args
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 49-sim-64b_comparisons
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 50-sim-hash_collision
 test mode:  c
 test type:  bpf-sim
 batch name: 51-live-user_notification
 test mode:  c
 test type:  live
Test 51-live-user_notification%%001-00001 result:   SUCCESS
 batch name: 52-basic-load
 test mode:  c
 test type:  basic
 batch name: 53-sim-binary_tree
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 54-live-binary_tree
 test mode:  c
 test type:  live
Test 54-live-binary_tree%%001-00001 result:   SUCCESS
 batch name: 55-basic-pfc_binary_tree
 test mode:  c
 test type:  basic
 batch name: 56-basic-iterate_syscalls
 test mode:  c
 test type:  basic
 batch name: 57-basic-rawsysrc
 test mode:  c
 test type:  basic
 batch name: 58-live-tsync_notify
 test mode:  c
 test type:  live
Test 58-live-tsync_notify%%001-00001 result:   SUCCESS
Regression Test Summary
 tests run: 11
 tests skipped: 0
 tests passed: 11
 tests failed: 0
 tests errored: 0
============================================================

--------------312FB7917C728875E74D6DAF--
