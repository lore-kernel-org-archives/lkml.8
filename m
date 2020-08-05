Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCE922CAF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgHEUME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHEQ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B31C11424;
        Wed,  5 Aug 2020 09:21:24 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 863283F7D7;
        Wed,  5 Aug 2020 09:21:16 -0700 (PDT)
Subject: Re: [PATCH RFC] sched/fair: simplfy the work when reweighting entity
To:     Jiang Biao <benbjiang@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
References: <20200804071222.31675-1-benbjiang@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f9eab9a5-c7c2-dbf3-834b-abd9c376f92c@arm.com>
Date:   Wed, 5 Aug 2020 18:21:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804071222.31675-1-benbjiang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 09:12, Jiang Biao wrote:
> If a se is on_rq when reweighting entity, all we need should be
> updating the load of cfs_rq, other dequeue/enqueue works could be
> redundant, such as,
> * account_numa_dequeue/account_numa_enqueue
> * list_del/list_add from/into cfs_tasks
> * nr_running--/nr_running++

I think this could make sense. Have you spotted a code path where this
gives you a change?

I guess only for a task on the rq, so: entity_is_task(se) && se->on_rq

> Just simplfy the work. Could be helpful for the hot path.

IMHO hotpath is update_cfs_group() -> reweight_entity() but this is only
called for '!entity_is_task(se)'.

See

 3290         if (!gcfs_rq)
 3291                 return;

in update_cfs_group().

The 'entity_is_task(se)' case is

set_load_weight(struct task_struct *p, ...) -> reweight_task(p, ...) ->
reweight_entity(..., &p->se, ...)

but here !se->on_rq.

> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..18a8fc7bd0de 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3086,7 +3086,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		/* commit outstanding execution time */
>  		if (cfs_rq->curr == se)
>  			update_curr(cfs_rq);
> -		account_entity_dequeue(cfs_rq, se);
> +		update_load_sub(&cfs_rq->load, se->load.weight);
>  	}
>  	dequeue_load_avg(cfs_rq, se);
>  
> @@ -3102,7 +3102,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  
>  	enqueue_load_avg(cfs_rq, se);
>  	if (se->on_rq)
> -		account_entity_enqueue(cfs_rq, se);
> +		update_load_add(&cfs_rq->load, se->load.weight);
>  
>  }
