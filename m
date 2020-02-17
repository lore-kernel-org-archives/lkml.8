Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A88C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A272070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgBQPbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:31:10 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:35716 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBQPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:31:10 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 76BEFD038A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 15:31:08 +0000 (GMT)
Received: (qmail 8451 invoked from network); 17 Feb 2020 15:31:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2020 15:31:08 -0000
Date:   Mon, 17 Feb 2020 15:31:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20200217153106.GL3466@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
 <20200217145216.GR14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200217145216.GR14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 03:52:16PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 02:49:11PM +0100, Vincent Guittot wrote:
> > > Patches 4-5 are Vincent's and use very similar code patterns and logic
> > > between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
> > > is necessary to avoid serious imbalances being introduced by the NUMA
> > 
> > Yes the test added in load_too_imbalanced() by patch 5 doesn't seem to
> > be a good choice.
> > I haven't remove it as it was done by your patch 6 but it might worth
> > removing it directly if a new version is needed
> 
> Aside of that, Vincent's patches look good to me.

Fully agreed, I think it's now much easier to understand the two balancers
when put side by side in addition to getting some performance gains.
Even if a regression is found, I think it'll be due to a workload seeing
an advantage when NUMA balancer constantly overrides the load balancer.
If that happens, the imbalance can be governed by adjust_numa_balance so
that the two balancers avoid fighting each other again.

-- 
Mel Gorman
SUSE Labs
