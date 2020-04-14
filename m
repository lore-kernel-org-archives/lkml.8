Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B93C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8152075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439865AbgDNMGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:06:55 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:40927 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439855AbgDNMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:06:51 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 2B940FAAFA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:06:48 +0100 (IST)
Received: (qmail 16607 invoked from network); 14 Apr 2020 12:06:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Apr 2020 12:06:47 -0000
Date:   Tue, 14 Apr 2020 13:06:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200414120646.GN3818@techsingularity.net>
References: <20200414081951.297676-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200414081951.297676-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:51PM +0800, Huang Ying wrote:
> In current AutoNUMA implementation, the page tables of the processes
> are scanned periodically to trigger the NUMA hint page faults.  The
> scanning runs in the context of the processes, so will delay the
> running of the processes.  In a test with 64 threads pmbench memory
> accessing benchmark on a 2-socket server machine with 104 logical CPUs
> and 256 GB memory, there are more than 20000 latency outliers that are
> > 1 ms in 3600s run time.  These latency outliers are almost all
> caused by the AutoNUMA page table scanning.  Because they almost all
> disappear after applying this patch to scan the page tables
> asynchronously.
> 
> Because there are idle CPUs in system, the asynchronous running page
> table scanning code can run on these idle CPUs instead of the CPUs the
> workload is running on.
> 
> So on system with enough idle CPU time, it's better to scan the page
> tables asynchronously to take full advantages of these idle CPU time.
> Another scenario which can benefit from this is to scan the page
> tables on some service CPUs of the socket, so that the real workload
> can run on the isolated CPUs without the latency outliers caused by
> the page table scanning.
> 
> But it's not perfect to scan page tables asynchronously too.  For
> example, on system without enough idle CPU time, the CPU time isn't
> scheduled fairly because the page table scanning is charged to the
> workqueue thread instead of the process/thread it works for.  And
> although the page tables are scanned for the target process, it may
> run on a CPU that is not in the cpuset of the target process.
> 
> One possible solution is to let the system administrator to choose the
> better behavior for the system via a sysctl knob (implemented in the
> patch).  But it's not perfect too.  Because every user space knob adds
> maintenance overhead.
> 
> A better solution may be to back-charge the CPU time to scan the page
> tables to the process/thread, and find a way to run the work on the
> proper cpuset.  After some googling, I found there's some discussion
> about this as in the following thread,
> 
> https://lkml.org/lkml/2019/6/13/1321
> 
> So this patch may be not ready to be merged by upstream yet.  It
> quantizes the latency outliers caused by the page table scanning in
> AutoNUMA.  And it provides a possible way to resolve the issue for
> users who cares about it.  And it is a potential customer of the work
> related to the cgroup-aware workqueue or other asynchronous execution
> mechanisms.
> 

The caveats you list are the important ones and the reason why it was
not done asynchronously. In an earlier implementation all the work was
done by a dedicated thread and ultimately abandoned.

There is no guarantee there is an idle CPU available and one that is
local to the thread that should be doing the scanning. Even if there is,
it potentially prevents another task from scheduling on an idle CPU and
similarly other workqueue tasks may be delayed waiting on the scanner. The
hiding of the cost is also problematic because the CPU cost is hidden
and mixed with other unrelated workqueues. It also has the potential
to mask bugs. Lets say for example there is a bug whereby a task is
scanning excessively, that can be easily missed when the work is done by
a workqueue.

While it's just an opinion, my preference would be to focus on reducing
the cost and amount of scanning done -- particularly for threads. For
example, all threads operate on the same address space but there can be
significant overlap where all threads are potentially scanning the same
areas or regions that the thread has no interest in. One option would be
to track the highest and lowest pages accessed and only scan within
those regions for example. The tricky part is that library pages may
create very wide windows that render the tracking useless but it could
at least be investigated. 

-- 
Mel Gorman
SUSE Labs
