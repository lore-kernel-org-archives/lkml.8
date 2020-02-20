Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69996C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4514B24682
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgBTPFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:05:15 -0500
Received: from foss.arm.com ([217.140.110.172]:44566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBTPFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:05:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122AF31B;
        Thu, 20 Feb 2020 07:05:15 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ED473F703;
        Thu, 20 Feb 2020 07:05:12 -0800 (PST)
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d90b2073-4b23-f0bb-fec0-42bef9096822@arm.com>
Date:   Thu, 20 Feb 2020 16:04:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219125513.8953-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 13:55, Vincent Guittot wrote:
> Now that runnable_load_avg has been removed, we can replace it by a new
> signal that will highlight the runnable pressure on a cfs_rq. This signal
> track the waiting time of tasks on rq and can help to better define the
> state of rqs.
> 
> At now, only util_avg is used to define the state of a rq:
>   A rq with more that around 80% of utilization and more than 1 tasks is
>   considered as overloaded.

Don't we make the distinction of overutilized and overloaded?

update_sg_lb_stats(), SG_OVERUTILIZED and SG_OVERLOAD

[...]

> @@ -310,13 +325,14 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
>   *   util_sum = cpu_scale * load_sum
>   *   runnable_sum = util_sum
>   *
> - *   load_avg is not supported and meaningless.
> + *   load_avg and runnable_load_avg are not supported and meaningless.

Nit pick:

s/runnable_load_avg/runnable_avg

[...]

> + *   load_avg and runnable_load_avg are not supported and meaningless.
>   *
>   */
>  
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)

[...]

> - *   load_avg is not supported and meaningless.
> + *   load_avg and runnable_load_avg are not supported and meaningless.
>   *
>   */
>  
> @@ -389,9 +406,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)

[...]
