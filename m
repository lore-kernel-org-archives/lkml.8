Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6429120671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgENJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:50:59 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:59831 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgENJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:50:59 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 334F21C37A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:50:57 +0100 (IST)
Received: (qmail 24030 invoked from network); 14 May 2020 09:50:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 May 2020 09:50:56 -0000
Date:   Thu, 14 May 2020 10:50:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200514095055.GG3758@techsingularity.net>
References: <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:20:53PM +0200, Jirka Hladky wrote:
> Thank you, Mel!
> 
> I think I have to make sure we cover the scenario you have targeted
> when developing adjust_numa_imbalance:
> 
> =======================================================================
> https://github.com/torvalds/linux/blob/4f8a3cc1183c442daee6cc65360e3385021131e4/kernel/sched/fair.c#L8910
> 
> /*
> * Allow a small imbalance based on a simple pair of communicating
> * tasks that remain local when the source domain is almost idle.
> */
> =======================================================================
> 
> Could you point me to a benchmark for this scenario? I have checked
> https://github.com/gormanm/mmtests
> and we use lots of the same benchmarks but I'm not sure if we cover
> this particular scenario.
> 

The NUMA imbalance part showed up as part of the general effort to
reconcile NUMA balancing with Load balancing. It's been known for years
that the two balancers disagreed to the extent that NUMA balancing retries
migrations multiple times just to keep things local leading to excessive
migrations. The full battery of tests that were used when I was trying
to reconcile the balancers and later working on Vincent's version is
as follows

scheduler-unbound
scheduler-forkintensive
scheduler-perfpipe
scheduler-perfpipe-cpufreq
scheduler-schbench
db-pgbench-timed-ro-small-xfs
hpc-nas-c-class-mpi-full-xfs
hpc-nas-c-class-mpi-half-xfs
hpc-nas-c-class-omp-full
hpc-nas-c-class-omp-half
hpc-nas-d-class-mpi-full-xfs
hpc-nas-d-class-mpi-half-xfs
hpc-nas-d-class-omp-full
hpc-nas-d-class-omp-half
io-dbench4-async-ext4
io-dbench4-async-xfs
jvm-specjbb2005-multi
jvm-specjbb2005-single
network-netperf-cstate
network-netperf-rr-cstate
network-netperf-rr-unbound
network-netperf-unbound
network-tbench
numa-autonumabench
workload-kerndevel-xfs
workload-shellscripts-xfs

Where there is -ext4 or -xfs, just remove the filesystem to get the base
configuration. i.e. io-dbench4-async-ext4 basic configuration is
io-dbench4-async. Both filesystems are sometimes tested because they
interact differently with the scheduler due to ext4 using a journal
thread and xfs using workqueues.

The imbalance one is most obvious with network-netperf-unbound running
on localhost. If the client/server are on separate nodes, it's obvious
from mpstat that two nodes are busy and it's migrating quite a bit. The
second effect is that NUMA balancing is active, trapping hinting faults
and migrating pages.

The biggest problem I have right now is that the wakeup path between tasks
that are local is slower than doing a remote wakeup via wake_list that
potentially sends an IPI which is ridiculous. The slower wakeup manifests
as a loss of throughput for netperf even though all the accesses are
local. At least that's what I'm looking at whenever I get the chance.

-- 
Mel Gorman
SUSE Labs
