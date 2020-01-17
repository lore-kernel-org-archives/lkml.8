Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33023C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BF92072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVelXQe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgAQUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:20:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36381 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:20:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so23992810qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NlHGXeYVtUWpsui+87kvKh+ZFIYbyJG1G/B6RvZSgI4=;
        b=BVelXQe0sD8MLWCLMIL1DKUz1Xw93+yH6cJlCQrZoFBfXPuJ53w7HCF1JsIYWv6Zvg
         Xi5DWaD1do/bggiQDpAs3islaycY3yCg7AIwsDNl7UeNuajzUlnnNfvPRzM7gKV5IPzQ
         IuxbiP4DJUQW93trU8b6RN2pA9yiIsfivN+E7JERSjl83ImVowtrDgrDz5qzoX1E/rWW
         TOCnC+00iyM0Fkm+nNhu8nAD7IExOP9DDrW18xLwkonekEYvFchYBpJ9NsfzVzi+O160
         c2SqoqDlr41mIFhV7yW95DrCFwLt77lD3Go9Asu6RY4L+clzMXTFW30CsJlGpB5Ocvsu
         Wr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NlHGXeYVtUWpsui+87kvKh+ZFIYbyJG1G/B6RvZSgI4=;
        b=OKS8V+nq1GmVuzL5ne3bjex9DjZgrsrugcj+2kWaJn6NngyTZvidxCZjdiO7xYc4pg
         Ut8ni1ry37nZQLk1V++jWk37YD0skKdknwS8VLyT/SGKZnFYUgT+QmjsmzRm3Xe9sRxh
         Mp4+JH1v4g4pLD+dlfO3STXockS5TO3Fwus3YpFrmpNhQGXkYgzBNR0Hbh3oqegIBM9k
         BncUgq1k/qeE4Z4QlpDdYfDrnl3sI9MzLSF7UMDLWg6zwTD7a8eidLJtJrC1HOjvXVw9
         EGIACI8Nb1vy8FqCZxP3aWPmdnaXhnq+aWETnPS+Gk9fbww9TMauUxJrZf84kEpUTQGB
         ebGg==
X-Gm-Message-State: APjAAAUK6AwoAHebmhy3Pg/2JZFkk9MO9zpCLVnEvnNaLsYbscyGhI+j
        TNZlLXLwUXk9b0Oee+PX3a6IwcgMPaE=
X-Google-Smtp-Source: APXvYqyKwJbGuPI3qyH+i57bdWPsqhLeP15Lefl9qjSNAqrpoI0e4GCps/fPSKLOlUOmOSeIzGlm3A==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr34398666qkg.71.1579292416084;
        Fri, 17 Jan 2020 12:20:16 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id j15sm13152574qtn.37.2020.01.17.12.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 12:20:15 -0800 (PST)
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E2216FD.5040903@linaro.org>
Date:   Fri, 17 Jan 2020 15:20:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/2020 10:15 AM, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 02:57:36PM -0500, Thara Gopinath wrote:
>> Introduce support in CFS periodic tick and other bookkeeping apis
>> to trigger the process of computing average thermal pressure for a
>> cpu. Also consider avg_thermal.load_avg in others_have_blocked
>> which allows for decay of pelt signals.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/fair.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8da0222..311bb0b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7470,6 +7470,9 @@ static inline bool others_have_blocked(struct rq *rq)
>>  	if (READ_ONCE(rq->avg_dl.util_avg))
>>  		return true;
>>  
>> +	if (READ_ONCE(rq->avg_thermal.load_avg))
>> +		return true;
>> +
> 
> Given that struct sched_avg is 1 cacheline, the above is a pointless
> guaranteed cacheline miss if the arch doesn't
> CONFIG_HAVE_SCHED_THERMAL_PRESSURE.
Thanks for the review Peter. I see your suggestion in Patch 1 to fix
this issue. Will send out the next version implementing it.

> 
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>  	if (READ_ONCE(rq->avg_irq.util_avg))
>>  		return true;
>> @@ -7495,6 +7498,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>>  {
>>  	const struct sched_class *curr_class;
>>  	u64 now = rq_clock_pelt(rq);
>> +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
>>  	bool decayed;
>>  
>>  	/*
>> @@ -7505,6 +7509,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>>  
>>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
>> +		  update_thermal_load_avg(rq_clock_task(rq), rq,
>> +					  thermal_pressure) 			|
>>  		  update_irq_load_avg(rq, 0);
>>  
>>  	if (others_have_blocked(rq))
> 
> That there indentation trainwreck is a reason to rename the function.
> 
> 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> 		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
> 		  update_irq_load_avg(rq, 0);
> 
> Is much better.

Did you intend to say here to rename  update_thermal_load_avg to
something else ?
> 
> But now that you made me look at that, I noticed it's using a different
> clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
> in sync with the other averages.
> 
> Is there a good reason for that?

So I guess as Vincent has replied in his email, rq_clock_pelt adjusts
clock for frequency and cpu capacity invariance. Thermal pressure signal
is already accounted for it when updated from the thermal framework.
> 
>> @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  {
>>  	struct cfs_rq *cfs_rq;
>>  	struct sched_entity *se = &curr->se;
>> +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
>>  
>>  	for_each_sched_entity(se) {
>>  		cfs_rq = cfs_rq_of(se);
>> @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  
>>  	update_misfit_status(curr, rq);
>>  	update_overutilized_status(task_rq(curr));
>> +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>>  }
> 
> I'm thinking this is the wrong place; should this not be in
> scheduler_tick(), right before calling sched_class::task_tick() ? Surely
> any execution will affect thermals, not only fair class execution.

I read all other comments from others on this. I agree. I will move this
to scheduler_tick.

> 


-- 
Warm Regards
Thara
