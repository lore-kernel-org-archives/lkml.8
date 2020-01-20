Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DC1C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454820684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATIeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:34:01 -0500
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:56769 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgATIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:34:01 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 00E721C2DB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:33:57 +0000 (GMT)
Received: (qmail 27818 invoked from network); 20 Jan 2020 08:33:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2020 08:33:56 -0000
Date:   Mon, 20 Jan 2020 08:33:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200120083354.GT3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
 <20200117215853.GS3466@techsingularity.net>
 <20200120080935.GD20112@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200120080935.GD20112@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 01:39:35PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2020-01-17 21:58:53]:
> 
> > On Fri, Jan 17, 2020 at 11:26:31PM +0530, Srikar Dronamraju wrote:
> > > * Mel Gorman <mgorman@techsingularity.net> [2020-01-14 10:13:20]:
> > > 
> > > We certainly are seeing better results than v1.
> > > However numa02, numa03, numa05, numa09 and numa10 still seem to regressing, while
> > > the others are improving.
> > > 
> > > While numa04 improves by 14%, numa02 regress by around 12%.
> > > 
> 
> > Ok, so it's both a win and a loss. This is a curiousity that this patch
> > may be the primary factor given that the logic only triggers when the
> > local group has spare capacity and the busiest group is nearly idle. The
> > test cases you describe should have fairly busy local groups.
> > 
> 
> Right, your code only seems to affect when the local group has spare
> capacity and the busiest->sum_nr_running <=2 
> 

And this is why I'm curious as to why your workload is affected at all
because it uses many tasks.  I stopped allowing an imbalance for higher
task counts partially on the basis of your previous report.

> > This one is more interesting. False sharing shouldn't be an issue so the
> > threads should be independent.
> > 
> > > numa03 is a single process with 256 threads;
> > > each thread doing 50 loops on 3GB process shared memory operations.
> > > 
> > 
> > Similar.
> 
> This is similar to numa01. Except now all threads belong to just one
> process.
> 

My concern is that the shared memory options means that NUMA balancing
and false sharing can dominate and hide any impact of the patch itself.
Whether it has good or bad results may be partially down to luck.

> > 
> > > numa05 is a set of 16 process (twice as many nodes) each running 16 threads;
> > > each thread doing 50 loops on 3GB process shared memory operations.
> > > 
> > 
> > > Details below:
> > 
> > How many iterations for each test? 
> 
> I run 5 iterations. Want me to run with more iterations?
> 

5 should be enough for now. I'm more interested in hearing if the
regression/gain is consistent when the patch is applied and a confirmation
that the patch really makes a difference to this set of workloads.

> > 
> > 
> > > ./numa02.sh      Real:  78.87      82.31      80.59      1.72     -12.7187%
> > > ./numa02.sh      Sys:   81.18      85.07      83.12      1.94     -35.0337%
> > > ./numa02.sh      User:  16303.70   17122.14   16712.92   409.22   -12.5182%
> > 
> > Before range: 58 to 72
> > After range: 78 to 82
> > 
> > This one is more interesting in general. Can you add trace_printks to
> > the check for SD_NUMA the patch introduces and dump the sum_nr_running
> > for both local and busiest when the imbalance is ignored please? That
> > might give some hint as to the improper conditions where imbalance is
> > ignored.
> 
> Can be done. Will get back with the results. But do let me know if you want
> to run with more iterations or rerun the tests.
> 

The results of this will be interesting in itself. I'm particularly
interested in seeing what the traces look like for a good and bad result.

> > 
> > However, knowing the number of iterations would be helpful. Can you also
> > tell me if this is consistent between boots or is it always roughly 12%
> > regression regardless of the number of iterations?
> > 
> 
> I have only measured for 5 iterations and I haven't repeated to see if the
> numbers are consistent.
> 

Ok, that is quite a problem as the assertion at the moment is that the
patch causes a mix of regressions/gains. It's currently unclear to me
why the patch would have a major impact on this workload at all given the
number of active tasks and the nature of the patch.  I'm concerned that
the workload may be naturally unstable but tracing may be able to help.

-- 
Mel Gorman
SUSE Labs
