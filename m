Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A78207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez2ibCU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgFPMb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:31:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7EC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:31:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so23315623ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/zHOZOAMFj76kOR7RONrkyP6O7E1SxDjrLhobFpBZA=;
        b=ez2ibCU8hKHq5wNIe7yKJ1eUfVyW+TNRygAaoyx07hyGkHFoljN5Z+LgpkyDMM0zjQ
         TjOEyEgTBQQJIrP3rjhfMlZ9Oleo0SJEtlBDvl1N5OwS3zsYtXf48Nw7RhKciaDgZe+f
         p/wH5yZCHHToT8w3TTxq7HqSWhMkbmx8IkA6gBLmTrXUPqmBEhXxJUwI4FiqXTm1fXDU
         KIhqBgw5gAnEqLO4s9rg4dfSh1dc363FlSOoHnEJ/lTEVVonGk4LTv79Ct+YyBgT2iQT
         T3WuQXIAHJfHqcEplChJZruHrWcj0UGtC4HXbGMHmE12AUeZSNd19KLvLZybYCVamTi6
         klVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/zHOZOAMFj76kOR7RONrkyP6O7E1SxDjrLhobFpBZA=;
        b=MEGYEHKE3X1UMDjZ2G4J2KnU+ErSdk93JNkiKAZj3ybi37wuJFuBlRbzRgC7uJUrsd
         qwIjyu9UxD93UeiOez/asrDyXZVqISAQmYie9jFel/9QI7d957RfVJZxqcDOXZaxiF7X
         ZQaVeZcIJaei+X8YZw+wRwjmsXHgpgMFvrDEfU36KmjS6TDIp5NN5sdxdypcvVvLKhF3
         aNvdzo6DunkNUcGOrVDNjon8Fe5mgY3IScJdjkwbK2ggwSNMvpBNITKeeHUjnowOEXvS
         wJ/BX18Twpcy9uWQRYUynurACjCuSl9J+qIzqc5keg2TM7asxvWAtpG8E/N5f44BQhMw
         uFIA==
X-Gm-Message-State: AOAM530ZQwTlL/NMBL6XR+jTJu/veXN/NmZGmWcPo7TzG19OK3IimlYS
        CTg4yqJIVrbGgTZ3aMuIjBcyw6g9b2mj33xUsuBmsg==
X-Google-Smtp-Source: ABdhPJxa7a5d43b4mHTth+9EaFfBFs8NMCABtvzTHjE9kvodmTdHQ0wSch+MxCfsS7sNM9XynQLQGUZHLJTPhWOaS1c=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr1233891ljb.156.1592310686347;
 Tue, 16 Jun 2020 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
 <701eef9a40de93dcf5fe7063fd607bca5db38e05.1592287263.git.rocking@linux.alibaba.com>
In-Reply-To: <701eef9a40de93dcf5fe7063fd607bca5db38e05.1592287263.git.rocking@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 16 Jun 2020 14:31:15 +0200
Message-ID: <CAKfTPtDUXmDB8w+03c2dqrjKDJyp7wrgdwj0oADg8N--9jmRJw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Optimize dequeue_task_fair()
To:     Peng Wang <rocking@linux.alibaba.com>
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

On Tue, 16 Jun 2020 at 08:05, Peng Wang <rocking@linux.alibaba.com> wrote:
>
> While looking at enqueue_task_fair and dequeue_task_fair, it occurred
> to me that dequeue_task_fair can also be optimized as Vincent described
> in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").
>
> When encountering throttled cfs_rq, dequeue_throttle label can ensure
> se not to be NULL, and rq->nr_running remains unchanged, so we can also
> skip the early balance check.
>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbcb2f7..05242b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5614,14 +5614,14 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>         }
>
> -dequeue_throttle:
> -       if (!se)
> -               sub_nr_running(rq, 1);
> +       /* At this point se is NULL and we are at root level*/
> +       sub_nr_running(rq, 1);
>
>         /* balance early to pull high priority tasks */
>         if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>                 rq->next_balance = jiffies;
>
> +dequeue_throttle:
>         util_est_dequeue(&rq->cfs, p, task_sleep);
>         hrtick_update(rq);
>  }
> --
> 2.9.5
>
