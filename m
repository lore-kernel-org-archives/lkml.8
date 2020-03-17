Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F40C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqW3XRnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCQRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:07:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCQRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:07:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id a132so108652wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lhBM2npoDh2h0cQZv3kZvpN+x9j/ymuS7fPvqHMBIfA=;
        b=kqW3XRnp66PdAX4hawOgnDPRI/lKAVswbcm/jzkCn2p8cRGQB0pv3Lu3zvkYHkC+c0
         s8A+WYtNDa6HJVDYmzJogwDjeJ6v+fqQkkVt7QxN+otOGAeaq4e8mPkooYlU0pC09jPU
         eyvFqC1Z2fSlzDbDlM2exNzSDz9f3MRjBJcb5zYgDhEOKLoSK1ByKZtbnSCaQ/rK7Dkc
         qsL6peRQyATc3yzguOSFN+yvghB5NXqCNZgaF6PSb/yYYFlTxquey8bbU+QF6o/n2In5
         1nUVd7fEonuhZLAh9vnKemB0Xrh7gR95fLSmqCzzYu575prYsWd9nPxh8vexrnMByU3M
         32ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lhBM2npoDh2h0cQZv3kZvpN+x9j/ymuS7fPvqHMBIfA=;
        b=rWRk+j9d3KIvfFM4RYIvEymdxZj8XCZnOie09WHuAFmsVtGcYWDmUBQcW+tIuqlmnL
         F8InwzFPeRt5cnXOI0cbzHkRUDlqfDQhRmHgX+Z4WiJHK00rtQ0QyW3dOoczjqNiHl50
         s3yFhMXAaUiLDsLz271uNRg2glKGWUwWIJwchryJgOUr45K1t1KKVqFMh/6Fue8O9gB9
         6jv/ETX1/kqE5DdmAyvhwr4t6aLo38o0m9D/kjROILn8h/jr/1ljH08/MA84Oj5K5Y20
         f+5uZsPSh5Ch0L2wxgZkcllRDdkTK6KiiRysgL4ecKuoKnkOJP5QxeIz2y5lvYv6iWuA
         7Aww==
X-Gm-Message-State: ANhLgQ13kp+y7g9V7HoF6U966fWgXUp1ODNU3ER3mwY4gpSMMh7KCPPx
        ALPVxaiA5DrdcN3qpdUsSVIi8Q==
X-Google-Smtp-Source: ADFU+vsDvHssmuPOguaMCyg4MXddkz6xJVpMjeDSwIlGUBMh8PxcF3QdKu7YFPqq/Vvs+lpF9nLgdw==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr16464wmj.9.1584464866081;
        Tue, 17 Mar 2020 10:07:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bd37:618d:f415:31ea? ([2a01:e34:ed2f:f020:bd37:618d:f415:31ea])
        by smtp.googlemail.com with ESMTPSA id a186sm56987wmh.33.2020.03.17.10.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:07:44 -0700 (PDT)
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
 <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
 <3520b762-08f5-0db8-30cb-372709188bb9@linaro.org>
 <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7cd04d35-3522-30fb-82e9-82fdf53d0957@linaro.org>
Date:   Tue, 17 Mar 2020 18:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2020 15:30, Morten Rasmussen wrote:
> On Tue, Mar 17, 2020 at 02:48:51PM +0100, Daniel Lezcano wrote:
>>
>> Hi Morten,
>>
>> On 17/03/2020 08:56, Morten Rasmussen wrote:
>>> Hi Daniel,
>>>
>>> First, I think letting the scheduler know about desired minimum idle
>>> times is an interesting optimization if the overhead can be kept at a
>>> minimum. I do have a few comments about the patch though.
>>>
>>> On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
>>>> On 12/03/2020 09:36, Vincent Guittot wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> In the idle CPU selection process occuring in the slow path via the
>>>>>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
>>>>>> with the shallowest idle state otherwise we fall back to the least
>>>>>> loaded CPU.
>>>>>
>>>>> The idea makes sense but this path is only used by fork and exec so
>>>>> I'm not sure about the real impact
>>>>
>>>> I agree the fork / exec path is called much less often than the wake
>>>> path but it makes more sense for the decision.
>>>
>>> Looking at the flow in find_idlest_cpu(), AFAICT,
>>> find_idlest_group_cpu() is not actually making the final choice of CPU,
>>> so going through a lot of trouble there looking at idle states is
>>> pointless. Is there something I don't see?
>>>
>>> We fellow sd->child until groups == CPUs which which means that
>>> find_idlest_group() actually makes the final choice as the final group
>>> passed to find_idlest_group_cpu() is single-CPU group. The flow has been
>>> like that for years. Even before you added the initial idle-state
>>> awareness.
>>>
>>> I agree with Vincent, if this should really make a difference it should
>>> include wake-ups existing tasks too. Although I'm aware it would be a
>>> more invasive change. As said from the beginning, the idea is fine, but
>>> the current implementation should not make any measurable difference?
>>
>> I'm seeing the wake-ups path so sensitive, I'm not comfortable to do any
>> changes in it. That is the reason why the patch only changes the slow path.
> 
> Right. I'm not against being cautious at all. It would be interesting to
> evaluate how bad it really is. The extra time-stamping business cost is
> the same, so it really down how much we dare to use the information in
> the fast-path and change the CPU selection policy. And of course, how
> much can be gained by the change.

If the change provided by this patch is acceptable. I can give a try
with the fast path.

>>>>>> In order to be more energy efficient but without impacting the
>>>>>> performances, let's use another criteria: the break even deadline.
>>>>>>
>>>>>> At idle time, when we store the idle state the CPU is entering in, we
>>>>>> compute the next deadline where the CPU could be woken up without
>>>>>> spending more energy to sleep.
>>>
>>> I don't follow the argument that sleeping longer should improve energy
>>> consumption. 
>>
>> May be it is not explained correctly.
>>
>> The patch is about selecting a CPU with the smallest break even deadline
>> value. In a group of idle CPUs in the same idle state, we will pick the
>> one with the smallest break even dead line which is the one with the
>> highest probability it already reached its target residency.
>>
>> It is best effort.
> 
> Indeed. I get what the patch does, I just don't see how the patch
> improves energy efficiency.

If the CPU is woken up before it reached the break even, the idle state
cost in energy is greater than the energy it saved.

Am I misunderstanding your point?

>>> The patch doesn't affect the number of idle state
>>> enter/exit cycles, so you spend the amount of energy on those
>>> transitions. The main change is that idle time get spread out, so CPUs
>>> are less likely to be in the process of entering an idle state when they
>>> are asked to wake back up again.
>>>
>>> Isn't it fair to say that we expect the total number of wake-ups remains
>>> unchanged? Total busy and idle times across all CPUs should remain the
>>> same too? Unless chosen idle-state is changed, which I don't think we
>>> expect either, there should be no net effect on energy? The main benefit
>>> is reduced wake-up latency I think.
>>>
>>> Regarding chosen idle state, I'm wondering how this patch affects the
>>> cpuidle governor's idle state selection. Could the spreading of wake-ups
>>> trick governor to pick a shallower idle-state for some idle CPUs because
>>> we actively spread wake-ups rather than consolidating them? Just a
>>> thought.
>>
>> May be I missed the point, why are we spreading the tasks?
> 
> Picking the CPU with the smallest break-even time-stamp means you pick
> the CPU that has been idle longest in the shallowest idle-state. If you
> periodically one-shot spawn tasks at a rate which is long enough that
> the shallowest state is the same for several CPUs, you would end up
> picking the least recently used CPU each time effectively spreading the
> wake-ups across all the CPUs in the same state.

Ok, thanks for the clarification.

> Thinking more about it, it might not be a real problem as if one of the
> CPUs suddenly choose a shallower idle-state, it would become the target
> all new tasks from that point onwards.

Right.

>> We are taking the decision on the same sched domain, no?
> 
> I'm not sure I get the relation to the sched_domain?

Never mind. I misunderstood your comment.

>>>>>> At the selection process, we use the shallowest CPU but in addition we
>>>>>> choose the one with the minimal break even deadline instead of relying
>>>>>> on the idle_timestamp. When the CPU is idle, the timestamp has less
>>>>>> meaning because the CPU could have wake up and sleep again several times
>>>>>> without exiting the idle loop. In this case the break even deadline is
>>>>>> more relevant as it increases the probability of choosing a CPU which
>>>>>> reached its break even.
>>>
>>> I guess you could improve the idle time stamping without adding the
>>> break-even time, they don't have to go together?
>>
>> Yes, we can add the idle start time when entering idle in the
>> cpuidle_enter function which is different from the idle_timestamp which
>> gives the idle task scheduling. I sent a RFC for that [1].
>>
>> However, each time we would like to inspect the deadline, we will have
>> to compute it, so IMO it makes more sense to pre-compute it when
>> entering idle in addition to the idle start.
>>
>> [1] https://lkml.org/lkml/2020/3/16/902
> 
> Yes, I saw that patch too. Seems to make sense :-)
> 
>>
>>>>>> Tested on:
>>>>>>  - a synquacer 24 cores, 6 sched domains
>>>>>>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe
>>>>>>
>>>>>> sched/perf and messaging does not show a performance regression. Ran
>>>>>> 50 times schbench, adrestia and forkbench.
>>>>>>
>>>>>> The tools described at https://lwn.net/Articles/724935/
>>>>>>
>>>>>>  --------------------------------------------------------------
>>>>>> | Synquacer             | With break even | Without break even |
>>>>>>  --------------------------------------------------------------
>>>>>> | schbench *99.0th      |      14844.8    |         15017.6    |
>>>>>> | adrestia / periodic   |        57.95    |              57    |
>>>>>> | adrestia / single     |         49.3    |            55.4    |
>>>>>>  --------------------------------------------------------------
>>>>>
>>>>> Have you got some figures or cpuidle statistics for the syncquacer ?
>>>>
>>>> No, and we just noticed the syncquacer has a bug in the firmware and
>>>> does not actually go to the idle states.
>>>
>>> I would also like some statistics to help understanding what actually
>>> changes.
>>>
>>> I did some measurements on TX2, which only has one idle-state. I don't
>>> see the same trends as you do. adrestia single seems to be most affected
>>> by the patch, but _increases_ with the break_even patch rather than
>>> decrease. I don't trust adrestia too much though as the time resolution
>>> is low on TX2.
>>>
>>> TX2			tip		break_even
>>> ----------------------------------------------------
>>> adrestia / single	5.21		5.51
>>> adrestia / periodic	5.75		5.67
>>> schbench 99.0th		45465.6		45376.0
>>> hackbench		27.9851		27.9775
>>>
>>> Notes:
>>> adrestia: Avg of 100 runs: adrestia -l 25000
>>> schbench: Avg of 10 runs: schbench -m16 -t64
>>> hackbench: Avg of 10 runs: hackbench -g 20 -T 256 -l 100000
>>
>> Thanks for testing. Is that a Jetson TX2 from Nvidia? If that is the
>> case, IIRC, it has some kind of switcher for the CPUs in the firmware, I
>> don't know how that can interact with the testing.
> 
> Sorry, I should have been clearer. It is a ThunderX2. 2x 32-core (128
> threads) = 256 HW threads.

Indeed, that is different :)

I've a syncquacer but we find out a bug in the firmware, hopefully it
can be fixed.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

