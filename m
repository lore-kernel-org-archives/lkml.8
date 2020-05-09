Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2160C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E76421655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AvaoSkes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEICPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:15:01 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17341 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbgEICPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:15:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588990500; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=IE+z/kClVwU1gvJqLL2HgEL3UKXb0e+KAz5nORz2gVo=; b=AvaoSkesPcTlG5dhgH1ZDO/HJiHDa9+thxdGIGLyUSK3auS7iiSAYiLQ1fi9XVOXP8r6hNSM
 riU1lWxY53HPuyV8L3hdPJdSunTSrNeArbsjB5dN+M+ISh77Zv0YJeSOemwRQaLNP3CzuaPW
 9/awNCQQ5zMCIbq94J5ilSs1ZdU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb61223.7f582984fc38-smtp-out-n04;
 Sat, 09 May 2020 02:14:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80258C44791; Sat,  9 May 2020 02:14:59 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2AEEC433D2;
        Sat,  9 May 2020 02:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2AEEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Sat, 9 May 2020 07:44:52 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 1/4] sched/core: Introduce per_cpu counter to track latency
 sensitive tasks
Message-ID: <20200509021452.GL19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-2-parth@linux.ibm.com>
 <20200508084002.GK19464@codeaurora.org>
 <552146c4-abee-1c8e-38fd-7ac3679c2ad9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552146c4-abee-1c8e-38fd-7ac3679c2ad9@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:00:44PM +0530, Parth Shah wrote:
> 
> 
> On 5/8/20 2:10 PM, Pavan Kondeti wrote:
> > On Thu, May 07, 2020 at 07:07:20PM +0530, Parth Shah wrote:
> >> The "nr_lat_sensitive" per_cpu variable provides hints on the possible
> >> number of latency-sensitive tasks occupying the CPU. This hints further
> >> helps in inhibiting the CPUIDLE governor from calling deeper IDLE states
> >> (next patches includes this).
> >>
> > 
> > Can you please explain the intended use case here? Once a latency sensitive
> > task is created, it prevents c-state on a CPU whether the task runs again
> > or not in the near future.
> > 
> > I assume, either these latency sensitive tasks won't be around for long time
> > or applications set/reset latency sensitive nice value dynamically.
> > 
> 
> Intended use-cases is to get rid of IDLE states exit_latency for
> wakeup-sleep-wakeup pattern workload. This types of tasks (like GPU
> workloads, few DB benchmarks) makes CPU go IDLE due to its low runtime on
> rq, resulting in higher wakeups due to IDLE states exit_latency.
> 
> And this kind of workloads may last for long time as well.
> 
> In current scenario, Sysadmins do disable all IDLE states or use PM_QoS to
> not have latency penalty on workload. This model was good when core counts
> were less. But now higher core count and Turbo frequencies have led to save
> power in-order to get higher performance and hence this patch-set tries to
> do PM_QoS like thing but at per-task granularity.
> 
Thanks for the details. Instead of disabling C-states for all CPUs, we disable
it for CPUS that host latency sensitive tasks. Since this is hooked with the
scheduler, the task migrations are accounted for. Got it.

Thanks,
Pavan

> If idea seems good to go, then this can potentially be extended to do IDLE
> gating upto certain level where latency_nice value hints on which IDLE
> states can't be chosen, just like PM_QoS have cpu_dma_latency constraints.
> 
> 
> Thanks,
> Parth
> 
> 
> > Thanks,
> > Pavan
> > 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
