Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED23C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD3220801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBQPOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:14:19 -0500
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:60841 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbgBQPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:14:17 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 21E7898B12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 15:14:15 +0000 (GMT)
Received: (qmail 5293 invoked from network); 17 Feb 2020 15:14:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2020 15:14:14 -0000
Date:   Mon, 17 Feb 2020 15:14:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v3
Message-ID: <20200217151412.GK3466@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 02:49:11PM +0100, Vincent Guittot wrote:
> On Mon, 17 Feb 2020 at 11:44, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Changelog since V2:
> > o Rebase on top of Vincent's series again
> > o Fix a missed rcu_read_unlock
> > o Reduce overhead of tracepoint
> >
> > Changelog since V1:
> > o Rebase on top of Vincent's series and rework
> >
> > Note: The baseline for this series is tip/sched/core as of February
> >         12th rebased on top of v5.6-rc1. The series includes patches from
> >         Vincent as I needed to add a fix and build on top of it. Vincent's
> >         series on its own introduces performance regressions for *some*
> >         but not *all* machines so it's easily missed. This series overall
> >         is close to performance-neutral with some gains depending on the
> >         machine. However, the end result does less work on NUMA balancing
> >         and the fact that both the NUMA balancer and load balancer uses
> >         similar logic makes it much easier to understand.
> >
> > The NUMA balancer makes placement decisions on tasks that partially
> > take the load balancer into account and vice versa but there are
> > inconsistencies. This can result in placement decisions that override
> > each other leading to unnecessary migrations -- both task placement
> > and page placement. This series reconciles many of the decisions --
> > partially Vincent's work with some fixes and optimisations on top to
> > merge our two series.
> >
> > The first patch is unrelated. It's picked up by tip but was not present in
> > the tree at the time of the fork. I'm including it here because I tested
> > with it.
> >
> > The second and third patches are tracing only and was needed to get
> > sensible data out of ftrace with respect to task placement for NUMA
> > balancing. The NUMA balancer is *far* easier to analyse with the
> > patches and informed how the series should be developed.
> >
> > Patches 4-5 are Vincent's and use very similar code patterns and logic
> > between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
> > is necessary to avoid serious imbalances being introduced by the NUMA
> 
> Yes the test added in load_too_imbalanced() by patch 5 doesn't seem to
> be a good choice.

But it *did* make sense intuitively!

> I haven't remove it as it was done by your patch 6 but it might worth
> removing it directly if a new version is needed
> 

They could be folded together or part folded together but I did not see
much value in that. I felt that keeping them seperate both preserved the
development history and acted as a historical reference on why using a
spare CPU can be hazardous. I do not believe it is a bisection hazard
as performance is roughly equivalent before and after the series (so
far at least). LKP might trip up on it and if so, we'll simply ask for
confirmation that patch 6 fixes it.

-- 
Mel Gorman
SUSE Labs
