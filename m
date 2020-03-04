Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB312166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uH3qiFZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbgCDIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:45:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42498 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:45:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id q19so1048443ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sea6ZhU2GGB1AnbzYLZryaue2vcZ5ldrKLoTAqsWg0c=;
        b=uH3qiFZXtw6gTIgDCr977zfmx0cZNoCq5OB4AUDDUXYw7OWlNXcNBymVOdHxO0SA8j
         hx+AutEenRVeSkd5FJ6RTpr0zHkS+3BOfhnJk/UZwiE1cmvY8dkHSFQqTmOXlINm57mx
         +aj37uXboO+VzD7sIswLhIklM3YQb9mLOthij6Q2zvu5bwEZOQImGIM+sUjrLDRp4EBT
         iN7tt9CWZgjS5FFWmfZMhmJxlyIBwzj7ouJ/P4UOQS0HHl9XYN9t0RaXgxsxVzedDlUP
         fjmdRMPPdxpMBfS1YkB0Hq69VyVTUhPVMDVFV9572rm/eJ2YcpsnhDiD0yTrBgSIKbdx
         wK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sea6ZhU2GGB1AnbzYLZryaue2vcZ5ldrKLoTAqsWg0c=;
        b=oN0E5Cu5sNw4RC+gW6BNoNTXZl/367gH7hccnuMT/Nz0+1PVTmUvnD/J1T8zOHGqvl
         qYyex/QLM/7mm/lAM4XbZN1h3SYxpiODKyWkxPrT/T28lIn+KJ7Ce4PY8ifwKpz05abl
         tkJ6nHlirs5JCJJrNfhykgdcLnlI/M58Dyvt3JuT0+tRtr2VfPvrtrKgWnqyXebkeK4O
         bLWySsBzU0NyZuSOtgVhmeRxHRbFXfs0qBlh0mScALXVcJt5QGC9AD/UMZIYJkssY/Tx
         BcjPu6dxAdPKBmUit3u3BprrCMm2qX8XOifzxBxChsiLHr/fPLqmXFOxXHGyfzNGIjS2
         /b3w==
X-Gm-Message-State: ANhLgQ0oE6hRN5SWsglUjhiNKShzfq9Sr7XmwEEHZ1mmTuu+TRkXQbng
        hsu/bwXTH/a69F5rU6krYwZHYsghIQw2ZPjkgnQ1pSKF49I=
X-Google-Smtp-Source: ADFU+vsbeKfNuhfhcCZ4tNePu3pR88FZxTNOPVmcKIYiwq/7XbxMZ3ywBRzUBRmWMYVDAiTGGc7JSTesPq5yBawub38=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr1246842ljg.154.1583311555647;
 Wed, 04 Mar 2020 00:45:55 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com> <20200303195245.GF2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200303195245.GF2596@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 09:45:44 +0100
Message-ID: <CAKfTPtCPTcfFs2OjaY9O2BtSZ_M6Gr-rGgFO2b8-wfvQWAZ1Zg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
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

On Tue, 3 Mar 2020 at 20:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 03, 2020 at 10:17:03PM +0800, =E7=8E=8B=E8=B4=87 wrote:
> > During our testing, we found a case that shares no longer
> > working correctly, the cgroup topology is like:
> >
> >   /sys/fs/cgroup/cpu/A                (shares=3D102400)
> >   /sys/fs/cgroup/cpu/A/B      (shares=3D2)
> >   /sys/fs/cgroup/cpu/A/B/C    (shares=3D1024)
> >
> >   /sys/fs/cgroup/cpu/D                (shares=3D1024)
> >   /sys/fs/cgroup/cpu/D/E      (shares=3D1024)
> >   /sys/fs/cgroup/cpu/D/E/F    (shares=3D1024)
> >
> > The same benchmark is running in group C & F, no other tasks are
> > running, the benchmark is capable to consumed all the CPUs.
> >
> > We suppose the group C will win more CPU resources since it could
> > enjoy all the shares of group A, but it's F who wins much more.
> >
> > The reason is because we have group B with shares as 2, which make
> > the group A 'cfs_rq->load.weight' very small.
> >
> > And in calc_group_shares() we calculate shares as:
> >
> >   load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_a=
vg);
> >   shares =3D (tg_shares * load) / tg_weight;
> >
> > Since the 'cfs_rq->load.weight' is too small, the load become 0
> > in here, although 'tg_shares' is 102400, shares of the se which
> > stand for group A on root cfs_rq become 2.
>
> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> B->shares/nr_cpus.
>
> > While the se of D on root cfs_rq is far more bigger than 2, so it
> > wins the battle.
> >
> > This patch add a check on the zero load and make it as MIN_SHARES
> > to fix the nonsense shares, after applied the group C wins as
> > expected.
> >
> > Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > ---
> >  kernel/sched/fair.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 84594f8aeaf8..53d705f75fa4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_=
rq)
> >       tg_shares =3D READ_ONCE(tg->shares);
> >
> >       load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.lo=
ad_avg);
> > +     if (!load && cfs_rq->load.weight)
> > +             load =3D MIN_SHARES;
> >
> >       tg_weight =3D atomic_long_read(&tg->load_avg);
>
> Yeah, I suppose that'll do. Hurmph, wants a comment though.
>
> But that has me looking at other users of scale_load_down(), and doesn't
> at least update_tg_cfs_load() suffer the same problem?

yes and other places like the load_avg that will stay to 0 or the fact
that weight !=3D 0 is used to assume that se on enqueued and to not
remove the cfs from the leaf_cfs_rq_list even if load_avg is null
