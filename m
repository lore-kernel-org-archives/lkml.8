Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85645C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96320870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mp/9m0Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbgCDIrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:47:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbgCDIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:47:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so797605lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1/muAEJRVDtA9WVzLEvKEtzqnYqmcLx2KuHECoY8Shs=;
        b=Mp/9m0FkAjBaUAP9dyLVOInMUfOesS6gQR/kqiAysxRIY1oojdvpJU4o9WZIBD3e5Y
         TOZlEcldPZahrilm3hs4AQWlS/dCaKKNoFGFKSw8nX1Qpds9pjEbIu0M1Uxqs53BzpnU
         fVCaFmK1SjGugd0f99DUh+JMNZHsCVyBrCPjSA6lch7kFgsUzloq4JBV3oFp194FdYUX
         xyHPeMN5rTzV/cHYoc0YVOt8ViEkETwwlqiiOuW5QcuG44rDjRt/RMwgl4zh8Xfy79iJ
         Na4vkcBJ3dQnc+RaNqbfctBIstOEOpNX+8/VNFtjoxqmrjCibyWzPvxKC6/f2SpvS7nF
         kgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1/muAEJRVDtA9WVzLEvKEtzqnYqmcLx2KuHECoY8Shs=;
        b=UoH7kjji0OpbpvyPBXhoe7Oknq1bypsFfpmPLqwbnR/34H1L4J+PXLDRWlBF1ZXj8c
         3CdEH70EJhMmWMeQM6mckSM345VLtzoIlFtrhqJciFkZvoiRy8TZkCO8AJKdwH0IWeZD
         5ynGjcfR8bQfNcuqBGpYNEh9jbrik0xEh7JzzV8TjI4mAd0wLz5cLruMxD4RYzPc1uXF
         tDOaEVnjaSDI5rC3OfvKGHtSkZ1By5SEfsZmHvKKZ0BJSg1ANZHLkqzYN3V9IF6qsdX9
         ywUpiqDwcBQipOePQNyniwcvjsBONE7f7JU2ixLKrQ6AWdEHy1EIdkE85umo8z1GUVDq
         QxJw==
X-Gm-Message-State: ANhLgQ1W39eB7rxUZU9pBPTbQfFyElgYWPSCErRTZ164HWkgjAC30O6P
        BHEzEifgomDkrk9UfOKRcplmOi3uHPTz9Rlwa+uSRg==
X-Google-Smtp-Source: ADFU+vv/bRj+YGAZ1h/SX6kcNhCwSfA0Pw9D+CAD2w+eW4ujsHfJzvt42/NYBOL5OJs96eCHD35J1MqXBQOm1QKmB2A=
X-Received: by 2002:ac2:596d:: with SMTP id h13mr1384751lfp.190.1583311665884;
 Wed, 04 Mar 2020 00:47:45 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
In-Reply-To: <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 09:47:34 +0100
Message-ID: <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
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

On Wed, 4 Mar 2020 at 02:19, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com=
> wrote:
>
>
>
> On 2020/3/4 =E4=B8=8A=E5=8D=883:52, Peter Zijlstra wrote:
> [snip]
> >> The reason is because we have group B with shares as 2, which make
> >> the group A 'cfs_rq->load.weight' very small.
> >>
> >> And in calc_group_shares() we calculate shares as:
> >>
> >>   load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_=
avg);
> >>   shares =3D (tg_shares * load) / tg_weight;
> >>
> >> Since the 'cfs_rq->load.weight' is too small, the load become 0
> >> in here, although 'tg_shares' is 102400, shares of the se which
> >> stand for group A on root cfs_rq become 2.
> >
> > Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> > B->shares/nr_cpus.
>
> Yeah, that's exactly why it happens, even the share 2 scale up to 2048,
> on 96 CPUs platform, each CPU get only 21 in equal case.
>
> >
> >> While the se of D on root cfs_rq is far more bigger than 2, so it
> >> wins the battle.
> >>
> >> This patch add a check on the zero load and make it as MIN_SHARES
> >> to fix the nonsense shares, after applied the group C wins as
> >> expected.
> >>
> >> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> >> ---
> >>  kernel/sched/fair.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 84594f8aeaf8..53d705f75fa4 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs=
_rq)
> >>      tg_shares =3D READ_ONCE(tg->shares);
> >>
> >>      load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.lo=
ad_avg);
> >> +    if (!load && cfs_rq->load.weight)
> >> +            load =3D MIN_SHARES;
> >>
> >>      tg_weight =3D atomic_long_read(&tg->load_avg);
> >
> > Yeah, I suppose that'll do. Hurmph, wants a comment though.
> >
> > But that has me looking at other users of scale_load_down(), and doesn'=
t
> > at least update_tg_cfs_load() suffer the same problem?
>
> Good point :-) I'm not sure but is scale_load_down() supposed to scale sm=
all
> value into 0? If not, maybe we should fix the helper to make sure it at
> least return some real load? like:
>
> # define scale_load_down(w) ((w + (1 << SCHED_FIXEDPOINT_SHIFT)) >> SCHED=
_FIXEDPOINT_SHIFT)

you will add +1 of nice prio for each device

should we use instead
# define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)

Regards,
Vincent

>
> Regards,
> Michael Wang
>
> >
