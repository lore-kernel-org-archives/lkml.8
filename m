Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D712074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595994223;
	bh=0/XwXlzsN++/dVqNDxGGq/Z/PQlQgWXOuYRBreapNio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FoPoUKFVIy1LmRN+GwUW7+L8MyylltY/5x3m1u/+bCSi8o8aUDqbXfsk5XHSnYyBx
	 vgaVX6GKPDB4ip2V/EEpbhQ5M8paPg4yb2NPOQy2kc5J/l2UwLJbPkesZbwXkO//yt
	 KY42Y8trZkHAdAvs6U5M/t8vIzN7jnwcLj9eYJvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2Dnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:43:41 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF862078E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595994220;
        bh=0/XwXlzsN++/dVqNDxGGq/Z/PQlQgWXOuYRBreapNio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbRCxZPb+lXVLWwdf20/W3ygNORNLAmK9aiFdw7WvWybV40mRjZxkIqqBV1R9Xgwp
         QU1ZFlm/S3junAHlHNGKqy8muwdhcAvOTlITPhPWMTPQdOcrI3uq1BAYyXKwaJfWq5
         lhxC3sgpkKjbZDKvqZN+hrS8Xfnz/+8akhNr5SQY=
Received: by mail-wm1-f52.google.com with SMTP id 9so1378859wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 20:43:40 -0700 (PDT)
X-Gm-Message-State: AOAM531Qmz9M6QcaZccQEuZSiiPw2Zt0WXfxdyddWjRUENKC1ORUzEPe
        gClznvCjkrSs8kRNkDj1kmKuhionQllBMr6Nh+dRBg==
X-Google-Smtp-Source: ABdhPJxYzlcMI9RTnlFnzXZInhPcDwtvYXT+CkwNID1wjXaaUgFR2XbGsrA/sFXQiCQE8CQjMjO7s+Tkjukh+7BvIzE=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr6651703wmc.138.1595994218953;
 Tue, 28 Jul 2020 20:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202229.1195682-1-krisman@collabora.com> <20200728202229.1195682-3-krisman@collabora.com>
In-Reply-To: <20200728202229.1195682-3-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 20:43:27 -0700
X-Gmail-Original-Message-ID: <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
Message-ID: <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> In preparation to remove TIF_IA32, add wrapper that check the process
> has IA32 ABI without using the flag directly.

Thank you for doing this, but let's please do it right.  There is,
fundamentally, no such thing as a "process with IA32 ABI".

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/events/core.c             | 2 +-
>  arch/x86/events/intel/ds.c         | 2 +-
>  arch/x86/events/intel/lbr.c        | 2 +-
>  arch/x86/include/asm/compat.h      | 2 +-
>  arch/x86/include/asm/thread_info.h | 2 ++
>  arch/x86/kernel/perf_regs.c        | 2 +-
>  arch/x86/oprofile/backtrace.c      | 2 +-
>  7 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4103665c6e03..42dff74c6197 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2491,7 +2491,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
>         struct stack_frame_ia32 frame;
>         const struct stack_frame_ia32 __user *fp;
>
> -       if (!test_thread_flag(TIF_IA32))
> +       if (!TASK_IA32(current))
>                 return 0;

if (user_64bit_mode(regs))
  return 0;

>
>         cs_base = get_segment_base(regs->cs);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index dc43cc124e09..27d1cc1f3d05 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1261,7 +1261,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
>                 old_to = to;
>
>  #ifdef CONFIG_X86_64
> -               is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
> +               is_64bit = kernel_ip(to) || !TASK_IA32(current);

PeterZ, does PEBS not give us a CPL?  Is it really just IP?

Anyway, this should probably be:

is_64bit = kernel_ip(to) || user_64bit_mode(regs) || !user_mode(regs);


>  #ifdef CONFIG_X86_64
> -       is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
> +       is64 = kernel_ip((unsigned long)addr) || !TASK_IA32(current);

Same as above.

> diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> index d4edf281fff4..d39f9b3ae683 100644
> --- a/arch/x86/include/asm/compat.h
> +++ b/arch/x86/include/asm/compat.h
> @@ -181,7 +181,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
>  {
>         compat_uptr_t sp;
>
> -       if (test_thread_flag(TIF_IA32)) {
> +       if (TASK_IA32(current)) {
>                 sp = task_pt_regs(current)->sp;

Christoph, you spend a *lot* more time looking at this stuff lately
than I do, but this looks totally wrong.  Shouldn't this be either:

sp = task_pt_regs(current)->sp;

/* This might be a compat syscall issued via int $0x80 from 64-bit-ABI code. */
if (user_64bit_mode(task_pt_regs(current))
  sp -= 128;

Or perhaps the same thing without the user_64bit_mode() check at all?
There shouldn't be much if any harm done by respecting the redzone
unnecessarily.

> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -123,7 +123,7 @@ int perf_reg_validate(u64 mask)
>
>  u64 perf_reg_abi(struct task_struct *task)
>  {
> -       if (test_tsk_thread_flag(task, TIF_IA32))
> +       if (TASK_IA32(task))
>                 return PERF_SAMPLE_REGS_ABI_32;
>         else
>                 return PERF_SAMPLE_REGS_ABI_64;

Surely this should be:

if (user_64bit_mode(task_pt_regs(regs))
  return PERF_SAMPLE_REGS_ABI_64;
else
  return PERF_SAMPLE_REGS_ABI_32;

> diff --git a/arch/x86/oprofile/backtrace.c b/arch/x86/oprofile/backtrace.c
> index a2488b6e27d6..3f1086afa297 100644
> --- a/arch/x86/oprofile/backtrace.c
> +++ b/arch/x86/oprofile/backtrace.c
> @@ -49,7 +49,7 @@ x86_backtrace_32(struct pt_regs * const regs, unsigned int depth)
>         struct stack_frame_ia32 *head;
>
>         /* User process is IA32 */
> -       if (!current || !test_thread_flag(TIF_IA32))
> +       if (!current || !TASK_IA32(current))
>                 return 0;

if (user_64bit_mode(regs))
  return 0;


And now you don't need the TASK_IA32 macro :)

All of the above being said, I'm wondering how many of these profiling
users remember to check whether the task is a kernel thread.  And I
have no idea what task_pt_regs(current) contains in a kernel thread.

--Andy
