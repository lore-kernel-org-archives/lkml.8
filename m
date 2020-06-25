Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF752C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8747C2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbgFYJYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:24:32 -0400
Received: from mail.itouring.de ([188.40.134.68]:35164 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390836AbgFYJYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:24:31 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id F17F2416080F;
        Thu, 25 Jun 2020 11:24:29 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id E7745F01605;
        Thu, 25 Jun 2020 11:24:28 +0200 (CEST)
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        rong.a.chen@intel.com
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
Date:   Thu, 25 Jun 2020 11:24:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200624154422.29166-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 17:44, Vincent Guittot wrote:
> Some performance regression on reaim benchmark have been raised with
>    commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> 
> The problem comes from the init value of runnable_avg which is initialized
> with max value. This can be a problem if the newly forked task is finally
> a short task because the group of CPUs is wrongly set to overloaded and
> tasks are pulled less agressively.
> 
> Set initial value of runnable_avg equals to util_avg to reflect that there
> is no waiting time so far.
> 
> Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0424a0af5f87..45e467bf42fc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>   		}
>   	}
>   
> -	sa->runnable_avg = cpu_scale;
> +	sa->runnable_avg = sa->util_avg;
>   
>   	if (p->sched_class != &fair_sched_class) {
>   		/*
> 

Something is wrong here. I woke up my machine from suspend-to-RAM this morning
and saw that a completely idle machine had a loadavg of ~7. According to my
monitoring system this happened to be the loadavg right before I suspended.
I've reverted this, rebooted, created a loadavg >0, suspended and after wake up
loadavg again correctly ranges between 0 and whatever, as expected.

-h
