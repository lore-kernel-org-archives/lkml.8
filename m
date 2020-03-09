Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC6C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FB420828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPZSzVFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCILPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:15:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41663 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCILPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:15:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so2727693ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0x8fgi0ytJn5jh/uttLWlvF3qbwpztPE+Wqbly2aQ4g=;
        b=zPZSzVFOomf+WSU42nis8HI2QYGPUv9nR68m1C372MpiovUy9avVIQ2xODxX8kvuD7
         yxOuxOkQvfX8apr3NvuwFzPsroMl7wDD0JlcwOb0DIfkkVJlWPoe4umak5fHrJ2BDabW
         2cRwJ5NXPipX2sI7G97aiGxnsol33Vs8XfV4ZZ7VPaG0GZZuhh27be5PN67p1gPJGF8A
         27dSZIy/6En2spdw/RvVIG5dCV6CbgNqCQvcxLKg4C50MNfeq4U0wuv42SBVTsbalq8/
         loDXs1yFmH2+a/hDfnCqG81Hj4BcY8pl077nwhaCIvp9U7QCMn3PWIrCFUNP2GevyrvR
         7qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0x8fgi0ytJn5jh/uttLWlvF3qbwpztPE+Wqbly2aQ4g=;
        b=ubzLFEeDJBHaPznDwj38bU0N+AaNM5y6HYvl5eTlj49RKxtAMcYVUOZmx+89JM4T1X
         YWbv3+scUKM+85MXRhKpy0C0nu6ugDRWTJJbi6zRQIvXr/5edX98OFl7ktBfkkpnEBz8
         LklLV/A5U2ESpV88Zzht8KcAYbopqZX1pubwHqE+x0v3j5aMRQEmaRt6/gUtZe5qyic1
         XRFWRKZ8Ggxxs86GZpLRnIjzm4OiaW3S8NKgjbmBg4iKpzYxpJ2iG6Qo0o7wppt2t7Co
         o91Z3sMZZTi+zu3dOeO/B7eqzs5wsgFhbsUkTAim7WoYf4F7vRlJv9YAUZhHT8Mmpg3c
         Zl6g==
X-Gm-Message-State: ANhLgQ3IdUHQeyBECTE4u3nSh4ZsnU/9afIDIfNF0jPF10+pcYIuA4gf
        WOWPucXagipWXyUZqHBwlR+HjVs7FtXASfIG7c0eVA==
X-Google-Smtp-Source: ADFU+vvGmEudDF0cQvq+MHyw5tCPEv0fizeCD7oHF0FiQIP/rtTsfTBOw/7/XvFz5ild4F/n9ikISUV70t6Kh+YHVNs=
X-Received: by 2002:a2e:b5c3:: with SMTP id g3mr3444500ljn.151.1583752548843;
 Mon, 09 Mar 2020 04:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
 <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com> <xm267dzx47k9.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm267dzx47k9.fsf@bsegall-linux.svl.corp.google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 9 Mar 2020 12:15:36 +0100
Message-ID: <CAKfTPtDKTp_G1VNgAXnh=_yLS_T6YkipOsQQ52tBRp-m612JEw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Ben Segall <bsegall@google.com>
Cc:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 at 20:17, <bsegall@google.com> wrote:
>
> =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com> writes:
>
> > On 2020/3/5 =E4=B8=8A=E5=8D=882:47, bsegall@google.com wrote:
> > [snip]
> >>> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> >>> B->shares/nr_cpus.
> >>>
> >>>> While the se of D on root cfs_rq is far more bigger than 2, so it
> >>>> wins the battle.
> >>>>
> >>>> This patch add a check on the zero load and make it as MIN_SHARES
> >>>> to fix the nonsense shares, after applied the group C wins as
> >>>> expected.
> >>>>
> >>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> >>>> ---
> >>>>  kernel/sched/fair.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 84594f8aeaf8..53d705f75fa4 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *c=
fs_rq)
> >>>>    tg_shares =3D READ_ONCE(tg->shares);
> >>>>
> >>>>    load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.lo=
ad_avg);
> >>>> +  if (!load && cfs_rq->load.weight)
> >>>> +          load =3D MIN_SHARES;
> >>>>
> >>>>    tg_weight =3D atomic_long_read(&tg->load_avg);
> >>>
> >>> Yeah, I suppose that'll do. Hurmph, wants a comment though.
> >>>
> >>> But that has me looking at other users of scale_load_down(), and does=
n't
> >>> at least update_tg_cfs_load() suffer the same problem?
> >>
> >> I think instead we should probably scale_load_down(tg_shares) and
> >> scale_load(load_avg). tg_shares is always a scaled integer, so just
> >> moving the source of the scaling in the multiply should do the job.
> >>
> >> ie
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index fcc968669aea..6d7a9d72d742 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs=
_rq)
> >>         long tg_weight, tg_shares, load, shares;
> >>         struct task_group *tg =3D cfs_rq->tg;
> >>
> >> -       tg_shares =3D READ_ONCE(tg->shares);
> >> +       tg_shares =3D scale_load_down(READ_ONCE(tg->shares));
> >>
> >> -       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg=
.load_avg);
> >> +       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_=
avg));
> >>
> >>         tg_weight =3D atomic_long_read(&tg->load_avg);
> >
> > Get the point, but IMHO fix scale_load_down() sounds better, to
> > cover all the similar cases, let's first try that way see if it's
> > working :-)
>
> Yeah, that might not be a bad idea as well; it's just that doing this
> fix would keep you from losing all your precision (and I'd have to think
> if that would result in fairness issues like having all the group ses
> having the full tg shares, or something like that).

AFAICT, we already have a fairness problem case because
scale_load_down is used in calc_delta_fair() so all sched groups that
have a weight lower than 1024 will end up with the same increase of
their vruntime when running.
Then the load_avg is used to balance between rq so load_balance will
ensure at least 1 task per CPU but not more because the load_avg which
is then used will stay null.

That being said, having a min of 2 for scale_load_down will enable us
to have the tg->load_avg !=3D 0 so a tg_weight !=3D 0 and each sched group
will not have the full shares. But it will make those group completely
fair anyway.
The best solution would be not to scale down the weight but that's a
bigger change
