Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9157C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E096206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEVLFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:05:09 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:35969 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgEVLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:05:07 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id A65B1FAE8A
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:05:02 +0100 (IST)
Received: (qmail 6893 invoked from network); 22 May 2020 11:05:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 May 2020 11:05:02 -0000
Date:   Fri, 22 May 2020 12:05:00 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        "aokuliar@redhat.com" <aokuliar@redhat.com>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200522110500.GD7167@techsingularity.net>
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com>
 <20200508034741.13036-1-hdanton@sina.com>
 <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com>
 <20200519043154.10876-1-hdanton@sina.com>
 <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
 <20200521140931.15232-1-hdanton@sina.com>
 <20200522010950.3336-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200522010950.3336-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:09:50AM +0800, Hillf Danton wrote:
> 
> On Thu, 21 May 2020 17:04:08 +0100 Mel Gorman wrote:
> > On Thu, May 21, 2020 at 10:09:31PM +0800, Hillf Danton wrote:
> > > > I'm ignoring the coding style of c++ comments but minimally that should
> > > > be fixed. More importantly, node_type can be one of node_overloaded,
> > > > node_has_spare or node_fully busy and this is checking if there is a
> > > > mismatch. However, it's not taking into account whether the dst_node
> > > > is more or less loaded than the src and does not appear to be actually
> > > > checking spare capacity like the comment suggests.
> > > > 
> > >
> > > Type other than node_has_spare is not considered because node is not
> > > possible to be so idle that two communicating tasks would better
> > > "stay local."
> > > 
> > 
> > You hardcode an imbalance of 2 at the start without computing any
> > imbalance.
> 
> Same result comes up if it's a bool.
> 

Then the magic number is simply confusing. The patch needs to be
a lot clearer about what the intent is if my patch that adds a "if
(env->src_stats.node_type == node_has_spare)" check is not what you were
aiming for.

> > Then if the source is fully_busy or overloaded while the
> > dst is idle, a task can move but that is based on an imaginary hard-coded
> > imbalance of 2.
> 
> This is the potpit I walked around by checking spare capacity first. As
> for overloaded, I see it as a signal that a glitch is not idle somewhere
> else, and I prefer to push it in to ICU before it's too late.
> 

The domain could be overloaded simply due to CPU bindings. I cannot
parse the ICU comment (Intensive Care Unit?!?) :(

> > Finally, it appears that that the load balancer and
> > NUMA balancer are again using separate logic again when one part of the
> > objective of the series is that the load balancer and NUMA balancer would
> > not override each other.
> 
> This explains 80% of why it is a choppy road ahead.
> 

And I don't think we should go back to the load balancer and NUMA balancer
taking different actions. It ends up doing useless CPU migrations and
can lead to higher NUMA scanning activity. It's partially why I changed
task_numa_compare to prefer swapping with tasks that move to their
preferred node when using an idle CPU would cause an imbalance.

> > As the imbalance is never computed, the patch
> > can create one which the load balancer then overrides. What am I missing?
> 
> LB would give a green light if things move in the direction in favor of
> cutting imb.
> 

Load balancing primarily cares about balancing the number of idle CPUs
between domains when there is spare capacity. While it tries to avoid
balancing by moving tasks from their preferred node, it will do so if
there are no other candidates.

> > > > <SNIP>
> > > >
> > > > Then there is this part
> > > > 
> > > > +               imbalance = adjust_numa_imbalance(imbalance,
> > > > +                                               env->src_stats.nr_running);
> > > > +
> > > > +               //Do nothing without imbalance
> > > > +               if (!imbalance) {
> > > > +                       imbalance = 2;
> > > > +                       goto check_imb;
> > > > +               }
> > > > 
> > > > So... if there is no imbalance, assume there is an imbalance of 2, jump to
> > > > a branch that will always be false and fall through to code that ignores
> > > > the value of imbalance ...... it's hard to see exactly why that code flow
> > > > is ideal.
> > > > 
> > > With spare capacity be certain, then lets see how idle the node is.
> > 
> > But you no longer check how idle it is or what it's relative idleness of
> > the destination is relative to the source. adjust_numa_imbalance does
> > not calculate an imbalance, it only decides whether it should be
> > ignored.
> 
> Then the idle CPU is no longer so tempting.
> 

True. While it's prefectly possible to ignore imbalance and use an idle
CPU if it exists, the load balancer will simply override it later and we
go back to the NUMA balancer and load balancer fighting each other with
the NUMA balancer retrying migrations based on p->numa_migrate_retry.
Whatever logic is used to allow imbalances (be they based on communicating
tasks or preferred locality), it needs to be the same in both balancers.

-- 
Mel Gorman
SUSE Labs
