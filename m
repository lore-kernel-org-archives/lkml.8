Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEEAC4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CBE206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEAZe1tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBZQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:30:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33217 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:30:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so3848372lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoGKRDRLjTha3fmwK9qaQxtRiyvigYgjt6KI1tkgp54=;
        b=kEAZe1tpnb92IKWsvcp94kqsw2LLiNwR3oeZF8tRxMnGrM8lBDk5llI4+qmb8ISt4X
         qOinA+BQa03i9wz3dzD7jSXPtJgXVRxvamaZUvBEjf0jALiyes4OvS8xSCmiij52b1TZ
         Fd7O9gP7ZlL7hxUroU9SK0DDNfc3pxzd1AicD9whOQq0TZnxtwAOXpKHTy2IKysewe1+
         qZbu1OC9PyiZV/QhRvum8B6J6p3VuE2DQ1kn0E4h5S8U45pFjPaJYGcWr+g8fyfuBAjC
         o5dsGFOQq4UVtnK+SRpbBGCCwZJ+WbukDsEY7GwVJ2MRCHZPQK4WKdAMViqDsTZ54Loi
         dWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoGKRDRLjTha3fmwK9qaQxtRiyvigYgjt6KI1tkgp54=;
        b=eI9pSNrotzy9YiDvPXFQGWNtSRSoG6BdD60RjoiRflDZ9LH9lBlHrJJQ1Vruz2G3y3
         5xnlriGaPyKMWJqJ6ysunqr0qzORpHqZru65QueCj0nB3W9QLr76uwpKn7mbYuaDiwZX
         5CyPKHoKB8MfXu9Ve+/WvVF/VY/ZX9SpnaoXRdudB5C+Ai8U8OUfyQznrslELGL9dWg4
         y6c06vBxTvwUzHWCmkDvh1OAAtZjHnVLlhEu9Ve+r/7a2wAqNhrETAGmfKZgWliOZ+Ra
         bsCx/sOX0RX3NMIGFIlkjwyRk3UK7DPepxpDlN0SRTIhPQvaVIyccFk8+/3+FoKwniOl
         /ydQ==
X-Gm-Message-State: APjAAAXZchelK28HWQeUSpE1RkM6Y+tsDtAlt1RKlqnCOFRLRGWdDIgT
        /qYPCUq4cw8KwMswKE1EiGzL6GWGbooXuQwEBmjTuQ==
X-Google-Smtp-Source: APXvYqx+e164s8E6sLSr29OcfaSuu3PHmDXjYtYHjM8lbAVXmpX84MOnwOOwjuP4nmJWIBw8dMJMO5HUp3X21HnT3Mw=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr3630892ljj.4.1582734626398;
 Wed, 26 Feb 2020 08:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org> <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
 <20200218132203.GB14914@hirez.programming.kicks-ass.net> <CAKfTPtB3qudK8aMq2cx==4RW8t1pz6ymz1Ti0r8oO4TefWzMRw@mail.gmail.com>
 <c18ab89e-d635-e370-6cbb-6015b404d906@arm.com> <CAKfTPtCbHb2X30gNqNp5sukrg9U-hC6rvWC0dj8d1DawNL4D3Q@mail.gmail.com>
 <274ebb9a-9328-e312-f554-34da8b183932@arm.com> <20200222152541.GA11669@geo.homenetwork>
In-Reply-To: <20200222152541.GA11669@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Feb 2020 17:30:15 +0100
Message-ID: <CAKfTPtAYc2JVDYPp9MDk-AnE+qgNTJoTmABFVYfv30JMvUudrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
To:     Tao Zhou <zhout@vivaldi.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, "T. Zhou" <t1zhou@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Sat, 22 Feb 2020 at 16:23, Tao Zhou <zhout@vivaldi.net> wrote:
>
> Hi,
>
> On Thu, Feb 20, 2020 at 02:38:59PM +0100, Dietmar Eggemann wrote:
> > On 19/02/2020 17:26, Vincent Guittot wrote:
> > > On Wed, 19 Feb 2020 at 12:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 18/02/2020 15:15, Vincent Guittot wrote:
> > >>> On Tue, 18 Feb 2020 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > >>>>
> > >>>> On Tue, Feb 18, 2020 at 01:37:37PM +0100, Dietmar Eggemann wrote:
> > >>>>> On 14/02/2020 16:27, Vincent Guittot wrote:
> > >>>>>> The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> > >>>>>> is split in 2 distinct parts for throttled cfs_rq without any added value
> > >>>>>> but making code less readable.
> > >>>>>>
> > >>>>>> Change the code ordering such that everything related to a cfs_rq
> > >>>>>> (throttled or not) will be done in the same loop.
> > >>>>>>
> > >>>>>> In addition, the same steps ordering is used when updating a cfs_rq:
> > >>>>>> - update_load_avg
> > >>>>>> - update_cfs_group
> > >>>>>> - update *h_nr_running
> > >>>>>
> > >>>>> Is this code change really necessary? You pay with two extra goto's. We
> > >>>>> still have the two for_each_sched_entity(se)'s because of 'if
> > >>>>> (se->on_rq); break;'.
> > >>>>
> > >>>> IIRC he relies on the presented ordering in patch #5 -- adding the
> > >>>> running_avg metric.
> > >>>
> > >>> Yes, that's the main reason, updating load_avg before h_nr_running
> > >>
> > >> My hunch is you refer to the new function:
> > >>
> > >> static inline void se_update_runnable(struct sched_entity *se)
> > >> {
> > >>         if (!entity_is_task(se))
> > >>                 se->runnable_weight = se->my_q->h_nr_running;
> > >> }
> > >>
> > >> I don't see the dependency to the 'update_load_avg -> h_nr_running'
> > >> order since it operates on se->my_q, not cfs_rq = cfs_rq_of(se), i.e.
> > >> se->cfs_rq.
> > >>
> > >> What do I miss here?
> > >
> > > update_load_avg() updates both se and cfs_rq so if you update
> > > cfs_rq->h_nr_running before calling update_load_avg() like in the 2nd
> > > for_each_sched_entity, you will update cfs_rq runnable_avg for the
> > > past time slot with the new h_nr_running value instead of the previous
> > > value.
> >
> > Ah, now I see:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     __update_load_avg_cfs_rq()
> >        ___update_load_sum(..., cfs_rq->h_nr_running, ...)
> >
> >                                ^^^^^^^^^^^^^^^^^^^^
>
> throttle/unthrottle_cfs_rq() update h_nr_running also. Maybe need
> to consider call se_update_runnable there.

yes you're right, group entity which are not enqueued/dequeued, which
updates runnable_avg and se->runnable_weight, during the
throttling/unthrottling are not updated. I'm going to send a fix on
top of sched/core

> And the name update_se_runnable seems to be consistent with others.

In fact, I have reused the same name as with runnable_load_avg

Thanks and sorry for the late reply

>
> Thanks,
> Tao
>
> > Not really obvious IMHO, since the code is introduced only in 4/5.
> >
> > Could you add a comment to this patch header?
> >
> > I see you mentioned this dependency already in v1 discussion
> >
> > https://lore.kernel.org/r/CAKfTPtAM=kgF7Fz-JKFY+s_k5KFirs-8Bub3s1Eqtq7P0NMa0w@mail.gmail.com
> >
> > "... But the following patches make PELT using h_nr_running ...".
> >
> > IMHO it would be helpful to have this explanation in the 1/5 patch
> > header so people stop wondering why this is necessary.
