Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3092EC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0818F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iBq/v5SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBYGco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:32:44 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39239 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgBYGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:32:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582612363; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ieAzKJEGqXO7uuP4tofi0kDsDedqiH3Cfd0F5f+Tzuc=; b=iBq/v5SUC5/pyrOkphXuEaRIVZ0UCis0rY47Izsi2+mkb73zEKs8kVPqXFGOCui3b1xkA2Y6
 o26Q+ma3KqL+FQvQjNZGQYE6QQvRCPCVLIHPHt3zPZLGgkauTfrpIOoNSneiGYod/GyggXFM
 ADDYymlR58ADG1SQRZWXmcLeGsQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e54bf84.7f6e36a62880-smtp-out-n01;
 Tue, 25 Feb 2020 06:32:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2F10C447A4; Tue, 25 Feb 2020 06:32:34 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F53CC43383;
        Tue, 25 Feb 2020 06:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F53CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 25 Feb 2020 12:02:26 +0530
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
Subject: Re: [PATCH v4 2/4] sched/core: Propagate parent task's latency
 requirements to the child task
Message-ID: <20200225063226.GJ28029@codeaurora.org>
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-3-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224085918.16955-3-parth@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:16PM +0530, Parth Shah wrote:
> Clone parent task's latency_nice attribute to the forked child task.
> 
> Reset the latency_nice value to default value when the child task is
> set to sched_reset_on_fork.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 377ec26e9159..65b6c00d6dac 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2860,6 +2860,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	 */
>  	p->prio = current->normal_prio;
>  
> +	/* Propagate the parent's latency requirements to the child as well */
> +	p->latency_nice = current->latency_nice;
> +
>  	uclamp_fork(p);
>  
>  	/*
> @@ -2876,6 +2879,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  		p->prio = p->normal_prio = __normal_prio(p);
>  		set_load_weight(p, false);
>  
> +		p->latency_nice = DEFAULT_LATENCY_NICE;
>  		/*
>  		 * We don't need the reset flag anymore after the fork. It has
>  		 * fulfilled its duty:
> -- 
> 2.17.2
> 

LGTM.

latency_nice value initialization is missing for the init_task.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
