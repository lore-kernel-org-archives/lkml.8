Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C42C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D708205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="HRk0SSPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHKVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:08:34 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:08:34 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id n25so17810vsq.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxR96oCE+wXLRBmlK1nLV/rdqqdlhyggKeJpYnzoNUE=;
        b=HRk0SSPpJt5dml1HLDtiPyIZXHX705XuOl0ejBzmbNG5ZXtF/+ZMBIdAx+ZhN5A9Lq
         uTETADwRcUHBT6p1dRfHeUHUGX4hiHxdIjRxtI7LsLqUCQlCsBAmaqRSuTjbwUY5pKgG
         8asyNXqvmAHPzWXS88rRk4EiEP0ai5dqn0NT7fziUX9KEVcDe1vDl1fmx/h6s4ywomTp
         svPoHhB94ndzXXCwxjH9jmro7/nsHCJBsp308PcgbJXKvkyUfZWYMTMJtVWzrqMyPiXW
         n4cBZMFiUNCKsCB2sEIdxz+K6ZUx/Zdnf5lmzWHGEFGqm8FuB9itD7rp5LQ+JV9DCdKy
         zJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxR96oCE+wXLRBmlK1nLV/rdqqdlhyggKeJpYnzoNUE=;
        b=qH/Vu0oeQgdSN7TF4wTg87zWh820d5h43ZuqTCJuZWBfbBjGek2lf9R/IVp6cgCE6W
         F0uHo9J3ma06wAkOxbd1coOPMsKeXZAzu1iib2sYuEPagXjPS3L3aQNLVH0iHZUKI96H
         tO/e0vyoj+84HOTj5Q+u4u1971jal8yxeaO0r+AGStX98JD0K6w48MjX68K4aasSyUy8
         YJBKRmg0twRI5lJbrze2M46yYK+UXsrB8VCYMobZeNzUE2lfA7AisEOl6aeEgTNBslb4
         jOQrCJINXNJR1x0XZviDwYZ7RspXgj8TnKmnKDCT2kH87a3pc8lJIElkGswXTMNj6prY
         8kIA==
X-Gm-Message-State: AOAM5301bneJr/NO4xx/YhAoLsqjY806Yvy7dL2sNhQVYBZLjEHkPxw2
        Ww6bzmk1gIZEnhadnYekqMiN7tyxR8obis6rMLncsg==
X-Google-Smtp-Source: ABdhPJxk3zwRyya/a7EJByypWPbfkJX9g19ATCsI9lx45hB5jHG3kJ8RsEyc7xP4DqYcfycvLqk0dw/0QIVRiU+Hsb8=
X-Received: by 2002:a05:6102:10c2:: with SMTP id t2mr24824591vsr.33.1597180113790;
 Tue, 11 Aug 2020 14:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200811062733.GP3982@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 11 Aug 2020 14:08:22 -0700
Message-ID: <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 10, 2020 at 05:09:58PM -0700, Peter Oskolkov wrote:
> > @@ -27,6 +35,12 @@
> >
> >  static void ipi_mb(void *info)
> >  {
>
> The #ifdef wants to behere, otherwise you'll get a compile warning for
> !RSEQ builds.

Ack. Will do in the next version - for now waiting for the rest to be
worked out.

[...]

>
> Mathieu did mention a few other points that I didn't see addressed:
>
>  - he didn't like abusing the @flags syscall argument for a CPUid;

@flags is not used now; maybe just rename it to something more
generic? @param? Or @options? Or maybe more specific, like @cpu_id?

>  - he wondered if we should support SYNC_CORE + RSEQ.

It seems to me that CMD_PRIVATE_EXPEDITED_RSEQ is basically
CMD_PRIVATE_EXPEDITED_SYNC_CORE with the extra "restart RSEQ CSs"
behavior. Am I missing something? If not, what is the point of
complicating the code as suggested below? Maybe just renaming
CMD_PRIVATE_EXPEDITED_RSEQ to CMD_PRIVATE_EXPEDITED_SYNC_CORE_RSEQ
will do?

>
>
> Not sure we can easily change the syscall at this point, but the latter
> point could be addressed with something like this.
>
> ---
> Index: linux-2.6/kernel/sched/membarrier.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/membarrier.c
> +++ linux-2.6/kernel/sched/membarrier.c
> @@ -374,8 +374,26 @@ static int membarrier_register_private_e
>   */
>  SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>  {
> +       int cflags = 0, int cpuid = -1;
> +
>         if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>                 return -EINVAL;
> +
> +       if (cmd & (MEMBARRIER_CMD_PRIVATE_EXPEDITED |
> +                  MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE |
> +                  MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)) {
> +
> +               if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
> +                       cflags |= MEMBARRIER_FLAG_RSEQ;
> +
> +               if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
> +                       cflags |= MEMBARRIER_FLAG_SYNC_CORE;
> +                       cpuid = flags;
> +               }
> +
> +               cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED;
> +       }
> +
>         switch (cmd) {
>         case MEMBARRIER_CMD_QUERY:
>         {
> @@ -396,18 +414,16 @@ SYSCALL_DEFINE2(membarrier, int, cmd, in
>                 return membarrier_global_expedited();
>         case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
>                 return membarrier_register_global_expedited();
> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> -               return membarrier_private_expedited(0, -1);
>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
>                 return membarrier_register_private_expedited(0);
> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
> -               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);
>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
> -               return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, flags);
>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
> +
> +       case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> +               return membarrier_private_expedited(cflags, cpuid);
> +
>         default:
>                 return -EINVAL;
>         }
>
