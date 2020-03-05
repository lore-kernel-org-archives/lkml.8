Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E21206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+riw4qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCEWCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:02:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33169 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgCEWCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:02:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so498810otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkyyN4vs7hmuZ4CbUD7BU2cWnhuKIj2A0l67otNaJ4s=;
        b=g+riw4qfowCwPaGzcjiT7QiROk1OXt2ChiLhGcDHkPTIOn2I1Z2+SLqmJc2UcSVLSc
         MckYtgpFPBm93URKQ/nlKJGt/Hf2oUhKd7A9U5Kj8stDj8tbyAgMIh4EYe98PFVNLXJR
         tQ4apUhyMklYrGd+s9XGIIm1pf+kR0P8HUvfHLVGST0UAVlzLNw8ifHm2Bz0UQyZK/9H
         o/zeNcosD6GMdZvjR5IhrnBOBGTcJBLD5v3yW16gHymsTeqCnt3Z+9EA23+LQYAncP1C
         gyUwTFwwHeQf8PMSFLOX4JxeWQp6UJuIOygYNmJt7w0fEQ2rYPGbAsE6V9Yfu3jk3Er6
         /1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkyyN4vs7hmuZ4CbUD7BU2cWnhuKIj2A0l67otNaJ4s=;
        b=j7+Vw65rbdMt7d01PxAI3dWi+l9IAkKy2k4lRWXcJSP05Ut8gCPYgWHvU2me9e8qUp
         4vPTWVYdn2WFerGQ7rUkmBUx4mX657xGBdwLd2oIp5j0DVp+QrNPhKX5Clh+bex7TJ++
         O7BguMDk6i+wRPLL3X45u/oczHx08ru77bwhlMj+8xPlWsQRjjhEqE8eZpP76cMU01fo
         pNBRFYPTNNoY78xpbSNQRxwBrGJL/HWDIqJjpSqiaJFqaKT6SSUVZYvxYQ1GchqDiIqJ
         zj5fymJAqcvvQdPa8gEgBicpAott2xjBd61elFlQaFIAw5CHFgTL0vVHHCGv8np/yVQO
         dQdA==
X-Gm-Message-State: ANhLgQ27UySQIF6DP6M3W1lihYQMzN46zSu5M2yAmKaVID3sQUiicaud
        UYiWFgWPoxm02BwTmw1EC8dlQ82pIg9KqLmHht+hMQ==
X-Google-Smtp-Source: ADFU+vvf3kFwa/7EwmrAOfJfr0tJS13Ag8J2rBOKScn1yLhpYWtavx2spnN5GSEzypmLyBNAi4MCP0lMQ0MZYJhqoWs=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr43762oti.32.1583445738182;
 Thu, 05 Mar 2020 14:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20200305215953.257399-1-jannh@google.com>
In-Reply-To: <20200305215953.257399-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 5 Mar 2020 23:01:51 +0100
Message-ID: <CAG48ez1Kr3xmRZbJ4W8cMCFdvLnLscv02QizWJ0WOuh=bi+Xpw@mail.gmail.com>
Subject: Re: [PATCH] exit: Move preemption fixup up, move blocking operations down
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 11:00 PM Jann Horn <jannh@google.com> wrote:
> With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> non-preemptible context look untidy; after the main oops, the kernel prints
> a "sleeping function called from invalid context" report because
> exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> fixup.
>
> It looks like the same thing applies to profile_task_exit() and
> kcov_task_exit().
>
> Fix it by moving the preemption fixup up and the calls to
> profile_task_exit() and kcov_task_exit() down.
>
> Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> As so often, I have no idea which tree this should go through. tip? mm?
>
>  kernel/exit.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2833ffb0c211..db77c540aa92 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -713,8 +713,12 @@ void __noreturn do_exit(long code)
>         struct task_struct *tsk = current;
>         int group_dead;
>
> -       profile_task_exit(tsk);
> -       kcov_task_exit(tsk);
> +       /*
> +        * We can get here from a kernel oops, sometimes with preemption off.
> +        * Start by checking for critical errors.
> +        * Then fix up important state like USER_DS and preemption.
> +        * Then do everything else.
> +        */
>
>         WARN_ON(blk_needs_flush_plug(tsk));
>
> @@ -732,6 +736,17 @@ void __noreturn do_exit(long code)
>          */
>         set_fs(USER_DS);
>
> +       if (unlikely(in_atomic())) {
> +               pr_info("note: %s[%d] exited with preempt_count %d\n",
> +                       current->comm, task_pid_nr(current),
> +                       preempt_count());
> +               preempt_count_set(PREEMPT_ENABLED);
> +       }
> +
> +       profile_task_exit(tsk);
> +       kcov_task_exit(tsk);
> +
> +
>         ptrace_event(PTRACE_EVENT_EXIT, code);

Ugh, I don't know where that extra whitespace comes from... I'll resend.
