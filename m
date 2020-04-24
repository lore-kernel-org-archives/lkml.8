Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C5EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E26215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQAv4mmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDXUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDXUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:54:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BBC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:54:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so8889742lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9dJvXPU3DQGo927h5SbiXa/eVORWW9OISLNR38eR+cg=;
        b=gQAv4mmn2dGW8w8sPoZ02DjgnhpwTXyv3KiWCMDKJoLIw26RuXV7sri3zh4p6qYPj+
         tBF+1j5U0hBSdIpQAwzolNnC2El7f0gMgPQejwlHvCkfwMow+LD9m75VA3zG36YofYuE
         Gq/e6X9qUI9uxPSOS1qPCDp+91y8BGTfI21mAJHvUgPBTHdni9REJ2QBtPiFQzEixz9Y
         XkMqRSs/oKX5NZF2+kywShBa8hwLgMkDw11p0kRq6zV08ituZ5TWs9G7sCweWAtTKobR
         gI+fbujZD/nfdQUmaDOJYMaqIODIahqn/Jf/30QWN2t3gUWC+oVraQ7SadxUALfbHP6B
         ND1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9dJvXPU3DQGo927h5SbiXa/eVORWW9OISLNR38eR+cg=;
        b=Pvfls2TEnfF0mjPTntt4yG0ajVKVQvZiQ15P7TxbtNHJevaH+ZgIW1fub2ztRtFvne
         CshBC8pRnvFLMKMWOpMlKfnjTUQCwLulwhUvM3ihT/nF5jfb4hHNpM9lG/esiGvNYW/k
         LuLoI0AgMEzwREkby2TkjyK2HsDUOytG5RK/JLf0x0lKxvtr4HIHayYfHB7IfeaBW8Pu
         /YMSyacTUlXmNilGBUiKVgLqF3eEMEnHPgdQmYQ2hg+3p91VyZXFWY5lCnDEoaZKR2E6
         AllMOzIvp3yn97MYhpBpspbU8fiSQJHS6whf7CC0lVjAPCpECjZl49NqBta9XL5WK9rN
         zwDg==
X-Gm-Message-State: AGi0PuY5sS+Yw/PUNBOMwemese0OUmNalveVJFivWaWj+7zI46ym7FHA
        jj+/pzbUg7DdIcN9vT1BZGFdEsen+/DsN8D1Q4f0hg==
X-Google-Smtp-Source: APiQypLvQfUIpzW+Yf4SM9wdhP87exMsH3aw4+bwoKfQsmHNRGc+VFDjYp9ZQpc5USTT9x3Bw5HXwjORAKo6iB/dMi0=
X-Received: by 2002:a19:c1d3:: with SMTP id r202mr7371882lff.216.1587761650052;
 Fri, 24 Apr 2020 13:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
 <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
 <20200424174025.GA13592@hirez.programming.kicks-ass.net> <CAJuCfpEEp=UVa=WXtXwdKbUa_yZsrmaE=wqhQL7xEYHXcKbg=w@mail.gmail.com>
In-Reply-To: <CAJuCfpEEp=UVa=WXtXwdKbUa_yZsrmaE=wqhQL7xEYHXcKbg=w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 Apr 2020 13:53:58 -0700
Message-ID: <CALvZod4hNWFMErVSCPnPV4TJAhJHH11ta_c30dhOgaWOesQxaA@mail.gmail.com>
Subject: Re: lockdep warning about possible circular dependency in PSI
To:     Suren Baghdasaryan <surenb@google.com>
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

On Fri, Apr 24, 2020 at 10:52 AM Suren Baghdasaryan <surenb@google.com> wro=
te:
>
> On Fri, Apr 24, 2020 at 10:40 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >
> > On Fri, Apr 24, 2020 at 09:34:42AM -0700, Suren Baghdasaryan wrote:
> > > Sorry to bother you again folks. Any suggestions on how to silence
> > > this lockdep warning which I believe to be a false positive?
> > >
> > > On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google.com=
> wrote:
> > > >
> > > > I received a report about possible circular locking dependency warn=
ing
> > > > generated from PSI polling code. I think we are protected from this
> > > > scenario by poll_scheduled atomic but wanted to double-check and I=
=E2=80=99m
> > > > looking for an advice on how to annotate this case to fix the lockd=
ep
> > > > warning. I copied the detailed information at the end of this email
> > > > but the short story is this:
> > > >
> > > > "WARNING: possible circular locking dependency detected" is generat=
ed
> > > > with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chain it
> > > > describes is:
> > > >
> > > > #0
> > > > kthread_delayed_work_timer_fn()
> > > >  |
> > > > worker->lock
> > > >  |
> > > > try_to_wake_up()
> > > >  |
> > > > p->pi_lock
> > > >
> > > > #1
> > > > sched_fork()
> > > >  |
> > > > p->pi_lock
> > > >  |
> > > > task_fork_fair()
> > > >  |
> > > > rq->lock
> > > >
> > > > #2
> > > > psi_memstall_enter
> > > >  |
> > > > rq->lock
> > > >  |
> > > > kthread_queue_delayed_work()
> > > >  |
> > > > worker->lock
> >
> > Irrespective of it actually being a deadlock or not, it is fairly
> > fragile. Ideally we'd fix #2, we really should minimize the number of
> > locks nested under rq->lock.
> >
> > That said, here's the easy fix, which breaks #0.
> >
>
> Thanks for the suggestion, Peter. Let me digest this and will post a
> patch with your Suggested-by.
> Cheers!
>

I tested on my simple repro and the patch fixes the lockdep splat.

You can add
Tested-by: Shakeel Butt <shakeelb@google.com>

> > ---
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index bfbfa481be3a..b443bba7dd21 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -806,14 +806,15 @@ static void kthread_insert_work_sanity_check(stru=
ct kthread_worker *worker,
> >  /* insert @work before @pos in @worker */
> >  static void kthread_insert_work(struct kthread_worker *worker,
> >                                 struct kthread_work *work,
> > -                               struct list_head *pos)
> > +                               struct list_head *pos,
> > +                               struct wake_q_head *wake_q)
> >  {
> >         kthread_insert_work_sanity_check(worker, work);
> >
> >         list_add_tail(&work->node, pos);
> >         work->worker =3D worker;
> >         if (!worker->current_work && likely(worker->task))
> > -               wake_up_process(worker->task);
> > +               wake_q_add(wake_q, worker->task);
> >  }
> >
> >  /**
> > @@ -831,15 +832,19 @@ static void kthread_insert_work(struct kthread_wo=
rker *worker,
> >  bool kthread_queue_work(struct kthread_worker *worker,
> >                         struct kthread_work *work)
> >  {
> > -       bool ret =3D false;
> > +       DEFINE_WAKE_Q(wake_q);
> >         unsigned long flags;
> > +       bool ret =3D false;
> >
> >         raw_spin_lock_irqsave(&worker->lock, flags);
> >         if (!queuing_blocked(worker, work)) {
> > -               kthread_insert_work(worker, work, &worker->work_list);
> > +               kthread_insert_work(worker, work, &worker->work_list, &=
wake_q);
> >                 ret =3D true;
> >         }
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > +
> > +       wake_up_q(&wake_q);
> > +
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_queue_work);
> > @@ -857,6 +862,7 @@ void kthread_delayed_work_timer_fn(struct timer_lis=
t *t)
> >         struct kthread_delayed_work *dwork =3D from_timer(dwork, t, tim=
er);
> >         struct kthread_work *work =3D &dwork->work;
> >         struct kthread_worker *worker =3D work->worker;
> > +       DEFINE_WAKE_Q(wake_q);
> >         unsigned long flags;
> >
> >         /*
> > @@ -873,15 +879,18 @@ void kthread_delayed_work_timer_fn(struct timer_l=
ist *t)
> >         /* Move the work from worker->delayed_work_list. */
> >         WARN_ON_ONCE(list_empty(&work->node));
> >         list_del_init(&work->node);
> > -       kthread_insert_work(worker, work, &worker->work_list);
> > +       kthread_insert_work(worker, work, &worker->work_list, &wake_q);
> >
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > +
> > +       wake_up_q(&wake_q);
> >  }
> >  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
> >
> >  static void __kthread_queue_delayed_work(struct kthread_worker *worker=
,
> >                                          struct kthread_delayed_work *d=
work,
> > -                                        unsigned long delay)
> > +                                        unsigned long delay,
> > +                                        struct wake_q_head *wake_q)
> >  {
> >         struct timer_list *timer =3D &dwork->timer;
> >         struct kthread_work *work =3D &dwork->work;
> > @@ -895,7 +904,7 @@ static void __kthread_queue_delayed_work(struct kth=
read_worker *worker,
> >          * on that there's no such delay when @delay is 0.
> >          */
> >         if (!delay) {
> > -               kthread_insert_work(worker, work, &worker->work_list);
> > +               kthread_insert_work(worker, work, &worker->work_list, w=
ake_q);
> >                 return;
> >         }
> >
> > @@ -928,17 +937,21 @@ bool kthread_queue_delayed_work(struct kthread_wo=
rker *worker,
> >                                 unsigned long delay)
> >  {
> >         struct kthread_work *work =3D &dwork->work;
> > +       DEFINE_WAKE_Q(wake_q);
> >         unsigned long flags;
> >         bool ret =3D false;
> >
> >         raw_spin_lock_irqsave(&worker->lock, flags);
> >
> >         if (!queuing_blocked(worker, work)) {
> > -               __kthread_queue_delayed_work(worker, dwork, delay);
> > +               __kthread_queue_delayed_work(worker, dwork, delay, &wak=
e_q);
> >                 ret =3D true;
> >         }
> >
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > +
> > +       wake_up_q(&wake_q);
> > +
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> > @@ -967,6 +980,7 @@ void kthread_flush_work(struct kthread_work *work)
> >                 KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> >                 COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> >         };
> > +       DEFINE_WAKE_Q(wake_q);
> >         struct kthread_worker *worker;
> >         bool noop =3D false;
> >
> > @@ -979,15 +993,17 @@ void kthread_flush_work(struct kthread_work *work=
)
> >         WARN_ON_ONCE(work->worker !=3D worker);
> >
> >         if (!list_empty(&work->node))
> > -               kthread_insert_work(worker, &fwork.work, work->node.nex=
t);
> > +               kthread_insert_work(worker, &fwork.work, work->node.nex=
t, &wake_q);
> >         else if (worker->current_work =3D=3D work)
> >                 kthread_insert_work(worker, &fwork.work,
> > -                                   worker->work_list.next);
> > +                                   worker->work_list.next, &wake_q);
> >         else
> >                 noop =3D true;
> >
> >         raw_spin_unlock_irq(&worker->lock);
> >
> > +       wake_up_q(&wake_q);
> > +
> >         if (!noop)
> >                 wait_for_completion(&fwork.done);
> >  }
> > @@ -1065,6 +1081,7 @@ bool kthread_mod_delayed_work(struct kthread_work=
er *worker,
> >                               unsigned long delay)
> >  {
> >         struct kthread_work *work =3D &dwork->work;
> > +       DEFINE_WAKE_Q(wake_q);
> >         unsigned long flags;
> >         int ret =3D false;
> >
> > @@ -1083,9 +1100,12 @@ bool kthread_mod_delayed_work(struct kthread_wor=
ker *worker,
> >
> >         ret =3D __kthread_cancel_work(work, true, &flags);
> >  fast_queue:
> > -       __kthread_queue_delayed_work(worker, dwork, delay);
> > +       __kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
> >  out:
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> > +
> > +       wake_up_q(&wake_q);
> > +
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
