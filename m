Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4EBC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF552080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBXN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:29:11 -0500
Received: from foss.arm.com ([217.140.110.172]:37080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBXN3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:29:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D0130E;
        Mon, 24 Feb 2020 05:29:10 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B973F534;
        Mon, 24 Feb 2020 05:29:08 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:29:06 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        David.Laight@ACULAB.COM, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v4 4/4] sched/core: Add permission checks for setting the
 latency_nice value
Message-ID: <20200224132905.32sdpbydnzypib47@e107158-lin.cambridge.arm.com>
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-5-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224085918.16955-5-parth@linux.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/20 14:29, Parth Shah wrote:
> Since the latency_nice uses the similar infrastructure as NICE, use the
> already existing CAP_SYS_NICE security checks for the latency_nice. This
> should return -EPERM for the non-root user when trying to set the task
> latency_nice value to any lower than the current value.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>

I'm not against this, so I'm okay if it goes in as is.

But IMO the definition of this flag is system dependent and I think it's
prudent to keep it an admin only configuration.

It'd be hard to predict how normal application could use and depend on this
feature in the future, which could tie our hand in terms of extending it.

I can't argue hard about this though. But I do feel going further and have
a sched_feature() for each optimization that uses this flag could be necessary
too.

Thanks

--
Qais Yousef

> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1dc536d4ca3..f883e1d3cd10 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4887,6 +4887,10 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return -EINVAL;
>  		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>  			return -EINVAL;
> +		/* Use the same security checks as NICE */
> +		if (attr->sched_latency_nice < p->latency_nice &&
> +		    !can_nice(p, attr->sched_latency_nice))
> +			return -EPERM;
>  	}
>  
>  	if (pi)
> -- 
> 2.17.2
> 
