Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C61C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B521A22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgGTNrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGTNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:47:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F27C061794;
        Mon, 20 Jul 2020 06:47:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6EA9728BC1E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
Organization: Collabora
References: <20200716193141.4068476-1-krisman@collabora.com>
        <20200716193141.4068476-2-krisman@collabora.com>
        <87v9iimrbk.fsf@nanos.tec.linutronix.de>
Date:   Mon, 20 Jul 2020 09:46:59 -0400
In-Reply-To: <87v9iimrbk.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 20 Jul 2020 12:08:47 +0200")
Message-ID: <87lfjepacs.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

Thanks for the valuable feedback!

Thomas Gleixner <tglx@linutronix.de> writes:
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
>> Introduce a mechanism to quickly disable/enable syscall handling for a
>> specific process and redirect to userspace via SIGSYS.  This is useful
>> for processes with parts that require syscall redirection and parts that
>> don't, but who need to perform this boundary crossing really fast,
>> without paying the cost of a system call to reconfigure syscall handling
>> on each boundary transition.  This is particularly important for Windows
>> games running over Wine.
>>
>> The proposed interface looks like this:
>>
>>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start_addr>, <end_addr>, [selector])
>>
>> The range [<start_addr>,<end_addr>] is a part of the process memory map
>> that is allowed to by-pass the redirection code and dispatch syscalls
>> directly, such that in fast paths a process doesn't need to disable the
>> trap nor the kernel has to check the selector.  This is essential to
>> return from SIGSYS to a blocked area without triggering another SIGSYS
>> from rt_sigreturn.
>
> Why isn't rt_sigreturn() exempt from that redirection in the first
> place?

This was actually a design decision for me.

The main use case I'm considering is emulation of applications written
for other OSs (games over wine), which means this dispatcher code is
exposed to applications built against different ABIs, who trigger
syscalls with bogus parameters (from a linux perspective)

In this emulation scenario, I cannot really trust the syscall number
means rt_sigreturn, so I try to only base the dispatcher decision on the
memory region and selector variable.

I think the best we can do is what Andy said: to exempt rt_sigreturn
when it comes from the vdso, for architectures that do it that way.

>
>> ---
>>  arch/Kconfig                          | 20 ++++++
>>  arch/x86/Kconfig                      |  1 +
>>  arch/x86/entry/common.c               |  5 ++
>>  arch/x86/include/asm/thread_info.h    |  4 +-
>>  arch/x86/kernel/signal_compat.c       |  2 +-
>>  fs/exec.c                             |  2 +
>>  include/linux/sched.h                 |  3 +
>>  include/linux/syscall_user_dispatch.h | 50 +++++++++++++++
>>  include/uapi/asm-generic/siginfo.h    |  3 +-
>>  include/uapi/linux/prctl.h            |  5 ++
>>  kernel/Makefile                       |  1 +
>>  kernel/fork.c                         |  1 +
>>  kernel/sys.c                          |  5 ++
>>  kernel/syscall_user_dispatch.c        | 92 +++++++++++++++++++++++++++
>
> A big combo patch is not how we do that. Please split it up into the
> core part and a patch enabling it for a particular architexture.
>
> As I said in my reply to Andy, this wants to go on top of the generic
> entry/exit work stuff:
>
>   https://lore.kernel.org/r/20200716182208.180916541@linutronix.de
>
> and then syscall_user_dispatch.c ends up in kernel/entry/ and the
> dispatching function is not exposed outside of that directory.
>
> I'm going to post a new version later today. Will cc you.

Thanks. Will do!


-- 
Gabriel Krisman Bertazi
