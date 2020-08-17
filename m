Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194FD206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgHQI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:41 -0400
Received: from foss.arm.com ([217.140.110.172]:50902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgHQI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1176631B;
        Mon, 17 Aug 2020 01:57:28 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4EB3F6CF;
        Mon, 17 Aug 2020 01:57:26 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
 <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
 <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com>
 <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
 <70236E62-AA36-48C1-9382-86353649253C@tencent.com>
 <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
 <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
Date:   Mon, 17 Aug 2020 10:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2020 01:55, benbjiang(蒋彪) wrote:
> Hi,
> 
>> On Aug 13, 2020, at 2:39 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 12/08/2020 05:19, benbjiang(蒋彪) wrote:
>>> Hi,
>>>
>>>> On Aug 11, 2020, at 11:54 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 11/08/2020 02:41, benbjiang(蒋彪) wrote:
>>>>> Hi,
>>>>>
>>>>>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 06/08/2020 17:52, benbjiang(蒋彪) wrote:
>>>>>>> Hi, 
>>>>>>>
>>>>>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 03/08/2020 13:26, benbjiang(蒋彪) wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
>>>>>>>>>>> From: Jiang Biao <benbjiang@tencent.com>

[...]

>>> ** 2normal+1idle: idle preempt normal every 600+ms **
>>
>> During the 3.2s the 2 SCHED_OTHER tasks run, the SCHED_IDLE task is
>> switched in only once, after ~2.5s.
> Use your config with loop increased from 200 to 2000, to observe longer,
> 
>            <...>-37620 [002] d... 47950.446191: sched_switch: prev_comm=task_other-1 prev_pid=37620 prev_prio=120 prev_state=S ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
>            <...>-37619 [002] d... 47955.687709: sched_switch: prev_comm=task_other-0 prev_pid=37619 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
> // The first preemption interval is 5.2s.
>            <...>-37620 [002] d... 47956.375716: sched_switch: prev_comm=task_other-1 prev_pid=37620 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
>            <...>-37619 [002] d... 47957.060722: sched_switch: prev_comm=task_other-0 prev_pid=37619 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
>            <...>-37620 [002] d... 47957.747728: sched_switch: prev_comm=task_other-1 prev_pid=37620 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
>           <...>-37620 [002] d... 47958.423734: sched_switch: prev_comm=task_other-1 prev_pid=37620 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
>            <...>-37620 [002] d... 47959.119740: sched_switch: prev_comm=task_other-1 prev_pid=37620 prev_prio=120 prev_state=R ==> next_comm=task_idle-2 next_pid=37621 next_prio=120
> // After the first preemption, the rest preemption intervals are all about 600ms+. :)

Are you sure about this?

The math is telling me for the:

idle task:      (3 / (1024 + 1024 + 3))^(-1) * 4ms = 2735ms

normal task: (1024 / (1024 + 1024 + 3))^(-1) * 4ms =    8ms

(4ms - 250 Hz)

>>> ** 3normal+idle: idle preempt normal every 1000+ms **
>>
>> Ah, this was meant to be 3 SCHED_OTHER tasks only! To see the difference
>> in behavior.
> With 3 SCHED_OHTER tasks only, the SCHED_OHTER task is switched in
> Every 27ms.

normal task: (1024 / (1024 + 1024 + 1024))^(-1) * 4ms = 12ms

>>> ** 2normal(nice 19)+1idle(nice 0): idle preempt normal every 30+ms **
>>
>> During the 3.2s the 2 SCHED_OTHER tasks run, the SCHED_IDLE task is
>> switched in every ~45ms.
> That’s as what I expected. :)

idle task:    (3 / (15 + 15 + 3))^(-1) * 4ms = 44ms

normal task: (15 / (15 + 15 + 3))^(-1) * 4ms =  9ms
