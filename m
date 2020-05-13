Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EFBC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FAA20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgmSex8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgEMHL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:11:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08419C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:11:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so16546176ljl.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkxWevqu/rX6tDPC/Fs7t03yeoK2gpvBrLo8GG0pjWE=;
        b=qgmSex8BHoYoSFp2pG05G0AtCAT8L1soLRAM6XF6Wm4rxVdH5CXAWZ+4OlOxGW/dn3
         jM4VSOm3X8xyhcMLbZa1mEkgM3k8EE2GLJ+FHYarpY+lw0m2UavS+jremFlgbajcw0xt
         NdKVRYL+UOpNlAkBi4sRq54Llne2TK8zp7raVmzuMpKKZQj8YZBfixpAXELu7XZjm/u/
         5tQW0zVx1r3iolgveho5tZvSfXn2m8AMAQCxtxEW/dxjIhObN4hJIFd34Jkbp+1rAsBo
         vgdaH0dEujnvDusTsaivjty+n7NXO/68BXTTG/+O7UQa14jOkjuj5iIm90Dq6Z5UCuC+
         0Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkxWevqu/rX6tDPC/Fs7t03yeoK2gpvBrLo8GG0pjWE=;
        b=nfbzXyIls70UKfIsvRDFCom6c3R73dbcDagIBQhCiwuFzzVUD1VBtt/UnXKWt5Vi8Z
         u6sXimjej6/8jRbN+on/vCusyXUJKxQGF9+URJ0PEo/JohNJcgfLuPRpUdrCFgzjDhlN
         Bh0uvLkb8DD2b1VMO4ZBuGClFfuFkTD/uNmKO7iMZbTIy1oHf5sNhC7e/n68nJYPUTmV
         Nuf2BMR+Ft9+ipRgh+3Jr9iJMtHU+dV9FTw8xGHxg8rYsVzKHBk4HRcAclkvYuwpGUaX
         hnto8jiy2R8mhazFw4mYs6lN9Tku9/LuQqNIrbHyiu2jer/XsxNNLJCjr+EKO6zMjwr2
         jcwg==
X-Gm-Message-State: AOAM533KNZOmsmGTKeZsV+LD1tBrTAR0d+WumEbvUuD3d6AQXGJ59pFi
        7sYqMtzfFY+YHFab9WkSTDYZmD6eFpLoUkpJo/adILxzLkI=
X-Google-Smtp-Source: ABdhPJwEH95mJS8O2M4XIyx+8yKcX374GkLpCQjk3MDpOjMr4BlrmqmutRJP8Vw97/lDC0RbcCvkUC8m2mXLIGO0v3Y=
X-Received: by 2002:a2e:740f:: with SMTP id p15mr16342317ljc.151.1589353884402;
 Wed, 13 May 2020 00:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200511191320.31854-1-vincent.guittot@linaro.org> <xm263685kmiv.fsf@google.com>
In-Reply-To: <xm263685kmiv.fsf@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 May 2020 09:11:13 +0200
Message-ID: <CAKfTPtBkJxjCxhDJUrz3aQ-3VKkC+kHTC1-4j+D2fWi7EtS+oA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
To:     Ben Segall <bsegall@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Tao Zhou <ouwen210@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 20:59, <bsegall@google.com> wrote:
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
> > are quite close and follow the same sequence for enqueuing an entity in the
> > cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
> > enqueue_task_fair(). This fixes a problem already faced with the latter and
> > add an optimization in the last for_each_sched_entity loop.
> >
> > Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > This path applies on top of 20200507203612.GF19331@lorien.usersys.redhat.com
> > and fixes similar problem for unthrottle_cfs_rq()
> >
> >  kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e2450c2e0747..4b73518aa25c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4803,26 +4803,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       idle_task_delta = cfs_rq->idle_h_nr_running;
> >       for_each_sched_entity(se) {
> >               if (se->on_rq)
> > -                     enqueue = 0;
> > +                     break;
> > +             cfs_rq = cfs_rq_of(se);
> > +             enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> >
> > +             cfs_rq->h_nr_running += task_delta;
> > +             cfs_rq->idle_h_nr_running += idle_task_delta;
> > +
> > +             /* end evaluation on encountering a throttled cfs_rq */
> > +             if (cfs_rq_throttled(cfs_rq))
> > +                     goto unthrottle_throttle;
> > +     }
> > +
> > +     for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> > -             if (enqueue) {
> > -                     enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > -             } else {
> > -                     update_load_avg(cfs_rq, se, 0);
> > -                     se_update_runnable(se);
> > -             }
> > +
> > +             update_load_avg(cfs_rq, se, UPDATE_TG);
> > +             se_update_runnable(se);
> >
> >               cfs_rq->h_nr_running += task_delta;
> >               cfs_rq->idle_h_nr_running += idle_task_delta;
> >
> > +
> > +             /* end evaluation on encountering a throttled cfs_rq */
> >               if (cfs_rq_throttled(cfs_rq))
> > -                     break;
> > +                     goto unthrottle_throttle;
> > +
> > +             /*
> > +              * One parent has been throttled and cfs_rq removed from the
> > +              * list. Add it back to not break the leaf list.
> > +              */
> > +             if (throttled_hierarchy(cfs_rq))
> > +                     list_add_leaf_cfs_rq(cfs_rq);
> >       }
> >
> >       if (!se)
>
> The if is no longer necessary, unlike in enqueue, where the skip goto

Yes. Good point

> goes to this if statement rather than past (but enqueue could be changed
> to match this). Also in general if we are making these loops absolutely

There is a patch on mailing that skip the if statement. I'm going to
update it to remove the if

> identical we should probably pull them out to a common function (ideally
> including the goto target and following loop as well).

I tried that but was not convinced by the result which generated a lot
of arguments. I didn't want to delay the fix for such cleanup but I
will have a closer look after. Also the same kind identical sequence
and clean up can be done with dequeue_task_fair and throtthle_cfs_rq.
But Those don't have the problem we are fixing here

>
> >               add_nr_running(rq, task_delta);
> >
> > +unthrottle_throttle:
> >       /*
> >        * The cfs_rq_throttled() breaks in the above iteration can result in
> >        * incomplete leaf list maintenance, resulting in triggering the
> > @@ -4831,7 +4849,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> >
> > -             list_add_leaf_cfs_rq(cfs_rq);
> > +             if (list_add_leaf_cfs_rq(cfs_rq))
> > +                     break;
>
> Do we also need to handle the case of tg_unthrottle_up followed by early exit
> from unthrottle_cfs_rq? I do not have enough of an idea what
> list_add_leaf_cfs_rq is doing to say.

If you are speaking about the 'if (!cfs_rq->load.weight) return;"
after walk_tg_tree_from(). I also thought it was needed but after more
analyses, I concluded that if cfs_rq->load.weight == 0 , no child has
been added in the leaf_cfs_rq_list in such case


>
> >       }
> >
> >       assert_list_leaf_cfs_rq(rq);
