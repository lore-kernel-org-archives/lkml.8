Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2179EC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CF2206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCYAkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:40:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:16928 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgCYAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 20:40:07 -0400
IronPort-SDR: qrqs8K/1J0Vj9X9iXt7v7z75outbVZhVIM1xhnVrf7D6FylWLVzbv5OLH2yLEu4cYJz5mCOLPM
 ZMWzheVPheKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 17:40:07 -0700
IronPort-SDR: e1rJ8IMBngrXbAyKxLgCIR7m6e9P7dkS9PIgQD+2100ugxG2ZO0VJVStofUy2wAad4otxDvR0M
 vqlnfbr5pH/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="357661266"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2020 17:40:04 -0700
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20200313232918.62303-1-joel@joelfernandes.org>
 <20200314003004.GI3199@paulmck-ThinkPad-P72>
 <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
 <20200323152126.GA141027@google.com>
 <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
 <20200324184946.GD257597@google.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a715e9f5-adc3-60fa-d2a0-2e82b1f4be9c@linux.intel.com>
Date:   Wed, 25 Mar 2020 08:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200324184946.GD257597@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/25 2:49, Joel Fernandes wrote:
> On Tue, Mar 24, 2020 at 11:01:27AM +0800, Li, Aubrey wrote:
>> On 2020/3/23 23:21, Joel Fernandes wrote:
>>> On Mon, Mar 23, 2020 at 02:58:18PM +0800, Li, Aubrey wrote:
>>>> On 2020/3/14 8:30, Paul E. McKenney wrote:
>>>>> On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
>>>>>> rcu_read_unlock() can incur an infrequent deadlock in
>>>>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>>>>>>
>>>>>> This fixes the following spinlock recursion observed when testing the
>>>>>> core scheduling patches on PREEMPT=y kernel on ChromeOS:
>>>>>>
>>>>>> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
>>>>>>
>>>>>
>>>>> The original could indeed deadlock, and this would avoid that deadlock.
>>>>> (The commit to solve this deadlock is sadly not yet in mainline.)
>>>>>
>>>>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>>>>
>>>> I saw this in dmesg with this patch, is it expected?
>>>>
>>>> [  117.000905] =============================
>>>> [  117.000907] WARNING: suspicious RCU usage
>>>> [  117.000911] 5.5.7+ #160 Not tainted
>>>> [  117.000913] -----------------------------
>>>> [  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
>>>> [  117.000918] 
>>>>                other info that might help us debug this:
>>>
>>> Sigh, this is because for_each_domain() expects rcu_read_lock(). From an RCU
>>> PoV, the code is correct (warning doesn't cause any issue).
>>>
>>> To silence warning, we could replace the rcu_read_lock_sched() in my patch with:
>>> preempt_disable();
>>> rcu_read_lock();
>>>
>>> and replace the unlock with:
>>>
>>> rcu_read_unlock();
>>> preempt_enable();
>>>
>>> That should both take care of both the warning and the scheduler-related
>>> deadlock. Thoughts?
>>>
>>
>> How about this?
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a01df3e..7ff694e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4743,7 +4743,6 @@ static void sched_core_balance(struct rq *rq)
>>  	int cpu = cpu_of(rq);
>>  
>>  	rcu_read_lock();
>> -	raw_spin_unlock_irq(rq_lockp(rq));
>>  	for_each_domain(cpu, sd) {
>>  		if (!(sd->flags & SD_LOAD_BALANCE))
>>  			break;
>> @@ -4754,7 +4753,6 @@ static void sched_core_balance(struct rq *rq)
>>  		if (steal_cookie_task(cpu, sd))
>>  			break;
>>  	}
>> -	raw_spin_lock_irq(rq_lockp(rq));
> 
> try_steal_cookie() does a double_rq_lock(). Would this change not deadlock
> with that?
> 
Oh yes, missed double_rq_lock() inside, just want to keep local intr disabled
to avoid preemption. will try Paul's patch and report back.

Thanks,
-Aubrey
