Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C0C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C492469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OD/qxb0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgB0NLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:11:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39906 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgB0NLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:11:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id n30so2043422lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0QO80UqgJslgx8qIXnB1ccHOMCOLtwSFNjlB6H50Q4=;
        b=OD/qxb0KHKEP0PfUyA2oWXf/1vF0wqEvPy2W8Es2MATVeYEGA9Gjno/fgc7iisSre/
         gREi82QnQ4V0vjrgWlg3UN1q97NK+fCbAscSxYY5AMttCZJoryv/tZ+EeHmyrJe2UWNg
         n5p5gLwSTcqERuOI4x+JWIFFksowMArffyLC4mIKcoOeRTk8zvVWUl0hCxaLWYGurm85
         6tdz7TMszI5INQGs3AFj9PA7UVHRHvVSu/8DSHTYD2WPFZl62HYZh0rQTj27MGq29wa9
         1qjcgX9+FvR6BVDAhYTaVLQmR3ifTNfmbuv8iZg+RQib1Z4fW/FIFlNuOwHpmwnT77W2
         dS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0QO80UqgJslgx8qIXnB1ccHOMCOLtwSFNjlB6H50Q4=;
        b=qUKjc9f8BJvOYn8RImQpQRsOAg3K14fBfbW/3BjKJmHppf62svtSoOv+tkRv1ICrld
         ZSRl876K6lJbNZFNOuN6CBSfIj5xG+Ks3fjfhJecL8LH//XYmXG8KwS1Odaca0lG49XW
         dOywJ7P2pU/7uPOjBBngZ2sYRYbR+57+2hSZWaOUWgZ+gwkyyWp9LU6+p3sH8ZYbkoWp
         Bgtlb9EIDJjuTO7QzVasPmw+vgUskD9mCZDTxJbpYng1YX+Gkb6eLWYl8jJEfRk0EpCF
         tm4nGtssQqr68Py3ryocx0pySeUOHN7JxryfVjWfaXW1mkW82YxXlKGNVhJkg7FAaAnD
         UHvQ==
X-Gm-Message-State: ANhLgQ0c35WeZ5CROM4sJIE6WQS5jwEp1gPDt4qiS0wdiXTVK7wErBXA
        dSzEdCzhl/Q7BTWRlDh/2SzNJC2D5nlMqzFd3EWhkw==
X-Google-Smtp-Source: ADFU+vvzFpKNc5HnQI7paHd+RZnZtHVeSsg2ecQ4nYB7bfW42+VB47oz1fxEFQqjRUh7QN9xslQIyPG1sRuznYV0E6c=
X-Received: by 2002:a19:6903:: with SMTP id e3mr2037098lfc.25.1582809058883;
 Thu, 27 Feb 2020 05:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com> <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
In-Reply-To: <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Feb 2020 14:10:47 +0100
Message-ID: <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
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

On Thu, 27 Feb 2020 at 12:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 26.02.20 21:01, Vincent Guittot wrote:
> > On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
> >>
> >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> >>
> >>> When a cfs_rq is throttled, its group entity is dequeued and its running
> >>> tasks are removed. We must update runnable_avg with current h_nr_running
> >>> and update group_se->runnable_weight with new h_nr_running at each level
>
>                                               ^^^
>
> Shouldn't this be 'current' rather 'new' h_nr_running for
> group_se->runnable_weight? IMHO, you want to cache the current value
> before you add/subtract task_delta.

hmm... it can't be current in both places. In my explanation,
"current" means the current situation when we started to throttle cfs
and "new" means the new situation after we finished to throttle the
cfs. I should probably use old and new to prevent any
misunderstanding.

That being said, we need to update runnable_avg with the old
h_nr_running: the one before we started to throttle the cfs which is
the value saved in group_se->runnable_weight. Once we have updated
runnable_avg, we save the new h_nr_running in
group_se->runnable_weight that will be used for next updates.

>
> >>> of the hierarchy.
> >>
> >> You'll also need to do this for task enqueue/dequeue inside of a
> >> throttled hierarchy, I'm pretty sure.
> >
> > AFAICT, this is already done with patch "sched/pelt: Add a new
> > runnable average signal" when task is enqueued/dequeued inside a
> > throttled hierarchy
> >
> >>
> >>>
> >>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>> This patch applies on top of tip/sched/core
> >>>
> >>>  kernel/sched/fair.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index fcc968669aea..6d46974e9be7 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> >>>
> >>>               if (dequeue)
> >>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> >>> +             else {
> >>> +                     update_load_avg(qcfs_rq, se, 0);
> >>> +                     se_update_runnable(se);
> >>> +             }
> >>> +
> >>>               qcfs_rq->h_nr_running -= task_delta;
> >>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> >>>
> >>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >>>               cfs_rq = cfs_rq_of(se);
> >>>               if (enqueue)
> >>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> >>> +             else {
> >>> +                     update_load_avg(cfs_rq, se, 0);
> >>
> >>
> >>> +                     se_update_runnable(se);
> >>> +             }
> >>> +
> >>>               cfs_rq->h_nr_running += task_delta;
> >>>               cfs_rq->idle_h_nr_running += idle_task_delta;
