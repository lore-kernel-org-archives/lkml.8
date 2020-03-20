Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB19C43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F10520767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCTRnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:43:10 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:39483 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgCTRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:43:09 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id B5E5CBEBC0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:43:06 +0000 (GMT)
Received: (qmail 24761 invoked from network); 20 Mar 2020 17:43:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Mar 2020 17:43:06 -0000
Date:   Fri, 20 Mar 2020 17:43:04 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
Message-ID: <20200320174304.GF3818@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-5-mgorman@techsingularity.net>
 <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
 <20200320164432.GE3818@techsingularity.net>
 <CAKfTPtBixZKDES_i3Lnsj1eAa_kVi-zHv-0uE8uTsKOBcjmkYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBixZKDES_i3Lnsj1eAa_kVi-zHv-0uE8uTsKOBcjmkYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 05:54:57PM +0100, Vincent Guittot wrote:
> On Fri, 20 Mar 2020 at 17:44, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Mar 20, 2020 at 04:48:39PM +0100, Vincent Guittot wrote:
> > > > ---
> > > >  include/linux/sched/topology.h |  1 +
> > > >  kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++---
> > > >  kernel/sched/features.h        |  3 ++
> > > >  3 files changed, 65 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > > index af9319e4cfb9..76ec7a54f57b 100644
> > > > --- a/include/linux/sched/topology.h
> > > > +++ b/include/linux/sched/topology.h
> > > > @@ -66,6 +66,7 @@ struct sched_domain_shared {
> > > >         atomic_t        ref;
> > > >         atomic_t        nr_busy_cpus;
> > > >         int             has_idle_cores;
> > > > +       int             is_overloaded;
> > >
> > > Can't nr_busy_cpus compared to sd->span_weight give you similar status  ?
> > >
> >
> > It's connected to nohz balancing and I didn't see how I could use that
> > for detecting overload. Also, I don't think it ever can be larger than
> > the sd weight and overload is based on the number of running tasks being
> > greater than the number of available CPUs. Did I miss something obvious?
> 
> IIUC you try to estimate if there is a chance to find an idle cpu
> before starting the loop and scanning the domain and abort early if
> the possibility is low.
> 
> if nr_busy_cpus equals to sd->span_weight it means that there is no
> free cpu so there is no need to scan
> 

Ok, I see what you are getting at but I worry there are multiple
problems there. First, the nr_busy_cpus is decremented only when a CPU
is entering idle with the tick stopped. If nohz is disabled then this
breaks, no? Secondly, a CPU can be idle but the tick not stopped if
__tick_nohz_idle_stop_tick knows there is an event in the near future
so using busy_cpus, we potentially miss a sibling that was adequate
for running a task. Finally, the threshold for cutting off the search
entirely seems low. The patch marks a domain as overloaded if there are
twice as many running tasks as runqueues scanned. In that scenario, even
if tasks are rapidly switching between busy/idle, it's still unlikely
the task will go idle. When cutting off at just the fully-busy mark, we
could miss a CPU that is going idle, almost idle or is running SCHED_IDLE
tasks where are acceptable target candidates for select_idle_sibling. I
think there are too many cases where nr_busy_cpus are problematic to
make it a good alternative.

-- 
Mel Gorman
SUSE Labs
