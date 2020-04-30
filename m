Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB623C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8234A2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DZ98+TQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD3LBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:01:21 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53840 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbgD3LBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:01:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588244479; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=2oduhd2RjV0y4DwWw19IfbKH7BMj1+ef9/lVlaVnz3w=; b=DZ98+TQl5saBBfknazE0dzwhgDxlbMnWRns1QxZ9NN9ddpAEJcyK8VsbCvaVeYCXt4BaT83B
 /Mlc3gIXEWvyy1LfqR+PIGQpX9fzBsAo1I0WvHnqTeOzBnQF1agPF0kHs27c3QVFwdTVZJXJ
 Y+C4XbVdnol4ClSvGaRYDp+6NK4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaafe3.7f386bceb928-smtp-out-n01;
 Thu, 30 Apr 2020 11:00:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3DF9C43636; Thu, 30 Apr 2020 11:00:51 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4A16C433CB;
        Thu, 30 Apr 2020 11:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4A16C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 30 Apr 2020 16:30:42 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200430110042.GD19464@codeaurora.org>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-7-dietmar.eggemann@arm.com>
 <20200427133438.GA6469@localhost.localdomain>
 <20200427161715.3dd3a148@nowhere>
 <57e4846a-4e54-5450-8167-768f021250f7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e4846a-4e54-5450-8167-768f021250f7@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:39:50PM +0200, Dietmar Eggemann wrote:
> On 27/04/2020 16:17, luca abeni wrote:
> > Hi Juri,
> > 
> > On Mon, 27 Apr 2020 15:34:38 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> >> Hi,
> >>
> >> On 27/04/20 10:37, Dietmar Eggemann wrote:
> >>> From: Luca Abeni <luca.abeni@santannapisa.it>
> >>>
> >>> When a task has a runtime that cannot be served within the
> >>> scheduling deadline by any of the idle CPU (later_mask) the task is
> >>> doomed to miss its deadline.
> >>>
> >>> This can happen since the SCHED_DEADLINE admission control
> >>> guarantees only bounded tardiness and not the hard respect of all
> >>> deadlines. In this case try to select the idle CPU with the largest
> >>> CPU capacity to minimize tardiness.
> >>>
> >>> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> >>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > [...]
> >>> -		if (!cpumask_empty(later_mask))
> >>> -			return 1;
> >>> +		if (cpumask_empty(later_mask))
> >>> +			cpumask_set_cpu(max_cpu, later_mask);  
> >>
> >> Think we touched upon this during v1 review, but I'm (still?)
> >> wondering if we can do a little better, still considering only free
> >> cpus.
> >>
> >> Can't we get into a situation that some of the (once free) big cpus
> >> have been occupied by small tasks and now a big task enters the
> >> system and it only finds small cpus available, were it could have fit
> >> into bigs if small tasks were put onto small cpus?
> >>
> >> I.e., shouldn't we always try to best fit among free cpus?
> > 
> > Yes; there was an additional patch that tried schedule each task on the
> > slowest core where it can fit, to address this issue.
> > But I think it will go in a second round of patches.
> 
> Yes, we can run into this situation in DL, but also in CFS or RT.
> 
In CFS case, the misfit task handling in load balancer should help pulling
the BIG task running on the little CPUs. I get your point that we can run
into the same scenario with other scheduling class tasks.

> IMHO, this patch is aligned with the Capacity Awareness implementation
> in CFS and RT.
> 
> Capacity Awareness so far is 'find a CPU which fits the requirement of
> the task (Req)'. It's not (yet) find the best CPU.
> 
> CFS - select_idle_capacity() -> task_fits_capacity()
> 
>       Req: util(p) * 1.25 < capacity_of(cpu)
> 
> RT  - select_task_rq_rt(), cpupri_find_fitness() ->
>       rt_task_fits_capacity()
> 
>       Req: uclamp_eff_value(p) <= capacity_orig_of(cpu)
> 
> DL  - select_task_rq_dl(), cpudl_find() -> dl_task_fits_capacity()
> 
>       Req: dl_runtime(p)/dl_deadline(p) * 1024  <= capacity_orig_of(cpu)
> 
> 
> There has to be an "idle" (from the viewpoint of the task) CPU available
> with a fitting capacity. Otherwise a fallback mechanism applies.
> 
> CFS - best capacity handling in select_idle_capacity().
> 
> RT  - Non-fitting lowest mask
> 
> DL  - This patch
> 
> You did spot the rt-app 'delay' for the small tasks in the test case ;-)

Thanks for the hint. It was not clear to me why 1 msec delay is given for
the small tasks in the rt-app json description in the cover letter.
I get it now :-)

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
