Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E74C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEBF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgDMUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:33:05 -0400
Received: from foss.arm.com ([217.140.110.172]:45986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDMUdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C14930E;
        Mon, 13 Apr 2020 13:33:02 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADB4E3F6C4;
        Mon, 13 Apr 2020 13:33:00 -0700 (PDT)
References: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com> <6f372bce-151e-79e1-2fda-d8b2bcf777d6@linux.alibaba.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Simplify the code of should_we_balance()
Message-ID: <jhjzhbf6t2p.mognet@arm.com>
In-reply-to: <6f372bce-151e-79e1-2fda-d8b2bcf777d6@linux.alibaba.com>
Date:   Mon, 13 Apr 2020 21:32:37 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/04/20 09:42, Peng Wang wrote:
> On 4/11/20 5:20 PM, Peng Wang wrote:
>> We only consider group_balance_cpu() after there is no idle
>> cpu. So, just do comparison before return at these two cases.
>>

It's not really changing much, but if it helps making it a bit more
readable, why not. Small nit below.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
>> ---
>>   kernel/sched/fair.c | 16 +++++-----------
>>   1 file changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1ea3ddd..81b2c647 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9413,7 +9413,7 @@ static int active_load_balance_cpu_stop(void *data);
>>   static int should_we_balance(struct lb_env *env)
>>   {
>>      struct sched_group *sg = env->sd->groups;
>> -	int cpu, balance_cpu = -1;
>> +	int cpu;
>>
>>      /*
>>       * Ensure the balancing environment is consistent; can happen
>> @@ -9434,18 +9434,12 @@ static int should_we_balance(struct lb_env *env)
>>              if (!idle_cpu(cpu))
>>                      continue;
>>
>> -		balance_cpu = cpu;
>> -		break;
>> +		/* Are we the first idle CPU? */
>> +		return cpu == env->dst_cpu;
>>      }
>>
>> -	if (balance_cpu == -1)
>> -		balance_cpu = group_balance_cpu(sg);
>> -
>> -	/*
>> -	 * First idle CPU or the first CPU(busiest) in this sched group
>> -	 * is eligible for doing load balancing at this and above domains.
>> -	 */
>> -	return balance_cpu == env->dst_cpu;
>> +	/* Are we the first balance CPU of this group? */

Nit: That should be either "the balance CPU" or "the first CPU in the group
balance mask"

>> +	return group_balance_cpu(sg) == env->dst_cpu;
>>   }
>>
>>   /*
>>
>
> +juri.lelli@redhat.com
