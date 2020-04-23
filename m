Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50F4C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C0F20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgDWOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:30:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDWOaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:30:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830B731B;
        Thu, 23 Apr 2020 07:30:10 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 153033F6CF;
        Thu, 23 Apr 2020 07:30:08 -0700 (PDT)
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when
 propagating
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <23c1cbb8-7335-80ca-cf40-8abc5c1463f4@arm.com>
Date:   Thu, 23 Apr 2020 16:30:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422151401.9147-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2020 17:14, Vincent Guittot wrote:
> update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
> an entity down into the cfs_rq hierarchy which must keep the sync with
> the current pelt window.
> 
> Even if we can't sync child rq and its group se, we can sync the group se

So we have

    gcfs --> tg --> gse
     ________________|
     |
     V

    cfs ---> tg (root)

     |
     V

    rq


here. What is 'child rq' for 'group se' here? I guess 'parent cfs_rq' is
cfs_rq.

> and parent cfs_rq with current PELT window. In fact, we must keep them sync
> in order to stay also synced with others se and group se that are already
> attached to the cfs_rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..ca6aa89c88f2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3441,52 +3441,38 @@ static inline void
>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
>  	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> +	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
>  	/* Nothing to update */
>  	if (!delta)
>  		return;
>  
> -	/*
> -	 * The relation between sum and avg is:
> -	 *
> -	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> -	 *
> -	 * however, the PELT windows are not aligned between grq and gse.
> -	 */
> -
>  	/* Set new sched_entity's utilization */
>  	se->avg.util_avg = gcfs_rq->avg.util_avg;
> -	se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
> +	se->avg.util_sum = se->avg.util_avg * divider;

divider uses cfs_rq but we sync se->avg.util_avg with gcfs_rq here.

But since avg.period_contrib of cfs_rq and gcfs_rq are the same this
should work.

>  	/* Update parent cfs_rq utilization */
>  	add_positive(&cfs_rq->avg.util_avg, delta);
> -	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
> +	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;

Looks like that avg.last_update_time of se (group entity), it's gcfs_rq
and cfs_rq is always the same in update_tg_cfs_[util\|runnable].

So that means the PELT windows are aligned for cfs_rqs and group se's?

And if we want to enforce this for cfs_rq and task, we have
sync_entity_load_avg().

[...]
