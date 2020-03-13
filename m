Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3A20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJuAS2cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCMMPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:15:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39159 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgCMMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:15:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so10037580wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C1O5cxw5KpD2RJtGkWeXDcCzatEvjYpNKrnN4meomK4=;
        b=nJuAS2cO/yReoGu2wPHx0RlajUug0qU7/EsyjQ825RWVX8YQoJjBJ4JixTt+R+BrFV
         njILtTds/RjOyLVy3ffl5cFbVrjlGI8Qd1q1KtTsBAlz0fF9m+ZWwRt4XElltmhRQgyP
         XrzHw8sEWVGagLlDyXdCgJCygNYL4zMp9LPF4FCKa6/zFgykDrf06ueAleO1bFgstwK+
         cZ14Hvl+npAzBlRYOKe+pmFPTipTKp7E4Dur8D7ZmT5m2R4tuGG0f93wKGVp+UH/4ndv
         7NyGIyRn45qgaodZy2TQBSPe5HXxRuAkSO4RCjg5ZwlFZEUuuqlXk2qyc746WvaAn/A3
         IvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C1O5cxw5KpD2RJtGkWeXDcCzatEvjYpNKrnN4meomK4=;
        b=X4lgzZuH/oNM18ZuXv1nYe8VP6imIDaEmTTvisN0jTKmmP2AdAwShGBKV1FHf/BCOa
         ecXSPL8ytK04eK6XxswQRUQtbACWoUc5A1wmY3G8GmKJVXJTubN7CB1vSp940gtXrUrn
         lkprS4DYtdi1Vs0A+wYnHHNYW19K7uyUs2Lk8qOjwDE/eKXfJUV7q5WZlMQIQUWyR58M
         ommrbzU4TlZA70lA8CC5dn+0IW8aZfzVja32IAvfrHG7MHZ3HROGdknAvSIm7mEM4G0b
         40Zwf869h8cSbPeOL++WO+X6WJ+PDvmQNP4DqU1xjQQTJOVTrBwcv9O5SCkKieR5s1vn
         dXiQ==
X-Gm-Message-State: ANhLgQ2pOR48QrjRY6Z0fGgA7nmOLF14L/xmBO5WD//jZUCVeIZ343ec
        D0FSg1Om118VGSh7+TdL//RfEQ==
X-Google-Smtp-Source: ADFU+vurNQRkJ+336nMC+OSHxceKGbHO3YGMG0d7txu3ACgiLJHZGB2cWLSZojXtDzCtMmUo8ijogg==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr10904081wmi.144.1584101743288;
        Fri, 13 Mar 2020 05:15:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:40fb:3990:3519:cc26? ([2a01:e34:ed2f:f020:40fb:3990:3519:cc26])
        by smtp.googlemail.com with ESMTPSA id c5sm14742589wma.3.2020.03.13.05.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:15:42 -0700 (PDT)
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <CAKfTPtBU1fyxWhR04QTCbvn07KgTqAHRVOt18D3TxmZSeiHQQQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ee3bbfeb-ddd5-e4dc-3999-39370e7a6c73@linaro.org>
Date:   Fri, 13 Mar 2020 13:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBU1fyxWhR04QTCbvn07KgTqAHRVOt18D3TxmZSeiHQQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 13:27, Vincent Guittot wrote:
> On Thu, 12 Mar 2020 at 11:04, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 12/03/2020 09:36, Vincent Guittot wrote:
>>> Hi Daniel,
>>>
>>> On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> In the idle CPU selection process occuring in the slow path via the
>>>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
>>>> with the shallowest idle state otherwise we fall back to the least
>>>> loaded CPU.
>>>
>>> The idea makes sense but this path is only used by fork and exec so
>>> I'm not sure about the real impact
>>
>> I agree the fork / exec path is called much less often than the wake
>> path but it makes more sense for the decision.
>>
>>>> In order to be more energy efficient but without impacting the
>>>> performances, let's use another criteria: the break even deadline.
>>>>
>>>> At idle time, when we store the idle state the CPU is entering in, we
>>>> compute the next deadline where the CPU could be woken up without
>>>> spending more energy to sleep.
>>>>
>>>> At the selection process, we use the shallowest CPU but in addition we
>>>> choose the one with the minimal break even deadline instead of relying
>>>> on the idle_timestamp. When the CPU is idle, the timestamp has less
>>>> meaning because the CPU could have wake up and sleep again several times
>>>> without exiting the idle loop. In this case the break even deadline is
>>>> more relevant as it increases the probability of choosing a CPU which
>>>> reached its break even.
>>>>
>>>> Tested on:
>>>>  - a synquacer 24 cores, 6 sched domains
>>>>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe
>>>>
>>>> sched/perf and messaging does not show a performance regression. Ran
>>>> 50 times schbench, adrestia and forkbench.
>>>>
>>>> The tools described at https://lwn.net/Articles/724935/
>>>>
>>>>  --------------------------------------------------------------
>>>> | Synquacer             | With break even | Without break even |
>>>>  --------------------------------------------------------------
>>>> | schbench *99.0th      |      14844.8    |         15017.6    |
>>>> | adrestia / periodic   |        57.95    |              57    |
>>>> | adrestia / single     |         49.3    |            55.4    |
>>>>  --------------------------------------------------------------
>>>
>>> Have you got some figures or cpuidle statistics for the syncquacer ?
>>
>> No, and we just noticed the syncquacer has a bug in the firmware and
>> does not actually go to the idle states.
>>
>>
>>>> | Hikey960              | With break even | Without break even |
>>>>  --------------------------------------------------------------
>>>> | schbench *99.0th      |      56140.8    |           56256    |
>>>> | schbench energy       |      153.575    |         152.676    |
>>>> | adrestia / periodic   |         4.98    |             5.2    |
>>>> | adrestia / single     |         9.02    |            9.12    |
>>>> | adrestia energy       |         1.18    |           1.233    |
>>>> | forkbench             |        7.971    |            8.05    |
>>>> | forkbench energy      |         9.37    |            9.42    |
>>>>  --------------------------------------------------------------
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  kernel/sched/fair.c  | 18 ++++++++++++++++--
>>>>  kernel/sched/idle.c  |  8 +++++++-
>>>>  kernel/sched/sched.h | 20 ++++++++++++++++++++
>>>>  3 files changed, 43 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 4b5d5e5e701e..8bd6ea148db7 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>>>  {
>>>>         unsigned long load, min_load = ULONG_MAX;
>>>>         unsigned int min_exit_latency = UINT_MAX;
>>>> +       s64 min_break_even = S64_MAX;
>>>>         u64 latest_idle_timestamp = 0;
>>>>         int least_loaded_cpu = this_cpu;
>>>>         int shallowest_idle_cpu = -1;
>>>> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>>>                 if (available_idle_cpu(i)) {
>>>>                         struct rq *rq = cpu_rq(i);
>>>>                         struct cpuidle_state *idle = idle_get_state(rq);
>>>> +                       s64 break_even = idle_get_break_even(rq);
>>>> +
>>>>                         if (idle && idle->exit_latency < min_exit_latency) {
>>>>                                 /*
>>>>                                  * We give priority to a CPU whose idle state
>>>> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>>>                                  * of any idle timestamp.
>>>>                                  */
>>>>                                 min_exit_latency = idle->exit_latency;
>>>> +                               min_break_even = break_even;
>>>>                                 latest_idle_timestamp = rq->idle_stamp;
>>>>                                 shallowest_idle_cpu = i;
>>>> -                       } else if ((!idle || idle->exit_latency == min_exit_latency) &&
>>>> -                                  rq->idle_stamp > latest_idle_timestamp) {
>>>> +                       } else if ((idle && idle->exit_latency == min_exit_latency) &&
>>>> +                                  break_even < min_break_even) {
>>>> +                               /*
>>>> +                                * We give priority to the shallowest
>>>> +                                * idle states with the minimal break
>>>> +                                * even deadline to decrease the
>>>> +                                * probability to choose a CPU which
>>>> +                                * did not reach its break even yet
>>>> +                                */
>>>> +                               min_break_even = break_even;
>>>> +                               shallowest_idle_cpu = i;
>>>> +                       } else if (!idle && rq->idle_stamp > latest_idle_timestamp) {
>>>>                                 /*
>>>>                                  * If equal or no active idle state, then
>>>>                                  * the most recently idled CPU might have
>>>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>>>> index b743bf38f08f..3342e7bae072 100644
>>>> --- a/kernel/sched/idle.c
>>>> +++ b/kernel/sched/idle.c
>>>> @@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>>>>   */
>>>>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>>>>  {
>>>> -       idle_set_state(this_rq(), idle_state);
>>>> +       struct rq *rq = this_rq();
>>>> +
>>>> +       idle_set_state(rq, idle_state);
>>>
>>> Shouldn't the state be set after setting break even otherwise you will
>>> have a time window with an idle_state != null but the break_even still
>>> set to the previous value
>>
>> IIUC we are protected in this section. Otherwise the routine above would
>> be also wrong [if (idle && idle->exit_latency)], no?
> 
> no there are not the same because it uses the idle pointer to read
> exit_latency so we are sure to use exit_latency related to the idle
> pointer.
> 
> In your case it checks idle is not null but then it uses rq to read
> break_even but it might not have been already updated

Ok I will invert the lines.

>>>> +
>>>> +       if (idle_state)
>>>> +               idle_set_break_even(rq, ktime_get_ns() +
>>>
>>> What worries me a bit is that it adds one ktime_get call each time a
>>> cpu enters idle
>>
>> Right, we can improve this in the future by folding the local_clock() in
>> cpuidle when entering idle with this ktime_get.
> 
> Using local_clock() would be more latency friendly

Unfortunately we are comparing the deadline across CPUs, so the
local_clock() can not be used here.

But if we have one ktime_get() instead of a local_clock() + ktime_get(),
that should be fine, no?

>>>> +                                   idle_state->exit_latency_ns);
>>>>  }
>>
>> [ ... ]
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

