Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0842465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/kVbkF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBTJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:38:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36266 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBTJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:38:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so3503119ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vVWCZgEt9hH/PfuM0yA2Dp0ajHL5MQQollzITWjSQY=;
        b=A/kVbkF6Y+rA6DuZmc2kKpj2Ndpq6FbK/R4L9L2wECYxtpam8JoVsBQzPfx5omeu09
         sg1y1tlvI9PR7s94/mcmUxGYeOkAo7j53iYgVKWmHUaYhrHO+uvihP0AqKr1axniHGEv
         HjJ9e7/TVMkTXFaZjYzAVyTr/I51sKJPnhN1EgD/2oSoMuAYJpI9QHB1LznlAUxo2OWQ
         tHVwpxpqmRDhq+N3PjV9E9umVlgYJ4WpLFzP8Goq9MEvEEJXZoUi3KYIt3MXLUe7GQiP
         IaRTU8YUhbPlq8TcfAFTsdDwgd42uuesSEY5GPhdoSFCSSSDC7LB8albln/cLWfL4LkN
         YexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vVWCZgEt9hH/PfuM0yA2Dp0ajHL5MQQollzITWjSQY=;
        b=kRrpzi2wVtGXrx4adH96PS3Sq1484rly+OpXyVYa74h1NEzuMX5Dqu0K8O6YJgrWmx
         hbN0fM6cI/DTylmzqnriG/CAePl0P1asez4U6T5hZqLaM5xuy0YKq2NLabweN5YG0m6h
         8VBycM+7zeXra7B3Y8nty01KI+gn6z20yz6wBUkmFuvMvVxVZTErSiS/Sysa/7m6ChrY
         B6i5tlczH31mMAerUNWL3xRqaN1wmP0lSd2Pe+V0A+nh5zpkfIiAIVV26noXJ3YXGLQx
         Wmm5Vu6GFmZ8Kqdziwym8m6+pb9nEa89R4j72UWcx7NICdbuzVPnvIyLegbUbVxCrBLw
         DiHw==
X-Gm-Message-State: APjAAAVZ7YEbiU225VukKJ4yGmLI7mJSMDC2opX/62UFhFkvTNTEoQLK
        yaklG6Ci6HThEssWpgtmoDjzDxkUVMraqgI6sJuq/w==
X-Google-Smtp-Source: APXvYqyxmW0oFUIAFUYAPQAt8GfEKxcq72zYNB9LzOnnQylSDNrPQcrQJHH2izAKYOzVKtLrzCPIis/w87qIuxR19eU=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr18253145ljg.151.1582191494031;
 Thu, 20 Feb 2020 01:38:14 -0800 (PST)
MIME-Version: 1.0
References: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
In-Reply-To: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Feb 2020 10:38:02 +0100
Message-ID: <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add !se->on_rq check before dequeue entity
To:     qiwuchen55@gmail.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 at 08:29, <qiwuchen55@gmail.com> wrote:
>
> From: chenqiwu <chenqiwu@xiaomi.com>
>
> We igonre checking for !se->on_rq condition before dequeue one
> entity from cfs rq. It must be required in case the entity has
> been dequeued.

Do you have a use case that triggers this situation ?

This is the only way to reach this situation seems to be dequeuing a
task on a throttled cfs_rq

>
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3c8a379..945dcaf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5341,6 +5341,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         bool was_sched_idle = sched_idle_rq(rq);
>
>         for_each_sched_entity(se) {
> +               if (!se->on_rq)
> +                       break;
>                 cfs_rq = cfs_rq_of(se);
>                 dequeue_entity(cfs_rq, se, flags);
>
> --
> 1.9.1
>
