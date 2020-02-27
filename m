Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD3F2468A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgRm/FMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbgB0O6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:58:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40366 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgB0O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:58:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so2305523lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTf53l+ERC5tzgGssL0BoGJrw05AN4ObqwUxsfjBbYg=;
        b=WgRm/FMpgAMUYeUo5G+W95Ep9TyZ3+12iwn9yu2TbN0mbhqC8/C8NdAhKm9pc1LnfT
         lBDciFBrXY7o2vRVi5f6Jz3/xNrPlJ8I8YoP+uI4i0T4ru3G4MCSBwmQ73muYHNmr3f8
         RzExTPNy+JDdxh6TOv7NetqK2RWzCkl8QyT4Ehp9g1kikwZSFoZF5Qqo0mbgqYxsFuCh
         rtBwTwDo8X6BvROUEYaWN9Hpm4vlXFYKewVhyMUycqer3QPIrXaVZNykXcsf2UKR7wc3
         4+SuPu5j/zfgBL6eqWL0Em1u8HGUpjcNwbEcai8t58ThkjcoVM9OsOjAQVVy5tHJVFtE
         3NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTf53l+ERC5tzgGssL0BoGJrw05AN4ObqwUxsfjBbYg=;
        b=Vxvz2HOydu/RHargaiULmK1EN7N4aGLBOaF/7MsNN7Bywq3skEKORdMPlA4nqZX5ba
         pLuxcmykBhW3cT9njDpTq70vQiCOgzdmbZ2xygDT+3FsG7XxHaDui0fOr4SLYSEqculo
         Rumbbo0UmtEmvw1Y5gcGdi7Ft/RlKH71hSp7KNbwF1zhDqwGoGkbQcOvOVzFA5OsmZrX
         z6TsjXY0GnfPsbu92mfwkrMfUP7ICpithGLTgg7W3qvytWT+GQndCQDaeZ4FP1E0vWku
         iVagy4Q0RyztHVHPZdRuyhm08VbAO2tSiuwqwFJ31mKSveKqB5vJbarmI5U28ynAehQ0
         hyew==
X-Gm-Message-State: ANhLgQ2nBTHUvkBczIVZA0pyWrotHawdRETbY3Rbnu3DzznVZW0/WiBX
        AkXrkfGrC8mGnhWBrLEjPYx2FyRVTruo5hm6wnrbsw==
X-Google-Smtp-Source: ADFU+vuvFgIeyOpTemZqCZN3AmVSSSHqtxc3oIx/4jV9DCXe1IbFO14Gg3vhvScB5v4QZqGBZqJDCVoJxosiWBTbhe8=
X-Received: by 2002:a19:6903:: with SMTP id e3mr6662lfc.25.1582815493879; Thu,
 27 Feb 2020 06:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com> <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com> <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
In-Reply-To: <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Feb 2020 15:58:02 +0100
Message-ID: <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 at 14:10, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 27 Feb 2020 at 12:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 26.02.20 21:01, Vincent Guittot wrote:
> > > On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
> > >>
> > >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> > >>
> > >>> When a cfs_rq is throttled, its group entity is dequeued and its running
> > >>> tasks are removed. We must update runnable_avg with current h_nr_running
> > >>> and update group_se->runnable_weight with new h_nr_running at each level
> >
> >                                               ^^^
> >
> > Shouldn't this be 'current' rather 'new' h_nr_running for
> > group_se->runnable_weight? IMHO, you want to cache the current value
> > before you add/subtract task_delta.
>
> hmm... it can't be current in both places. In my explanation,
> "current" means the current situation when we started to throttle cfs
> and "new" means the new situation after we finished to throttle the
> cfs. I should probably use old and new to prevent any
> misunderstanding.

I'm about to send a new version to fix some minor changes: The if
statement should have some  { }   as there are some on the else part

Would it be better for you if i use old and new instead of current and
new in the commit message ?

>
> That being said, we need to update runnable_avg with the old
> h_nr_running: the one before we started to throttle the cfs which is
> the value saved in group_se->runnable_weight. Once we have updated
> runnable_avg, we save the new h_nr_running in
> group_se->runnable_weight that will be used for next updates.
>
> >
> > >>> of the hierarchy.
> > >>
> > >> You'll also need to do this for task enqueue/dequeue inside of a
> > >> throttled hierarchy, I'm pretty sure.
> > >
> > > AFAICT, this is already done with patch "sched/pelt: Add a new
> > > runnable average signal" when task is enqueued/dequeued inside a
> > > throttled hierarchy
> > >
> > >>
> > >>>
> > >>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> > >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >>> ---
> > >>> This patch applies on top of tip/sched/core
> > >>>
> > >>>  kernel/sched/fair.c | 10 ++++++++++
> > >>>  1 file changed, 10 insertions(+)
> > >>>
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index fcc968669aea..6d46974e9be7 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> > >>>
> > >>>               if (dequeue)
> > >>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> > >>> +             else {
> > >>> +                     update_load_avg(qcfs_rq, se, 0);
> > >>> +                     se_update_runnable(se);
> > >>> +             }
> > >>> +
> > >>>               qcfs_rq->h_nr_running -= task_delta;
> > >>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> > >>>
> > >>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> > >>>               cfs_rq = cfs_rq_of(se);
> > >>>               if (enqueue)
> > >>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > >>> +             else {
> > >>> +                     update_load_avg(cfs_rq, se, 0);
> > >>
> > >>
> > >>> +                     se_update_runnable(se);
> > >>> +             }
> > >>> +
> > >>>               cfs_rq->h_nr_running += task_delta;
> > >>>               cfs_rq->idle_h_nr_running += idle_task_delta;
