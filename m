Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB908C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43792080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgH1Cxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:53:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47738 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgH1Cxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:53:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U73igQg_1598583227;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U73igQg_1598583227)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:48 +0800
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
Message-ID: <9bfaa095-2074-e0bb-da0b-81e00c7ca490@linux.alibaba.com>
Date:   Fri, 28 Aug 2020 10:53:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/24 PM8:30, Xunlei Pang wrote:
> We've met problems that occasionally tasks with full cpumask
> (e.g. by putting it into a cpuset or setting to full affinity)
> were migrated to our isolated cpus in production environment.
> 
> After some analysis, we found that it is due to the current
> select_idle_smt() not considering the sched_domain mask.
> 
> Fix it by checking the valid domain mask in select_idle_smt().
> 
> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..fa942c4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  /*
>   * Scan the local SMT mask for idle CPUs.
>   */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	int cpu;
>  
> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
>  		return -1;
>  
>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>  			continue;
>  		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>  			return cpu;
> @@ -6099,7 +6100,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>  	return -1;
>  }
>  
> -static inline int select_idle_smt(struct task_struct *p, int target)
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	return -1;
>  }
> @@ -6274,7 +6275,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> -	i = select_idle_smt(p, target);
> +	i = select_idle_smt(p, sd, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> 

Hi Peter, any other comments?
