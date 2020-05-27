Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84769C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F582088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RbcqV21e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgE0KLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:11:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37690 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgE0KLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:11:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590574267; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=atu17+9W+FIQs8MYmL02BKnoigWTXhhZazgWN3a+IvY=; b=RbcqV21eE0unoxXhqNVGJ59AaGU4FrsuFyH7pKuGWnTauKm21MkxsAFrNvVjwA6lfFeL+Trs
 Ky6lvZQTHE2bao9snIFaSwKSgM7dU4SlNuN5ajUx/2UFjX28efR1KqF1wsacNjweVt1SJXUp
 IicYNaJd/aiyHwjbpYR9C+1z0HA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ece3cbbcb045869331ce203 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 10:11:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 352DEC433CB; Wed, 27 May 2020 10:11:06 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 806D5C433C9;
        Wed, 27 May 2020 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 806D5C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 27 May 2020 15:40:59 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched: Offload wakee task activation if it the wakee
 is descheduling
Message-ID: <20200527101059.GA9455@codeaurora.org>
References: <20200524202956.27665-1-mgorman@techsingularity.net>
 <20200524202956.27665-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524202956.27665-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 09:29:56PM +0100, Mel Gorman wrote:
> The patch "sched: Optimize ttwu() spinning on p->on_cpu" avoids spinning
> on p->on_rq when the task is descheduling but only if the wakee is on
> a CPU that does not share cache with the waker. This patch offloads the
> activation of the wakee to the CPU that is about to go idle if the task
> is the only one on the runqueue. This potentially allows the waker task
> to continue making progress when the wakeup is not strictly synchronous.
> 
> This is very obvious with netperf UDP_STREAM running on localhost. The
> waker is sending packets as quickly as possible without waiting for any
> reply. It frequently wakes the server for the processing of packets and
> when netserver is using local memory, it quickly completes the processing
> and goes back to idle. The waker often observes that netserver is on_rq
> and spins excessively leading to a drop in throughput.
> 
> This is a comparison of 5.7-rc6 against "sched: Optimize ttwu() spinning
> on p->on_cpu" and against this patch labeled vanilla, optttwu-v1r1 and
> localwakelist-v1r2 respectively.
> 
>                                   5.7.0-rc6              5.7.0-rc6              5.7.0-rc6
>                                     vanilla           optttwu-v1r1     localwakelist-v1r2
> Hmean     send-64         251.49 (   0.00%)      258.05 *   2.61%*      305.59 *  21.51%*
> Hmean     send-128        497.86 (   0.00%)      519.89 *   4.43%*      600.25 *  20.57%*
> Hmean     send-256        944.90 (   0.00%)      997.45 *   5.56%*     1140.19 *  20.67%*
> Hmean     send-1024      3779.03 (   0.00%)     3859.18 *   2.12%*     4518.19 *  19.56%*
> Hmean     send-2048      7030.81 (   0.00%)     7315.99 *   4.06%*     8683.01 *  23.50%*
> Hmean     send-3312     10847.44 (   0.00%)    11149.43 *   2.78%*    12896.71 *  18.89%*
> Hmean     send-4096     13436.19 (   0.00%)    13614.09 (   1.32%)    15041.09 *  11.94%*
> Hmean     send-8192     22624.49 (   0.00%)    23265.32 *   2.83%*    24534.96 *   8.44%*
> Hmean     send-16384    34441.87 (   0.00%)    36457.15 *   5.85%*    35986.21 *   4.48%*
> 
> Note that this benefit is not universal to all wakeups, it only applies
> to the case where the waker often spins on p->on_rq.
> 
Thanks for the detailed description. I think you meant p->on_cpu here not
p->on_rq. I know this patch is included, if possible, please make this edit
here and below.

>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..06297d1142a0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1688,7 +1688,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>   */
>  #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
>  #define WF_FORK			0x02		/* Child wakeup after fork */
> -#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
> +#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
> +#define WF_ON_RQ		0x08		/* Wakee is on_rq */
>  
should this be WF_ON_CPU? There is a different check for p->on_rq in
try_to_wake_up.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

