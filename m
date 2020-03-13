Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74AE2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5spvTKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCMLYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:24:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40364 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:24:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so7524996lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6vwtcS1o8wVHnbXsbeZvZhN3RsKoWR7xyO93JYUPfQ=;
        b=l5spvTKFvur8vazMS4cstlevrMH0lLNnOOG4rR3Ff4yP6wftsR0CC6D48OSmjl6Jqi
         6xWiKT34VQ61GfaL2oRGT8uGpo7IaawuRqiwbElRGQUkuLA8BEwvH3mCzKS1ipA1rDFq
         tn6WCO6mCqOQ6312RIvSca1AhejEwUqZ7fDE5FEyWT51q2nIZNfKWb4gBlg+lJuhfC9t
         tTsSz9tCPFvBEYHikrXq5QLgZBvdDBm1oHfuT6N95CxQdYbNo7wSMGcOnN9JFl9ZQBxB
         rSF07CJ2vW+1o8PV7km8p6OV9O+A6+UTWXEvUvHwY57fUwPDFOW5qKfAVzduihj7yBaz
         BUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6vwtcS1o8wVHnbXsbeZvZhN3RsKoWR7xyO93JYUPfQ=;
        b=hFj2xk3JAh5Im6spGLMWrZjejq809znxJOsAVPUOp8zSFqBU3ci3+J4HBYnPWPPK66
         XEBM5E31AsMJBthyMPY0M2iZySQUqAuonnCZfb3gstcLKX9BCCzcdGL2VM70Veo316sG
         aM0Mcaix6P1MCVCBig7qnLCQIL3kSMWI/vWupzcrySsaoALenwguwAmsQCm+D5Nlxgfb
         NxdU1CQDmnDLur/NnjnKYtl1UqmYJ8BZn1dQFuG4nMJYVJEtMYmHfMwoS1WzR95oqDFF
         IKcgcGSir1cF4NdnWB50QQ8LiuGwvnCgyPIKXvJQ7OpY1mgSIi5TvI7S7/C/y0aCboGY
         rBCQ==
X-Gm-Message-State: ANhLgQ1jaG8DNPpgnhmB1hQUIGUykjVznbJIwRKJjqnMrsKI15qF+qGD
        Kbr5BFmRYODzvqy/KQJfP/v/nwdtj5wV7YE7hoVh1g==
X-Google-Smtp-Source: ADFU+vtdbQblmMmR308C+PHCofI8WevpDF2HFNnmc07B/kU1Hxc78tv8ed6vNDdN74pzp4KsCQ4SPN/5oby4Obrg9TM=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr8096774lfa.95.1584098657653;
 Fri, 13 Mar 2020 04:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200312165429.990-1-vincent.guittot@linaro.org> <jhjr1xwjz96.mognet@arm.com>
In-Reply-To: <jhjr1xwjz96.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 12:24:05 +0100
Message-ID: <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 12:00, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On Thu, Mar 12 2020, Vincent Guittot wrote:
> >  kernel/sched/fair.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3c8a379c357e..97a0307312d9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9025,6 +9025,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >               case migrate_util:
> >                       util = cpu_util(cpu_of(rq));
> >
> > +                     /*
> > +                      * Don't try to pull utilization from a CPU with one
> > +                      * running task. Whatever its utilization, we will fail
> > +                      * detach the task.
> > +                      */
> > +                     if (nr_running <= 1)
> > +                             continue;
> > +
>
> Doesn't this break misfit? If the busiest group is group_misfit_task, it
> is totally valid for the runqueues to have a single running task -
> that's the CPU-bound task we want to upmigrate.

 group_misfit_task has its dedicated migrate_misfit case

>
> If the busiest rq has only a single running task, we'll skip the
> detach_tasks() block and go straight to the active balance bits.
> Misfit balancing totally relies on this, and IMO ASYM_PACKING does
> too. Looking at voluntary_active_balance(), it seems your change also
> goes against the one added by
>   1aaf90a4b88a ("sched: Move CFS tasks to CPUs with higher capacity")
>
> The bandaid here would be gate this 'continue' with checks against the
> busiest_group_type, but that's only a loose link wrt
> voluntary_active_balance().
>
> >                       if (busiest_util < util) {
> >                               busiest_util = util;
> >                               busiest = rq;
