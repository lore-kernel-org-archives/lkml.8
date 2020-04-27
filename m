Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DAC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E39206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8kGvYRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgD0SsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgD0SsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:48:03 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89197C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:48:02 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id a7so10622406uak.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cFn00JHO3//cIrlbFatqYT5gKfrzHc2bMxqCPhl3DDk=;
        b=Z8kGvYRNc3cU4CYxNXtCQpRxxZmVaZfpzE/MSz3U/6rA4aTwWVgKQa4V4AN01u0OlD
         WbZeyFUDbAxHOvqxU6EB6lc4Qe3GW4aCnRLCZoRj/eAswrAaiSZpH3Qlmk7ZM/BZrLm3
         7Dn2kHG/tMV0nai5SbBRPg4Ztg1d0O8LKr+74e3QjYiJwbUbUCdcJJB7rzKRwmAcKiXW
         mMQEaXZnrdVVjd+yQRvHqsGSh8E5lXX4i2xkvj8ET0RcHCkL/jWrblLA3lSHDK19CkjG
         uG8VzDKK3JnWVxGrLiGARmzLzUoVlUDsSPE+JWgincUgONghx4Vf/elPzgmGLW7s+v7g
         ef6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cFn00JHO3//cIrlbFatqYT5gKfrzHc2bMxqCPhl3DDk=;
        b=QnHehJVFwgRZ3B6aRMu/pY9+sVe+wAe06d/gANOV21XWQf/LQBBqxLqkU8AmS6qLqr
         7asThGb3EWx15kLiL3oSwhMAJmL/rkeM+HGdP2WQipAmzvRugw4CEB7J4nb/o0awLKS9
         pNBad9l3hczl0Q18nL8asDR9Ifql9Yd+dA5C6+92Rkl6r31ANZnYYflCgUCZdMjg/u1l
         JL8aqIVRCRKs06ndcl5OCpISS+Oix4ogeUeIOxF3wuLJ224NP0Vk3uLDxs4PWjsXuY6T
         mHWgQr+uW8ezm1fz+IvRrqN0om7zDBUYpHgjASGEbrlAX/RDEnwMIIC3Xlj8sqyDZXOO
         yLmw==
X-Gm-Message-State: AGi0Pubo8bnCChYHYqiW4aoUUxCS4/hFwLkYBLfqT2vP1VnGsVLHN4Qs
        c30HuuTgmRUlm+plWOeMNw+zfQ/lgsHtYCKonipQAA==
X-Google-Smtp-Source: APiQypLu6VKxQGNQLLvqKo1WMOawCQmpu4RzXh4UZIdVYvclWAiYpQcdFRX9JT1mAatyGGYXf/UXXMUFbn6PhtF1OwM=
X-Received: by 2002:ab0:202:: with SMTP id 2mr17746122uas.42.1588013281404;
 Mon, 27 Apr 2020 11:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
 <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
 <20200424174025.GA13592@hirez.programming.kicks-ass.net> <CAJuCfpEEp=UVa=WXtXwdKbUa_yZsrmaE=wqhQL7xEYHXcKbg=w@mail.gmail.com>
 <CALvZod4hNWFMErVSCPnPV4TJAhJHH11ta_c30dhOgaWOesQxaA@mail.gmail.com> <CAJuCfpECDryYL7ia+JH8HZtWRWHtLFFg2ZwtAB4nj=mXDDPENg@mail.gmail.com>
In-Reply-To: <CAJuCfpECDryYL7ia+JH8HZtWRWHtLFFg2ZwtAB4nj=mXDDPENg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 27 Apr 2020 11:47:50 -0700
Message-ID: <CAJuCfpE+qHpOVU9JS+CEVKgdJMgZB8jG3KKq=AMFNZXCgvE69Q@mail.gmail.com>
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

On Sun, Apr 26, 2020 at 5:00 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Fri, Apr 24, 2020 at 1:54 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 10:52 AM Suren Baghdasaryan <surenb@google.com>=
 wrote:
> > >
> > > On Fri, Apr 24, 2020 at 10:40 AM Peter Zijlstra <peterz@infradead.org=
> wrote:
> > > >
> > > > On Fri, Apr 24, 2020 at 09:34:42AM -0700, Suren Baghdasaryan wrote:
> > > > > Sorry to bother you again folks. Any suggestions on how to silenc=
e
> > > > > this lockdep warning which I believe to be a false positive?
> > > > >
> > > > > On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > > > > >
> > > > > > I received a report about possible circular locking dependency =
warning
> > > > > > generated from PSI polling code. I think we are protected from =
this
> > > > > > scenario by poll_scheduled atomic but wanted to double-check an=
d I=E2=80=99m
> > > > > > looking for an advice on how to annotate this case to fix the l=
ockdep
> > > > > > warning. I copied the detailed information at the end of this e=
mail
> > > > > > but the short story is this:
> > > > > >
> > > > > > "WARNING: possible circular locking dependency detected" is gen=
erated
> > > > > > with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chai=
n it
> > > > > > describes is:
> > > > > >
> > > > > > #0
> > > > > > kthread_delayed_work_timer_fn()
> > > > > >  |
> > > > > > worker->lock
> > > > > >  |
> > > > > > try_to_wake_up()
> > > > > >  |
> > > > > > p->pi_lock
> > > > > >
> > > > > > #1
> > > > > > sched_fork()
> > > > > >  |
> > > > > > p->pi_lock
> > > > > >  |
> > > > > > task_fork_fair()
> > > > > >  |
> > > > > > rq->lock
> > > > > >
> > > > > > #2
> > > > > > psi_memstall_enter
> > > > > >  |
> > > > > > rq->lock
> > > > > >  |
> > > > > > kthread_queue_delayed_work()
> > > > > >  |
> > > > > > worker->lock
> > > >
> > > > Irrespective of it actually being a deadlock or not, it is fairly
> > > > fragile. Ideally we'd fix #2, we really should minimize the number =
of
> > > > locks nested under rq->lock.
> > > >
> > > > That said, here's the easy fix, which breaks #0.
> > > >
> > >
> > > Thanks for the suggestion, Peter. Let me digest this and will post a
> > > patch with your Suggested-by.
> > > Cheers!
> > >
> >
> > I tested on my simple repro and the patch fixes the lockdep splat.
> >
> > You can add
> > Tested-by: Shakeel Butt <shakeelb@google.com>
> >
>
> Thanks Shakeel! Will do.
>
> > > > ---
> > > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > > index bfbfa481be3a..b443bba7dd21 100644
> > > > --- a/kernel/kthread.c
> > > > +++ b/kernel/kthread.c
> > > > @@ -806,14 +806,15 @@ static void kthread_insert_work_sanity_check(=
struct kthread_worker *worker,
> > > >  /* insert @work before @pos in @worker */
> > > >  static void kthread_insert_work(struct kthread_worker *worker,
> > > >                                 struct kthread_work *work,
> > > > -                               struct list_head *pos)
> > > > +                               struct list_head *pos,
> > > > +                               struct wake_q_head *wake_q)
> > > >  {
> > > >         kthread_insert_work_sanity_check(worker, work);
> > > >
> > > >         list_add_tail(&work->node, pos);
> > > >         work->worker =3D worker;
> > > >         if (!worker->current_work && likely(worker->task))
> > > > -               wake_up_process(worker->task);
> > > > +               wake_q_add(wake_q, worker->task);
> > > >  }
> > > >
> > > >  /**
> > > > @@ -831,15 +832,19 @@ static void kthread_insert_work(struct kthrea=
d_worker *worker,
> > > >  bool kthread_queue_work(struct kthread_worker *worker,
> > > >                         struct kthread_work *work)
> > > >  {
> > > > -       bool ret =3D false;
> > > > +       DEFINE_WAKE_Q(wake_q);
> > > >         unsigned long flags;
> > > > +       bool ret =3D false;
> > > >
> > > >         raw_spin_lock_irqsave(&worker->lock, flags);
> > > >         if (!queuing_blocked(worker, work)) {
> > > > -               kthread_insert_work(worker, work, &worker->work_lis=
t);
> > > > +               kthread_insert_work(worker, work, &worker->work_lis=
t, &wake_q);
> > > >                 ret =3D true;
> > > >         }
> > > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > > +
> > > > +       wake_up_q(&wake_q);
> > > > +
> > > >         return ret;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(kthread_queue_work);
> > > > @@ -857,6 +862,7 @@ void kthread_delayed_work_timer_fn(struct timer=
_list *t)
> > > >         struct kthread_delayed_work *dwork =3D from_timer(dwork, t,=
 timer);
> > > >         struct kthread_work *work =3D &dwork->work;
> > > >         struct kthread_worker *worker =3D work->worker;
> > > > +       DEFINE_WAKE_Q(wake_q);
> > > >         unsigned long flags;
> > > >
> > > >         /*
> > > > @@ -873,15 +879,18 @@ void kthread_delayed_work_timer_fn(struct tim=
er_list *t)
> > > >         /* Move the work from worker->delayed_work_list. */
> > > >         WARN_ON_ONCE(list_empty(&work->node));
> > > >         list_del_init(&work->node);
> > > > -       kthread_insert_work(worker, work, &worker->work_list);
> > > > +       kthread_insert_work(worker, work, &worker->work_list, &wake=
_q);
> > > >
> > > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > > +
> > > > +       wake_up_q(&wake_q);
> > > >  }
> > > >  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
> > > >
> > > >  static void __kthread_queue_delayed_work(struct kthread_worker *wo=
rker,
> > > >                                          struct kthread_delayed_wor=
k *dwork,
> > > > -                                        unsigned long delay)
> > > > +                                        unsigned long delay,
> > > > +                                        struct wake_q_head *wake_q=
)
> > > >  {
> > > >         struct timer_list *timer =3D &dwork->timer;
> > > >         struct kthread_work *work =3D &dwork->work;
> > > > @@ -895,7 +904,7 @@ static void __kthread_queue_delayed_work(struct=
 kthread_worker *worker,
> > > >          * on that there's no such delay when @delay is 0.
> > > >          */
> > > >         if (!delay) {
> > > > -               kthread_insert_work(worker, work, &worker->work_lis=
t);
> > > > +               kthread_insert_work(worker, work, &worker->work_lis=
t, wake_q);
> > > >                 return;
> > > >         }
> > > >
> > > > @@ -928,17 +937,21 @@ bool kthread_queue_delayed_work(struct kthrea=
d_worker *worker,
> > > >                                 unsigned long delay)
> > > >  {
> > > >         struct kthread_work *work =3D &dwork->work;
> > > > +       DEFINE_WAKE_Q(wake_q);
> > > >         unsigned long flags;
> > > >         bool ret =3D false;
> > > >
> > > >         raw_spin_lock_irqsave(&worker->lock, flags);
> > > >
> > > >         if (!queuing_blocked(worker, work)) {
> > > > -               __kthread_queue_delayed_work(worker, dwork, delay);
> > > > +               __kthread_queue_delayed_work(worker, dwork, delay, =
&wake_q);
> > > >                 ret =3D true;
> > > >         }
> > > >
> > > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > > +
> > > > +       wake_up_q(&wake_q);
> > > > +
> > > >         return ret;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> > > > @@ -967,6 +980,7 @@ void kthread_flush_work(struct kthread_work *wo=
rk)
> > > >                 KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn=
),
> > > >                 COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > > >         };
> > > > +       DEFINE_WAKE_Q(wake_q);
> > > >         struct kthread_worker *worker;
> > > >         bool noop =3D false;
> > > >
> > > > @@ -979,15 +993,17 @@ void kthread_flush_work(struct kthread_work *=
work)
> > > >         WARN_ON_ONCE(work->worker !=3D worker);
> > > >
> > > >         if (!list_empty(&work->node))
> > > > -               kthread_insert_work(worker, &fwork.work, work->node=
.next);
> > > > +               kthread_insert_work(worker, &fwork.work, work->node=
.next, &wake_q);
> > > >         else if (worker->current_work =3D=3D work)
> > > >                 kthread_insert_work(worker, &fwork.work,
> > > > -                                   worker->work_list.next);
> > > > +                                   worker->work_list.next, &wake_q=
);
> > > >         else
> > > >                 noop =3D true;
> > > >
> > > >         raw_spin_unlock_irq(&worker->lock);
> > > >
> > > > +       wake_up_q(&wake_q);
> > > > +
> > > >         if (!noop)
> > > >                 wait_for_completion(&fwork.done);
> > > >  }
> > > > @@ -1065,6 +1081,7 @@ bool kthread_mod_delayed_work(struct kthread_=
worker *worker,
> > > >                               unsigned long delay)
> > > >  {
> > > >         struct kthread_work *work =3D &dwork->work;
> > > > +       DEFINE_WAKE_Q(wake_q);
> > > >         unsigned long flags;
> > > >         int ret =3D false;
> > > >
> > > > @@ -1083,9 +1100,12 @@ bool kthread_mod_delayed_work(struct kthread=
_worker *worker,
> > > >
> > > >         ret =3D __kthread_cancel_work(work, true, &flags);
> > > >  fast_queue:
> > > > -       __kthread_queue_delayed_work(worker, dwork, delay);
> > > > +       __kthread_queue_delayed_work(worker, dwork, delay, &wake_q)=
;
> > > >  out:
> > > >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > > > +
> > > > +       wake_up_q(&wake_q);
> > > > +
> > > >         return ret;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> > > >

Patch is posted at https://lkml.org/lkml/2020/4/27/985 . Had to
include linux/sched/wake_q.h and fix a long line but other than that
it's unchanged.
Thanks!

> > > > --
> > > > To unsubscribe from this group and stop receiving emails from it, s=
end an email to kernel-team+unsubscribe@android.com.
> > > >
