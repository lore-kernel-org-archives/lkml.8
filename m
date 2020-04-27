Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4FC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5216C2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJSlPJ4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgD0AAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgD0AAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 20:00:41 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034FC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 17:00:40 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id s5so15633926uad.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KGz+0+Cll4o0mawl4NXbvvTUOj3HZ99fsd0YD47xD0=;
        b=lJSlPJ4NUdh+uNKk7ghHIVffAyjwZ66Ca0V0L65xgLVtvtoZ2hlHsTwRpzZalEnm1l
         AXC2pidLYotiYSjTQABfnQsVp3q90k3+3UXnmMGXPDPd1i/YGwmxxVOcQNKcjsfqYC6b
         wFL6AQDkLLEX/xPtT7skDvUmF/evmHIloTZRUjs0hommD/iIuP/O/TRH8+zDqgPG8A0f
         z2E2hId8poEEtxY0WrK0IzuPhu3h95e/TbjCzcO1QHHAuHX4eYKaHkL7tGGrmhb0vVtl
         2XhtrTJHDhoj7dOt921T2VfsFWaVWwAfteGntU8tpyORe1+v5an8GamStfsCuTMzyaSB
         4nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KGz+0+Cll4o0mawl4NXbvvTUOj3HZ99fsd0YD47xD0=;
        b=Y2yrNOaKAQx5k0ONMcl/5K9jwLWE3mM3C0QY3FywPTPJaFiEMMI93OWh9SCE0DB1ZA
         7EKgvUI2A6hJfRVP1x7nkc652BAZKggk9x50OZvf/SKzEd4p9GTGmKTLrMmOCP7GnLh7
         WfsrSeef7UqdlGhQ4OpKUxCDoc1+CsLlmDWXFupw9eK+5xn4whaB8v6aRvWCNpivmy6Q
         +Nw8lmeYph1NmvUJlGD350uT5ExKShvsSAUSbGqEUclVhNOIErRMWZy91SLF+NwXh3py
         Ef3k6A9ZUsH2fe9pyMf4C8EXHuUJ2lgcpDL1hI0CshB3q/VXgkcgbA0/yAWRtz/GQkE1
         Ln+A==
X-Gm-Message-State: AGi0Pub+wBjcR67XFvsok+w9IcdFLRj+E5PIko53be5FpFqRY9aSXzSZ
        vt0It1rcu+dOsVolsQgG+9IsCpYtiiDPeM3vtb0G/w==
X-Google-Smtp-Source: APiQypLhRaHvVZYirK1nkAxRUkuMTKFyoOEV8vmj4IijnYPYkH1zDnh8zdW6PZCDKfO/Prno79JBHuaO2aSQqddQtjY=
X-Received: by 2002:ab0:485:: with SMTP id 5mr14227287uaw.86.1587945638973;
 Sun, 26 Apr 2020 17:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
 <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
 <20200424174025.GA13592@hirez.programming.kicks-ass.net> <CAJuCfpEEp=UVa=WXtXwdKbUa_yZsrmaE=wqhQL7xEYHXcKbg=w@mail.gmail.com>
 <CALvZod4hNWFMErVSCPnPV4TJAhJHH11ta_c30dhOgaWOesQxaA@mail.gmail.com>
In-Reply-To: <CALvZod4hNWFMErVSCPnPV4TJAhJHH11ta_c30dhOgaWOesQxaA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 26 Apr 2020 17:00:27 -0700
Message-ID: <CAJuCfpECDryYL7ia+JH8HZtWRWHtLFFg2ZwtAB4nj=mXDDPENg@mail.gmail.com>
Subject: Re: lockdep warning about possible circular dependency in PSI
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 1:54 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Apr 24, 2020 at 10:52 AM Suren Baghdasaryan <surenb@google.com> w=
rote:
> >
> > On Fri, Apr 24, 2020 at 10:40 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> > >
> > > On Fri, Apr 24, 2020 at 09:34:42AM -0700, Suren Baghdasaryan wrote:
> > > > Sorry to bother you again folks. Any suggestions on how to silence
> > > > this lockdep warning which I believe to be a false positive?
> > > >
> > > > On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> > > > >
> > > > > I received a report about possible circular locking dependency wa=
rning
> > > > > generated from PSI polling code. I think we are protected from th=
is
> > > > > scenario by poll_scheduled atomic but wanted to double-check and =
I=E2=80=99m
> > > > > looking for an advice on how to annotate this case to fix the loc=
kdep
> > > > > warning. I copied the detailed information at the end of this ema=
il
> > > > > but the short story is this:
> > > > >
> > > > > "WARNING: possible circular locking dependency detected" is gener=
ated
> > > > > with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chain =
it
> > > > > describes is:
> > > > >
> > > > > #0
> > > > > kthread_delayed_work_timer_fn()
> > > > >  |
> > > > > worker->lock
> > > > >  |
> > > > > try_to_wake_up()
> > > > >  |
> > > > > p->pi_lock
> > > > >
> > > > > #1
> > > > > sched_fork()
> > > > >  |
> > > > > p->pi_lock
> > > > >  |
> > > > > task_fork_fair()
> > > > >  |
> > > > > rq->lock
> > > > >
> > > > > #2
> > > > > psi_memstall_enter
> > > > >  |
> > > > > rq->lock
> > > > >  |
> > > > > kthread_queue_delayed_work()
> > > > >  |
> > > > > worker->lock
> > >
> > > Irrespective of it actually being a deadlock or not, it is fairly
> > > fragile. Ideally we'd fix #2, we really should minimize the number of
> > > locks nested under rq->lock.
> > >
> > > That said, here's the easy fix, which breaks #0.
> > >
> >
> > Thanks for the suggestion, Peter. Let me digest this and will post a
> > patch with your Suggested-by.
> > Cheers!
> >
>
> I tested on my simple repro and the patch fixes the lockdep splat.
>
> You can add
> Tested-by: Shakeel Butt <shakeelb@google.com>
>

Thanks Shakeel! Will do.

> > > ---
> > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > index bfbfa481be3a..b443bba7dd21 100644
> > > --- a/kernel/kthread.c
> > > +++ b/kernel/kthread.c
> > > @@ -806,14 +806,15 @@ static void kthread_insert_work_sanity_check(st=
ruct kthread_worker *worker,
> > >  /* insert @work before @pos in @worker */
> > >  static void kthread_insert_work(struct kthread_worker *worker,
> > >                                 struct kthread_work *work,
> > > -                               struct list_head *pos)
> > > +                               struct list_head *pos,
> > > +                               struct wake_q_head *wake_q)
> > >  {
> > >         kthread_insert_work_sanity_check(worker, work);
> > >
> > >         list_add_tail(&work->node, pos);
> > >         work->worker =3D worker;
> > >         if (!worker->current_work && likely(worker->task))
> > > -               wake_up_process(worker->task);
> > > +               wake_q_add(wake_q, worker->task);
> > >  }
> > >
> > >  /**
> > > @@ -831,15 +832,19 @@ static void kthread_insert_work(struct kthread_=
worker *worker,
> > >  bool kthread_queue_work(struct kthread_worker *worker,
> > >                         struct kthread_work *work)
> > >  {
> > > -       bool ret =3D false;
> > > +       DEFINE_WAKE_Q(wake_q);
> > >         unsigned long flags;
> > > +       bool ret =3D false;
> > >
> > >         raw_spin_lock_irqsave(&worker->lock, flags);
> > >         if (!queuing_blocked(worker, work)) {
> > > -               kthread_insert_work(worker, work, &worker->work_list)=
;
> > > +               kthread_insert_work(worker, work, &worker->work_list,=
 &wake_q);
> > >                 ret =3D true;
> > >         }
> > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > +
> > > +       wake_up_q(&wake_q);
> > > +
> > >         return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(kthread_queue_work);
> > > @@ -857,6 +862,7 @@ void kthread_delayed_work_timer_fn(struct timer_l=
ist *t)
> > >         struct kthread_delayed_work *dwork =3D from_timer(dwork, t, t=
imer);
> > >         struct kthread_work *work =3D &dwork->work;
> > >         struct kthread_worker *worker =3D work->worker;
> > > +       DEFINE_WAKE_Q(wake_q);
> > >         unsigned long flags;
> > >
> > >         /*
> > > @@ -873,15 +879,18 @@ void kthread_delayed_work_timer_fn(struct timer=
_list *t)
> > >         /* Move the work from worker->delayed_work_list. */
> > >         WARN_ON_ONCE(list_empty(&work->node));
> > >         list_del_init(&work->node);
> > > -       kthread_insert_work(worker, work, &worker->work_list);
> > > +       kthread_insert_work(worker, work, &worker->work_list, &wake_q=
);
> > >
> > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > +
> > > +       wake_up_q(&wake_q);
> > >  }
> > >  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
> > >
> > >  static void __kthread_queue_delayed_work(struct kthread_worker *work=
er,
> > >                                          struct kthread_delayed_work =
*dwork,
> > > -                                        unsigned long delay)
> > > +                                        unsigned long delay,
> > > +                                        struct wake_q_head *wake_q)
> > >  {
> > >         struct timer_list *timer =3D &dwork->timer;
> > >         struct kthread_work *work =3D &dwork->work;
> > > @@ -895,7 +904,7 @@ static void __kthread_queue_delayed_work(struct k=
thread_worker *worker,
> > >          * on that there's no such delay when @delay is 0.
> > >          */
> > >         if (!delay) {
> > > -               kthread_insert_work(worker, work, &worker->work_list)=
;
> > > +               kthread_insert_work(worker, work, &worker->work_list,=
 wake_q);
> > >                 return;
> > >         }
> > >
> > > @@ -928,17 +937,21 @@ bool kthread_queue_delayed_work(struct kthread_=
worker *worker,
> > >                                 unsigned long delay)
> > >  {
> > >         struct kthread_work *work =3D &dwork->work;
> > > +       DEFINE_WAKE_Q(wake_q);
> > >         unsigned long flags;
> > >         bool ret =3D false;
> > >
> > >         raw_spin_lock_irqsave(&worker->lock, flags);
> > >
> > >         if (!queuing_blocked(worker, work)) {
> > > -               __kthread_queue_delayed_work(worker, dwork, delay);
> > > +               __kthread_queue_delayed_work(worker, dwork, delay, &w=
ake_q);
> > >                 ret =3D true;
> > >         }
> > >
> > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > +
> > > +       wake_up_q(&wake_q);
> > > +
> > >         return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> > > @@ -967,6 +980,7 @@ void kthread_flush_work(struct kthread_work *work=
)
> > >                 KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > >                 COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > >         };
> > > +       DEFINE_WAKE_Q(wake_q);
> > >         struct kthread_worker *worker;
> > >         bool noop =3D false;
> > >
> > > @@ -979,15 +993,17 @@ void kthread_flush_work(struct kthread_work *wo=
rk)
> > >         WARN_ON_ONCE(work->worker !=3D worker);
> > >
> > >         if (!list_empty(&work->node))
> > > -               kthread_insert_work(worker, &fwork.work, work->node.n=
ext);
> > > +               kthread_insert_work(worker, &fwork.work, work->node.n=
ext, &wake_q);
> > >         else if (worker->current_work =3D=3D work)
> > >                 kthread_insert_work(worker, &fwork.work,
> > > -                                   worker->work_list.next);
> > > +                                   worker->work_list.next, &wake_q);
> > >         else
> > >                 noop =3D true;
> > >
> > >         raw_spin_unlock_irq(&worker->lock);
> > >
> > > +       wake_up_q(&wake_q);
> > > +
> > >         if (!noop)
> > >                 wait_for_completion(&fwork.done);
> > >  }
> > > @@ -1065,6 +1081,7 @@ bool kthread_mod_delayed_work(struct kthread_wo=
rker *worker,
> > >                               unsigned long delay)
> > >  {
> > >         struct kthread_work *work =3D &dwork->work;
> > > +       DEFINE_WAKE_Q(wake_q);
> > >         unsigned long flags;
> > >         int ret =3D false;
> > >
> > > @@ -1083,9 +1100,12 @@ bool kthread_mod_delayed_work(struct kthread_w=
orker *worker,
> > >
> > >         ret =3D __kthread_cancel_work(work, true, &flags);
> > >  fast_queue:
> > > -       __kthread_queue_delayed_work(worker, dwork, delay);
> > > +       __kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
> > >  out:
> > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > +
> > > +       wake_up_q(&wake_q);
> > > +
> > >         return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-team+unsubscribe@android.com.
> > >
