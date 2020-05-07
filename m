Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C454C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB720870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEGLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:17:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:17:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4451FB;
        Thu,  7 May 2020 04:17:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6A73F68F;
        Thu,  7 May 2020 04:17:49 -0700 (PDT)
References: <20200507110625.37254-1-yanaijie@huawei.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in voluntary_active_balance()
In-reply-to: <20200507110625.37254-1-yanaijie@huawei.com>
Date:   Thu, 07 May 2020 12:17:36 +0100
Message-ID: <jhjpnbg6lkf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/05/20 12:06, Jason Yan wrote:
> Fix the following coccicheck warning:
>
> kernel/sched/fair.c:9375:9-10: WARNING: return of 0/1 in function
> 'voluntary_active_balance' with return type bool
>

It's perfectly safe to return 0/1 in a boolean function; that said seeing
as this is the second attempt at "fixing" this I'm tempted to say we should
pick it up...

> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3bb4d6e49c3..e8390106ada4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9373,7 +9373,7 @@ voluntary_active_balance(struct lb_env *env)
>       struct sched_domain *sd = env->sd;
>
>       if (asym_active_balance(env))
> -		return 1;
> +		return true;
>
>       /*
>        * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> @@ -9385,13 +9385,13 @@ voluntary_active_balance(struct lb_env *env)
>           (env->src_rq->cfs.h_nr_running == 1)) {
>               if ((check_cpu_capacity(env->src_rq, sd)) &&
>                   (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
> -			return 1;
> +			return true;
>       }
>
>       if (env->migration_type == migrate_misfit)
> -		return 1;
> +		return true;
>
> -	return 0;
> +	return false;
>  }
>
>  static int need_active_balance(struct lb_env *env)
