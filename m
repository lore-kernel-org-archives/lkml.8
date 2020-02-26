Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E5C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB412067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hyCf40mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgBZDog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:44:36 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:39531 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgBZDog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:44:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582688675; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=UbtExdr2bi0dCmJgKcev0fuQbPUYk2NRkiBpDXCW+jM=; b=hyCf40mr1npuk43VLf29equ/M2XgyjwWaznm2N6Zg88KXMVE4a018SnKEc/bN1TQmvYvGxFS
 dzMWXCiZvKA79hwTrgcWdJD6Rqzyg/NkrCWZ1eRPeRyUTMxObIWymh+yoYVCkuUPWotmyCn9
 kdbU81HYPrTOvhTViUjXsF3rgW4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e55e9a2.7faad75cc768-smtp-out-n01;
 Wed, 26 Feb 2020 03:44:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95D2FC447A5; Wed, 26 Feb 2020 03:44:34 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E48DC43383;
        Wed, 26 Feb 2020 03:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E48DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 26 Feb 2020 09:14:25 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v4 3/4] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
Message-ID: <20200226034425.GL28029@codeaurora.org>
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-4-parth@linux.ibm.com>
 <20200225065409.GK28029@codeaurora.org>
 <f44fb56c-d9d9-a132-d953-bcbee8c03dda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44fb56c-d9d9-a132-d953-bcbee8c03dda@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 08:33:53PM +0530, Parth Shah wrote:
> 
> 
> On 2/25/20 12:24 PM, Pavan Kondeti wrote:
> > On Mon, Feb 24, 2020 at 02:29:17PM +0530, Parth Shah wrote:
> > 
> > [...]
> > 
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 65b6c00d6dac..e1dc536d4ca3 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -4723,6 +4723,8 @@ static void __setscheduler_params(struct task_struct *p,
> >>  	p->rt_priority = attr->sched_priority;
> >>  	p->normal_prio = normal_prio(p);
> >>  	set_load_weight(p, true);
> >> +
> >> +	p->latency_nice = attr->sched_latency_nice;
> >>  }
> > 
> > We don't want this when SCHED_FLAG_LATENCY_NICE is not set in
> > attr->flags.
> > 
> > The user may pass SCHED_FLAG_KEEP_PARAMS | SCHED_FLAG_LATENCY_NICE to
> > change only latency nice value. So we have to update latency_nice
> > outside __setscheduler_params(), I think.
> 
> 
> AFAICT, passing SCHED_FLAG_KEEP_PARAMS with any other flag will prevent us
> from changing the latency_nice value because of the below code flow:
> 
> __sched_setscheduler()
> 	__setscheduler()
> 		if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) return;
> 		__setscheduler_params()
> 

I thought the user space could set SCHED_FLAG_KEEP_ALL | SCHED_FLAG_LATENCY_NICE
and be able to modify the nice value alone. This does not work since we skip
setting the latency nice value when SCHED_FLAG_KEEP_PARAMS is set. So to
change the nice value alone, we first have to do getattr() and modify the nice
value and pass it to setattr(). It is not a big deal. so I will leave it here.

> whereas, one thing we still can do is add if condition when setting the
> value, i.e.,
> 
> @@ -4724,7 +4724,8 @@ static void __setscheduler_params(struct task_struct *p,
>         p->normal_prio = normal_prio(p);
>         set_load_weight(p, true);
> 
> -       p->latency_nice = attr->sched_latency_nice;
> +       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> +               p->latency_nice = attr->sched_latency_nice;
>  }
> 

Yes, without this, we accidently override latency value when other attributes
are modified.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
