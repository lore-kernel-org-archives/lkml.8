Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5DC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4666720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbgBKVEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:04:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbgBKVEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:04:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB55DAB7F;
        Tue, 11 Feb 2020 21:04:42 +0000 (UTC)
Date:   Tue, 11 Feb 2020 21:04:39 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [PATCH 0/4] remove runnable_load_avg and improve group_classify
Message-ID: <20200211210439.GS3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200211174651.10330-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:46:47PM +0100, Vincent Guittot wrote:
> NUMA load balancing is the last remaining piece of code that uses the 
> runnable_load_avg of PELT to balance tasks between nodes. The normal
> load_balance has replaced it by a better description of the current state
> of the group of cpus.  The same policy can be applied to the numa
> balancing.
> 
> Once unused, runnable_load_avg can be replaced by a simpler runnable_avg
> signal that tracks the waiting time of tasks on rq. Currently, the state
> of a group of CPUs is defined thanks to the number of running task and the
> level of utilization of rq. But the utilization can be temporarly low
> after the migration of a task whereas the rq is still overloaded with
> tasks. In such case where tasks were competing for the rq, the
> runnable_avg will stay high after the migration.
> 
> Some hackbench results:
> 
> - small arm64 dual quad cores system
> hackbench -l (2560/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1       1,327(+/-10,06 %)     1,247(+/-5,45 %)       5,97 %
> 4       1,250(+/- 2,55 %)     1,207(+/-2,12 %)       3,42 %
> 8       1,189(+/- 1,47 %)     1,179(+/-1,93 %)       0,90 %
> 16      1,221(+/- 3,25 %)     1,219(+/-2,44 %)       0,16 %						
> 
> - large arm64 2 nodes / 224 cores system
> hackbench -l (256000/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1      14,197(+/- 2,73 %)     13,917(+/- 2,19 %)     1,98 %
> 4       6,817(+/- 1,27 %)      6,523(+/-11,96 %)     4,31 %
> 16      2,930(+/- 1,07 %)      2,911(+/- 1,08 %)     0,66 %
> 32      2,735(+/- 1,71 %)      2,725(+/- 1,53 %)     0,37 %
> 64      2,702(+/- 0,32 %)      2,717(+/- 1,07 %)    -0,53 %
> 128     3,533(+/-14,66 %)     3,123(+/-12,47 %)     11,59 %
> 256     3,918(+/-19,93 %)     3,390(+/- 5,93 %)     13,47 %
> 

I haven't reviewed this yet because by co-incidence I'm finalising a
series that tries to reconcile the load balancer with the NUMA balancer
and it has been very tricky to get right.  One aspect though is that
hackbench is generally not long-running enough to detect any performance
regressions in NUMA balancing. At least I've never observed it to be a
good evaluation for NUMA balancing.

> Without the patchset, there is a significant number of time that a CPU has
> spare capacity with more than 1 running task. Although this is a valid
> case, this is not a state that should often happen when 160 tasks are
> competing on 8 cores like for this test. The patchset fixes the situation
> by taking into account the runnable_avg, which stays high after the
> migration of a task on another CPU.
> 

FWIW, during the rewrite, I ended up moving away from runnable_load to
get the load balancer and NUMA balancer to use the same metrics.

-- 
Mel Gorman
SUSE Labs
