Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB65C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571AB206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUcOLew+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgDUOxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:53:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93369C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:53:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so11344789lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCrTDQsKQHDWbYxlfVnieiay8DadhrLSbXTjO6Z/IzU=;
        b=QUcOLew+D8JbCYH59ZZNCyUoBqKA5tyrK5sV6IQIrhib6qFkqEfqXaVg5InUXegzx5
         taTirHWKsZZ5pJ1/bHXue1gy3etsKRWBFdpo/XAt+211fE5wUDXG7CPT19+GIKpKx9Kw
         Z8k7liseB1wB4PxL7Nay/UuQUjkbpbuivU03okNZMQrVSOuTott0Z42nztBN1HP7ctcm
         kxhx2BuTmZBaGDwzSn11K3AciQnBLRh/A9dsLjBTUMJwDjPmEQTMKOgvv8jjDbkN4Cgi
         dp9OchDAJzGsN0RXZ31h+5TjTi958ar+wxbM9TZ5SvvtZP9CA3SmthxCEwaTGvjSkxTQ
         c5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCrTDQsKQHDWbYxlfVnieiay8DadhrLSbXTjO6Z/IzU=;
        b=G7bmGkZqFa+e33v/9Vk1cpBEHn/cFhvuZYaMJ4Eka4236u7TYIT0IcErYbLPkpjdWL
         tHHd/vYUeLEwcM9sC7MFuu0na/Vhzu8GbEo+sJ0oZoFImWFIxf+TUOcgaOxL1XMnAwzl
         pCjtiumWgb27JR4t2gw4Wtvy1SLGlGwtfHCTuYCnB1hZsT3mzbzUrlt5kLtBGtt5i23L
         ZomsSj9i09O3RDwHU2hCPmgsmAH1GAUcSeS7DY1aTbhKYZg8z6tqqjfRIF38Fe58X3pk
         KvdSHZOQQKa+y5Z9UGExJQ6KiNkhijci/6SEHHB8dLKXE0jOknTFCicWgXKqViIoIs3t
         79Mw==
X-Gm-Message-State: AGi0PuYcPVXxB+ny3aww3lJV0VDq0oVJY5Fl2qu3GucPm986lVmJN36s
        d2xDELG8FgQ2N0mMIoCDNdRnf+Kv1gstKUpkgLi8PiK7
X-Google-Smtp-Source: APiQypLSayC4nNyQAXQjgYGk9P66uK0SREmbQz2jSHR8oHWYKYf9SHyZcA19vC8KvUvPpX1oz2v/cgmQP4akKulP4ec=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr13917273lfr.189.1587480796967;
 Tue, 21 Apr 2020 07:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587464698.git.yu.c.chen@intel.com> <5a99860cf66293db58a397d6248bcb2eee326776.1587464698.git.yu.c.chen@intel.com>
In-Reply-To: <5a99860cf66293db58a397d6248bcb2eee326776.1587464698.git.yu.c.chen@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Apr 2020 16:53:05 +0200
Message-ID: <CAKfTPtCsbHDfYw6sJXPdLvWfWgn5Ot5xN=a-MH7Am9rrynCo-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2][v3] sched: Extract the task putting code from pick_next_task()
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 at 12:50, Chen Yu <yu.c.chen@intel.com> wrote:
>
> Introduce a new function put_prev_task_balance() to do the balance
> when necessary, and then put previous task back to the run queue.
> This function is extracted from pick_next_task() to prepare for
> future usage by other type of task picking logic.
>
> No functional change.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v3: According to Steven's suggestion, fix the comment
>     to change put_next_task() to put_prev_task()
>
>     Rename finish_prev_task() to put_prev_task_balance()
>     as this reflects what we do before picking a new task.
>
>     Per Valentin's suggestion, put the declaration of
>     struct sched_class within the ifdef, given it isn't
>     used outside of it.
> ---
>  kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..c9d7880f6bf2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>         schedstat_inc(this_rq()->sched_count);
>  }
>
> +static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> +                                 struct rq_flags *rf)
> +{
> +#ifdef CONFIG_SMP
> +       const struct sched_class *class;
> +       /*
> +        * We must do the balancing pass before put_prev_task(), such
> +        * that when we release the rq->lock the task is in the same
> +        * state as before we took rq->lock.
> +        *
> +        * We can terminate the balance pass as soon as we know there is
> +        * a runnable task of @class priority or higher.
> +        */
> +       for_class_range(class, prev->sched_class, &idle_sched_class) {
> +               if (class->balance(rq, prev, rf))
> +                       break;
> +       }
> +#endif
> +
> +       put_prev_task(rq, prev);
> +}
> +
>  /*
>   * Pick up the highest-prio task:
>   */
> @@ -3937,22 +3959,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>         }
>
>  restart:
> -#ifdef CONFIG_SMP
> -       /*
> -        * We must do the balancing pass before put_next_task(), such
> -        * that when we release the rq->lock the task is in the same
> -        * state as before we took rq->lock.
> -        *
> -        * We can terminate the balance pass as soon as we know there is
> -        * a runnable task of @class priority or higher.
> -        */
> -       for_class_range(class, prev->sched_class, &idle_sched_class) {
> -               if (class->balance(rq, prev, rf))
> -                       break;
> -       }
> -#endif
> -
> -       put_prev_task(rq, prev);
> +       put_prev_task_balance(rq, prev, rf);
>
>         for_each_class(class) {
>                 p = class->pick_next_task(rq);
> --
> 2.17.1
>
