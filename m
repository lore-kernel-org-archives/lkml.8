Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E7DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12EA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXlGChI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0MqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0MqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:46:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:46:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so17372863ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J89CwVDAEoOoYoFpVHKQBHJ9NLGvboer0Vt9QxnaDtY=;
        b=lXlGChI9X8pGCBZDpMRc24gG0BNCkJiMQWAkJtFVhvNu0bCP/qnBd4tk9GKtqeu0g7
         xBfM/Iys839iGdQhOG1SWuuzusEgZ86btb2Epg4zrnuGwItOZvk7Temk0BGGqd9N9HUa
         l/s8IOMq8qvPdw5H0GGz/554Cu4PwI3qrmWSu0rRWhHlN9Dp839oDcuNQSjkZ/DCG66P
         Rz5q3e7tDTwrHw7vqndMwJPTrhcJJeh7cV8rbZG1YPQO6CoPJ7miqzvgoWINcLdumKEy
         iRRqrYVsvZ1kv5zoeFzHRNuHgbUThIsinAMXqxkorzqUc4ETAER9YQ7xcVD0WMqfCHLW
         eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J89CwVDAEoOoYoFpVHKQBHJ9NLGvboer0Vt9QxnaDtY=;
        b=d12wydXXN6892k/1JOpr/tSnEdX/3/qA9txwSWfMLAerMC0j4Ql8CIvzOYO/YKFTAR
         W2aAlqh/k+2nRmyS9u3BhtopdKczxV9LpKxxeuZWCtnuPZdw+WpgyQg85UR52jskqRfO
         d4Ziqbz3PhSbtl84slZofPOwt1EpOuaTmwCX/bIdyvQxD/gc0nUizCimcqFl9DBO+l5q
         2YN62Pv7OhlPAqZoyrD4GtXg3f9ocym+UYs8guwaAI1v53uCLpNM2PuS5Xq3Pj8nmfLs
         GXBf00iu0EQGn1M3RUg/h7J3Dt/EbY6+HlcAbCzGZX9F9ifp0AEb2qG++iSZP0lDzUd6
         Jbew==
X-Gm-Message-State: AGi0PubScoyuwGyVbJg/9BJhsVsP12++CFAeijZnkRCcL0o//u3ayKub
        p0N5tlAAD+faqlkCgK1HUWXmWhUXeix64bQFIWDi2g==
X-Google-Smtp-Source: APiQypLN1azdx4pOOPAHusAu0lNgr7uAvvTuCfwi0YEcdHhWaZXTD3yWmvFfNjzw9KVryCVF1ll1/O9++lVa+P+gjrg=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr13179366ljp.209.1587991580657;
 Mon, 27 Apr 2020 05:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004749.GC26573@shao2-debian> <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com> <20200427113533.4688-1-hdanton@sina.com>
In-Reply-To: <20200427113533.4688-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Apr 2020 14:46:07 +0200
Message-ID: <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 at 13:35, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Mon, 27 Apr 2020 11:03:58 +0200 Vincent Guittot wrote:
> > On Sun, 26 Apr 2020 at 14:42, Hillf Danton wrote:
> > >
> > > On 4/21/2020 8:47 AM, kernel test robot wrote:
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
> > > >
> > > >
> > > > commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > >
> > > > in testcase: stress-ng
> > > > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> > > > with following parameters:
> > > >
> > > >     nr_threads: 100%
> > > >     disk: 1HDD
> > > >     testtime: 1s
> > > >     class: scheduler
> > > >     cpufreq_governor: performance
> > > >     ucode: 0xb000038
> > > >     sc_pid_max: 4194304
> > > >
> > >
> > > We need to handle group_fully_busy in a different way from
> > > group_overloaded as task push does not help grow load balance
> > > in the former case.
> >
> > Have you tested this patch for the UC above ? Do you have figures ?
> >
> No I am looking for a box of 88 threads. Likely to get access to it in
> as early as three weeks.
>
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8744,30 +8744,20 @@ find_idlest_group(struct sched_domain *s
> > >
> > >         switch (local_sgs.group_type) {
> > >         case group_overloaded:
> > > -       case group_fully_busy:
> > > -               /*
> > > -                * When comparing groups across NUMA domains, it's possible for
> > > -                * the local domain to be very lightly loaded relative to the
> > > -                * remote domains but "imbalance" skews the comparison making
> > > -                * remote CPUs look much more favourable. When considering
> > > -                * cross-domain, add imbalance to the load on the remote node
> > > -                * and consider staying local.
> > > -                */
> > > -
> > > -               if ((sd->flags & SD_NUMA) &&
> > > -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
> > > +               if (100 * local_sgs.avg_load <= sd->imbalance_pct * (idlest_sgs.avg_load + imbalance))
> > > +                       return idlest;
> >
> > So you have completely removed the NUMA special case without explaining why.
> >
> That was for the local domain that is lightly loaded, as the comment says,
> it now is overloaded.

The load value is not linked to the overloaded state of the group as
you can be overloaded but still have a low load especially with cgroup

That's also why there are 2 type of comparison:
an absolute comparison for low load value
and a proportional comparison for normal/high value

>
> > And you have also removed the tests for small load.
> >
> It is a heuristic I want to avoid. It can be replaced with the load of the
> task in question as best effort.
>
> > Could you explain the rationale behind all these changes ?
> >
> > Also keep in mind that the current version provide +58% improvement
> > for  stress-ng.fifo
> >
> Yes it's great. I'm on the minor one.
>
> > > +               if (local_sgs.avg_load > idlest_sgs.avg_load + imbalance)
> > > +                       return idlest;
> > > +               else
> > >                         return NULL;
> > >
> > > +       case group_fully_busy:
> > >                 /*
> > > -                * If the local group is less loaded than the selected
> > > -                * idlest group don't try and push any tasks.
> > > +                * Pushing task to the idlest group will make the target group
> > > +                * overloaded, leaving the local group that is overloaded fully busy,
> > > +                * thus we earn nothing except for the exchange of group types.
> >
> > For this case both local and idlest are fully busy and in this case
> > one will become overloaded so you must compare the load to be fair in
> > the spread of load
> >
> It may be sooner than thought that the newly overloaded group is looking to
> push task out, and we'll see a task ping-pong if it happens.
>
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8683,15 +8683,11 @@ find_idlest_group(struct sched_domain *s
>         struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>         struct sg_lb_stats local_sgs, tmp_sgs;
>         struct sg_lb_stats *sgs;
> -       unsigned long imbalance;
>         struct sg_lb_stats idlest_sgs = {
>                         .avg_load = UINT_MAX,
>                         .group_type = group_overloaded,
>         };
>
> -       imbalance = scale_load_down(NICE_0_LOAD) *
> -                               (sd->imbalance_pct-100) / 100;
> -
>         do {
>                 int local_group;
>
> @@ -8743,31 +8739,26 @@ find_idlest_group(struct sched_domain *s
>                 return idlest;
>
>         switch (local_sgs.group_type) {
> -       case group_overloaded:
>         case group_fully_busy:
> -               /*
> -                * When comparing groups across NUMA domains, it's possible for
> -                * the local domain to be very lightly loaded relative to the
> -                * remote domains but "imbalance" skews the comparison making
> -                * remote CPUs look much more favourable. When considering
> -                * cross-domain, add imbalance to the load on the remote node
> -                * and consider staying local.
> -                */
> -
> -               if ((sd->flags & SD_NUMA) &&
> -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
> -                       return NULL;
> -
> -               /*
> -                * If the local group is less loaded than the selected
> -                * idlest group don't try and push any tasks.
> -                */
> -               if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
> -                       return NULL;
> -
> -               if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
> -                       return NULL;
> -               break;
> +               return NULL;
> +       case group_overloaded:
> +               /* No push if balanced */
> +               if (100 * local_sgs.avg_load > sd->imbalance_pct *
> +                                               idlest_sgs.avg_load) {
> +                       unsigned long avg_load;
> +
> +                       avg_load = task_h_load(p) + idlest_sgs.group_load;
> +                       avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
> +                                               idlest_sgs.group_capacity;
> +
> +                       if (100 * local_sgs.avg_load <= sd->imbalance_pct *
> +                                                               avg_load)
> +                               return idlest;
> +
> +                       if (local_sgs.avg_load > avg_load)
> +                               return idlest;
> +               }
> +               return NULL;
>
>         case group_imbalanced:
>         case group_asym_packing:
>
