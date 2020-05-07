Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D88E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRwdOYWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:21:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93FDC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:21:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h26so5322232lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHv1m6LwfP89HVSY8eFBB5eZ2PLAcVQZWj8UEAPI95A=;
        b=uRwdOYWkW1CdUJqiaSg6++KvyTedHprh2g0kMZqq4PkgK49B58kQk3yM+ktdSrqgBG
         XiyzHdz9C4LlFp9zBp6QU9OqtVKXMi8F1zfdMrvP7CBXa9qYPMUhgIDV+8cw5sZL6J5v
         yM1k0A0Jr8UvFVUpByuCTx6MHAH0rLPITPzJeMFwfoZ0n+Laif/VxTtBo11lO9opQ0rP
         unc7xvipDoPGKgVwIeFWVAXd3Y9qUw8XqGR+xlSjFenT74oMEK5hC3skTgJNzxi9JA4U
         f6lEX3cAnY5n7BYG4AXZMVray+UcwXtDz4FKbrKTpCSXROw03q4dEmjjCxuPUTIdi5wE
         tSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHv1m6LwfP89HVSY8eFBB5eZ2PLAcVQZWj8UEAPI95A=;
        b=Wog17s9SwZV2eHHR58D69TK/gmAmeH4L0aUoRzmwoozOX6JwyRiP+y96pwiBduBOUs
         B8Pdw/X938bORRJpXnDooEAE0yTE/Z/xXYPcEFJKJAiNLsRHdgUjsx6mh9Yi1gMaDFxG
         fVKGcE48nb37uUpqMuhxlp43trRbIb+qvEvJO1FBPNCW8eOK+2dA9rQ8qpxKCMRRUtWw
         xPcM47Yv+ZEMpga0b/ybLXp5FdyOo0o+KGaYKmuYVJcC0iuyoXslwlS9c3ySxitZSLhn
         zRwqmRMq32LAVyd9BPoDUuFSoCGTXuopdEn9EhM1IRz4j427TIzj3LNfAyfuBAfT2pRJ
         kavA==
X-Gm-Message-State: AGi0PubEyHZHvkN238rniluQKPYIDT/8KSqJjd9g7IDtaDZHx5enFbCF
        qaLBwvcOqqQdoLTk9KrgVCQq3NDesGnXFUeogBgYtgJX
X-Google-Smtp-Source: APiQypIMWN/orbVpmSThTuouH+2lZZcRWcvRNWCzQL/APK8sPWnGDUaKU8f+4eCKCn4Skc6VqZ56Q/LxroFsmf00Wdk=
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr9110467lfo.25.1588875683088;
 Thu, 07 May 2020 11:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <CAKfTPtADSaFmxE_-qtfgYEQw0A90oma2tEwH=XrE7r=qfRVsaA@mail.gmail.com>
 <20200506180521.GC9773@lorien.usersys.redhat.com> <CAKfTPtC6jEJ00YG6DyKOwxxpzuUEBE48ivoi3njKLCEB88U8LQ@mail.gmail.com>
 <20200507180417.GE19331@lorien.usersys.redhat.com>
In-Reply-To: <20200507180417.GE19331@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 May 2020 20:21:11 +0200
Message-ID: <CAKfTPtD2UegRUuuSDOw735++furT16qMVb1ZxsX7OCq9n_TA0w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix enqueue_task_fair warning some more
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 20:04, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Thu, May 07, 2020 at 05:06:29PM +0200 Vincent Guittot wrote:
> > Hi Phil,
> >
> > On Wed, 6 May 2020 at 20:05, Phil Auld <pauld@redhat.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > Thanks for taking a look. More below...
> > >
> > > On Wed, May 06, 2020 at 06:36:45PM +0200 Vincent Guittot wrote:
> > > > Hi Phil,
> > > >
> > > > - reply to all this time
> > > >
> > > > On Wed, 6 May 2020 at 16:18, Phil Auld <pauld@redhat.com> wrote:
> > > > >
> > > > > sched/fair: Fix enqueue_task_fair warning some more
> > > > >
> > > > > The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > > > > did not fully resolve the issues with the (rq->tmp_alone_branch !=
> > > > > &rq->leaf_cfs_rq_list) warning in enqueue_task_fair. There is a case where
> > > > > the first for_each_sched_entity loop exits due to on_rq, having incompletely
> > > > > updated the list.  In this case the second for_each_sched_entity loop can
> > > > > further modify se. The later code to fix up the list management fails to do
> > > >
> > > > But for the 2nd  for_each_sched_entity, the cfs_rq should already be
> > > > in the list, isn't it ?
> > >
> > > No. In this case we hit the parent not on list case in list_add_leaf_cfs_rq
> > > which sets rq-tmp_alone_branch to cfs_rq->leaf_cfs_rq_list which is not
> > > the same. It returns false expecting the parent to be added later.
> > >
> > > But then the parent doens't get there because it's on_rq.
> > >
> > > >
> > > > The third for_each_entity loop is there for the throttled case but is
> > > > useless for other case
> > > >
> > >
> > > There actually is a throttling involved usually. The second loop breaks out
> > > early because one of the parents is throttled. But not before it advances
> > > se at least once.
> >
> > Ok, that's even because of the throttling that the problem occurs
> >
> > >
> > > Then the 3rd loop doesn't fix the tmp_alone_branch because it doesn't start
> > > with the right se.
> > >
> > > > Could you provide us some details about the use case that creates such
> > > > a situation ?
> > > >
> > >
> > > I admit I had to add trace_printks to get here. Here's what it showed (sorry
> > > for the long lines...)
> > >
> > > 1)  sh-6271  [044]  1271.322317: bprint: enqueue_task_fair: se 0xffffa085e7e30080 on_rq 0 cfs_rq = 0xffffa085e93da200
> > > 2)  sh-6271  [044]  1271.322320: bprint: enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e93da200 onlist 0 tmp_a_b = 0xffffa085ef92c868 &rq->l_c_r_l = 0xffffa085ef92c868
> > > 3)  sh-6271  [044]  1271.322322: bprint: enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2: parent not onlist  Set t_a_branch to 0xffffa085e93da340 rq->l_c_r_l = 0xffffa085ef92c868
> > > 4)  sh-6271  [044]  1271.322323: bprint: enqueue_task_fair: se 0xffffa085e93d8800 on_rq 1 cfs_rq = 0xffffa085dbfaea00
> > > 5)  sh-6271  [044]  1271.322324: bprint: enqueue_task_fair: Done enqueues, se=0xffffa085e93d8800, pid=3642
> > > 6)  sh-6271  [044]  1271.322326: bprint: enqueue_task_fair: update: cfs 0xffffa085e48ce000 throttled, se = 0xffffa085dbfafc00
> > > 7)  sh-6271  [044]  1271.322326: bprint: enqueue_task_fair: current se = 0xffffa085dbfafc00, orig_se = 0xffffa085e7e30080
> > > 8)  sh-6271  [044]  1271.322327: bprint: enqueue_task_fair: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e48ce000 onlist 1 tmp_a_b = 0xffffa085e93da340 &rq->l_c_r_l = 0xffffa085ef92c868
> > > 9)  sh-6271  [044]  1271.322328: bprint: enqueue_task_fair: Add_leaf_rq: cpu 17: nr_r 0; cfs 0xffffa085ef92bf80 onlist 1 tmp_a_b = 0xffffa085e93da340 &rq->l_c_r_l = 0xffffa085ef92c868
> > > 10) sh-6271  [044]  1271.672599: bprint: enqueue_task_fair: cpu 17: rq->tmp_alone_branch = 0xffffa085e93da340 != &rq->leaf_cfs_rq_list = 0xffffa085ef92c868
> > >
> > >
> > > lines 1 and 4 are from the first loop in enqueue_task_fair. Line 2 and 3 are from the
> > > first call to list_add_leaf_rq with line 2 being at the start and line 3 showing which
> > > of the 3 cases we hit.
> > >
> > > Line 5 is right after the first loop.
> > >
> > > Line 6 is the second trip through the 2nd loop and is in the if(throttled) condition.
> > > Line 7 is right below the enqueue_throttle label.
> > >
> > > Lines 8 and 9 are from the fixup loop and since onlist is set for both of these it doesn't
> > > do anything. But we've left rq->tmp_alone_branch pointing to the cfs_rq->leaf_cfs_rq_list
> > > from the one call to list_add_leaf_rq that did something and so the cleanup doesn't work.
> > >
> > > Based on the comment at the clean up, it looked like it expected the se to be what it was
> > > when the first loop broke not whatever it was left at after the second loop.  Could have
> > > been NULL there too I guess but I didn't hit that case.
> > >
> > > This is 100% reproducible. And completely gone with the fix. I have a trace showing that.
> > >
> > > Does that make more sense?
> >
> > Yes, Good catch
> > And thanks for the detailed explanation.
> >
> > >
> > >
> > >
> > > Cheers,
> > > Phil
> > >
> > >
> > > > > what is needed because se does not point to the sched_entity which broke out
> > > > > of the first loop.
> > > > >
> > > > > Address this issue by saving the se pointer when the first loop exits and
> > > > > resetting it before doing the fix up, if needed.
> > > > >
> > > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > > > ---
> > > > >  kernel/sched/fair.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 02f323b85b6d..719c996317e3 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -5432,6 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >  {
> > > > >         struct cfs_rq *cfs_rq;
> > > > >         struct sched_entity *se = &p->se;
> > > > > +       struct sched_entity *saved_se = NULL;
> > > > >         int idle_h_nr_running = task_has_idle_policy(p);
> > > > >
> > > > >         /*
> > > > > @@ -5466,6 +5467,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >                 flags = ENQUEUE_WAKEUP;
> > > > >         }
> > > > >
> > > > > +       saved_se = se;
> >
> > TBH, I don't like saving and going back to the saved se and loop one
> > more time on them
> >
> > > > >         for_each_sched_entity(se) {
> > > > >                 cfs_rq = cfs_rq_of(se);
> >
> > Could you add something like below in the 2nd loop instead ?
>
> This one solves the problem as well with no other visible issues.
>
> Do you want to spin it into a real patch?

You can respin your patch in a V2 with the proposal.
A suggested-by from me will be enough

Thanks
Vincent
>
> You can have my {reported/tested}-by or whatever you need.
>
>
> Cheers,
> Phil
>
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5486,6 +5486,13 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >                 /* end evaluation on encountering a throttled cfs_rq */
> >                 if (cfs_rq_throttled(cfs_rq))
> >                         goto enqueue_throttle;
> > +
> > +               /*
> > +                * One parent has been throttled and cfs_rq removed from the
> > +                * list. Add it back to not break the leaf list.
> > +                */
> > +               if (throttled_hierarchy(cfs_rq))
> > +                       list_add_leaf_cfs_rq(cfs_rq);
> >         }
> >
> >  enqueue_throttle:
> >
> > > > >
> > > > > @@ -5510,6 +5512,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >                  * leaf list maintenance, resulting in triggering the assertion
> > > > >                  * below.
> > > > >                  */
> > > > > +               if (saved_se)
> > > > > +                       se = saved_se;
> > > > >                 for_each_sched_entity(se) {
> > > > >                         cfs_rq = cfs_rq_of(se);
> > > > >
> > > > > --
> > > > > 2.18.0
> > > > >
> > > > >
> > > > > Cheers,
> > > > > Phil
> > > > >
> > > >
> > >
> > > --
> > >
> >
>
> --
>
