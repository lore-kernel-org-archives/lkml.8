Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6F3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DE120775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0J5xjgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCXKfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:35:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36507 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCXKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:35:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so18006179ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LHYyFGD9Er8JMcaofOCqcMt+HKxQKQvAYYRYfkCj9U=;
        b=Y0J5xjgAnUnYrUo8xGTuOnthRalZYZyLc4M3fa5aGrwS3WhV5JEKs7Rp8QaynTxHPr
         WH/lM9Ec2U/Dnz++lSfQZvBdMbxXUUnbdFe0cMA6wxvs72X3p392jPwmg4oBLuVeIfDh
         0uhPjACF0EBl+Idcbp3SFfFUc4c3PJH0cDhwvFXErP9tOAPHyofkZHiNbFtesJKXX1cH
         moJkxKk/MrrnYJ2AlgMaEZ1M+3DykMsA7jPUu+wxiIjpuycIbCPG39junbMgi9BQRDV8
         0nQGIay3/5dB7hHS65JHEbVhYrRD9+qCskyZyL+RtzIu5JD++3LNvkPlhI7JIIRFthp4
         cgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LHYyFGD9Er8JMcaofOCqcMt+HKxQKQvAYYRYfkCj9U=;
        b=eMXBilp1LRHAziFOR3aS0U1hYuqqChn0KVfYsNFYmDv9FDpo/r1ub/CLjQsPuAmy9f
         aPNoWMvT152yrdZYx2AWNqiObOu9I+i/Yoh0sQT8aKyVCGRw4v71OF7UG9SJmz15+woA
         ogHxHRRV4RgM/ELknscU8IK+742zYE0vLYMCgame+Poy89q3InnXX5/lYncGzm28Rtyk
         203bL8S13guhF5dF6KmHxa6loXHDlpEhdA+p1B4xWiXuSxmI/Qtm2u0RqcPsfAcaZuGP
         Hdkj3QH32drSj2Ko7uSpeqzWKIQNyzorGWI9AmeJ42B2pJ+7fIq4XbKF7zoMJJHkyg4w
         +0MA==
X-Gm-Message-State: ANhLgQ3HQ43m/Lz6WhZPleAvZQhZk3geKpgjgMFrg0sAMM7iN5be7tLW
        tg+O62aI59Sf0aMvyx31FcPUHP540h0fzMknv6lRSg==
X-Google-Smtp-Source: ADFU+vsM2m8/z81QygyaT/ce4V34TY21p1mB2AC1wH972BTitDk7DVBGXUuxoK3NjpJx62o1qCQQF34ZYpU3WdoUz4E=
X-Received: by 2002:a2e:9091:: with SMTP id l17mr15600874ljg.154.1585046119623;
 Tue, 24 Mar 2020 03:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-5-mgorman@techsingularity.net> <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
 <20200320164432.GE3818@techsingularity.net> <CAKfTPtBixZKDES_i3Lnsj1eAa_kVi-zHv-0uE8uTsKOBcjmkYg@mail.gmail.com>
 <20200320174304.GF3818@techsingularity.net>
In-Reply-To: <20200320174304.GF3818@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Mar 2020 11:35:08 +0100
Message-ID: <CAKfTPtBQ5Y5CAtbJ2YSVxFtQWUVsdxTLjz+NxTHcLj-UnAQWqg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 18:43, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 20, 2020 at 05:54:57PM +0100, Vincent Guittot wrote:
> > On Fri, 20 Mar 2020 at 17:44, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Fri, Mar 20, 2020 at 04:48:39PM +0100, Vincent Guittot wrote:
> > > > > ---
> > > > >  include/linux/sched/topology.h |  1 +
> > > > >  kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++---
> > > > >  kernel/sched/features.h        |  3 ++
> > > > >  3 files changed, 65 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > > > index af9319e4cfb9..76ec7a54f57b 100644
> > > > > --- a/include/linux/sched/topology.h
> > > > > +++ b/include/linux/sched/topology.h
> > > > > @@ -66,6 +66,7 @@ struct sched_domain_shared {
> > > > >         atomic_t        ref;
> > > > >         atomic_t        nr_busy_cpus;
> > > > >         int             has_idle_cores;
> > > > > +       int             is_overloaded;
> > > >
> > > > Can't nr_busy_cpus compared to sd->span_weight give you similar status  ?
> > > >
> > >
> > > It's connected to nohz balancing and I didn't see how I could use that
> > > for detecting overload. Also, I don't think it ever can be larger than
> > > the sd weight and overload is based on the number of running tasks being
> > > greater than the number of available CPUs. Did I miss something obvious?
> >
> > IIUC you try to estimate if there is a chance to find an idle cpu
> > before starting the loop and scanning the domain and abort early if
> > the possibility is low.
> >
> > if nr_busy_cpus equals to sd->span_weight it means that there is no
> > free cpu so there is no need to scan
> >
>
> Ok, I see what you are getting at but I worry there are multiple
> problems there. First, the nr_busy_cpus is decremented only when a CPU
> is entering idle with the tick stopped. If nohz is disabled then this
> breaks, no? Secondly, a CPU can be idle but the tick not stopped if

But this can be changed if that make the statistic useful

> __tick_nohz_idle_stop_tick knows there is an event in the near future
> so using busy_cpus, we potentially miss a sibling that was adequate
> for running a task. Finally, the threshold for cutting off the search
> entirely seems low. The patch marks a domain as overloaded if there are
> twice as many running tasks as runqueues scanned. In that scenario, even
> if tasks are rapidly switching between busy/idle, it's still unlikely
> the task will go idle. When cutting off at just the fully-busy mark, we
> could miss a CPU that is going idle, almost idle or is running SCHED_IDLE
> tasks where are acceptable target candidates for select_idle_sibling. I
> think there are too many cases where nr_busy_cpus are problematic to
> make it a good alternative.

I don't really like this patch because it adds yet another metrics and
yet another feature which is set true by default. Also the current
proposal seems a bit fragile because it uses an arbitrary ratio of 2
on an arbitrary number of CPUs. This threshold probably works in your
case and your system but probably not for others and the threshold
really looks like a heuristic that works for you but without any real
meaning.

Then, the update is done at each and every task wake up and by all
CPUs in the LLC. It means that the same variable is updated
simultaneously by all CPUs: one CPU can set it and the next one might
clear it immediately because they haven't scanned the same CPUs. At
the end, 2 threads waking up simultaneously on different CPUS, might
end up using 2 different policy without any other reason than a random
ordering.

I agree that the concept of detecting that a LLC domain is overloaded
can be useful to decide to skip searching for an idle cpu but this
proposal seems to be not really generic

Vincent

>
> --
> Mel Gorman
> SUSE Labs
