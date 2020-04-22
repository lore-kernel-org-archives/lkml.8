Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C9C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266C92076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgC2+8oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgDVSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:44:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6BC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:44:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so1552311pgo.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f1+5Bslx+AGzRvVAW/l9eAKCNMiAnjFtT2q8yc6baXM=;
        b=HgC2+8ozAtOezjm45oOH6cdx0IQmCBUacX+qb2/TsoTKF+uxDh9k/KCkP8b1tW0P8X
         /5CAOpGU2xV1tUCw86uGW43HmIMq3NsDleztEWj+oswD4Nrk3Bss9RkKugSZJl90ndEG
         MTxl1n36fgTXnQepe1qgkDuezFJodQJ2E5p+wWGyrguUvmjZHRLQR0D3hL9x/CCSnaWo
         UO3/ycLE3FpbLIDOeOPZWpxYltRx1+a7I3q0JydSkrEmYiKg4/OgiO9LnKMyv7Sa6WgA
         N1aYL0a1+s3qQBN1k21OWBy5DuupYpG+dFzKo5z3MCBnf21t+a924nQ76F5f8fNcsZ0C
         iAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=f1+5Bslx+AGzRvVAW/l9eAKCNMiAnjFtT2q8yc6baXM=;
        b=BHQMHA6uzhMJk+jrQxUyPkBrRewg7eS6o1xCZEOxRiLUkV35bJVRAIq8KgphE0Wh0r
         ydkkzvTx9COHWfjKUvFE02YlYwNLcaYlvYJ4YJJgjhlcynyN5zsM03ThvV2CXe9K9yYD
         mkN0GsjSyKI8sj928Ib8cJpIhSmZTIMrPQ42D3it0fumuvEK+kQ8ttENMM9steRGC/6V
         J7GRCjdOiRqZNfF+/xs9N/U25OUjFmVEcm+1bG1P6VQT6B9eG7QjyAOUxeZOtg2oky3C
         svRTYO1vU6ZKXyQiaHJF1s17LvEmOC7MkI5ZukGn+bfGYOJELiOzNghhEF0cjHMlgcbx
         Q2Dw==
X-Gm-Message-State: AGi0PuY4d8qPZ9qU1IPi/Q83Yb5JxIGo8hsuHl6VQ+jDsN6SIG61/1W/
        wQWwjQa6Rl6FgmMxKx7WMwYzAGZYfzA=
X-Google-Smtp-Source: APiQypKKdXpOFcd56LCiw3lelsfMIssm74ErnRCP54UMFi84TF07+OnXZpSaFOT37azh8/3oqamIVw==
X-Received: by 2002:a62:fc02:: with SMTP id e2mr1614524pfh.195.1587581073505;
        Wed, 22 Apr 2020 11:44:33 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id q63sm176741pfb.178.2020.04.22.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 11:44:32 -0700 (PDT)
From:   bsegall@google.com
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org, pauld@redhead.com
Subject: Re: [PATCH 1/2] sched: Defend cfs and rt bandwidth quota against overflow
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
        <20200420024421.22442-2-changhuaixin@linux.alibaba.com>
        <xm261roim4hi.fsf@google.com>
        <9E9BB5A6-E282-4359-A6BB-4B3B53AE875D@linux.alibaba.com>
Date:   Wed, 22 Apr 2020 11:44:30 -0700
In-Reply-To: <9E9BB5A6-E282-4359-A6BB-4B3B53AE875D@linux.alibaba.com>
        (changhuaixin@linux.alibaba.com's message of "Wed, 22 Apr 2020
        11:36:19 +0800")
Message-ID: <xm26o8rjl5rl.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changhuaixin <changhuaixin@linux.alibaba.com> writes:

>> =E5=9C=A8 2020=E5=B9=B44=E6=9C=8821=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=881=
:50=EF=BC=8Cbsegall@google.com =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Huaixin Chang <changhuaixin@linux.alibaba.com> writes:
>>=20
>>> Kernel limitation on cpu.cfs_quota_us is insufficient. Some large
>>> numbers might cause overflow in to_ratio() calculation and produce
>>> unexpected results.
>>>=20
>>> For example, if we make two cpu cgroups and then write a reasonable
>>> value and a large value into child's and parent's cpu.cfs_quota_us. This
>>> will cause a write error.
>>>=20
>>> 	cd /sys/fs/cgroup/cpu
>>> 	mkdir parent; mkdir parent/child
>>> 	echo 8000 > parent/child/cpu.cfs_quota_us
>>> 	# 17592186044416 is (1UL << 44)
>>> 	echo 17592186044416 > parent/cpu.cfs_quota_us
>>>=20
>>> In this case, quota will overflow and thus fail the __cfs_schedulable
>>> check. Similar overflow also affects rt bandwidth.
>>=20
>> More to the point is that I think doing
>>=20
>> echo 17592186044416 > parent/cpu.cfs_quota_us
>> echo 8000 > parent/child/cpu.cfs_quota_us
>>=20
>> will only fail on the second write, while with this patch it will fail
>> on the first, which should be more understandable.
>>=20
>>=20
>> to_ratio could be altered to avoid unnecessary internal overflow, but
>> min_cfs_quota_period is less than 1<<BW_SHIFT, so a cutoff would still
>> be needed.
>>=20
>
> Yes, I will rewrite commit log in the following patch.
>
>> Also tg_rt_schedulable sums a bunch of to_ratio(), and doesn't check for
>> overflow on that sum, so if we consider preventing weirdness around
>> schedulable checks and max quotas relevant we should probably fix that t=
oo.
>>=20
>
> It seems to me that check for overflow on sum of to_ratio(rt_period, rt_r=
untime)
> is not necessary. As to_ratio() of a rt group is bounded by global_rt_per=
iod()
> and global_rt_runtime() due to the checks in tg_rt_schedulable(). And
> global_rt_runtime() is not allowed to be greater than global_rt_period() =
thanks
> to sched_rt_global_validate(). Thus, to_ratio() of a rt group will not ex=
ceed
> BW_UNIT, sum of which is unlikely to overflow then. Checks against rt_run=
time
> overflow during to_ratio is still needed.
>
> Is that correct?

Good point, that's probably not a problem then.

>
>>>=20
>>> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
>>> ---
>>> kernel/sched/core.c  | 8 ++++++++
>>> kernel/sched/rt.c    | 9 +++++++++
>>> kernel/sched/sched.h | 2 ++
>>> 3 files changed, 19 insertions(+)
>>>=20
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 3a61a3b8eaa9..f0a74e35c3f0 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
>>>=20
>>> const u64 max_cfs_quota_period =3D 1 * NSEC_PER_SEC; /* 1s */
>>> static const u64 min_cfs_quota_period =3D 1 * NSEC_PER_MSEC; /* 1ms */
>>> +/* More than 203 days if BW_SHIFT equals 20. */
>>> +static const u64 max_cfs_runtime =3D MAX_BW_USEC * NSEC_PER_USEC;
>>>=20
>>> static int __cfs_schedulable(struct task_group *tg, u64 period, u64 run=
time);
>>>=20
>>> @@ -7417,6 +7419,12 @@ static int tg_set_cfs_bandwidth(struct task_grou=
p *tg, u64 period, u64 quota)
>>> 	if (period > max_cfs_quota_period)
>>> 		return -EINVAL;
>>>=20
>>> +	/*
>>> +	 * Bound quota to defend quota against overflow during bandwidth shif=
t.
>>> +	 */
>>> +	if (quota !=3D RUNTIME_INF && quota > max_cfs_runtime)
>>> +		return -EINVAL;
>>> +
>>> 	/*
>>> 	 * Prevent race between setting of cfs_rq->runtime_enabled and
>>> 	 * unthrottle_offline_cfs_rqs().
>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>> index df11d88c9895..f5eea19d68c4 100644
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg=
, u64 period, u64 runtime)
>>> 	return ret;
>>> }
>>>=20
>>> +/* More than 203 days if BW_SHIFT equals 20. */
>>> +static const u64 max_rt_runtime =3D MAX_BW_USEC * NSEC_PER_USEC;
>>=20
>> It looks to me like __rt_schedulable doesn't divide by NSEC_PER_USEC, so
>> to_ratio is operating on nsec, and the limit is in nsec, and MAX_BW_USEC
>> should probably not be named USEC then as well.
>
> Yes, the limit for rt_runtime is in nsec. This should be changed.
>
>>=20
>>> +
>>> static int tg_set_rt_bandwidth(struct task_group *tg,
>>> 		u64 rt_period, u64 rt_runtime)
>>> {
>>> @@ -2585,6 +2588,12 @@ static int tg_set_rt_bandwidth(struct task_group=
 *tg,
>>> 	if (rt_period =3D=3D 0)
>>> 		return -EINVAL;
>>>=20
>>> +	/*
>>> +	 * Bound quota to defend quota against overflow during bandwidth shif=
t.
>>> +	 */
>>> +	if (rt_runtime !=3D RUNTIME_INF && rt_runtime > max_rt_runtime)
>>> +		return -EINVAL;
>>> +
>>> 	mutex_lock(&rt_constraints_mutex);
>>> 	err =3D __rt_schedulable(tg, rt_period, rt_runtime);
>>> 	if (err)
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index db3a57675ccf..6f6b7f545557 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sc=
hed_dl_entity *dl_se);
>>> #define BW_SHIFT		20
>>> #define BW_UNIT			(1 << BW_SHIFT)
>>> #define RATIO_SHIFT		8
>>> +#define MAX_BW_BITS		(64 - BW_SHIFT)
>>> +#define MAX_BW_USEC		((1UL << MAX_BW_BITS) - 1)
>>> unsigned long to_ratio(u64 period, u64 runtime);
>>>=20
>>> extern void init_entity_runnable_average(struct sched_entity *se);
