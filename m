Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12908C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927A207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="at3VFiob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgCEHyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:54:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34147 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCEHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:54:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so2686470lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Vo7v3A29qLhL95wUBh6dD5eErodqSEdH9NgC3IKBcE=;
        b=at3VFiobWlcoKRKBqRBBR4dPdUy3MfwRIWfL32V4+Pk6F99EfdSqYf+kYqbcV2BvtU
         tIJvg/rCUgDZjkA2ILJi4FARJ3yGpcd3ZtHC6g7PAnxpGyujHbX/gSVrnbj+AGTR8ALc
         i8MxK21jFKMsK0ThiSwUeWimpHeqLC+AJKlxrq07rxnPvmS4yClqY+84bE4Q5nCavZKA
         MG8wDrOmXuBynBjcm1hhgM9w02ANxVUggNxgGj4PvkZ/608SORfPit9fVOhkMnMZg8r1
         6zC/HbIfZv6843V1Vxs6jIvxfKIfyruOZSH8EA6h8ZlqMqzzDJZN9d8jLId9wLFcofHg
         QZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Vo7v3A29qLhL95wUBh6dD5eErodqSEdH9NgC3IKBcE=;
        b=ltZRxQn+t84ejo4d8ME+yVlNDqBDvt7qYdeqVMed3gpeDXB4ieYoafldpg2C5eWeGm
         /NClj5xCLjFMCM1Vr1DyGGmXV/5A3B8vXF6Jm9CeW3tc6gKURJPGjUi9q4iyDIbmxfzp
         PArn4+FF+b4DfnhG0Uh4SE/qspSxIj7tLtFWieBr8WNdqHWs3B3W6fQ7DZecZDasu86P
         TCa+22MkF5QN8J99TAq1VDyqv7T24koFoUWXZWOElvhYuWNDdG+SfFucLIQbvjCXbRCS
         BS/U5QoKBIIZ324xWJmtLTl1BjFZ+ar3D1C722thWdZKscH+cHZNo6UWEiVpOQq4INir
         7Wyw==
X-Gm-Message-State: ANhLgQ0YGunt5F7fbMqSOldAVw1zgpmAjpV8DsQPpZdY8wec5ksXoIi2
        uVNgjOE57MLF0dyRM4g8gq1OkDtPpT3GyIvXd8m2tw==
X-Google-Smtp-Source: ADFU+vsQDhS1NhOYmtoB78Cs8xlsOI8ptRgqAIR3/ipW5v26RatXCDeMFuI3GYDNWZRyE9zz89U+6tFqiv6toQpK054=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr4198517ljg.154.1583394839550;
 Wed, 04 Mar 2020 23:53:59 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
 <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
In-Reply-To: <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Mar 2020 08:53:48 +0100
Message-ID: <CAKfTPtCaPz2KBmagzpEurh5S9aNFzUomHGh1pDWBx6L_29w5hw@mail.gmail.com>
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

On Thu, 5 Mar 2020 at 02:14, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com=
> wrote:
>
>
>
> On 2020/3/5 =E4=B8=8A=E5=8D=882:47, bsegall@google.com wrote:
> [snip]
> >> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> >> B->shares/nr_cpus.
> >>
> >>> While the se of D on root cfs_rq is far more bigger than 2, so it
> >>> wins the battle.
> >>>
> >>> This patch add a check on the zero load and make it as MIN_SHARES
> >>> to fix the nonsense shares, after applied the group C wins as
> >>> expected.
> >>>
> >>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> >>> ---
> >>>  kernel/sched/fair.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 84594f8aeaf8..53d705f75fa4 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cf=
s_rq)
> >>>     tg_shares =3D READ_ONCE(tg->shares);
> >>>
> >>>     load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.lo=
ad_avg);
> >>> +   if (!load && cfs_rq->load.weight)
> >>> +           load =3D MIN_SHARES;
> >>>
> >>>     tg_weight =3D atomic_long_read(&tg->load_avg);
> >>
> >> Yeah, I suppose that'll do. Hurmph, wants a comment though.
> >>
> >> But that has me looking at other users of scale_load_down(), and doesn=
't
> >> at least update_tg_cfs_load() suffer the same problem?
> >
> > I think instead we should probably scale_load_down(tg_shares) and
> > scale_load(load_avg). tg_shares is always a scaled integer, so just
> > moving the source of the scaling in the multiply should do the job.
> >
> > ie
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fcc968669aea..6d7a9d72d742 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs_=
rq)
> >         long tg_weight, tg_shares, load, shares;
> >         struct task_group *tg =3D cfs_rq->tg;
> >
> > -       tg_shares =3D READ_ONCE(tg->shares);
> > +       tg_shares =3D scale_load_down(READ_ONCE(tg->shares));
> >
> > -       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.=
load_avg);
> > +       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_a=
vg));
> >
> >         tg_weight =3D atomic_long_read(&tg->load_avg);
>
> Get the point, but IMHO fix scale_load_down() sounds better, to
> cover all the similar cases, let's first try that way see if it's
> working :-)

The problem with this solution is that the avg.load_avg of gse or
cfs_rq might stay to 0 because it uses
scale_load_down(se/cfs_rq->load.weight)

>
> Regards,
> Michael Wang
>
> >
> >
> >
