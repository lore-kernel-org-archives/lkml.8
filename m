Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50570C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0F320739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRNGuRQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgFOPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFOPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:10:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:10:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so19592876lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4sVMM7TaNawdbsHgDCWa8zSnS2h9z0AXuq8X1e8ReQ=;
        b=vRNGuRQZjesjUflGiRKEGce7m37DbhtoGaMt5c9miL80zJacRgCqaFj88HlLnKbQZV
         VThb+a3WLwphv0AzeTjNvjFY1u/sWfwGUhD/fd6EZVWdMajCACk8nKx5LeR6TZuSduTR
         Ow5p1T9ltleg2ul7/5H0fCYq6apXcTA9xI+15VzOF5tfGIgZ7CjAB5IV/GN/CwgkUhFc
         tjPailaxNrN8SAkwNPqgg8rChdsY/DmP/vX+wkjMHXed5NNTL/YgtTUiCSoM5WayfNyU
         HY+3096zEW3bTBWeBGIrIe88rL6tvhYldzO1OtRX0iXIYNh0Nr3SKW4JAKKHnDM5c5Sv
         F76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4sVMM7TaNawdbsHgDCWa8zSnS2h9z0AXuq8X1e8ReQ=;
        b=KtIkczNgv8QINYpfurbWXuf0Px6P2CzmnaulWtBbD8l9MtVH64uHgfbgExKwrqErQB
         5mS2D24bZ6IQYl1aCa6i67pSKNcc7u2WjD4Otc5r4wlD1n0GdoRyk0N925UNpMA8Fg5o
         cAePIFGFzfi1wL3OVyPND9Cq0imau8t6NrIwdo1ro7fSr8+PQ9spGshXqrIfeL/Q5jeU
         5eFu8ZY+BmOM2vGILirD8JfPLyo2pjY9HsMqP3ovsJbx8DmOK/VuVG39Irmz7LgFbbj9
         JyCeDvue3aRlpamqr2RSzy65qutc8vJEZMUQKtyueiKgeYoMnHn+ahVaZLyjnZgeeR7v
         2Asg==
X-Gm-Message-State: AOAM532DA0NCpAeTrVhgVm0iUpZSjGl1ayBDhjCU6lnQIcoiYz1aDIL8
        bUnLTUi/QqD0lLmkivQl9aNvmvgP/0KoDxGcdCCESA==
X-Google-Smtp-Source: ABdhPJyq3PYE0aYlLV/tRtn7CGYlJGREOYSvNVsbKqAMu9OfeKFSvgRc1SIy1/QCP+5sVWnrNBoALXKqi0w6a4WFCWk=
X-Received: by 2002:a2e:96da:: with SMTP id d26mr13367284ljj.25.1592233803627;
 Mon, 15 Jun 2020 08:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
In-Reply-To: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 Jun 2020 17:09:51 +0200
Message-ID: <CAKfTPtACgUutP86nM6HvgQ-Hj7RdBnK+yxqg3Dr+cOZCPSoeyg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Optimize dequeue_task_fair()
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

On Mon, 15 Jun 2020 at 16:20, Peng Wang <rocking@linux.alibaba.com> wrote:
>
> While looking at enqueue_task_fair and dequeue_task_fair, it occurred
> to me that dequeue_task_fair can also be optimized as Vincent described
> in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").

good point

>
> dequeue_throttle label can ensure se not to be NULL, and se is
> always NULL when reaching root level.
>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbcb2f7..e6be952 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5614,10 +5614,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>         }
>
> -dequeue_throttle:
> -       if (!se)
> -               sub_nr_running(rq, 1);
> +       /* At this point se is NULL and we are at root level*/
> +       sub_nr_running(rq, 1);
>
> +dequeue_throttle:
>         /* balance early to pull high priority tasks */
>         if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>                 rq->next_balance = jiffies;

You can move the label here because sched_idle_rq() uses
rq->nr-running and rq->cfs.idle_h_nr_running so they will not change
if we jump to the label before reaching root level

> --
> 2.9.5
>
