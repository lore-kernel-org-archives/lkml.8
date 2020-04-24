Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59AC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CDE20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTy0nVvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgDXRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbgDXRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:52:51 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A01C09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:52:51 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id 10so2975611vkr.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oCkpHjUDe5r5NXfpo6Bv1Tz6lsKJUGkgn2Pt+jfQ0XE=;
        b=qTy0nVvdde1XDjJOmdgVtdAGQp9sFh6CkMckB5X66cuku9ILEMB/9pf4ZJ6xj8oSWW
         4MiD9AFO1J9jKv3CzKG1t/oHqwTNOC6RA+tYaBZz8JXHJ3es+/PNmBcqwBj0JqvDiSJK
         8UJLA7SaUZP2TqLMtPRA7kQ126WamrYIG0HbnfWDdbIdf56+CTb/mRvz+/1eSOsMyfE3
         DTK1LLBOOdrg/MbgUZCcZlkqOkYUVJS6LCQfEmRfusWnKz6vzcwWq7zFcgNL/mx4paDM
         p8fKH2btOiQMUobl2sA7LJCt8hAlLHOQVGkw2OS8HejZFPqcHV7ZOYwmxzVAl9ugnU4s
         mcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oCkpHjUDe5r5NXfpo6Bv1Tz6lsKJUGkgn2Pt+jfQ0XE=;
        b=NWYHejx+3cn/RXI/01VtYU9rIGl0ISHP5e6nEbPARtMv0gxw2+sx30vD5LmYYa1ZSs
         fzxyZDdq+BO5R/iX7qID6Rm3ZNYObRYGNEZB5AofYImHs5JI58FGDMyp5XylVwoLFk3k
         XmWirygmj2af92L09H4ROkw8iZAB255UKMdApu50V+D7vqzTkO3R67k+GPlCWostaB9r
         kezIutYtaSI50ap4AP0Hu8tiWjlpOrlXsIkNKAthIvHxIr10uqPWQTMfLW2qy5+jiffA
         bdf3byo3UkSPJqk5x8UoisGF0CMxwA7cUf8FfbM4E3KniKkIciy38lOHkJOqjoF41Lcy
         Tx9w==
X-Gm-Message-State: AGi0PuabtdTul0vovTN9sMPJrghDRfdDh7aZ3uuAODv2dSt/rNKd3gb8
        cBD3qifinX0cCnyNnqepxx6qR1jnJSfR9bNpN0GXzg==
X-Google-Smtp-Source: APiQypLpY8DBWbB9/6iMHGx/3VuQ5SXe7Qs+6032/K531TJwNc7GM794qXWdiUIRImYYJAz3gXQl+0997C8VJIYczEw=
X-Received: by 2002:a1f:a844:: with SMTP id r65mr8841300vke.56.1587750769869;
 Fri, 24 Apr 2020 10:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
 <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com> <20200424174025.GA13592@hirez.programming.kicks-ass.net>
In-Reply-To: <20200424174025.GA13592@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Apr 2020 10:52:38 -0700
Message-ID: <CAJuCfpEEp=UVa=WXtXwdKbUa_yZsrmaE=wqhQL7xEYHXcKbg=w@mail.gmail.com>
Subject: Re: lockdep warning about possible circular dependency in PSI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:40 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Fri, Apr 24, 2020 at 09:34:42AM -0700, Suren Baghdasaryan wrote:
> > Sorry to bother you again folks. Any suggestions on how to silence
> > this lockdep warning which I believe to be a false positive?
> >
> > On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google.com> =
wrote:
> > >
> > > I received a report about possible circular locking dependency warnin=
g
> > > generated from PSI polling code. I think we are protected from this
> > > scenario by poll_scheduled atomic but wanted to double-check and I=E2=
=80=99m
> > > looking for an advice on how to annotate this case to fix the lockdep
> > > warning. I copied the detailed information at the end of this email
> > > but the short story is this:
> > >
> > > "WARNING: possible circular locking dependency detected" is generated
> > > with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chain it
> > > describes is:
> > >
> > > #0
> > > kthread_delayed_work_timer_fn()
> > >  |
> > > worker->lock
> > >  |
> > > try_to_wake_up()
> > >  |
> > > p->pi_lock
> > >
> > > #1
> > > sched_fork()
> > >  |
> > > p->pi_lock
> > >  |
> > > task_fork_fair()
> > >  |
> > > rq->lock
> > >
> > > #2
> > > psi_memstall_enter
> > >  |
> > > rq->lock
> > >  |
> > > kthread_queue_delayed_work()
> > >  |
> > > worker->lock
>
> Irrespective of it actually being a deadlock or not, it is fairly
> fragile. Ideally we'd fix #2, we really should minimize the number of
> locks nested under rq->lock.
>
> That said, here's the easy fix, which breaks #0.
>

Thanks for the suggestion, Peter. Let me digest this and will post a
patch with your Suggested-by.
Cheers!

> ---
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index bfbfa481be3a..b443bba7dd21 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -806,14 +806,15 @@ static void kthread_insert_work_sanity_check(struct=
 kthread_worker *worker,
>  /* insert @work before @pos in @worker */
>  static void kthread_insert_work(struct kthread_worker *worker,
>                                 struct kthread_work *work,
> -                               struct list_head *pos)
> +                               struct list_head *pos,
> +                               struct wake_q_head *wake_q)
>  {
>         kthread_insert_work_sanity_check(worker, work);
>
>         list_add_tail(&work->node, pos);
>         work->worker =3D worker;
>         if (!worker->current_work && likely(worker->task))
> -               wake_up_process(worker->task);
> +               wake_q_add(wake_q, worker->task);
>  }
>
>  /**
> @@ -831,15 +832,19 @@ static void kthread_insert_work(struct kthread_work=
er *worker,
>  bool kthread_queue_work(struct kthread_worker *worker,
>                         struct kthread_work *work)
>  {
> -       bool ret =3D false;
> +       DEFINE_WAKE_Q(wake_q);
>         unsigned long flags;
> +       bool ret =3D false;
>
>         raw_spin_lock_irqsave(&worker->lock, flags);
>         if (!queuing_blocked(worker, work)) {
> -               kthread_insert_work(worker, work, &worker->work_list);
> +               kthread_insert_work(worker, work, &worker->work_list, &wa=
ke_q);
>                 ret =3D true;
>         }
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
> +
> +       wake_up_q(&wake_q);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_queue_work);
> @@ -857,6 +862,7 @@ void kthread_delayed_work_timer_fn(struct timer_list =
*t)
>         struct kthread_delayed_work *dwork =3D from_timer(dwork, t, timer=
);
>         struct kthread_work *work =3D &dwork->work;
>         struct kthread_worker *worker =3D work->worker;
> +       DEFINE_WAKE_Q(wake_q);
>         unsigned long flags;
>
>         /*
> @@ -873,15 +879,18 @@ void kthread_delayed_work_timer_fn(struct timer_lis=
t *t)
>         /* Move the work from worker->delayed_work_list. */
>         WARN_ON_ONCE(list_empty(&work->node));
>         list_del_init(&work->node);
> -       kthread_insert_work(worker, work, &worker->work_list);
> +       kthread_insert_work(worker, work, &worker->work_list, &wake_q);
>
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
> +
> +       wake_up_q(&wake_q);
>  }
>  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
>
>  static void __kthread_queue_delayed_work(struct kthread_worker *worker,
>                                          struct kthread_delayed_work *dwo=
rk,
> -                                        unsigned long delay)
> +                                        unsigned long delay,
> +                                        struct wake_q_head *wake_q)
>  {
>         struct timer_list *timer =3D &dwork->timer;
>         struct kthread_work *work =3D &dwork->work;
> @@ -895,7 +904,7 @@ static void __kthread_queue_delayed_work(struct kthre=
ad_worker *worker,
>          * on that there's no such delay when @delay is 0.
>          */
>         if (!delay) {
> -               kthread_insert_work(worker, work, &worker->work_list);
> +               kthread_insert_work(worker, work, &worker->work_list, wak=
e_q);
>                 return;
>         }
>
> @@ -928,17 +937,21 @@ bool kthread_queue_delayed_work(struct kthread_work=
er *worker,
>                                 unsigned long delay)
>  {
>         struct kthread_work *work =3D &dwork->work;
> +       DEFINE_WAKE_Q(wake_q);
>         unsigned long flags;
>         bool ret =3D false;
>
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         if (!queuing_blocked(worker, work)) {
> -               __kthread_queue_delayed_work(worker, dwork, delay);
> +               __kthread_queue_delayed_work(worker, dwork, delay, &wake_=
q);
>                 ret =3D true;
>         }
>
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
> +
> +       wake_up_q(&wake_q);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> @@ -967,6 +980,7 @@ void kthread_flush_work(struct kthread_work *work)
>                 KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
>                 COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>         };
> +       DEFINE_WAKE_Q(wake_q);
>         struct kthread_worker *worker;
>         bool noop =3D false;
>
> @@ -979,15 +993,17 @@ void kthread_flush_work(struct kthread_work *work)
>         WARN_ON_ONCE(work->worker !=3D worker);
>
>         if (!list_empty(&work->node))
> -               kthread_insert_work(worker, &fwork.work, work->node.next)=
;
> +               kthread_insert_work(worker, &fwork.work, work->node.next,=
 &wake_q);
>         else if (worker->current_work =3D=3D work)
>                 kthread_insert_work(worker, &fwork.work,
> -                                   worker->work_list.next);
> +                                   worker->work_list.next, &wake_q);
>         else
>                 noop =3D true;
>
>         raw_spin_unlock_irq(&worker->lock);
>
> +       wake_up_q(&wake_q);
> +
>         if (!noop)
>                 wait_for_completion(&fwork.done);
>  }
> @@ -1065,6 +1081,7 @@ bool kthread_mod_delayed_work(struct kthread_worker=
 *worker,
>                               unsigned long delay)
>  {
>         struct kthread_work *work =3D &dwork->work;
> +       DEFINE_WAKE_Q(wake_q);
>         unsigned long flags;
>         int ret =3D false;
>
> @@ -1083,9 +1100,12 @@ bool kthread_mod_delayed_work(struct kthread_worke=
r *worker,
>
>         ret =3D __kthread_cancel_work(work, true, &flags);
>  fast_queue:
> -       __kthread_queue_delayed_work(worker, dwork, delay);
> +       __kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
>  out:
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
> +
> +       wake_up_q(&wake_q);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
