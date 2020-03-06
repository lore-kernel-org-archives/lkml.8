Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E47C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844EA20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubyOpI4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFIFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:05:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCFIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:04:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id q10so390505lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fLE8ZB0HcdjSfZLQxo/1fQfJtjwlBtD1VH7kpiLR0+U=;
        b=ubyOpI4n/mJYTfePXj71eIIUihGJ0P4fMrcL6n/0PI+CqLaiccgc49MPT5esrzfNpB
         pzbhrGKr9srrRxHAhCWYuRdHcCdVvlSCRiqvBQUzSxjlsa36dIkJVCNLm36EAZKFgEAu
         4FiUFMtWwpi0Z3SFZpmJhyEjo9DLoD+fwXsvalNTY869wqWk1xpBmmoNFLxXRaZ56LM9
         0pNwRfFaP63NG0zZShr3RYpfqlFigjS1HOE3Rx24rtWEChFumyVv6lttj6jhKQgDKqWi
         rX2uoAuWsCWk/igE3xH8cOmj45c2VykOiDZtf6CmZHppejbEzuSCLfN6EZHUfY9YeHGP
         I3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fLE8ZB0HcdjSfZLQxo/1fQfJtjwlBtD1VH7kpiLR0+U=;
        b=SYaliZpj+FjM537eCCWzbwUXlW4abpvuONxmLi/2QQh+BLtodT/VZdsQPN+3JqRrjF
         WuHlxry8WRFX7uGCrI3H03GpccWSk7PUFH33v0fuXc6T80YLIiY0MYZ536KXbuiY81By
         f3tlsEV4HeZmU0UTTvdXBKYJtlH2TvMkDdXLarAC1s4Yij03geSKsqVVcyoljYLBg/qL
         TmiZAJLyqfcnsSNRtZK/QA0cicCnix9RsMjKAIx7X6C404Trw9+NzZq1gCk27K4Nd146
         mRnRLV9EUPmLNOFcLulCC9XEouj88kg+7+KuD2GkAElIhI/hJ6lZZ2tFGoQ8+TfhQ+I6
         riRg==
X-Gm-Message-State: ANhLgQ0SV9Avn4hSKtiIvQVOgpe1G10cAC5K1zAqUMGJ8+ZohpyS9jm9
        F1fTne7CRviXpRk/9opAt/7Ytozh0T2jifxCc1GSXA==
X-Google-Smtp-Source: ADFU+vtcCP7wZXpoGJgY8z3oL0kLxWxNaNnpjMP2QKMfN5ClCK5bIngcZ78bQu0ikmFi0cBfv2hxNzL6vFuxtaNJOT4=
X-Received: by 2002:a19:428a:: with SMTP id p132mr1151971lfa.189.1583481896994;
 Fri, 06 Mar 2020 00:04:56 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
 <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com> <CAKfTPtCaPz2KBmagzpEurh5S9aNFzUomHGh1pDWBx6L_29w5hw@mail.gmail.com>
 <12f79b83-491c-4b4b-0581-d23bdcec7c0c@linux.alibaba.com>
In-Reply-To: <12f79b83-491c-4b4b-0581-d23bdcec7c0c@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Mar 2020 09:04:45 +0100
Message-ID: <CAKfTPtD+He8UULUavz0csUeUV3TBdjShV9kUPQY6rpLswUAm4g@mail.gmail.com>
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

On Fri, 6 Mar 2020 at 05:23, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com=
> wrote:
>
>
>
> On 2020/3/5 =E4=B8=8B=E5=8D=883:53, Vincent Guittot wrote:
> > On Thu, 5 Mar 2020 at 02:14, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba=
.com> wrote:
> [snip]
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index fcc968669aea..6d7a9d72d742 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cf=
s_rq)
> >>>         long tg_weight, tg_shares, load, shares;
> >>>         struct task_group *tg =3D cfs_rq->tg;
> >>>
> >>> -       tg_shares =3D READ_ONCE(tg->shares);
> >>> +       tg_shares =3D scale_load_down(READ_ONCE(tg->shares));
> >>>
> >>> -       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->av=
g.load_avg);
> >>> +       load =3D max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load=
_avg));
> >>>
> >>>         tg_weight =3D atomic_long_read(&tg->load_avg);
> >>
> >> Get the point, but IMHO fix scale_load_down() sounds better, to
> >> cover all the similar cases, let's first try that way see if it's
> >> working :-)
> >
> > The problem with this solution is that the avg.load_avg of gse or
> > cfs_rq might stay to 0 because it uses
> > scale_load_down(se/cfs_rq->load.weight)
>
> Will cfs_rq->load.weight be zero too without scale down?

cfs_rq->load.weight will never be 0, it's min is 2

>
> If cfs_rq->load.weight got at least something, the load will not be
> zero after pick the max, correct?

But the cfs_rq->avg.load_avg will never be other than 0 what ever
there are heavy or light tasks in the group

>
> Regards,
> Michael Wang
>
> >
> >>
> >> Regards,
> >> Michael Wang
> >>
> >>>
> >>>
> >>>
