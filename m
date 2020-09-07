Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3138C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C31216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgIGKyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:54:05 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:56605 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbgIGKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:53:51 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 06:53:50 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id D83331C3C72
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 11:44:08 +0100 (IST)
Received: (qmail 913 invoked from network); 7 Sep 2020 10:44:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2020 10:44:08 -0000
Date:   Mon, 7 Sep 2020 11:44:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Message-ID: <20200907104406.GD3179@techsingularity.net>
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
 <20200907092717.GD3117@suse.de>
 <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:44:03AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Mel Gorman [mailto:mgorman@suse.de]
> > Sent: Monday, September 7, 2020 9:27 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
> > vincent.guittot@linaro.org; dietmar.eggemann@arm.com;
> > bsegall@google.com; linux-kernel@vger.kernel.org; Linuxarm
> > <linuxarm@huawei.com>; Mel Gorman <mgorman@techsingularity.net>;
> > Peter Zijlstra <a.p.zijlstra@chello.nl>; Valentin Schneider
> > <valentin.schneider@arm.com>; Phil Auld <pauld@redhat.com>; Hillf Danton
> > <hdanton@sina.com>; Ingo Molnar <mingo@kernel.org>
> > Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
> > NUMA balancer
> > 
> > On Mon, Sep 07, 2020 at 07:27:08PM +1200, Barry Song wrote:
> > > Something is wrong. In find_busiest_group(), we are checking if src has
> > > higher load, however, in task_numa_find_cpu(), we are checking if dst
> > > will have higher load after balancing. It seems it is not sensible to
> > > check src.
> > > It maybe cause wrong imbalance value, for example, if
> > > dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
> > > src_running = env->src_stats.nr_running - 1 results in 1;
> > > The current code is thinking imbalance as 0 since src_running is smaller
> > > than 2.
> > > This is inconsistent with load balancer.
> > >
> > 
> > It checks the conditions if the move was to happen. Have you evaluated
> > this for a NUMA balancing load and confirmed it a) balances properly and
> > b) does not increase the scan rate trying to "fix" the problem?
> 
> I think the original code was trying to check if the numa migration
> would lead to new imbalance in load balancer. In case src is A, dst is B, and
> both of them have nr_running as 2. A moves one task to B, then A
> will have 1, B will have 3. In load balancer, A will try to pull task
> from B since B's nr_running is larger than min_imbalance. But the code
> is saying imbalance=0 by finding A's nr_running is smaller than
> min_imbalance.
> 
> Will share more test data if you need.
> 

Include the test description, data and details of the system you used to
evaluate the patch. I ask because the load/numa reconcilation took a long
time to cover all the corner cases and it's very easy to reintroduce major
regressions. At least one of those corner cases was trying to balance
in the wrong direction because in some cases NUMA balancing will try to
allow a small imbalance if it makes sense from a locality point of view.
Another corner case was if that small imbalance is too large or done at
the wrong time, it regresses overall even though the locality is good
because of memory bandwidth limitations. This is obviously far from ideal
but it does mean that it's an area that needs data backing up the changes.

-- 
Mel Gorman
SUSE Labs
