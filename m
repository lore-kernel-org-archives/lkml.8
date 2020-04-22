Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4B0C55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 03:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEED206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 03:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDVDg0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 23:36:26 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39218 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgDVDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 23:36:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TwHMyq2_1587526579;
Received: from 30.27.116.1(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0TwHMyq2_1587526579)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Apr 2020 11:36:20 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] sched: Defend cfs and rt bandwidth quota against
 overflow
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <xm261roim4hi.fsf@google.com>
Date:   Wed, 22 Apr 2020 11:36:19 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org, pauld@redhead.com
Content-Transfer-Encoding: 8BIT
Message-Id: <9E9BB5A6-E282-4359-A6BB-4B3B53AE875D@linux.alibaba.com>
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
 <20200420024421.22442-2-changhuaixin@linux.alibaba.com>
 <xm261roim4hi.fsf@google.com>
To:     bsegall@google.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 在 2020年4月21日，上午1:50，bsegall@google.com 写道：
> 
> Huaixin Chang <changhuaixin@linux.alibaba.com> writes:
> 
>> Kernel limitation on cpu.cfs_quota_us is insufficient. Some large
>> numbers might cause overflow in to_ratio() calculation and produce
>> unexpected results.
>> 
>> For example, if we make two cpu cgroups and then write a reasonable
>> value and a large value into child's and parent's cpu.cfs_quota_us. This
>> will cause a write error.
>> 
>> 	cd /sys/fs/cgroup/cpu
>> 	mkdir parent; mkdir parent/child
>> 	echo 8000 > parent/child/cpu.cfs_quota_us
>> 	# 17592186044416 is (1UL << 44)
>> 	echo 17592186044416 > parent/cpu.cfs_quota_us
>> 
>> In this case, quota will overflow and thus fail the __cfs_schedulable
>> check. Similar overflow also affects rt bandwidth.
> 
> More to the point is that I think doing
> 
> echo 17592186044416 > parent/cpu.cfs_quota_us
> echo 8000 > parent/child/cpu.cfs_quota_us
> 
> will only fail on the second write, while with this patch it will fail
> on the first, which should be more understandable.
> 
> 
> to_ratio could be altered to avoid unnecessary internal overflow, but
> min_cfs_quota_period is less than 1<<BW_SHIFT, so a cutoff would still
> be needed.
> 

Yes, I will rewrite commit log in the following patch.

> Also tg_rt_schedulable sums a bunch of to_ratio(), and doesn't check for
> overflow on that sum, so if we consider preventing weirdness around
> schedulable checks and max quotas relevant we should probably fix that too.
> 

It seems to me that check for overflow on sum of to_ratio(rt_period, rt_runtime) is not necessary. As to_ratio() of a rt group is bounded by global_rt_period() and global_rt_runtime() due to the checks in tg_rt_schedulable(). And global_rt_runtime() is not allowed to be greater than global_rt_period() thanks to sched_rt_global_validate(). Thus, to_ratio() of a rt group will not exceed BW_UNIT, sum of which is unlikely to overflow then. Checks against rt_runtime overflow during to_ratio is still needed.

Is that correct?

>> 
>> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
>> ---
>> kernel/sched/core.c  | 8 ++++++++
>> kernel/sched/rt.c    | 9 +++++++++
>> kernel/sched/sched.h | 2 ++
>> 3 files changed, 19 insertions(+)
>> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3a61a3b8eaa9..f0a74e35c3f0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
>> 
>> const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
>> static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
>> +/* More than 203 days if BW_SHIFT equals 20. */
>> +static const u64 max_cfs_runtime = MAX_BW_USEC * NSEC_PER_USEC;
>> 
>> static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>> 
>> @@ -7417,6 +7419,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>> 	if (period > max_cfs_quota_period)
>> 		return -EINVAL;
>> 
>> +	/*
>> +	 * Bound quota to defend quota against overflow during bandwidth shift.
>> +	 */
>> +	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
>> +		return -EINVAL;
>> +
>> 	/*
>> 	 * Prevent race between setting of cfs_rq->runtime_enabled and
>> 	 * unthrottle_offline_cfs_rqs().
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index df11d88c9895..f5eea19d68c4 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
>> 	return ret;
>> }
>> 
>> +/* More than 203 days if BW_SHIFT equals 20. */
>> +static const u64 max_rt_runtime = MAX_BW_USEC * NSEC_PER_USEC;
> 
> It looks to me like __rt_schedulable doesn't divide by NSEC_PER_USEC, so
> to_ratio is operating on nsec, and the limit is in nsec, and MAX_BW_USEC
> should probably not be named USEC then as well.

Yes, the limit for rt_runtime is in nsec. This should be changed.

> 
>> +
>> static int tg_set_rt_bandwidth(struct task_group *tg,
>> 		u64 rt_period, u64 rt_runtime)
>> {
>> @@ -2585,6 +2588,12 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>> 	if (rt_period == 0)
>> 		return -EINVAL;
>> 
>> +	/*
>> +	 * Bound quota to defend quota against overflow during bandwidth shift.
>> +	 */
>> +	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
>> +		return -EINVAL;
>> +
>> 	mutex_lock(&rt_constraints_mutex);
>> 	err = __rt_schedulable(tg, rt_period, rt_runtime);
>> 	if (err)
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index db3a57675ccf..6f6b7f545557 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
>> #define BW_SHIFT		20
>> #define BW_UNIT			(1 << BW_SHIFT)
>> #define RATIO_SHIFT		8
>> +#define MAX_BW_BITS		(64 - BW_SHIFT)
>> +#define MAX_BW_USEC		((1UL << MAX_BW_BITS) - 1)
>> unsigned long to_ratio(u64 period, u64 runtime);
>> 
>> extern void init_entity_runnable_average(struct sched_entity *se);

