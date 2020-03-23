Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23DEC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B02E20769
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWG6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:58:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:41721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWG6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:58:23 -0400
IronPort-SDR: 4qqFghqYqJvRKLen7U4JvsmY8vxbrP/e1tKR+dvWYqoefu0RHQ5cBk7b9Vv5RMIZs4FTfrzqLZ
 MuNA7nsvrnCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 23:58:22 -0700
IronPort-SDR: jZfDROTwMlocgaKQO+cBS7eT/pYH+5XWKH4m9coTaSgLYLzAzRX3V4uzVu9JSv+4jQLVffWgfl
 2jkQLLCo21yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="357011531"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2020 23:58:19 -0700
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
To:     paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, vpillai <vpillai@digitalocean.com>,
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
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
Date:   Mon, 23 Mar 2020 14:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200314003004.GI3199@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/14 8:30, Paul E. McKenney wrote:
> On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
>> rcu_read_unlock() can incur an infrequent deadlock in
>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>>
>> This fixes the following spinlock recursion observed when testing the
>> core scheduling patches on PREEMPT=y kernel on ChromeOS:
>>
>> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
>>
> 
> The original could indeed deadlock, and this would avoid that deadlock.
> (The commit to solve this deadlock is sadly not yet in mainline.)
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

I saw this in dmesg with this patch, is it expected?

Thanks,
-Aubrey

[  117.000905] =============================
[  117.000907] WARNING: suspicious RCU usage
[  117.000911] 5.5.7+ #160 Not tainted
[  117.000913] -----------------------------
[  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
[  117.000918] 
               other info that might help us debug this:

[  117.000921] 
               rcu_scheduler_active = 2, debug_locks = 1
[  117.000923] 1 lock held by swapper/52/0:
[  117.000925]  #0: ffffffff82670960 (rcu_read_lock_sched){....}, at: sched_core_balance+0x5/0x700
[  117.000937] 
               stack backtrace:
[  117.000940] CPU: 52 PID: 0 Comm: swapper/52 Kdump: loaded Not tainted 5.5.7+ #160
[  117.000943] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0412.020920172159 02/09/2017
[  117.000945] Call Trace:
[  117.000955]  dump_stack+0x86/0xcb
[  117.000962]  sched_core_balance+0x634/0x700
[  117.000982]  __balance_callback+0x49/0xa0
[  117.000990]  __schedule+0x1416/0x1620
[  117.001000]  ? lockdep_hardirqs_off+0xa0/0xe0
[  117.001005]  ? _raw_spin_unlock_irqrestore+0x41/0x70
[  117.001024]  schedule_idle+0x28/0x40
[  117.001030]  do_idle+0x17e/0x2a0
[  117.001041]  cpu_startup_entry+0x19/0x20
[  117.001048]  start_secondary+0x16c/0x1c0
[  117.001055]  secondary_startup_64+0xa4/0xb0

> 
>> ---
>>  kernel/sched/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3045bd50e249..037e8f2e2686 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4735,7 +4735,7 @@ static void sched_core_balance(struct rq *rq)
>>  	struct sched_domain *sd;
>>  	int cpu = cpu_of(rq);
>>  
>> -	rcu_read_lock();
>> +	rcu_read_lock_sched();
>>  	raw_spin_unlock_irq(rq_lockp(rq));
>>  	for_each_domain(cpu, sd) {
>>  		if (!(sd->flags & SD_LOAD_BALANCE))
>> @@ -4748,7 +4748,7 @@ static void sched_core_balance(struct rq *rq)
>>  			break;
>>  	}
>>  	raw_spin_lock_irq(rq_lockp(rq));
>> -	rcu_read_unlock();
>> +	rcu_read_unlock_sched();
>>  }
>>  
>>  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
>> -- 
>> 2.25.1.481.gfbce0eb801-goog
>>

