Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E543C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4902C208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7r4m9+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgHaXI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:08:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A6C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:08:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w11so2455311lfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFOwZqPQy+End9TmkGk8//KnSSeYvzkG/gwOBN2yU+c=;
        b=U7r4m9+EyjAb37Q9nfGOYH+65wJydKc9ZpUlzQSMbBhUrAO638rRw1OfoJo38Y7i0w
         ILyY7Go+C0LtWzuH3KBIhwk+blaoPglXMgiPj6rt9k6gF5wBqjQJt1rc1CvsioG1SlyZ
         TaiJH98zhI5O68YC8POrADP3vwxkml9G2gfY3jCU+pS/zgmX8Tn0ZPaMCvz7pMIefET+
         z4LrBHiJ61leUHbIhOO/PvQzDLJ6OvJd2lsYldtxJbLNcR/0JF5p+1S+lNngBvioBH3u
         oH+sy3bbcDCg1trAaU9et2yI24KVRnpGTbZYOEZFmmYyAqfYaa0sRKdtspsLQV+VYi7K
         YSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFOwZqPQy+End9TmkGk8//KnSSeYvzkG/gwOBN2yU+c=;
        b=rFAkd8R8wE5c98YcElQHBC+7EiqTMYG3eo+CRrbchcemmsu6CvH89I1eoKDlrEIfEg
         gCr+hM2grLBg56jDnoZo09NvTRXuWBtG9K1lmJHUEeyNwlo4OLJUMLFXakBLTM2+NArc
         4uZ5Cv3/iw0KYhyYma8gYqUywfv8lVAC4I5m9SmCDP/2JrkWvt7QH1LK7M4JRwz8vMaK
         JF6ncwJIW3Jhc5YUxdq2eRUv/j05QfvXeM8tdR3ixW2XklKaTIuCNbY2TbVFZ0/gVRTf
         RdyC8U6YpqxRwFbkET2L+MryuqrRwFUg1YcBn2xcvQq4+ZzPbBcSv7BXXwZF6rO2znhO
         gzcA==
X-Gm-Message-State: AOAM532xQqY1b79gAbB0fr599qw32ZSyOO/XzHGw6qI4csu4LKQU3mRP
        CBjtpSnRM/FjW2qRUrQIbhSDmqf5cq4Ztrzp8UW0kjbDreQ=
X-Google-Smtp-Source: ABdhPJwcC+K8YjkWSdaZ0phbx58pLddBVpuLH4E99ms1abUprg6Tf8kQ16VTRgNyVRvhx0TxwXc1bfsHzxWt/xCrQYA=
X-Received: by 2002:a05:6512:1048:: with SMTP id c8mr1663540lfb.101.1598915333216;
 Mon, 31 Aug 2020 16:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200826230225.3782486-1-posk@google.com> <2086453141.23738.1598888098693.JavaMail.zimbra@efficios.com>
In-Reply-To: <2086453141.23738.1598888098693.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 31 Aug 2020 16:08:41 -0700
Message-ID: <CAPNVh5fWuEjyc9SxGt+Ex+bUrbLjUJt4bDhg=03y4jtSAh1igA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 8:35 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>

Thanks for the review!

>
> ----- On Aug 26, 2020, at 7:02 PM, Peter Oskolkov posk@google.com wrote:
> [...]
> >
> > static void ipi_mb(void *info)
> > {
> > +#ifdef CONFIG_RSEQ
> > +     int *flags = info;
> > +
> > +     if (flags && (*flags == MEMBARRIER_FLAG_RSEQ))
> > +             rseq_preempt(current);
> > +#endif
>
> Please lift this into a new ipi_rseq(), which will be defined as an empty function
> if RSEQ is not defined.

Done.

>
>
> >       smp_mb();       /* IPIs should be serializing but paranoid. */
> > }
> >
> > @@ -129,19 +143,26 @@ static int membarrier_global_expedited(void)
> >       return 0;
> > }
> >
> > -static int membarrier_private_expedited(int flags)
> > +static int membarrier_private_expedited(int flags, int cpu_id)
> > {
> >       int cpu;
> >       cpumask_var_t tmpmask;
> >       struct mm_struct *mm = current->mm;
> >
> > -     if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
> > +     if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
>
> I'm not sure why we need to change the behavior from a mask on flags to
> an equality, which means this behaves more like a list of items rather
> than flags.
>
> It's one thing to disallow combining things like SYNC_CORE and RSEQ in the
> ABI, but I wonder why we need to change the flags behavior to an equality
> for the internal flags.

I do not feel too strongly about this, but using "flags & XXX" implies
that flags is a bitmask that can have more than one bit set. I was actually
confused initially by this and was trying to figure out where / how more than
one bit can be set, and where / how this is handled. By explicitly using "=="
the code indicates that (at the moment) this is not a bitmask.

I can revert the change back to "&" if you think it is better than having "==".

>
> >               if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> >                       return -EINVAL;
> >               if (!(atomic_read(&mm->membarrier_state) &
> >                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
> >                       return -EPERM;
> > +     } else if (flags == MEMBARRIER_FLAG_RSEQ) {
> > +             if (!IS_ENABLED(CONFIG_RSEQ))
> > +                     return -EINVAL;
> > +             if (!(atomic_read(&mm->membarrier_state) &
> > +                   MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
> > +                     return -EPERM;
> >       } else {
> > +             BUG_ON(flags != 0);
> >               if (!(atomic_read(&mm->membarrier_state) &
> >                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
> >                       return -EPERM;
> > @@ -174,6 +195,8 @@ static int membarrier_private_expedited(int flags)
> >                */
> >               if (cpu == raw_smp_processor_id())
> >                       continue;
> > +             if (cpu_id >= 0 && cpu != cpu_id)
> > +                     continue;
>
> When the cpu is specified, it seems rather inefficient to iterate on all
> cpus to skip all but the one we are looking for. I suspect we don't want
> to go through the loop in that case.

Done. The code is a bit more complicated now, but definitely more
efficient.

>
> >               p = rcu_dereference(cpu_rq(cpu)->curr);
> >               if (p && p->mm == mm)
> >                       __cpumask_set_cpu(cpu, tmpmask);
> > @@ -181,7 +204,7 @@ static int membarrier_private_expedited(int flags)
> >       rcu_read_unlock();
> >
> >       preempt_disable();
> > -     smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> > +     smp_call_function_many(tmpmask, ipi_mb, &flags, 1);
> >       preempt_enable();
> >
> >       free_cpumask_var(tmpmask);
> > @@ -283,11 +306,18 @@ static int membarrier_register_private_expedited(int
> > flags)
> >           set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
> >           ret;
> >
> > -     if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
> > +     if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
>
> Same comment about changing this internal flags behavior from mask to equality.

Same reply :)

I can revert the change, but it will look weird, imho - the code does not
treat flags as a bitmask, and changing it to actually work with flags a bitmask
will make it more complicated without a real use case at the moment.

>
> >               if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> >                       return -EINVAL;
> >               ready_state =
> >                       MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
> > +     } else if (flags == MEMBARRIER_FLAG_RSEQ) {
> > +             if (!IS_ENABLED(CONFIG_RSEQ))
> > +                     return -EINVAL;
> > +             ready_state =
> > +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY;
> > +     } else {
> > +             BUG_ON(flags != 0);
> >       }
> >
> >       /*
> > @@ -299,6 +329,8 @@ static int membarrier_register_private_expedited(int flags)
> >               return 0;
> >       if (flags & MEMBARRIER_FLAG_SYNC_CORE)
> >               set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
> > +     if (flags & MEMBARRIER_FLAG_RSEQ)
> > +             set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ;
>
> This one still behaves like a mask, so there is a discrepancy between registration
> and action functions.

Yes, and I vaguely remember you saying that commands being distinct bits
is for "discoverability", not for any "ORing" of commands at the moment.

[...]

> > +SYSCALL_DEFINE3(membarrier, int, cmd, int, flags, int, cpu_id)
> > {
> > -     if (unlikely(flags))
> > +     if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>
> I would prefer that we deal with flags and cpu_id entirely here rather than
> half here, half below, with e.g.:
>
> switch (cmd) {
> case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>     if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
>         return -EINVAL;
>     break;
> default:
>     if (unlikely(flags))
>         return -EINVAL;
> }
>
> if (!(flags & MEMBARRIER_CMD_FLAG_CPU))
>     cpu_id = -1;

Done.

[...]
