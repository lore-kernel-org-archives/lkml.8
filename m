Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80184C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35102215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgIGMso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:48:44 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:45739 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbgIGMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:42:40 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id A8BCA1C3F14
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 13:42:19 +0100 (IST)
Received: (qmail 10544 invoked from network); 7 Sep 2020 12:42:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2020 12:42:19 -0000
Date:   Mon, 7 Sep 2020 13:42:16 +0100
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
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [RFC] sched/numa: don't move tasks to idle numa nodes while src
 node has very light load?
Message-ID: <20200907124216.GE3179@techsingularity.net>
References: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:00:10PM +0000, Song Bao Hua (Barry Song) wrote:
> Hi All,
> In case we have a numa system with 4 nodes and in each node we have 24 cpus, and all of the 96 cores are idle.
> Then we start a process with 4 threads in this totally idle system. 
> Actually any one of the four numa nodes should have enough capability to run the 4 threads while they can still have 20 idle CPUS after that.
> But right now the existing code in CFS load balance will spread the 4 threads to multiple nodes.
> This results in two negative side effects:
> 1. more numa nodes are awaken while they can save power in lowest frequency and halt status
> 2. cache coherency overhead between numa nodes
> 
> A proof-of-concept patch I made to "fix" this issue to some extent is like:
> 

This is similar in concept to a patch that did something similar except
in adjust_numa_imbalance(). It ended up being great for light loads like
simple communicating pairs but fell apart for some HPC workloads when
memory bandwidth requirements increased. Ultimately it was dropped until
the NUMA/CPU load balancing was reconciled so may be worth a revisit. At
the time, it was really problematic once a one node was roughly 25% CPU
utilised on a 2-socket machine with hyper-threading enabled. The patch may
still work out but it would need wider testing. Within mmtests, the NAS
workloads for D-class on a 2-socket machine varying the number of parallel
tasks/processes are used should be enough to determine if the patch is
free from side-effects for one machine. It gets problematic for different
machine sizes as the point where memory bandwidth is saturated varies.
group_weight/4 might be fine on one machine as a cut-off and a problem
on a larger machine with more cores -- I hit that particular problem
when one 2 socket machine with 48 logical CPUs was fine but a different
machine with 80 logical CPUs regressed.

I'm not saying the patch is wrong, just that patches in general for this
area (everyone, not just you) need fairly broad testing.

-- 
Mel Gorman
SUSE Labs
