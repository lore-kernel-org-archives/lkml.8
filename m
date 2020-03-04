Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE4AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA6A215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqcC8388"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgCDQRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:17:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35550 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:17:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id m3so2476887wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SuItPfOPgJTKtjMG+1ss0YKG8iROFQEu39Z0gnXlLMo=;
        b=xqcC8388pg/+iCSd4q3ukrN01a1IC3It222d8uOYpbweU/UvQameZAW+abmVHI3aXo
         waD2kchBrLzcDlxKefIiN4JIWC2rcQ/A0kFoSR77kXjq2MSUtwKAvXnr0/Ve3Ffyz7Ho
         17YdH1EcJXDIftLLBuSAlTOEa4H84qiC4unh2NqMjxupfkqembij4oFOX2unJXFzO3Qh
         JEMV/6sl2nhX1LYDPVkfyx1mFd4mM/p+9lbPAehMF1/v3ztXe/LNOzp/iYx+XFRlqkgL
         5BsA+E4ggJUMaphdWdba3F+7I6rOR+0HJIUeQLZbmxf79dVtQZ89DOvqExmP0qFsEVCE
         JxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SuItPfOPgJTKtjMG+1ss0YKG8iROFQEu39Z0gnXlLMo=;
        b=Pswqjv283gtKMLOw0NRFHWhPTLUIDw/tcF9nzQTqkStfI5zeedK5lUtd9AL4biMGDg
         tm5XxnUcafTWWuaFPUvG0IBYIi1eKwtZ1Cume79b1RhVroCbYb7xApwPWdnz0YVrMY76
         wP/0S+d8uRc4KjVeGhjLO18nzbCD1xmwQwE77m3CcRMpECkBTkQNYcPEYTg2KaBLa83e
         QOaJg7jaq7oR6vnRL548FtVZIKxKb3dyNghYkChc8/cqSBP/JOAKfRIYX1o83Axww1TZ
         hXCXstYsrrK5v+mr88pH5TNSms9thWg/HS/6q8irKWTlek4yENEsRvQUhL7m655/UloF
         zT0A==
X-Gm-Message-State: ANhLgQ0dFVC3omj1H4hPFdACiWqXMhE0oivjG4XpD3/ZQTLUBE2Ut2uA
        2melPvK4+bu6qqNfxPYPKDfBzfWIqPU=
X-Google-Smtp-Source: ADFU+vtG+cv8YpRwq5VbFG8tOg6IYQ4KOcvnJOHeO8HGhxmzsDOgi/O6SbZwlyjqVuSvNKBtf6VIkg==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr4115842wmb.64.1583338662537;
        Wed, 04 Mar 2020 08:17:42 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3? ([2a01:e34:ed2f:f020:10d8:56c2:f55d:11e3])
        by smtp.googlemail.com with ESMTPSA id c23sm2589326wme.39.2020.03.04.08.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 08:17:41 -0800 (PST)
Subject: Re: [PATCH] sched: fair: Use the earliest break even
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
 <20200304150145.agekdwrpvvamttk6@e107158-lin.cambridge.arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <33e42f55-c85b-2056-cf2c-8a7ac5bd36f4@linaro.org>
Date:   Wed, 4 Mar 2020 17:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304150145.agekdwrpvvamttk6@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qais,

On 04/03/2020 16:01, Qais Yousef wrote:
> Hi Daniel
> 
> Adding Rafael to CC as I think he might be interested in this too.
> 
> On 03/04/20 12:48, Daniel Lezcano wrote:
>> In the idle CPU selection process occuring in the slow path via the
>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
>> with the shallowest idle state otherwise we fall back to the least
>> loaded CPU.
>>
>> In order to be more energy efficient but without impacting the
>> performances, let's use another criteria: the break even deadline.
> 
> What is the break even deadline?
>
>> At idle time, when we store the idle state the CPU is entering in, we
>> compute the next deadline where the CPU could be woken up without
>> spending more energy to sleep.
> 
> I think that's its definition, but could do with more explanation.
> 
> So the break even deadline is the time window during which we can abort the CPU
> while entering its shallowest idle state?

No, it is the moment in absolute time when the min residency is reached.

From Documentation/devicetree/bindings/arm/idle-states.yaml

"
min-residency is defined for a given idle state as the minimum expected
residency time for a state (inclusive of preparation and entry) after
which choosing that state become the most energy efficient option. A
good way to visualise this, is by taking the same graph above and
comparing some states energy consumptions plots.
"

> So if we have 2 cpus entering the shallowest idle state, we pick the one that
> has a faster abort? And the energy saving comes from the fact we avoided
> unnecessary sleep-just-to-wakeup-immediately cycle?

No, actually it is about to choose a CPU where it has a better chance to
have reach its min residency. Basically, when the CPU enters an idle
state, that has a cost (cache flush / refill, context saving/restore etc
...), so there is a peak of energy and the CPU has to save energy long
enough to compensate this extra consumption.

If the scheduler is constantly waking up an idle CPU before it slept
long enough, we lose energy and performance.

Example 1, the CPUs are in a state:
 - CPU0 (power down)
 - CPU1 (power down)
 - CPU2 (WFI)
 - CPU3 (power down)

 The routine choose CPU2 because it is the shallowest state.

Example 2, the CPUs are in a state:
 - CPU0 (power down) (bedl = 1234)
 - CPU1 (power down) (bedl = 4321)
 - CPU2 (power down) (bedl = 9876)
 - CPU3 (power down) (bedl = 3421)

* bedl = break even deadline

  The routine choose CPU1 because the bedl is the smallest.


>> At the selection process, we use the shallowest CPU but in addition we
>> choose the one with the minimal break even deadline instead of relying
>> on the idle_timestamp. When the CPU is idle, the timestamp has less
>> meaning because the CPU could have wake up and sleep again several times
>> without exiting the idle loop. In this case the break even deadline is
>> more relevant as it increases the probability of choosing a CPU which
>> reached its break even.
>>
>> Tested on a synquacer 24 cores, 6 sched domains:
>>
>> sched/perf and messaging does not show a performance regression. Ran
>> 10 times schbench and adrestia.
>>
>> with break-even deadline:
>> -------------------------
>> schbench *99.0th        : 14844.8
>> adrestia / periodic     : 57.95
>> adrestia / single       : 49.3
>>
>> Without break-even deadline:
>> ----------------------------
>> schbench / *99.0th      : 15017.6
>> adrestia / periodic     : 57
>> adrestia / single       : 55.4
> 
> Lower is better or worse? The numbers might be popular and maybe I should have
> known them, but adding some explanation will always help.

 * lesser is better

> Do you have any energy measurement on the impact of this patch?

No, I don't have any platform allowing that. I've an instrumented
big.Little but this patch is not relevant as the EAS takes over.

The only platform I have in my hands now is the synquacer 24 cores which
makes sense for this slow path selection.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  kernel/sched/fair.c  | 18 ++++++++++++++++--
>>  kernel/sched/idle.c  |  9 ++++++++-
>>  kernel/sched/sched.h | 20 ++++++++++++++++++++
>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fcc968669aea..520c5e822fdd 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>  {
>>  	unsigned long load, min_load = ULONG_MAX;
>>  	unsigned int min_exit_latency = UINT_MAX;
>> +	s64 min_break_even = S64_MAX;
>>  	u64 latest_idle_timestamp = 0;
>>  	int least_loaded_cpu = this_cpu;
>>  	int shallowest_idle_cpu = -1;
>> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>  		if (available_idle_cpu(i)) {
>>  			struct rq *rq = cpu_rq(i);
>>  			struct cpuidle_state *idle = idle_get_state(rq);
>> +			s64 break_even = idle_get_break_even(rq);
>> +			
>>  			if (idle && idle->exit_latency < min_exit_latency) {
>>  				/*
>>  				 * We give priority to a CPU whose idle state
>> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>  				 * of any idle timestamp.
>>  				 */
>>  				min_exit_latency = idle->exit_latency;
>> +				min_break_even = break_even;
>>  				latest_idle_timestamp = rq->idle_stamp;
>>  				shallowest_idle_cpu = i;
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
> 
> Shouldn't you retain the original if condition here? You omitted the 2nd part
> of this check compared to the original condition
> 
> 	(!idle || >>>idle->exit_latency == min_exit_latency<<<)

It is done on purpose because of the condition right before.

>>  				/*
>>  				 * If equal or no active idle state, then
>>  				 * the most recently idled CPU might have
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
>> +		kt = ktime_add_ns(ktime_get(), idle_state->exit_latency_ns);
>> +		idle_set_state(rq, idle_state);
> 
> This changes the behavior of the function.
> 
> There's a call to sched_idle_set_state(NULL), so with this it'd be a NOP.
> 
> Is this intentional?

Nope, thanks for spotting it. It should be:

 void sched_idle_set_state(struct cpuidle_state *idle_state)
 {
-       idle_set_state(this_rq(), idle_state);
+       struct rq *rq = this_rq();
+       idle_set_state(rq, idle_state);
+
+       if (likely(idle_state)) {
+               ktime_t kt = ktime_add_ns(ktime_get(),
+                                         idle_state->exit_latency_ns);
+               idle_set_break_even(rq, ktime_to_ns(kt));
+       }
 }


> Don't you need to reset the break_even value if idle_state is NULL too?

If the idle_state is NULL, the routine won't use the break_even.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

