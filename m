Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44601C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F420704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNv9R8K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgDWQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:17:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F29C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:17:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k28so5217547lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QZl+b5n39GhclZKWhGgFEfzmZHeerLcWtoVp5AHrqM=;
        b=qNv9R8K74eklVBdaLfLOxt0Logwaoub61YLqBhyYsj1U0roPtKnE2t//6vCFNQQo2C
         9bD1ZceoqcOyLKwDdo21DBmYVvv5+5t/t73SP3iT+TmeBk8Qj1jlhm2IoOzO9Kdtj6uC
         /AiAQ9qA1fI8/rSfmQuKaZFtnT5RdVTqthSC3wTgOD84D9+HRgZhPWsoTihiLQIDzXo2
         bKKCT2MtlTxVWBq6byGipU4z1mGXozAUsC0IGFRcf5vwQuO8QjuaETRQF1xDlvAZLbWU
         zmj5SUTJgeh0m0Yz3jc977PliyfQXwfeEIR1Wxm9w0rNWy8eeXc9EOm3oDKUu8DcN0Fq
         D25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QZl+b5n39GhclZKWhGgFEfzmZHeerLcWtoVp5AHrqM=;
        b=jhqlSeGxrKuD9EssMgCaFUyOVYgt3EBkk72RC/yPk6ygIQMT+2Fel+dyxyNig1Y+8R
         UJcui/lC2MBHOnrMWpwo1fg9sKNPQWqYtbuSVO15p177nq3kqvahpKFUGJB9VsbPnJJm
         H2c8UIbkddYzk4yQQjxhQ5bFjdaiIkr4+YZ3olhLjLFTW7WXQUnil1AS7rmt9Qqf3QqZ
         VzF5wBhNH6Pvs6VOs9U1m/Z+Bnl16LB6/Ar9+Vpr4eorTgv8Ce2vBVkjFoPGnwtIMrAv
         E889dKX/N+Lws1RCgHcMh48yizqHERKkeXAPFuVoZrp8zsrZdEpUVrGdSkkrCDVnrPjD
         ysZw==
X-Gm-Message-State: AGi0PuagJ42eIlJZsuVhR98E3vi4qVt2A5sdBGjrX8cDze0gnZJor4HZ
        tcPW5xOkss77Rb1m9PWj4pWDyOA1ZUu0bmuEedpCkA==
X-Google-Smtp-Source: APiQypJ7xr5BswC3kJGXSX28Ol70xTMqhaBNNZN+KKNku27mav64bY4zzSgddRRyIBErwFSmrswjOeDWzXotbwhdB3I=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr2863155lff.190.1587658650720;
 Thu, 23 Apr 2020 09:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200422151401.9147-1-vincent.guittot@linaro.org> <23c1cbb8-7335-80ca-cf40-8abc5c1463f4@arm.com>
In-Reply-To: <23c1cbb8-7335-80ca-cf40-8abc5c1463f4@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 23 Apr 2020 18:17:19 +0200
Message-ID: <CAKfTPtD_W8DRmFS6xJUo+Yt=XaJgZmKxUzcCSnoLWNJN5xPFCw@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when propagating
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 16:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
>
>
> On 22/04/2020 17:14, Vincent Guittot wrote:
> > update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
> > an entity down into the cfs_rq hierarchy which must keep the sync with
> > the current pelt window.
> >
> > Even if we can't sync child rq and its group se, we can sync the group se
>
> So we have
>
>     gcfs --> tg --> gse
>      ________________|
>      |
>      V
>
>     cfs ---> tg (root)
>
>      |
>      V
>
>     rq
>

child cfs_rq aka gcfs_rq
  |
gse: group entity that represents child cfs_rq in parent cfs_rq
  |
  v
parent cfs_rq aka cfs_rq

>
> here. What is 'child rq' for 'group se' here? I guess 'parent cfs_rq' is
> cfs_rq.
>
> > and parent cfs_rq with current PELT window. In fact, we must keep them sync
> > in order to stay also synced with others se and group se that are already
> > attached to the cfs_rq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 26 ++++++--------------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..ca6aa89c88f2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3441,52 +3441,38 @@ static inline void
> >  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> >       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> > +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
> >
> >       /* Nothing to update */
> >       if (!delta)
> >               return;
> >
> > -     /*
> > -      * The relation between sum and avg is:
> > -      *
> > -      *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> > -      *
> > -      * however, the PELT windows are not aligned between grq and gse.
> > -      */
> > -
> >       /* Set new sched_entity's utilization */
> >       se->avg.util_avg = gcfs_rq->avg.util_avg;
> > -     se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
> > +     se->avg.util_sum = se->avg.util_avg * divider;
>
> divider uses cfs_rq but we sync se->avg.util_avg with gcfs_rq here.

we sync the util_avg of gse with the new util_avg of gcfs_rq but gse
is attached to cfs_rq and as a result we have to use cfs_rq's
period_contrib

>
> But since avg.period_contrib of cfs_rq and gcfs_rq are the same this
> should work.
>
> >       /* Update parent cfs_rq utilization */
> >       add_positive(&cfs_rq->avg.util_avg, delta);
> > -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
> > +     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
>
> Looks like that avg.last_update_time of se (group entity), it's gcfs_rq
> and cfs_rq is always the same in update_tg_cfs_[util\|runnable].
>
> So that means the PELT windows are aligned for cfs_rqs and group se's?

We want to align util_avg with util_sum and period_contrib otherwise
we might have some unalignment. It's quite similarly to what is done
in attach_entity_load_avg()

>
> And if we want to enforce this for cfs_rq and task, we have
> sync_entity_load_avg().

It's not a matter of syncing the last_update_time

>
> [...]
