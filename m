Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D18C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F334B20771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgHKPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:54:45 -0400
Received: from foss.arm.com ([217.140.110.172]:38472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgHKPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:54:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5AD31B;
        Tue, 11 Aug 2020 08:54:38 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B10E3F6CF;
        Tue, 11 Aug 2020 08:54:30 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
Date:   Tue, 11 Aug 2020 17:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 02:41, benbjiang(蒋彪) wrote:
> Hi,
> 
>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 06/08/2020 17:52, benbjiang(蒋彪) wrote:
>>> Hi, 
>>>
>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 03/08/2020 13:26, benbjiang(蒋彪) wrote:
>>>>>
>>>>>
>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
>>>>>>> From: Jiang Biao <benbjiang@tencent.com>

[...]

>> Because of this very small weight (weight=3), compared to a SCHED_NORMAL
>> nice 0 task (weight=1024), a SCHED_IDLE task is penalized by a huge
>> se->vruntime value (1024/3 higher than for a SCHED_NORMAL nice 0 task).
>> This should make sure it doesn't tick preempt a SCHED_NORMAL nice 0 task.
> Could you please explain how the huge penalization of vruntime(1024/3) could
> make sure SCHED_IDLE not tick preempting SCHED_NORMAL nice 0 task?
> 
> Thanks a lot.

Trace a run of 2 SCHED_OTHER (nice 0) tasks and 1 SCHED_IDLE task on a
single CPU and trace_printk the conditions  'if (delta < 0)' and ' if
(delta > ideal_runtime)' in check_preempt_tick().

Then do the same with 3 SCHED_OTHER (nice 0) tasks. You can also change
the niceness of the 2 SCHED_OTHER task to 19 to see some differences in
the kernelshark's task layout.

rt-app (https://github.com/scheduler-tools/rt-app) is a nice tool to
craft those artificial use cases.

[...]
