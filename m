Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692020848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDm+34fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgCDJoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:44:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43464 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbgCDJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:44:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so933325lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZdaAuvXDt5Zm8uZKcBa5GQKSlbVmS+sOfjwP1g7YNcU=;
        b=PDm+34fKqct7NzNr+Nig+fHXOBiWiaNrx8M4sR80jCIOmG8g3mst3DmDhWu23K7MPt
         EiMCEYtkirPIFYO2UH1UZYr3bxNj9U2o1BY/Yw3P6Q//8DnjKSqkiezrZfcuizDKHo43
         UiXBmo2SapD23I7hPbMOi/mOSKB1WBD0s1NGdaydKRT8fmT3WJsrOPq7+am4kYPLrcR2
         7UhQsxtKimqsLEJJ7JxKNXT+B5iw/gr7KYtujp2sdfZkKoKTlS7VPZm7u4k2bEFElnqU
         2S9HtmTCscRkabiVZXvmfniDYaEIbvuT8ozFt8rEpMiJE+qnjdPLGyEY39USwX7vRV4u
         7yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZdaAuvXDt5Zm8uZKcBa5GQKSlbVmS+sOfjwP1g7YNcU=;
        b=EoXo7tv9Fn60Z7hVLcgcNAiUF+qTRGCxDxVBSqa/3AO6N2HrJHy2Sa8wv/0Xn2YSjI
         i/857kMQQOZNFYe0U9mbe3Rg8N1NEau++kD5WNzb3iPk9RBK/dFSCijK4X9Wf6YyWzBY
         Mw0O7ztJwyzyoTWWD25WbdZONJoxbPt1JuzMmdLeCLTb1iz/ENfv9J2gW/DY2elgBO/U
         r3v3Eie9eU4ZtHBGaXrWeXCTYoupzBeHT6p4iY7wjeugVBe4a81J32jm0x9hNpm6a116
         SPZ/lJpEobtxKSIOF1BjY3JtDo9lUb86ChOpbkUKga/y6CijK6KWGY7n2Zc5sdAI7vsj
         SCEg==
X-Gm-Message-State: ANhLgQ1/EYS9dSwxKXiU5/zliqiYf/YDV5ys/rOs4JAqmqtlP36K0Bft
        9VOSaJ8gasBUvZ1adEXv2OoHF3925mqooinwxJUXaw==
X-Google-Smtp-Source: ADFU+vsn+WmWyQHUmVSjEeH0HohCjkFkeRhctMOeYFoX+rZjdBvPH3ev27LeMypi5iGJ9qpFYHnLADg+QMYXVGQ6GLY=
X-Received: by 2002:a19:230d:: with SMTP id j13mr1516518lfj.189.1583315042890;
 Wed, 04 Mar 2020 01:44:02 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
 <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
In-Reply-To: <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 10:43:51 +0100
Message-ID: <CAKfTPtCnwUKCNbmGR-oErNrF+H+D0FPZPVS=d4m3mvr8Hc7ivQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 09:47, Vincent Guittot <vincent.guittot@linaro.org> w=
rote:
>
> On Wed, 4 Mar 2020 at 02:19, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.c=
om> wrote:
> >
> >
> >
> > On 2020/3/4 =E4=B8=8A=E5=8D=883:52, Peter Zijlstra wrote:
> > [snip]
> > >> The reason is because we have group B with shares as 2, which make
> > >> the group A 'cfs_rq->load.weight' very small.
> > >>
> > >> And in calc_group_shares() we calculate shares as:
> > >>
> > >>   load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.loa=
d_avg);
> > >>   shares =3D (tg_shares * load) / tg_weight;
> > >>
> > >> Since the 'cfs_rq->load.weight' is too small, the load become 0
> > >> in here, although 'tg_shares' is 102400, shares of the se which
> > >> stand for group A on root cfs_rq become 2.
> > >
> > > Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> > > B->shares/nr_cpus.
> >
> > Yeah, that's exactly why it happens, even the share 2 scale up to 2048,
> > on 96 CPUs platform, each CPU get only 21 in equal case.
> >
> > >
> > >> While the se of D on root cfs_rq is far more bigger than 2, so it
> > >> wins the battle.
> > >>
> > >> This patch add a check on the zero load and make it as MIN_SHARES
> > >> to fix the nonsense shares, after applied the group C wins as
> > >> expected.
> > >>
> > >> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > >> ---
> > >>  kernel/sched/fair.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >> index 84594f8aeaf8..53d705f75fa4 100644
> > >> --- a/kernel/sched/fair.c
> > >> +++ b/kernel/sched/fair.c
> > >> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *c=
fs_rq)
> > >>      tg_shares =3D READ_ONCE(tg->shares);
> > >>
> > >>      load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.=
load_avg);
> > >> +    if (!load && cfs_rq->load.weight)
> > >> +            load =3D MIN_SHARES;
> > >>
> > >>      tg_weight =3D atomic_long_read(&tg->load_avg);
> > >
> > > Yeah, I suppose that'll do. Hurmph, wants a comment though.
> > >
> > > But that has me looking at other users of scale_load_down(), and does=
n't
> > > at least update_tg_cfs_load() suffer the same problem?
> >
> > Good point :-) I'm not sure but is scale_load_down() supposed to scale =
small
> > value into 0? If not, maybe we should fix the helper to make sure it at
> > least return some real load? like:
> >
> > # define scale_load_down(w) ((w + (1 << SCHED_FIXEDPOINT_SHIFT)) >> SCH=
ED_FIXEDPOINT_SHIFT)
>
> you will add +1 of nice prio for each device

Of course, it's not prio but only weight which is different

>
> should we use instead
> # define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
> SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)
>
> Regards,
> Vincent
>
> >
> > Regards,
> > Michael Wang
> >
> > >
