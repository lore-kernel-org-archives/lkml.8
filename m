Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D75EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248CB208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgEKIpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:45:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgEKIpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DACED6E;
        Mon, 11 May 2020 01:45:18 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5787B3F305;
        Mon, 11 May 2020 01:45:16 -0700 (PDT)
Subject: Re: [PATCH v2] sched/debug: Fix requested task uclamp values shown in
 procfs
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
References: <1589162011-4998-1-git-send-email-pkondeti@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <da48db5b-a2b3-1e4c-fcb9-67f5b03c33dd@arm.com>
Date:   Mon, 11 May 2020 10:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589162011-4998-1-git-send-email-pkondeti@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 03:53, Pavankumar Kondeti wrote:
> The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
> values to SCHED_DEBUG procfs") was to print requested and effective
> task uclamp values. The requested values printed are read from p->uclamp,
> which holds the last effective values. Fix this by printing the values
> from p->uclamp_req.
> 
> Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
> Tested-and-reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
> 
> V2: Added "requested" prefix (suggested by Valentin)

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> 
>  kernel/sched/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index a562df5..77ecebd 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  	P(se.avg.util_est.enqueued);
>  #endif
>  #ifdef CONFIG_UCLAMP_TASK
> -	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
> -	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
> +	__PS("requested uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> +	__PS("requested uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
>  	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
>  	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
>  #endif
