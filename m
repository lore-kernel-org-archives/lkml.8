Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784EDC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E0D21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhTbWlqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgBLOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:47:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40384 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgBLOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:47:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so1796739lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9iMxDXlfk87YsgzDeP791j5DHdY7d352oDqG74g8oE=;
        b=mhTbWlqB4B/YnOIkDMFmGC6d/h8lPpOoSODi42Nd5NoLs/r7sztqO9brEUNE2SfevL
         VLvHLu+aQ+cHhJPmtMx2XNyV1KGiWarcffK538VyXy6UCht7aKyoPnVd6QDZe00qVbJt
         1r71KDsGfB+s/JjT8iHMJvovEbTBC9ANzQZYIIFL7dD6VGtBhMdFkbifTbyVXhYU887+
         5jcCBwVhEPMto1tbExEGjM+tAbnBKJRjwlUY0KZ0Cpc6pdNAj3qMdJI43rV8FXCTST42
         HadSVppithhIn/MJ9hiLPajTcWMctR70R3Mlc8y+APcOLegiK5WQfdU6KzKhTGXtFG14
         ltWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9iMxDXlfk87YsgzDeP791j5DHdY7d352oDqG74g8oE=;
        b=jpCIMlE7nXhhiF6iPiaMPfR+8kWyGLvA9rZGOsrVqHRhH9z76CkN+r/r72sOqydqv3
         BcEHwko2qSiOB/9l5v9OucULkJkauH0oULvTkgx2lYt5sa0KpntG4JUOictAPR1689tw
         Jb/jkHSjhkWnvZqDPNZ+BezIff0Hm9EI2E38f8OsDva1jFhAZv5XScrbMHA56gOfHuui
         FZrelsi5TlChnmnKmtBO9T8J7KVNb3TtOIabnyXbVx4fYxYD0ybmU61rp9ZYqR8ZkGtb
         smCje+mRsAhc7tUPIXfftqwi+THxkxxL1WfYTXFEeFhHfBsT1lZPMX/yrXAp8urSuoJC
         2PgA==
X-Gm-Message-State: APjAAAXtdDI9jyNEZlIzg6U3AQM6kdeFM5lrpZu6i8iWRFBn8bBAz5+j
        BGSbbjI7JlMS+Mw+uZ7Q4U/VMeAnOl7YncnEhJzbzg==
X-Google-Smtp-Source: APXvYqxka93P9g6KFjVSoTaMOubCrne0KDBr3L5bwLfQyBl/LLgHmBKzN0ckBLfufjR6il1qbAtVVFuZsCJHTAqBk70=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr6880686lfp.190.1581518862177;
 Wed, 12 Feb 2020 06:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-2-vincent.guittot@linaro.org> <20200212132036.GT3420@suse.de>
In-Reply-To: <20200212132036.GT3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Feb 2020 15:47:30 +0100
Message-ID: <CAKfTPtAM=kgF7Fz-JKFY+s_k5KFirs-8Bub3s1Eqtq7P0NMa0w@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: reorder enqueue/dequeue_task_fair path
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 14:20, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 11, 2020 at 06:46:48PM +0100, Vincent Guittot wrote:
> > The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> > is split in 2 distinct parts for throttled cfs_rq without any added value
> > but making code less readable.
> >
> > Change the code ordering such that everything related to a cfs_rq
> > (throttled or not) will be done in the same loop.
> >
> > In addition, the same steps ordering is used when updating a cfs_rq:
> > - update_load_avg
> > - update_cfs_group
> > - update *h_nr_running
> >
> > No functional and performance changes are expected and have been noticed
> > during tests.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 42 ++++++++++++++++++++----------------------
> >  1 file changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a0ce83e835a..a1ea02b5362e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5259,32 +5259,31 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >               cfs_rq = cfs_rq_of(se);
> >               enqueue_entity(cfs_rq, se, flags);
> >
> > -             /*
> > -              * end evaluation on encountering a throttled cfs_rq
> > -              *
> > -              * note: in the case of encountering a throttled cfs_rq we will
> > -              * post the final h_nr_running increment below.
> > -              */
> > -             if (cfs_rq_throttled(cfs_rq))
> > -                     break;
> >               cfs_rq->h_nr_running++;
> >               cfs_rq->idle_h_nr_running += idle_h_nr_running;
> >
> > +             /* end evaluation on encountering a throttled cfs_rq */
> > +             if (cfs_rq_throttled(cfs_rq))
> > +                     goto enqueue_throttle;
> > +
> >               flags = ENQUEUE_WAKEUP;
> >       }
> >
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> > -             cfs_rq->h_nr_running++;
> > -             cfs_rq->idle_h_nr_running += idle_h_nr_running;
> >
> > +             /* end evaluation on encountering a throttled cfs_rq */
> >               if (cfs_rq_throttled(cfs_rq))
> > -                     break;
> > +                     goto enqueue_throttle;
> > AFAICT, there are in tip/sched/core
> >               update_load_avg(cfs_rq, se, UPDATE_TG);
> >               update_cfs_group(se);
> > +
> > +             cfs_rq->h_nr_running++;
> > +             cfs_rq->idle_h_nr_running += idle_h_nr_running;
> >       }
> >
> > +enqueue_throttle:
> >       if (!se) {
> >               add_nr_running(rq, 1);
> >               /*
>
> I'm having trouble reconciling the patch with the description and the
> comments explaining the intent behind the code are unhelpful.
>
> There are two loops before and after your patch -- the first dealing with
> sched entities that are not on a runqueue and the second for the remaining
> entities that are. The intent appears to be to update the load averages
> once the entity is active on a runqueue.
>
> I'm not getting why the changelog says everything related to cfs is
> now done in one loop because there are still two. But even if you do
> get throttled, it's not clear why you jump to the !se check given that
> for_each_sched_entity did not complete. What it *does* appear to do is
> have all the h_nr_running related to entities being enqueued updated in
> one loop and all remaining entities stats updated in the other.

Let's take the example of 2 levels in addition to root so we have :
root->cfs1->cfs2
Now we enqueue a task T1 on cfs2 but cfs1 is throttled, we will have
the sequence:

In 1st for_each_sched_entity loop:
  loop 1
    enqueue_entity (T1->se, cfs2) which calls update load_avg(cfs2)
    cfs2->h_nr_running++;
  loop 2
    enqueue_entity (cfs2->gse, cfs1) which calls update load_avg(cfs1)
    break because cfs1 is throttled

In 2nd for_each_sched_entity loop:
  loop 1
    cfs1->h_nr_running++
    break because throttled

Using the 2nd loop for incrementing h_nr_running of the throttled cfs
is useless and we could do that directly in 1st loop and skip the 2nd
loop

With this patch we have :

In 1st for_each_sched_entity loop:
  loop 1
    enqueue_entity (T1->se, cfs2) which update load_avg(cfs2)
    cfs2->h_nr_running++;
  loop 2
    enqueue_entity (cfs2->gse, cfs1) which update load_avg(cfs1)
    cfs1->h_nr_running++
    skip the 2nd for_each_sched_entity entirely

Then the patch also reorders the call to update_load_avg() and the
increment of h_nr_running

Before the patch we had different order between the to
for_each_sched_entity which is not a problem because there is
currently no relation between both. But the following patches make
PELT using h_nr_running so we must have the same ordering to prevent
updating pelt with the wrong h_nr_running value

>
> Following the accounting is tricky. Before the patch, if throttling
> happened then h_nr_running was updated without updating the corresponding
> nr_running counter in rq. They are out of sync until unthrottle_cfs_rq
> is called at the very least. After your patch, the same is true and while
> the accounting appears to be equivalent, it's not clear it's correct and
> I do not find the code any easier to understand after the patch or how
> it's connected to runnable_load_avg which this series is about :(
>
> I think the patch is functionally ok but I am having trouble figuring
> out the motive. Maybe it'll be obvious after I read the rest of the series.
>
> --
> Mel Gorman
> SUSE Labs
