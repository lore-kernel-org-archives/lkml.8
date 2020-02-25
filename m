Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF1C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5142072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgBYPVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:21:24 -0500
Received: from foss.arm.com ([217.140.110.172]:52118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbgBYPVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:21:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E0FA1FB;
        Tue, 25 Feb 2020 07:21:23 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96483F703;
        Tue, 25 Feb 2020 07:21:21 -0800 (PST)
Subject: Re: [PATCH v2 2/6] sched/rt: Re-instate old behavior in
 select_task_rq_rt
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-3-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <01313581-0c60-8b4c-ceb3-e23554a600ed@arm.com>
Date:   Tue, 25 Feb 2020 15:21:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200223184001.14248-3-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.20 18:39, Qais Yousef wrote:

[...]

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4043abe45459..2c3fae637cef 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1474,6 +1474,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	if (test || !rt_task_fits_capacity(p, cpu)) {
>  		int target = find_lowest_rq(p);
>  
> +		/*
> +		 * Bail out if we were forcing a migration to find a better
> +		 * fitting CPU but our search failed.
> +		 */
> +		if (!test && !rt_task_fits_capacity(p, target))
> +			goto out_unlock;

Didn't you loose the 'target != -1' condition from
https://lore.kernel.org/r/20200218041620.GD28029@codeaurora.org ?

A call to rt_task_fits_capacity(p, -1) would cause issues on a
heterogeneous system.

I tried to provoke this but wasn't able to do so. find_lowest_rq()
returns -1 in 4 places. (1) lowest_mask should be there (2) if
'task->nr_cpus_allowed == 1' select_task_rq_rt() wouldn't have been
called but maybe (3) or (4) can still return -1.

[...]
