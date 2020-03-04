Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5320870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDtBMEGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgCDSrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:47:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42732 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgCDSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:47:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so1396859plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=v7k2LSY5o0a0mFl+RRVR7ik9N89blp340TgtHce0C/0=;
        b=EDtBMEGXyVh0fIWTILCelMI+gdPujV1YVwkkUtxmZXRCnRubtsvKd6W3PNh0hXlBwM
         2zIvf/aoR8Fcav/eW6vzWXmFscf92ZP9exyXOSLvYmjwawdYhLwZCggQeDE0U3Iv/H3T
         iD+uU2T0YXZ8TogJ+cDGBM1MY4TYgLpW0O5pSsy6y/O7ALQsOaI3080XQh5C5aFLoSrO
         PzzpyL/0QnlUWq1IbM5lVTwDyTbY2LRUD9GIbuK9hdYG8RnlL4SRqhcgCoi9jxvotSCX
         RXqeCWcAlxKXdkNW3mga27kZNWE69uvcV5w8B6sHugRXmT9yJ6opYplI4dAqd1zgJ9dc
         wfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=v7k2LSY5o0a0mFl+RRVR7ik9N89blp340TgtHce0C/0=;
        b=dmDm7+05ZW9K3ZFQWt75K9g3cs4CVa6ra4jrfrMmBJqCSNWjaawpwYkpqHpWeEWLnk
         2UUR+rjdege1H+3IDEvK9QfPZwIfYgiCrEkyJpijfhQlYzWoR3Qp6nmwV17tBnXgEBGP
         f8E6csbUQJivkoVHhTHvDmorOpeqV2sUQoM9Vud58l3nohROsGaFdKPA1AjgbsrdExTP
         WTnGiywOVe2AXYGjc8l5YnrBBDty5UmY2iIV5qq0lcjrUNt11+Z1hJNr6JIICYYgoyR6
         KrCxK8xcJJw0mvlS9S3ojU5v+XV0cVmOMnY/oY23tMU8k0Ms3xBv88vzkb1guh2WKcz+
         U/jQ==
X-Gm-Message-State: ANhLgQ0kz7HVY6kEkFE+4Cr0X1Ro6OMm5lBsQXGj9qKi6zSbHFsPdhHl
        31C+dEPh85cvXHxSz40VN88tC2EpFtpqYQ==
X-Google-Smtp-Source: ADFU+vs3HTTV9cA9wqFbN1eGeQT6xv4ysbaCuLl9iA4ak9z3V9hlR77q+D3bB1ifwxhcp90vGAWimA==
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr4479428pjb.109.1583347641851;
        Wed, 04 Mar 2020 10:47:21 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id f8sm28873667pfn.2.2020.03.04.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:47:20 -0800 (PST)
From:   bsegall@google.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is too, small
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
        <20200303195245.GF2596@hirez.programming.kicks-ass.net>
Date:   Wed, 04 Mar 2020 10:47:12 -0800
In-Reply-To: <20200303195245.GF2596@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 3 Mar 2020 20:52:45 +0100")
Message-ID: <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Mar 03, 2020 at 10:17:03PM +0800, =E7=8E=8B=E8=B4=87 wrote:
>> During our testing, we found a case that shares no longer
>> working correctly, the cgroup topology is like:
>>=20
>>   /sys/fs/cgroup/cpu/A		(shares=3D102400)
>>   /sys/fs/cgroup/cpu/A/B	(shares=3D2)
>>   /sys/fs/cgroup/cpu/A/B/C	(shares=3D1024)
>>=20
>>   /sys/fs/cgroup/cpu/D		(shares=3D1024)
>>   /sys/fs/cgroup/cpu/D/E	(shares=3D1024)
>>   /sys/fs/cgroup/cpu/D/E/F	(shares=3D1024)
>>=20
>> The same benchmark is running in group C & F, no other tasks are
>> running, the benchmark is capable to consumed all the CPUs.
>>=20
>> We suppose the group C will win more CPU resources since it could
>> enjoy all the shares of group A, but it's F who wins much more.
>>=20
>> The reason is because we have group B with shares as 2, which make
>> the group A 'cfs_rq->load.weight' very small.
>>=20
>> And in calc_group_shares() we calculate shares as:
>>=20
>>   load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_av=
g);
>>   shares =3D (tg_shares * load) / tg_weight;
>>=20
>> Since the 'cfs_rq->load.weight' is too small, the load become 0
>> in here, although 'tg_shares' is 102400, shares of the se which
>> stand for group A on root cfs_rq become 2.
>
> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> B->shares/nr_cpus.
>
>> While the se of D on root cfs_rq is far more bigger than 2, so it
>> wins the battle.
>>=20
>> This patch add a check on the zero load and make it as MIN_SHARES
>> to fix the nonsense shares, after applied the group C wins as
>> expected.
>>=20
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 84594f8aeaf8..53d705f75fa4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_r=
q)
>>  	tg_shares =3D READ_ONCE(tg->shares);
>>=20
>>  	load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_av=
g);
>> +	if (!load && cfs_rq->load.weight)
>> +		load =3D MIN_SHARES;
>>=20
>>  	tg_weight =3D atomic_long_read(&tg->load_avg);
>
> Yeah, I suppose that'll do. Hurmph, wants a comment though.
>
> But that has me looking at other users of scale_load_down(), and doesn't
> at least update_tg_cfs_load() suffer the same problem?

I think instead we should probably scale_load_down(tg_shares) and
scale_load(load_avg). tg_shares is always a scaled integer, so just
moving the source of the scaling in the multiply should do the job.

ie

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..6d7a9d72d742 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
        long tg_weight, tg_shares, load, shares;
        struct task_group *tg =3D cfs_rq->tg;
=20
-       tg_shares =3D READ_ONCE(tg->shares);
+       tg_shares =3D scale_load_down(READ_ONCE(tg->shares));
=20
-       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load=
_avg);
+       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_avg));
=20
        tg_weight =3D atomic_long_read(&tg->load_avg);
=20



