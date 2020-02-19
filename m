Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61306C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392B624654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="M5Ob83ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgBSCqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:46:24 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:25949 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbgBSCqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:46:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582080383; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=EZldwMwfRwILNbyiADsIQMw6OSHJxtFM2DQb2VA7DkY=; b=M5Ob83haVinyvmzduiwwULsSncmmzfQGSn69/7tF0qe9eVWrVdiiKoMedBoxb8LjjFQwZLcW
 Ebb6VOj1rmYwMtHlu1z40Gm9nKijAgBjyK/jV4aGLzyKtwrw0FgE1j5Y9m+qPhoPahzwQ/+i
 0rXKyW5SNqGU6i2pgwyaVk6kffo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4ca178.7fe21eea3ae8-smtp-out-n02;
 Wed, 19 Feb 2020 02:46:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 076E4C447A0; Wed, 19 Feb 2020 02:46:16 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B682C43383;
        Wed, 19 Feb 2020 02:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B682C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 19 Feb 2020 08:16:09 +0530
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
Message-ID: <20200219024608.GE28029@codeaurora.org>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
 <20200217092329.GC28029@codeaurora.org>
 <20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com>
 <20200218041620.GD28029@codeaurora.org>
 <20200218174718.ma6cpr2qwnueertn@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218174718.ma6cpr2qwnueertn@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:47:19PM +0000, Qais Yousef wrote:
> On 02/18/20 09:46, Pavan Kondeti wrote:
> > The original RT task placement i.e without capacity awareness, places the task
> > on the previous CPU if the task can preempt the running task. I interpreted it
> > as that "higher prio RT" task should get better treatment even if it results
> > in stopping the lower prio RT execution and migrating it to another CPU.
> > 
> > Now coming to your patch (merged), we force find_lowest_rq() if the previous
> > CPU can't fit the task though this task can right away run there. When the
> > lowest mask returns an unfit CPU (with your new patch), We have two choices,
> > either to place it on this unfit CPU (may involve migration) or place it on
> > the previous CPU to avoid the migration. We are selecting the first approach.
> > 
> > The task_cpu(p) check in find_lowest_rq() only works when the previous CPU
> > does not have a RT task. If it is running a lower prio RT task than the
> > waking task, the lowest_mask may not contain the previous CPU.
> > 
> > I don't if any workload hurts due to this change in behavior. So not sure
> > if we have to restore the original behavior. Something like below will do.
> 
> Is this patch equivalent to yours? If yes, then I got you. If not, then I need
> to re-read this again..
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ace9acf9d63c..854a0c9a7be6 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1476,6 +1476,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>         if (test || !rt_task_fits_capacity(p, cpu)) {
>                 int target = find_lowest_rq(p);
> 
> +               /*
> +                * Bail out if we were forcing a migration to find a better
> +                * fitting CPU but our search failed.
> +                */
> +               if (!test && !rt_task_fits_capacity(p, target))
> +                       goto out_unlock;
> +

Yes. This is what I was referring to.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
