Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6210FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37354206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="IwhGZX7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHGRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHGRuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:50:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97EBC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:50:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a14so1856124edx.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV60Lqd/s6jkR9RwVRlKW7Xy32P0lIA2VNvjGGWHCBg=;
        b=IwhGZX7LdBz9Um8mRp/QS0j6Q+GbQl8v73j0V8V2WITC6uJ2ifcAkkiIIfaxA9/9ig
         T96guVNcY8tg1p4oKZrQ2H3KYKPVrusWb1ZomNrEMd/NlUlmHSE159rPjcfA4sE2nZSr
         T5WwdJSNJSbR4VYAsuED8Dkk1kfgLjFwLOLGFp680oA4u+TxQvdy4rq5qu/ybULVFECY
         IavpPCYKYmZ13sepQ/4Ka/LOrhSAu+6DtzXg5Hb3KwPWSeY3wH6n1v7KMEHFifcTgCfX
         +AmcTfZFtuy+HMD1eoTuWivbfPh7+xH0mZyMQjwBYYnpZnsbBM6Z5dCuISeyFXGT6YwY
         S8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV60Lqd/s6jkR9RwVRlKW7Xy32P0lIA2VNvjGGWHCBg=;
        b=T98Alh9wGig5UQtAb90ySsIsKmCHqwOjFzcoWe3saNbNnWFGHHvlE5qy/bq6aCrvuq
         OJuT7XmNMykYOPcogbjjYXUsM3T4wL4vdxpKTrQH7Gna1gKTBXj61syyL+tQG0LjnssV
         6Fya6D5bCM/ERLe/9GZFIKYOZcx2ejUSSyOVsQg9e07rET/ZB2Td221XbpEVesWdQ26I
         f9LjdBuNFxDj4CwpBrswDG+rOUCj9mluIb6+ItSk+Y4/5Y/XmsBUK+2TWQeatP2M1bAs
         gcXDdN57Q2mb1AErijnlORC18SSfFUpIBGHql2dha8jrir3Kc1Uu14NLnkfolDidrHU7
         a4JQ==
X-Gm-Message-State: AOAM532xofh6oVAsPfrkUs29IENmKEZkclUbp+KbBfPwo+vUNTXyi5rB
        3HryHJik/gFURjvfX2zJns+UOi9AUh2ZmoPpWER2hg==
X-Google-Smtp-Source: ABdhPJzvhKrW3dF3SpuUWaQUa/eW+G5WCapZOMN4nSQUAw999XeWxTFetxrMHXiBNl2+15joikVxjo+F1zTL04Gwbs0=
X-Received: by 2002:a05:6402:16d0:: with SMTP id r16mr10237222edx.124.1596822653289;
 Fri, 07 Aug 2020 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806170544.382140-1-posk@google.com> <20200807133755.GJ2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200807133755.GJ2674@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 7 Aug 2020 10:50:42 -0700
Message-ID: <CAFTs51VHC5nyAb7bf-jvuYDRwLS5kWP98T336Uu7h+RMFb0ZqA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
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

On Fri, Aug 7, 2020 at 6:38 AM <peterz@infradead.org> wrote:
>

[...]

> I'm thinking even this is a problem, we can end up sending IPIs to CPUs
> outside out partition (they might be NOHZ_FULL) and that's a no-no too.
>
> Something like so perhaps... that really limits it to CPUs that match
> our mm.

Thanks for the suggestion - I'll prepare a v3 based on your and
Mathieu's feedback.

>
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 6be66f52a2ad..bee5e98e6774 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -356,6 +356,7 @@ enum {
>
>  enum {
>         MEMBARRIER_FLAG_SYNC_CORE       = (1U << 0),
> +       MEMBARRIER_FLAG_RSEQ            = (1U << 1),
>  };
>
>  #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 168479a7d61b..4d9b22c2f5e2 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -27,6 +27,11 @@
>
>  static void ipi_mb(void *info)
>  {
> +       int *flags = info;
> +
> +       if (flags && (*flags & MEMBARRIER_FLAG_RSEQ))
> +               rseq_preempt(current);
> +
>         smp_mb();       /* IPIs should be serializing but paranoid. */
>  }
>
> @@ -129,11 +134,11 @@ static int membarrier_global_expedited(void)
>         return 0;
>  }
>
> -static int membarrier_private_expedited(int flags)
> +static int membarrier_private_expedited(int flags, int cpu_id)
>  {
> -       int cpu;
> -       cpumask_var_t tmpmask;
>         struct mm_struct *mm = current->mm;
> +       cpumask_var_t tmpmask;
> +       int cpu;
>
>         if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
>                 if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> @@ -174,6 +179,10 @@ static int membarrier_private_expedited(int flags)
>                  */
>                 if (cpu == raw_smp_processor_id())
>                         continue;
> +
> +               if (cpu_id >= 0 && cpu != cpu_id)
> +                       continue;
> +
>                 p = rcu_dereference(cpu_rq(cpu)->curr);
>                 if (p && p->mm == mm)
>                         __cpumask_set_cpu(cpu, tmpmask);
> @@ -181,7 +190,7 @@ static int membarrier_private_expedited(int flags)
>         rcu_read_unlock();
>
>         preempt_disable();
> -       smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> +       smp_call_function_many(tmpmask, ipi_mb, &flags, 1);
>         preempt_enable();
>
>         free_cpumask_var(tmpmask);
> @@ -362,11 +371,13 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>         case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
>                 return membarrier_register_global_expedited();
>         case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> -               return membarrier_private_expedited(0);
> +               return membarrier_private_expedited(0, -1);
>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
>                 return membarrier_register_private_expedited(0);
>         case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
> -               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
> +               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);
> +       case MEMBERRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
> +               return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, flags);
>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
>         default:
