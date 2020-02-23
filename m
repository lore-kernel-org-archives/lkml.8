Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56CC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FFF20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBWXTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:19:06 -0500
Received: from foss.arm.com ([217.140.110.172]:53936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgBWXST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B05630E;
        Sun, 23 Feb 2020 15:18:18 -0800 (PST)
Received: from [10.43.4.116] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007193F534;
        Sun, 23 Feb 2020 15:18:16 -0800 (PST)
Subject: Re: [PATCH v2 6/6] sched/rt: Remove unnecessary assignment in
 inc/dec_rt_migration
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-7-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a000f6b4-7548-1964-ba30-e8396c727d31@arm.com>
Date:   Mon, 24 Feb 2020 00:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200223184001.14248-7-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.20 19:40, Qais Yousef wrote:
> The statement
> 
> 	rt_rq = &rq_of_rt_rq(rt_rq)->rt
> 
> Was just dereferencing rt_rq to get a pointer to itself. Which is a NOP.
> Remove it.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/rt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b35e49cdafcc..520e84993fe7 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -343,7 +343,6 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>  		return;
>  
>  	p = rt_task_of(rt_se);
> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;

IMHO, this is here to get the root rt_rq from any rt_rq (task_groups).
Looks like that e.g rt_nr_total is only maintained on root rt_rq's.

Similar to CFS' &rq_of(cfs_rq)->cfs (cfs_rq_util_change()) to get root
cfs_rq.

Not sure where CONFIG_RT_GROUP_SCHED=y is used but it's part of the rt
class implementation.

[...]
