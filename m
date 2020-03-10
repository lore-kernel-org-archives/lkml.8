Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56851C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2E324673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koCVLsi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJH54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:57:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36282 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:57:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so703919ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFEoAaMGL/1O9sOIVW40k5I21HfvcnJTHJcQ+qcDRqQ=;
        b=koCVLsi3/Cn95tnvkyWBd6BKaP0PBLseqp/zXAJsz1j+5/OYsKQwwNhFnDw4G1PvPN
         wPPQzumFva+xRdxqKLJL+vL1YsrLxo2x8idOZov3AG47pPH757ySZFqTUvJaLOD+vdsD
         P0pyphzI0gsM9uCN8C0FoQfbzzr/0LvSqoOC9hqXmNowgcvFscfcDl4AQ+j9isc5UFCU
         tV0M3Xl5CkYfL3zyQB2MLhgqYMLhTEg9OZtscVilktyNE3Tc1AhP5oC9g+ZzHbzsaFoK
         aLLA6Uev2K4YtTUQXLm3aUEALcmDBt1f4ILxzRWY6EqrcM97jmjsIBbcDTM+Z4AoQ6wK
         +Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFEoAaMGL/1O9sOIVW40k5I21HfvcnJTHJcQ+qcDRqQ=;
        b=Z5HpoMugE5Prtw7X/dqOLyj9iXPcw8UM3s8PkTnpjW5Ogdwv4ptwjdCLrDQfWUyJB6
         MeJgyXJQbeuHJLk0kkqRlf4JeQH/0VDbw6X7VKNvteYBtD0lPBhP2jzBwv0EmeJP9VWp
         P1r/RcVZWH5ePuDwq3dkVbR2ExZPRa3KCje5K6AFm3jrto8vyahkmgcLx0LTV4SInyXp
         1JEkkqpN/BaKu9RxpMYWyeAMMkYC/5gcHieEMmvkUoCqe55vlD1OU57RCb4+9Zq2AJy6
         UdGfW13PJa1njiYrchlV+rtkXb5t0B+boK0bdcugbUxdxjUKmrwF6nif9o4X1e/ygKjX
         BNFw==
X-Gm-Message-State: ANhLgQ3bHf6/nK2f5tgnTBpobIduB4UNbFwo3OPvFfPtRBUdMkOl+web
        dHzMDAMvr1pGen7xFA1IycmS0hf8PSmky7LacuRy7g==
X-Google-Smtp-Source: ADFU+vvT3+qD97JTwYrdls0zyY8hlFCA7j1mhmAlevQkF5J8MPsC5XDX9uZnUyiZSpFKRps7/6vbVBS/bt3gZhY52d8=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr11316683ljg.137.1583827073751;
 Tue, 10 Mar 2020 00:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
 <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com> <xm267dzx47k9.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtDKTp_G1VNgAXnh=_yLS_T6YkipOsQQ52tBRp-m612JEw@mail.gmail.com> <49a4dd4a-e7b6-5182-150d-16fff2d101cf@linux.alibaba.com>
In-Reply-To: <49a4dd4a-e7b6-5182-150d-16fff2d101cf@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Mar 2020 08:57:41 +0100
Message-ID: <CAKfTPtCviqkifAieSQT2bT0TsDirkEzSW8kn8Kb9uws9q-+E_A@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ben Segall <bsegall@google.com>,
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

On Tue, 10 Mar 2020 at 04:42, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.co=
m> wrote:
>
>
>
> On 2020/3/9 =E4=B8=8B=E5=8D=887:15, Vincent Guittot wrote:
> [snip]
> >>>> -       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->a=
vg.load_avg);
> >>>> +       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.loa=
d_avg));
> >>>>
> >>>>         tg_weight =3D atomic_long_read(&tg->load_avg);
> >>>
> >>> Get the point, but IMHO fix scale_load_down() sounds better, to
> >>> cover all the similar cases, let's first try that way see if it's
> >>> working :-)
> >>
> >> Yeah, that might not be a bad idea as well; it's just that doing this
> >> fix would keep you from losing all your precision (and I'd have to thi=
nk
> >> if that would result in fairness issues like having all the group ses
> >> having the full tg shares, or something like that).
> >
> > AFAICT, we already have a fairness problem case because
> > scale_load_down is used in calc_delta_fair() so all sched groups that
> > have a weight lower than 1024 will end up with the same increase of
> > their vruntime when running.
> > Then the load_avg is used to balance between rq so load_balance will
> > ensure at least 1 task per CPU but not more because the load_avg which
> > is then used will stay null.
> >
> > That being said, having a min of 2 for scale_load_down will enable us
> > to have the tg->load_avg !=3D 0 so a tg_weight !=3D 0 and each sched gr=
oup
> > will not have the full shares. But it will make those group completely
> > fair anyway.
> > The best solution would be not to scale down the weight but that's a
> > bigger change
>
> Does that means a changing for all those 'load.weight' related
> calculation, to reserve the scaled weight?

yes, to make sure that calculation still fit in the variable

>
> I suppose u64 is capable for 'cfs_rq.load' to reserve the scaled up load,
> changing all those places could be annoying but still fine.

it's fine but the max number of runnable tasks at the max priority on
a cfs_rq  will decrease from around 4 billion to "only" 4 Million.

>
> However, I'm not quite sure about the benefit, how much more precision
> we'll gain and does that really matters? better to have some testing to
> demonstrate it.

it will ensure a better fairness in a larger range of share value. I
agree that we can wonder if it's worth the effort for those low share
values. Wouldbe interesting to knwo who use such low value and for
which purpose

Regards,
Vincent
>
> Regards,
> Michael Wang
>
>
> >
