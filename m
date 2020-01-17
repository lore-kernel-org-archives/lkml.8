Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9156CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA7D2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgAQO0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:26:34 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:37406 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727011AbgAQO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:26:34 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id D59F41C3E23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:26:30 +0000 (GMT)
Received: (qmail 18746 invoked from network); 17 Jan 2020 14:26:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2020 14:26:30 -0000
Date:   Fri, 17 Jan 2020 14:26:28 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117142628.GR3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
 <CAKfTPtBROKKtTkz55McjJo6b=Qq0QRVckFe2fQS2kdxf8kCJLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBROKKtTkz55McjJo6b=Qq0QRVckFe2fQS2kdxf8kCJLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:16:15PM +0100, Vincent Guittot wrote:
> > A more interesting example is the Facebook schbench which uses a
> > number of messaging threads to communicate with worker threads. In this
> > configuration, one messaging thread is used per NUMA node and the number of
> > worker threads is varied. The 50, 75, 90, 95, 99, 99.5 and 99.9 percentiles
> > for response latency is then reported.
> >
> > Lat 50.00th-qrtle-1        44.00 (   0.00%)       37.00 (  15.91%)
> > Lat 75.00th-qrtle-1        53.00 (   0.00%)       41.00 (  22.64%)
> > Lat 90.00th-qrtle-1        57.00 (   0.00%)       42.00 (  26.32%)
> > Lat 95.00th-qrtle-1        63.00 (   0.00%)       43.00 (  31.75%)
> > Lat 99.00th-qrtle-1        76.00 (   0.00%)       51.00 (  32.89%)
> > Lat 99.50th-qrtle-1        89.00 (   0.00%)       52.00 (  41.57%)
> > Lat 99.90th-qrtle-1        98.00 (   0.00%)       55.00 (  43.88%)
> 
> Which parameter changes between above and below tests ?
> 
> > Lat 50.00th-qrtle-2        42.00 (   0.00%)       42.00 (   0.00%)
> > Lat 75.00th-qrtle-2        48.00 (   0.00%)       47.00 (   2.08%)
> > Lat 90.00th-qrtle-2        53.00 (   0.00%)       52.00 (   1.89%)
> > Lat 95.00th-qrtle-2        55.00 (   0.00%)       53.00 (   3.64%)
> > Lat 99.00th-qrtle-2        62.00 (   0.00%)       60.00 (   3.23%)
> > Lat 99.50th-qrtle-2        63.00 (   0.00%)       63.00 (   0.00%)
> > Lat 99.90th-qrtle-2        68.00 (   0.00%)       66.00 (   2.94%
> >

The number of worker pool threads. Above is 1 worker thread, below is 2.

> > @@ -8691,16 +8687,37 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                         env->migration_type = migrate_task;
> >                         lsub_positive(&nr_diff, local->sum_nr_running);
> >                         env->imbalance = nr_diff >> 1;
> > -                       return;
> > -               }
> > +               } else {
> >
> > -               /*
> > -                * If there is no overload, we just want to even the number of
> > -                * idle cpus.
> > -                */
> > -               env->migration_type = migrate_task;
> > -               env->imbalance = max_t(long, 0, (local->idle_cpus -
> > +                       /*
> > +                        * If there is no overload, we just want to even the number of
> > +                        * idle cpus.
> > +                        */
> > +                       env->migration_type = migrate_task;
> > +                       env->imbalance = max_t(long, 0, (local->idle_cpus -
> >                                                  busiest->idle_cpus) >> 1);
> > +               }
> > +
> > +               /* Consider allowing a small imbalance between NUMA groups */
> > +               if (env->sd->flags & SD_NUMA) {
> > +                       unsigned int imbalance_min;
> > +
> > +                       /*
> > +                        * Compute an allowed imbalance based on a simple
> > +                        * pair of communicating tasks that should remain
> > +                        * local and ignore them.
> > +                        *
> > +                        * NOTE: Generally this would have been based on
> > +                        * the domain size and this was evaluated. However,
> > +                        * the benefit is similar across a range of workloads
> > +                        * and machines but scaling by the domain size adds
> > +                        * the risk that lower domains have to be rebalanced.
> > +                        */
> > +                       imbalance_min = 2;
> > +                       if (busiest->sum_nr_running <= imbalance_min)
> > +                               env->imbalance = 0;
> 
> Out of curiosity why have you decided to use the above instead of
>   env->imbalance -= min(env->imbalance, imbalance_adj);
> 
> Have you seen perf regression with the min ?
> 

I didn't see a regression with min() but at this point, we're only
dealing with the case of ignoring a small imbalance when the busiest
group is almost completely idle. The distinction between using min and
just ignoring the imbalance is almost irrevelant in that case.

-- 
Mel Gorman
SUSE Labs
