Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036EC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAEC215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5UHs9K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgCDQvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:51:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbgCDQvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:51:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so3238900wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tVV5N4CtvvLuQopSqXJQHkkWyjApYoQhvGkB+B5JClQ=;
        b=T5UHs9K6zqO+WZ4S4OZSResYWRoPzFRib5Yhu6RGhXJBF4/TQaiBY4f5i3XTs95PWf
         52bdLcY3oq5x57wnOsde4+6tJNVKaKIFW/OnhaYd8ItpXgIQvrUY51lz8imA/eyHVnV4
         nUbcVJt+7TVnw8Ro8z7QQ7qPbd4W+qxl/6O5pyzq8re4cclU1eh7phLXx65bdkjIIPVK
         8MlslSg4dE/Mp7fhCZsbWKIJf+R8OF50dXOrQCh19IOd0Z+uX4zavGI/IXGR4zbt5gr9
         mrNICtdsDrn5yMvd3Va1TczUqJ48W1pfo+VJ453YI1qY1yCJ+qd0h0gC0tHT01OIEl9V
         sjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tVV5N4CtvvLuQopSqXJQHkkWyjApYoQhvGkB+B5JClQ=;
        b=Jsss2wGPLHCnVQRIqsdH57Ge/1NwBMUneXznFgcTWWQzlFFpa3kseJ/G2HJrB9puRE
         fxQ1aBZL095xN0yGio4RpvlDJL1Na8PNcAOjCPfxp1i4q60e0TLKAy4GyT+qmX4RSZ5k
         stzTbEcoKOGghXWibyLeRa0CSxjQgz/tcMAydPKNHq6mc8H+gGO5aYzbaTXlziZJmLvd
         duoPKm+4B0uYaXwWFkL/aHcGjzSQ3S1+gTictLkLgI9mzT9eqelh/DdIv8uCKkf9Q4+f
         20g329AwnebiLYMgSWwhRytFWRWcGE8kt+ACc9KB2asOMHvvBH/eblKUiBMnAgcgX2lb
         jXxQ==
X-Gm-Message-State: ANhLgQ1iEuRhPNuFIJ9hBIZV0ja8xoLSRyFO1U8pXODKbi/Svq02B7mC
        tOVPMauHO5RyENYH75/ZT3Y4T3xuesA=
X-Google-Smtp-Source: ADFU+vv7yFWwJjImxZTqKZ/9ut8OJdzvsJegKZVjIN1kCuwCB/yPOX2HivBO61KfscIzKc/H5hrm9w==
X-Received: by 2002:adf:a512:: with SMTP id i18mr4962377wrb.61.1583340691613;
        Wed, 04 Mar 2020 08:51:31 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3? ([2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3])
        by smtp.googlemail.com with ESMTPSA id k7sm40903357wrq.12.2020.03.04.08.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 08:51:30 -0800 (PST)
Subject: Re: [PATCH] sched: fair: Use the earliest break even
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
 <jhjimjk16xi.mognet@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a3ab2f17-92b8-20f7-50cd-060385ff655e@linaro.org>
Date:   Wed, 4 Mar 2020 17:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <jhjimjk16xi.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2020 16:22, Valentin Schneider wrote:
> 
> On Wed, Mar 04 2020, Daniel Lezcano wrote:
>> In the idle CPU selection process occuring in the slow path via the
>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
>> with the shallowest idle state otherwise we fall back to the least
>> loaded CPU.
>>
>> In order to be more energy efficient but without impacting the
>> performances, let's use another criteria: the break even deadline.
>>
>> At idle time, when we store the idle state the CPU is entering in, we
>> compute the next deadline where the CPU could be woken up without
>> spending more energy to sleep.
>>
>> At the selection process, we use the shallowest CPU but in addition we
>> choose the one with the minimal break even deadline instead of relying
>> on the idle_timestamp. When the CPU is idle, the timestamp has less
>> meaning because the CPU could have wake up and sleep again several times
>> without exiting the idle loop. In this case the break even deadline is
>> more relevant as it increases the probability of choosing a CPU which
>> reached its break even.
>>
> 
> Ok so we still favour smallest exit latency, but if we have to pick
> among several CPUs with the same exit latency, we can use the break
> even. I'll want to test this on stuff, but I like the overall idea.
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fcc968669aea..520c5e822fdd 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>  {
>>       unsigned long load, min_load = ULONG_MAX;
>>       unsigned int min_exit_latency = UINT_MAX;
>> +	s64 min_break_even = S64_MAX;
>>       u64 latest_idle_timestamp = 0;
>>       int least_loaded_cpu = this_cpu;
>>       int shallowest_idle_cpu = -1;
>> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>               if (available_idle_cpu(i)) {
>>                       struct rq *rq = cpu_rq(i);
>>                       struct cpuidle_state *idle = idle_get_state(rq);
>> +			s64 break_even = idle_get_break_even(rq);
>> +
> 
> Nit: there's tabs in that line break.
> 
>>                       if (idle && idle->exit_latency < min_exit_latency) {
>>                               /*
>>                                * We give priority to a CPU whose idle state
>> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>                                * of any idle timestamp.
>>                                */
>>                               min_exit_latency = idle->exit_latency;
>> +				min_break_even = break_even;
>>                               latest_idle_timestamp = rq->idle_stamp;
>>                               shallowest_idle_cpu = i;
>> -			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
>> -				   rq->idle_stamp > latest_idle_timestamp) {
>> +			} else if ((idle && idle->exit_latency == min_exit_latency) &&
>> +				   break_even < min_break_even) {
>> +				/*
>> +				 * We give priority to the shallowest
>> +				 * idle states with the minimal break
>> +				 * even deadline to decrease the
>> +				 * probability to choose a CPU which
>> +				 * did not reach its break even yet
>> +				 */
>> +				min_break_even = break_even;
>> +				shallowest_idle_cpu = i;
>> +			} else if (!idle && rq->idle_stamp > latest_idle_timestamp) {
>>                               /*
>>                                * If equal or no active idle state, then
>>                                * the most recently idled CPU might have
> 
> That comment will need to be changed as well, that condition now only
> catters to the !idle case.

Right.

> With that said, that comment actually raises a valid point: picking
> recently idled CPUs might give us warmer cache. So by using the break
> even stat, we can end up picking CPUs with colder caches (have been
> idling for longer) than the current logic would. I suppose more testing
> will tell us where we stand.

Actually I'm not sure this comment still applies. If the CPU is powered
down, the cache is flushed or we can be picking up CPU with their cache
totally trashed by interrupt processing.

>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index b743bf38f08f..189cd51cd474 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -19,7 +19,14 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>>   */
>>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>>  {
>> -	idle_set_state(this_rq(), idle_state);
>> +	struct rq *rq = this_rq();
>> +	ktime_t kt;
>> +
>> +	if (likely(idle_state)) {
> 
> Doesn't this break things? e.g. calling this with NULL?

Yes, Qais spotted it.

>> +		kt = ktime_add_ns(ktime_get(), idle_state->exit_latency_ns);
> 
> ISTR there were objections to using ktime stuff in the scheduler, but I
> can't remember anything specific. If we only call into it when actually
> entering an idle state (and not when we're exiting one), I suppose that
> would be fine?

In this slow path it is fine. In the fast path, it is unacceptable.

>> +		idle_set_state(rq, idle_state);
>> +		idle_set_break_even(rq, ktime_to_ns(kt));
>> +	}
>>  }
>>
>>  static int __read_mostly cpu_idle_force_poll;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 2a0caf394dd4..abf2d2e73575 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1015,6 +1015,7 @@ struct rq {
>>  #ifdef CONFIG_CPU_IDLE
>>       /* Must be inspected within a rcu lock section */
>>       struct cpuidle_state	*idle_state;
>> +	s64			break_even;
> 
> Why signed? This should be purely positive, right?

It should be, but s64 complies with the functions ktime_to_ns signature.

static inline s64 ktime_to_ns(const ktime_t kt)

>>  #endif
>>  };
>>
>> @@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>>
>>       return rq->idle_state;
>>  }
>> +
>> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
>> +{
>> +	rq->break_even = break_even;
>> +}
>> +
>> +static inline s64 idle_get_break_even(struct rq *rq)
>> +{
>> +	return rq->break_even;
>> +}
> 
> I'm not super familiar with the callsites for setting idle states,
> what's the locking situation there? Do we have any rq lock?

It is safe, we are under rcu, this section was discussed several years
ago when introducing the idle_set_state():

 https://lkml.org/lkml/2014/9/19/332

> In find_idlest_group_cpu() we're in a read-side RCU section, so the
> idle_state is protected (speaking of which, why isn't idle_get_state()
> using rcu_dereference()?), but that's doesn't cover the break even.
> 
> IIUC at the very least we may want to give them the READ/WRITE_ONCE()
> treatment.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

