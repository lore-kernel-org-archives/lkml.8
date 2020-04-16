Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93884C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7974221924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbgDPRXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:23:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbgDPRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:23:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E25830E;
        Thu, 16 Apr 2020 10:23:36 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 616E03F73D;
        Thu, 16 Apr 2020 10:23:33 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
Date:   Thu, 16 Apr 2020 19:23:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200416000235.GA211099@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 16.04.20 02:02, Joel Fernandes wrote:
> On Thu, Sep 05, 2019 at 12:47:26PM +0100, Qais Yousef wrote:
>> On 09/05/19 13:30, Peter Zijlstra wrote:
>>> On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
>>>> On 09/05/19 12:46, Peter Zijlstra wrote:
>>>
>>>>> This is important because we want to be able to bias towards less
>>>>> importance to (tail) latency as well as more importantance to (tail)
>>>>> latency.
>>>>>
>>>>> Specifically, Oracle wants to sacrifice (some) latency for throughput.
>>>>> Facebook OTOH seems to want to sacrifice (some) throughput for latency.
>>>>
>>>> Another use case I'm considering is using latency-nice to prefer an idle CPU if
>>>> latency-nice is set otherwise go for the most energy efficient CPU.
>>>>
>>>> Ie: sacrifice (some) energy for latency.
>>>>
>>>> The way I see interpreting latency-nice here as a binary switch. But
>>>> maybe we can use the range to select what (some) energy to sacrifice
>>>> mean here. Hmmm.
>>>
>>> It cannot be binary, per definition is must be ternary, that is, <0, ==0
>>> and >0 (or middle value if you're of that persuasion).
>>
>> I meant I want to use it as a binary.
>>
>>>
>>> In your case, I'm thinking you mean >0, we want to lower the latency.
>>
>> Yes. As long as there's an easy way to say: does this task care about latency
>> or not I'm good.
> 
> Qais, Peter, all,
> 
> For ChromeOS (my team), we are planning to use the upstream uclamp mechanism
> instead of the out-of-tree schedtune mechanism to provide EAS with the
> latency-sensitivity (binary/ternary) hint. ChromeOS is thankfully quite a bit
> upstream focussed :)
> 
> However, uclamp is missing an attribute to provide this biasing to EAS as we
> know.
> 
> What was the consensus on adding a per-task attribute to uclamp for providing
> this? Happy to collaborate on this front.

We're planning to have a session about this topic (latency-nice
attribute per task group) during the virtual Pisa OSPM summit
retis.sssup.it/ospm-summit in May this year.

There are two presentations/discussions planned:

"Introducing Latency Nice for Scheduler Hints and Optimizing Scheduler
Task Wakeup" and "The latency nice use case for Energy-Aware-Scheduling
(EAS) in Android Common Kernel (ACK)"

We'll probably merge those two into one presentation/discussion.

So far we have Parth's per-task implementation

https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com

What's missing is the per-taskgroup implementation, at least from the
standpoint of ACK.

The (mainline) EAS use-case for latency nice is already in ACK
(android-5.4):

https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54
