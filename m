Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21028C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A6F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHQM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:28:13 -0400
Received: from foss.arm.com ([217.140.110.172]:54426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:28:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9925030E;
        Mon, 17 Aug 2020 05:28:11 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE223F66B;
        Mon, 17 Aug 2020 05:28:05 -0700 (PDT)
Subject: Re: [PATCH v3] sched/fair: simplfy the work when reweighting entity
To:     Jiang Biao <benbjiang@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
References: <20200811113209.34057-1-benbjiang@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4a0e414a-7662-58f5-f9ef-b1796552b9be@arm.com>
Date:   Mon, 17 Aug 2020 14:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811113209.34057-1-benbjiang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 13:32, Jiang Biao wrote:
> From: Jiang Biao <benbjiang@tencent.com>
> 
> The code in reweight_entity() can be simplified.
> 
> For a sched entity on the rq, the entity accounting can be replaced by
> cfs_rq instantaneous load updates currently called from within the
> entity accounting.
> 
> Even though an entity on the rq can't represent a task in
> reweight_entity() (a task is always dequeued before calling this
> function) and so the numa task accounting and the rq->cfs_tasks list
> management of the entity accounting are never called, the redundant
> cfs_rq->nr_running decrement/increment will be avoided.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
> v3<-v2: Amend commit log taking Dietmar's advice. Thx.
> v2<-v1: Amend the commit log
> 
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

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
