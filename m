Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20252C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4B7206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDLIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:42:26 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57124 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgDLImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:42:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvGWLBf_1586680942;
Received: from 30.25.201.141(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0TvGWLBf_1586680942)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Apr 2020 16:42:22 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
Subject: Re: [PATCH] sched/fair: Simplify the code of should_we_balance()
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
References: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
Message-ID: <6f372bce-151e-79e1-2fda-d8b2bcf777d6@linux.alibaba.com>
Date:   Sun, 12 Apr 2020 16:42:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/20 5:20 PM, Peng Wang wrote:
> We only consider group_balance_cpu() after there is no idle
> cpu. So, just do comparison before return at these two cases.
> 
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>   kernel/sched/fair.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1ea3ddd..81b2c647 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9413,7 +9413,7 @@ static int active_load_balance_cpu_stop(void *data);
>   static int should_we_balance(struct lb_env *env)
>   {
>   	struct sched_group *sg = env->sd->groups;
> -	int cpu, balance_cpu = -1;
> +	int cpu;
>   
>   	/*
>   	 * Ensure the balancing environment is consistent; can happen
> @@ -9434,18 +9434,12 @@ static int should_we_balance(struct lb_env *env)
>   		if (!idle_cpu(cpu))
>   			continue;
>   
> -		balance_cpu = cpu;
> -		break;
> +		/* Are we the first idle CPU? */
> +		return cpu == env->dst_cpu;
>   	}
>   
> -	if (balance_cpu == -1)
> -		balance_cpu = group_balance_cpu(sg);
> -
> -	/*
> -	 * First idle CPU or the first CPU(busiest) in this sched group
> -	 * is eligible for doing load balancing at this and above domains.
> -	 */
> -	return balance_cpu == env->dst_cpu;
> +	/* Are we the first balance CPU of this group? */
> +	return group_balance_cpu(sg) == env->dst_cpu;
>   }
>   
>   /*
> 

+juri.lelli@redhat.com
