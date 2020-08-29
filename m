Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C6C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A1E207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgH2LJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:09:52 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50379 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbgH2LJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:09:49 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kByjw-001kcF-L1; Sat, 29 Aug 2020 13:09:44 +0200
Received: from p5b13abb5.dip0.t-ipconnect.de ([91.19.171.181] helo=[192.168.178.159])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kByjw-001PBY-A6; Sat, 29 Aug 2020 13:09:44 +0200
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
To:     Rich Felker <dalias@libc.org>
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
 <20200828163057.GY3265@brightrain.aerifal.cx>
 <82b625c2-23cb-69a4-7495-39427430c306@physik.fu-berlin.de>
 <20200828170259.GZ3265@brightrain.aerifal.cx>
 <20200829004939.GB3265@brightrain.aerifal.cx>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <b0e38ede-3860-eb83-615e-ad77f619a3a6@physik.fu-berlin.de>
Date:   Sat, 29 Aug 2020 13:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829004939.GB3265@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.171.181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 8/29/20 2:49 AM, Rich Felker wrote:
> This restored my ability to use strace

I can confirm that. However ...

> and I've written and tested a minimal strace-like hack using
> SECCOMP_RET_USER_NOTIF that works as
> expected on both j2 and qemu-system-sh4, so I think the above is
> correct.

The seccomp live testsuite has regressed.

With your patch:

=============== Sat 29 Aug 2020 12:35:52 PM CEST ===============
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
Test 20-live-basic_die%%003-00001 result:   FAILURE 20-live-basic_die 1 ERRNO rc=38
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
Test 44-live-a2_order%%001-00001 result:   FAILURE 44-live-a2_order 1 ALLOW rc=1
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
Test 51-live-user_notification%%001-00001 result:   FAILURE 51-live-user_notification 5 ALLOW rc=14
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
Test 58-live-tsync_notify%%001-00001 result:   FAILURE 58-live-tsync_notify 6 ALLOW rc=14
Regression Test Summary
 tests run: 11
 tests skipped: 0
 tests passed: 7
 tests failed: 4
 tests errored: 0
============================================================

And without:

=============== Sat 29 Aug 2020 01:03:07 PM CEST ===============
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

To test libseccomp, check out my superh branch from here:

> https://github.com/glaubitz/libseccomp/tree/superh

then build and test with:

# ./autogen.sh && ./configure && make && make check && make check-build && cd tests && ./regression -T live

Maybe Michael Karcher has any idea what's wrong with the strace stuff?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
