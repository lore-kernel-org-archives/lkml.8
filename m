Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C94C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2320656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugpjNIfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:17:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:17:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id f5so1560239pfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EMb1uxg86SKuS/Penoll9c77PJlDDlCBvN4Dz9g4wPo=;
        b=ugpjNIfBan9LAlcZqkHyEH/a6xr4i1Scpyo4XMpevjHZGCxQc2PrAcJF4+GrNBpdZU
         B7cSqqBQceG6rp/j1n7Ceyyd66oWztOosei3ojumUoeryfUPQNqf+e+ihslxCyL3Jbj4
         z7AC/DXrkbIRSUAORXRmn9UjYioMAzGNVuuCBzDCc9+2OtbKT4nZkBkO4h3ckz0ChDWO
         DGjiOVdes7g32p0pdP+8Rre8jlG+C4ka+QV3Spkzf5CDKT/j5kH9bsL3TKaTPzTXbOtp
         U2qNWklxq6LmM4EdeT7+gEHZ20kWuP7pOprWvcfitkLbRh2ERprsIokUhoncrnF+pZs5
         S12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=EMb1uxg86SKuS/Penoll9c77PJlDDlCBvN4Dz9g4wPo=;
        b=nNW1f2+HF+bVviFPerwrrEz9a+ggnPDfRMJ+tTPNyqWvP4stjKnxEkdia2qJcsXhps
         4nGuU49vWN3/CBwNBDA4dKvbWjQkLZq0DxpPDkIsPaUuUieKPRrRDIRvJbk/iAQQDyw0
         AZANOYN5zf2oUu7UOjWc5RzdYctr47NVyZ/SIll8/vA2CA97fiPnSVOYBFbkkLmGV6cw
         8dR7WBuWziVTLgtmKJA9VeDqBaxF7XoBpRVs4/PYAAe0tTjYc8nFzQZwCAhkti4eoKNC
         tyFuLFBI0UkZg+sPvCXHKRRuBuMzDQxljNkv8NTDCTkakTJEFand5ge1AEuBLseJG7Rc
         7rHA==
X-Gm-Message-State: ANhLgQ2PWlV1fsCZtQguKgFEIpFu4QzLRxZ+R4OpurfDGrT7BVi70BM3
        1S1sM1y2YJKLTxdCoitGwdicjBvSZGZ3bsuw
X-Google-Smtp-Source: ADFU+vvXOQZyXGldXXVHW+fcgowjcCTDj/JVV/8LEagvOpKhvobLSArpOXxFbQCPfizGUDx1fkjPSA==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr4870600pgh.236.1583522232587;
        Fri, 06 Mar 2020 11:17:12 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id u12sm36373207pgr.3.2020.03.06.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:17:11 -0800 (PST)
From:   bsegall@google.com
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     bsegall@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is too, small
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
        <20200303195245.GF2596@hirez.programming.kicks-ass.net>
        <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
        <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
Date:   Fri, 06 Mar 2020 11:17:10 -0800
In-Reply-To: <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
 (=?utf-8?B?IueOi+i0hw==?=
        "'s message of "Thu, 5 Mar 2020 09:14:47 +0800")
Message-ID: <xm267dzx47k9.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com> writes:

> On 2020/3/5 =E4=B8=8A=E5=8D=882:47, bsegall@google.com wrote:
> [snip]
>>> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
>>> B->shares/nr_cpus.
>>>
>>>> While the se of D on root cfs_rq is far more bigger than 2, so it
>>>> wins the battle.
>>>>
>>>> This patch add a check on the zero load and make it as MIN_SHARES
>>>> to fix the nonsense shares, after applied the group C wins as
>>>> expected.
>>>>
>>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>>>> ---
>>>>  kernel/sched/fair.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 84594f8aeaf8..53d705f75fa4 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs=
_rq)
>>>>  	tg_shares =3D READ_ONCE(tg->shares);
>>>>
>>>>  	load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_=
avg);
>>>> +	if (!load && cfs_rq->load.weight)
>>>> +		load =3D MIN_SHARES;
>>>>
>>>>  	tg_weight =3D atomic_long_read(&tg->load_avg);
>>>
>>> Yeah, I suppose that'll do. Hurmph, wants a comment though.
>>>
>>> But that has me looking at other users of scale_load_down(), and doesn't
>>> at least update_tg_cfs_load() suffer the same problem?
>>=20
>> I think instead we should probably scale_load_down(tg_shares) and
>> scale_load(load_avg). tg_shares is always a scaled integer, so just
>> moving the source of the scaling in the multiply should do the job.
>>=20
>> ie
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fcc968669aea..6d7a9d72d742 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs_r=
q)
>>         long tg_weight, tg_shares, load, shares;
>>         struct task_group *tg =3D cfs_rq->tg;
>>=20=20
>> -       tg_shares =3D READ_ONCE(tg->shares);
>> +       tg_shares =3D scale_load_down(READ_ONCE(tg->shares));
>>=20=20
>> -       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.l=
oad_avg);
>> +       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_av=
g));
>>=20=20
>>         tg_weight =3D atomic_long_read(&tg->load_avg);
>
> Get the point, but IMHO fix scale_load_down() sounds better, to
> cover all the similar cases, let's first try that way see if it's
> working :-)

Yeah, that might not be a bad idea as well; it's just that doing this
fix would keep you from losing all your precision (and I'd have to think
if that would result in fairness issues like having all the group ses
having the full tg shares, or something like that).
