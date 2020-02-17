Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E02C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6A42064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vtjJRlm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgBQJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:23:40 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:24423 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728650AbgBQJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:23:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581931420; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=56xPaJjtI8R0OC8Em8HF9HGcS/i65/aM+Jl81fhRZQo=; b=vtjJRlm3011hiu6wF9GTECJkxENXN5jRZPEnfTQQbVSACJdwWQ/XOf8TuFUy2p6HyBfQtiZ5
 ARM7FaWnx5b3MHXfSmjGqUhAWU6qiUy06pbEh0ig2qcdEW+SaRyC6NtQHK79Tg/7asD0MGAN
 iw1uf4mp3y1PBQQUsV0gRRPpGcY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a5b98.7f4a309d7b20-smtp-out-n03;
 Mon, 17 Feb 2020 09:23:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9D22C4479C; Mon, 17 Feb 2020 09:23:36 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1A59C43383;
        Mon, 17 Feb 2020 09:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1A59C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 17 Feb 2020 14:53:29 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/rt: fix pushing unfit tasks to a better CPU
Message-ID: <20200217092329.GC28029@codeaurora.org>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214163949.27850-4-qais.yousef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Fri, Feb 14, 2020 at 04:39:49PM +0000, Qais Yousef wrote:

[...]

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 0c8bac134d3a..5ea235f2cfe8 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1430,7 +1430,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
>  	struct rq *rq;
> -	bool test;
> +	bool test, fit;
>  
>  	/* For anything but wake ups, just return the task_cpu */
>  	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
> @@ -1471,16 +1471,32 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	       unlikely(rt_task(curr)) &&
>  	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
>  
> -	if (test || !rt_task_fits_capacity(p, cpu)) {
> +	fit = rt_task_fits_capacity(p, cpu);
> +
> +	if (test || !fit) {
>  		int target = find_lowest_rq(p);
>  
> -		/*
> -		 * Don't bother moving it if the destination CPU is
> -		 * not running a lower priority task.
> -		 */
> -		if (target != -1 &&
> -		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
> -			cpu = target;
> +		if (target != -1) {
> +			/*
> +			 * Don't bother moving it if the destination CPU is
> +			 * not running a lower priority task.
> +			 */
> +			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				cpu = target;
> +
> +			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				/*
> +				 * If the priority is the same and the new CPU
> +				 * is a better fit, then move, otherwise don't
> +				 * bother here either.
> +				 */
> +				fit = rt_task_fits_capacity(p, target);
> +				if (fit)
> +					cpu = target;
> +			}
> +		}

I understand that we are opting for the migration when priorities are tied but
the task can fit on the new task. But there is no guarantee that this task
stay there. Because any CPU that drops RT prio can pull the task. Then why
not leave it to the balancer?

I notice a case where tasks would migrate for no reason (happens without this
patch also). Assuming BIG cores are busy with other RT tasks. Now this RT
task can go to *any* little CPU. There is no bias towards its previous CPU.
I don't know if it makes any difference but I see RT task placement is too
keen on reducing the migrations unless it is absolutely needed.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
