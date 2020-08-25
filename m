Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2404C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B33B2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgHYJ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:27:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33828 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgHYJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:27:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U6pQcyl_1598347663;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6pQcyl_1598347663)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 17:27:44 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
 <CAPJCdBnTm0=Nazi2w9a6mBcKNv=_66UwvMfTNg6vLNKqW6qfwQ@mail.gmail.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <495238bd-ea0d-56c6-4a9c-7b18deafcc8f@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 17:27:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPJCdBnTm0=Nazi2w9a6mBcKNv=_66UwvMfTNg6vLNKqW6qfwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/25 下午2:37, Jiang Biao wrote:
> On Mon, 24 Aug 2020 at 20:31, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
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
>>         int cpu;
>>
>> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
>>                 return -1;
>>
>>         for_each_cpu(cpu, cpu_smt_mask(target)) {
>> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>> +               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
>> +                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> Maybe the following change could be better, :)
> for_each_cpu_and(cpu, cpu_smt_mask(target), sched_domain_span(sd))
> keep a similar style with select_idle_core/cpu, and could reduce loops.
> 

I thought that, but given that smt mask is usually small, the original
code may run a bit faster?

> Just an option.
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> 

Thanks :-)
