Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C20C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F5320716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgICD4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:56:06 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:49068 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgICD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:56:05 -0400
Date:   Wed, 2 Sep 2020 23:56:04 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-ID: <20200903035603.GV3265@brightrain.aerifal.cx>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
 <20200828163057.GY3265@brightrain.aerifal.cx>
 <82b625c2-23cb-69a4-7495-39427430c306@physik.fu-berlin.de>
 <20200828170259.GZ3265@brightrain.aerifal.cx>
 <20200829004939.GB3265@brightrain.aerifal.cx>
 <b0e38ede-3860-eb83-615e-ad77f619a3a6@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e38ede-3860-eb83-615e-ad77f619a3a6@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:09:43PM +0200, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 8/29/20 2:49 AM, Rich Felker wrote:
> > This restored my ability to use strace
> 
> I can confirm that. However ...
> 
> > and I've written and tested a minimal strace-like hack using
> > SECCOMP_RET_USER_NOTIF that works as
> > expected on both j2 and qemu-system-sh4, so I think the above is
> > correct.
> 
> The seccomp live testsuite has regressed.
> 
> With your patch:
> 
> =============== Sat 29 Aug 2020 12:35:52 PM CEST ===============
> Regression Test Report ("regression -T live")
>  batch name: 01-sim-allow
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 02-sim-basic
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 03-sim-basic_chains
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 04-sim-multilevel_chains
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 05-sim-long_jumps
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 06-sim-actions
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 07-sim-db_bug_looping
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 08-sim-subtree_checks
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 09-sim-syscall_priority_pre
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 10-sim-syscall_priority_post
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 11-basic-basic_errors
>  test mode:  c
>  test type:  basic
>  batch name: 12-sim-basic_masked_ops
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 13-basic-attrs
>  test mode:  c
>  test type:  basic
>  batch name: 14-sim-reset
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 15-basic-resolver
>  test mode:  c
>  test type:  basic
>  batch name: 16-sim-arch_basic
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 17-sim-arch_merge
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 18-sim-basic_allowlist
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 19-sim-missing_syscalls
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 20-live-basic_die
>  test mode:  c
>  test type:  live
> Test 20-live-basic_die%%001-00001 result:   SUCCESS
> Test 20-live-basic_die%%002-00001 result:   SUCCESS
> Test 20-live-basic_die%%003-00001 result:   FAILURE 20-live-basic_die 1 ERRNO rc=38
>  batch name: 21-live-basic_allow
>  test mode:  c
>  test type:  live
> Test 21-live-basic_allow%%001-00001 result:   SUCCESS
>  batch name: 22-sim-basic_chains_array
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 23-sim-arch_all_le_basic
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 24-live-arg_allow
>  test mode:  c
>  test type:  live
> Test 24-live-arg_allow%%001-00001 result:   SUCCESS
>  batch name: 25-sim-multilevel_chains_adv
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 26-sim-arch_all_be_basic
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 27-sim-bpf_blk_state
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 28-sim-arch_x86
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 29-sim-pseudo_syscall
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 30-sim-socket_syscalls
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 31-basic-version_check
>  test mode:  c
>  test type:  basic
>  batch name: 32-live-tsync_allow
>  test mode:  c
>  test type:  live
> Test 32-live-tsync_allow%%001-00001 result:   SUCCESS
>  batch name: 33-sim-socket_syscalls_be
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 34-sim-basic_denylist
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 35-sim-negative_one
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 36-sim-ipc_syscalls
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 37-sim-ipc_syscalls_be
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 38-basic-pfc_coverage
>  test mode:  c
>  test type:  basic
>  batch name: 39-basic-api_level
>  test mode:  c
>  test type:  basic
>  batch name: 40-sim-log
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 41-sim-syscall_priority_arch
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 42-sim-adv_chains
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 43-sim-a2_order
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 44-live-a2_order
>  test mode:  c
>  test type:  live
> Test 44-live-a2_order%%001-00001 result:   FAILURE 44-live-a2_order 1 ALLOW rc=1
>  batch name: 45-sim-chain_code_coverage
>  test mode:  c
>  test type:  bpf-sim
>  batch name: 46-sim-kill_process
>  test mode:  c
>  test type:  bpf-sim
>  batch name: 47-live-kill_process
>  test mode:  c
>  test type:  live
> Test 47-live-kill_process%%001-00001 result:   SUCCESS
>  batch name: 48-sim-32b_args
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-sim-fuzz
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 49-sim-64b_comparisons
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 50-sim-hash_collision
>  test mode:  c
>  test type:  bpf-sim
>  batch name: 51-live-user_notification
>  test mode:  c
>  test type:  live
> Test 51-live-user_notification%%001-00001 result:   FAILURE 51-live-user_notification 5 ALLOW rc=14

AFAICT, this test is buggy and cannot possibly work. It attempts to
have SYS_getpid return a 64-bit value and check that the returned
value matches. On 32-bit archs this will be truncated to 32 bits, but
the comparison in the caller still compares against the full 64-bit
value. I have no idea how this seemed to work before.

>  batch name: 52-basic-load
>  test mode:  c
>  test type:  basic
>  batch name: 53-sim-binary_tree
>  test mode:  c
>  test type:  bpf-sim
>  test mode:  c
>  test type:  bpf-valgrind
>  batch name: 54-live-binary_tree
>  test mode:  c
>  test type:  live
> Test 54-live-binary_tree%%001-00001 result:   SUCCESS
>  batch name: 55-basic-pfc_binary_tree
>  test mode:  c
>  test type:  basic
>  batch name: 56-basic-iterate_syscalls
>  test mode:  c
>  test type:  basic
>  batch name: 57-basic-rawsysrc
>  test mode:  c
>  test type:  basic
>  batch name: 58-live-tsync_notify
>  test mode:  c
>  test type:  live
> Test 58-live-tsync_notify%%001-00001 result:   FAILURE 58-live-tsync_notify 6 ALLOW rc=14

This is similar to 51.

I think the commonality of all the failures is that they deal with
return values set by seccomp filters for blocked syscalls, which are
getting clobbered by ENOSYS from the failed syscall here. So I do need
to keep the code path that jumps over the actual syscall if
do_syscall_trace_enter returns -1, but that means
do_syscall_trace_enter must now be responsible for setting the return
value in non-seccomp failure paths.

I'll experiment to see what's still needed if that change is made.

> [...]
> ============================================================
> 
> To test libseccomp, check out my superh branch from here:
> 
> > https://github.com/glaubitz/libseccomp/tree/superh
> 
> then build and test with:
> 
> # ./autogen.sh && ./configure && make && make check && make check-build && cd tests && ./regression -T live
> 
> Maybe Michael Karcher has any idea what's wrong with the strace stuff?

I'd welcome any input, but I think I'm on track to solving this either
way.

Rich
