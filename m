Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E1DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B020673
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c03FXKU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbgEMNGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgEMNGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:06:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:06:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so17664236ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMgD6NcJSkFRcGfrU9XFvRYlw7oc9Dcio6csAzbYRM4=;
        b=c03FXKU7FSx9ZDW0oi6XOvIYSabz4oO2PUORIynbOyzhlDhMMbLlxTLpo5hQ5FMXoD
         5I4rWOkevs63T1+7ytomdv81446fi1ImesLK4CtbaIE6UzfSgOqgYFI1/Zd82ee30Fy+
         QNhVXaZZjuQU731JUFDK2J6oC7jUqtXAYMCjNEDd7PG4hfACsBguALweKkzX7Hk1jExe
         fcqjiS88U2YS2MiygARqm57pM7p3rLSDc1Sio5HFQjUCPr7vgZ+Yv+xBXGcR1i1bBVUY
         MK/1IfXo0OoDdBswnyKDLDTWW33G/9xLuzCFOIU3JwzNMIn3u6YfIQO/ZPldPQ9R99BP
         m9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMgD6NcJSkFRcGfrU9XFvRYlw7oc9Dcio6csAzbYRM4=;
        b=Pu8gtqD/o0Em0WvyztOvN68uM5JGI88VFF4JOuqzA8McFQtfDPPui1z69FlleaBssx
         mCnADKOTzWLvjl4o80vBqYyg1zZ8JRION5ce5KtNl0z9QSqLSQ9obMMOKU96WC/BGUE6
         tZXX6wk/lktQGANvIrJWH9PE5dEQeX858EZu/y6EgOUABVCYpWGL+Wa5UOOqdQWS1Hdz
         hXff3cyHKavkjFXMyzZO5r6AT8U1PGvHhMDmgSpPRbfjcLZJzWqThnPaGuHMfEigHJ2n
         Ew6BcXrmcBk84Xn/8N0CICPftcI7eXsv+x8lFcrEhqop72vVFgKFT0XJaZlEB7X6ioM6
         Hk3A==
X-Gm-Message-State: AOAM533PRQEZ23c23US+ESaQmh4NLPFg+vuPmG0c10VGiReZ1KhgfiqP
        r5k4z0eRIebcJgSd+cyTFi1IAbRXTUA0oJhmr7nlaQ==
X-Google-Smtp-Source: ABdhPJwuZIEObGj5qdHuUCt4fb6lNy2Mxrzkus2BO+OEbT73x0o0cIZaxMrF9pOpob4TInSAe2vxVhprQHAVebMxPyY=
X-Received: by 2002:a05:651c:105c:: with SMTP id x28mr5200924ljm.65.1589375205568;
 Wed, 13 May 2020 06:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200513123422.28299-1-vincent.guittot@linaro.org> <20200513125600.GC12425@lorien.usersys.redhat.com>
In-Reply-To: <20200513125600.GC12425@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 May 2020 15:06:33 +0200
Message-ID: <CAKfTPtB5C=fZtk1hKYk1JO05Wm93jBiE9zF3V4w6VUBU-QyP_w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <ouwen210@hotmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 14:56, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Wed, May 13, 2020 at 02:34:22PM +0200 Vincent Guittot wrote:
> > Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
> > are quite close and follow the same sequence for enqueuing an entity in the
> > cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
> > enqueue_task_fair(). This fixes a problem already faced with the latter and
> > add an optimization in the last for_each_sched_entity loop.
> >
> > Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > v2 changes:
> > - Remove useless if statement
> >
> >  kernel/sched/fair.c | 41 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4e12ba882663..a0c690d57430 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4816,26 +4816,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       idle_task_delta = cfs_rq->idle_h_nr_running;
> >       for_each_sched_entity(se) {
> >               if (se->on_rq)
> > -                     enqueue = 0;
>
> Can probably drop the now-unused enqueue variable too.

argh, yes, it dropped during rebase.

preparing a v3

>
>
> Cheers,
> Phil
>
>
>
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
> > -     if (!se)
> > -             add_nr_running(rq, task_delta);
> > +     /* At this point se is NULL and we are at root level*/
> > +     add_nr_running(rq, task_delta);
> >
> > +unthrottle_throttle:
> >       /*
> >        * The cfs_rq_throttled() breaks in the above iteration can result in
> >        * incomplete leaf list maintenance, resulting in triggering the
> > @@ -4844,7 +4862,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> >
> > -             list_add_leaf_cfs_rq(cfs_rq);
> > +             if (list_add_leaf_cfs_rq(cfs_rq))
> > +                     break;
> >       }
> >
> >       assert_list_leaf_cfs_rq(rq);
> > --
> > 2.17.1
> >
>
> --
>
