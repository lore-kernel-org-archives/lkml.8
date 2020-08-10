Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54D1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHJLSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:18:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgHJLSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B0BD101E;
        Mon, 10 Aug 2020 04:18:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBC33F6CF;
        Mon, 10 Aug 2020 04:18:30 -0700 (PDT)
References: <20200810083004.26420-1-lukasz.luba@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org, mgorman@suse.de,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        patrick.bellasi@matbug.com, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] sched/fair: Fix wrong negative conversion in find_energy_efficient_cpu()
In-reply-to: <20200810083004.26420-1-lukasz.luba@arm.com>
Date:   Mon, 10 Aug 2020 12:18:25 +0100
Message-ID: <jhjy2mmhhq6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/08/20 09:30, Lukasz Luba wrote:
> In find_energy_efficient_cpu() 'cpu_cap' could be less that 'util'.
> It might be because of RT, DL (so higher sched class than CFS), irq or
> thermal pressure signal, which reduce the capacity value.
> In such situation the result of 'cpu_cap - util' might be negative but
> stored in the unsigned long. Then it might be compared with other unsigned
> long when uclamp_rq_util_with() reduced the 'util' such that is passes the
> fits_capacity() check.
>
> Prevent this situation and make the arithmetic more safe.
>
> Fixes: 1d42509e475cd ("sched/fair: Make EAS wakeup placement consider
> uclamp restrictions")

I was going to say that might even go as far back as:

  732cd75b8c92 ("sched/fair: Select an energy-efficient CPU on task wake-up")

but we had a capacity fitness check in the right place back then, which I
screwed over with that uclamp_rq_util_with() :/

LGTM, thanks for figuring that one out.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536add..51408ebd76c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6594,7 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>                       util = cpu_util_next(cpu, p, cpu);
>                       cpu_cap = capacity_of(cpu);
> -			spare_cap = cpu_cap - util;
> +			spare_cap = cpu_cap;
> +			lsub_positive(&spare_cap, util);
>
>                       /*
>                        * Skip CPUs that cannot satisfy the capacity request.
