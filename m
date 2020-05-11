Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A2C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B28C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgEKLNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:13:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKLNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:13:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63841FB;
        Mon, 11 May 2020 04:13:08 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 678013F305;
        Mon, 11 May 2020 04:13:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200228090755.22829-1-parth@linux.ibm.com>
 <20200228090755.22829-4-parth@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <00bf190a-6d84-48aa-83cb-b25e6c24777c@arm.com>
Date:   Mon, 11 May 2020 13:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200228090755.22829-4-parth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 10:07, Parth Shah wrote:
> Introduce the latency_nice attribute to sched_attr and provide a
> mechanism to change the value with the use of sched_setattr/sched_getattr
> syscall.
> 
> Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
> latency_nice of the task on every sched_setattr syscall.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

[...]

ndif /* _UAPI_LINUX_SCHED_TYPES_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 866ea3d2d284..cd1fb9c8be26 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4710,6 +4710,9 @@ static void __setscheduler_params(struct task_struct *p,
>  	p->rt_priority = attr->sched_priority;
>  	p->normal_prio = normal_prio(p);
>  	set_load_weight(p, true);
> +
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> +		p->latency_nice = attr->sched_latency_nice;
>  }

How do you make sure that p->latency_nice can be set independently from
p->static_prio?

AFAICS, util_clamp achieves this by relying on SCHED_FLAG_KEEP_PARAMS,
so completely bypassing __setscheduler_params() and using it's own
__setscheduler_uclamp().

[...]
