Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A244C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F7920578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHYCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:11:27 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54715 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgHYCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:11:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U6n3eMK_1598321483;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6n3eMK_1598321483)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 10:11:24 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
 <20200824133820.GA31355@linux.vnet.ibm.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <b84b9194-b79e-a708-6151-1bbb0826b70e@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 10:11:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824133820.GA31355@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/24 PM9:38, Srikar Dronamraju wrote:
> * Xunlei Pang <xlpang@linux.alibaba.com> [2020-08-24 20:30:19]:
> 
>> We've met problems that occasionally tasks with full cpumask
>> (e.g. by putting it into a cpuset or setting to full affinity)
>> were migrated to our isolated cpus in production environment.
>>
>> After some analysis, we found that it is due to the current
>> select_idle_smt() not considering the sched_domain mask.
>>
>> Fix it by checking the valid domain mask in select_idle_smt().
>>
>> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
>> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1a68a05..fa942c4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>>  /*
>>   * Scan the local SMT mask for idle CPUs.
>>   */
>> -static int select_idle_smt(struct task_struct *p, int target)
>> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>>  {
>>  	int cpu;
>>  
>> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
>>  		return -1;
>>  
>>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
>> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
>> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>>  			continue;
> 
> Don't think this is right thing to do.  What if this task had set a cpumask
> that doesn't cover all the cpus in this sched_domain_span(sd)

It doesn't matter, without this patch, it selects an idle cpu from:
"cpu_smt_mask(target) and p->cpus_ptr"

with this patch, it selects an idle cpu from:
"cpu_smt_mask(target) and p->cpus_ptr and sched_domain_span(sd)"

> 
> cpu_smt_mask(target) would already limit to the sched_domain_span(sd) so I
> am not sure how this can help?
> 
> 

Here is an example:
CPU0 and CPU16 are hyper-thread pair, CPU16 is domain isolated. So its
sd_llc doesn't contain CPU16, and cpu_smt_mask(0) is 0 and 16.

Then we have @target is 0, select_idle_smt() may return the isolated(and
idle) CPU16 without this patch.
