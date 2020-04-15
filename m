Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77BC2051A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635694AbgDOIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:14:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:19418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635659AbgDOIOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:14:42 -0400
IronPort-SDR: qINdq/1g+u4vad8mEQSvJ7SvJYWFoWFM3Qyp8n05sbmCMEGrjl248RS2UhZ58Hf3AXayVPvYfR
 ODrsPe3zxmMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:14:41 -0700
IronPort-SDR: vQtDQBeAxJ8iTSsboqe294WKrUKBTv38qRDUS8kY74WNtIPJna71MNpoXdK4HxmF6gXiuz40rn
 pAVwgS8aO3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="427355854"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 01:14:38 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
References: <20200414081951.297676-1-ying.huang@intel.com>
        <20200414120646.GN3818@techsingularity.net>
Date:   Wed, 15 Apr 2020 16:14:38 +0800
In-Reply-To: <20200414120646.GN3818@techsingularity.net> (Mel Gorman's message
        of "Tue, 14 Apr 2020 13:06:46 +0100")
Message-ID: <87eespyxld.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Tue, Apr 14, 2020 at 04:19:51PM +0800, Huang Ying wrote:
>> In current AutoNUMA implementation, the page tables of the processes
>> are scanned periodically to trigger the NUMA hint page faults.  The
>> scanning runs in the context of the processes, so will delay the
>> running of the processes.  In a test with 64 threads pmbench memory
>> accessing benchmark on a 2-socket server machine with 104 logical CPUs
>> and 256 GB memory, there are more than 20000 latency outliers that are
>> > 1 ms in 3600s run time.  These latency outliers are almost all
>> caused by the AutoNUMA page table scanning.  Because they almost all
>> disappear after applying this patch to scan the page tables
>> asynchronously.
>> 
>> Because there are idle CPUs in system, the asynchronous running page
>> table scanning code can run on these idle CPUs instead of the CPUs the
>> workload is running on.
>> 
>> So on system with enough idle CPU time, it's better to scan the page
>> tables asynchronously to take full advantages of these idle CPU time.
>> Another scenario which can benefit from this is to scan the page
>> tables on some service CPUs of the socket, so that the real workload
>> can run on the isolated CPUs without the latency outliers caused by
>> the page table scanning.
>> 
>> But it's not perfect to scan page tables asynchronously too.  For
>> example, on system without enough idle CPU time, the CPU time isn't
>> scheduled fairly because the page table scanning is charged to the
>> workqueue thread instead of the process/thread it works for.  And
>> although the page tables are scanned for the target process, it may
>> run on a CPU that is not in the cpuset of the target process.
>> 
>> One possible solution is to let the system administrator to choose the
>> better behavior for the system via a sysctl knob (implemented in the
>> patch).  But it's not perfect too.  Because every user space knob adds
>> maintenance overhead.
>> 
>> A better solution may be to back-charge the CPU time to scan the page
>> tables to the process/thread, and find a way to run the work on the
>> proper cpuset.  After some googling, I found there's some discussion
>> about this as in the following thread,
>> 
>> https://lkml.org/lkml/2019/6/13/1321
>> 
>> So this patch may be not ready to be merged by upstream yet.  It
>> quantizes the latency outliers caused by the page table scanning in
>> AutoNUMA.  And it provides a possible way to resolve the issue for
>> users who cares about it.  And it is a potential customer of the work
>> related to the cgroup-aware workqueue or other asynchronous execution
>> mechanisms.
>> 
>
> The caveats you list are the important ones and the reason why it was
> not done asynchronously. In an earlier implementation all the work was
> done by a dedicated thread and ultimately abandoned.
>
> There is no guarantee there is an idle CPU available and one that is
> local to the thread that should be doing the scanning. Even if there is,
> it potentially prevents another task from scheduling on an idle CPU and
> similarly other workqueue tasks may be delayed waiting on the scanner. The
> hiding of the cost is also problematic because the CPU cost is hidden
> and mixed with other unrelated workqueues. It also has the potential
> to mask bugs. Lets say for example there is a bug whereby a task is
> scanning excessively, that can be easily missed when the work is done by
> a workqueue.

Do you think something like cgroup-aware workqueue is a solution deserve
to be tried when it's available?  It will not hide the scanning cost,
because the CPU time will be charged to the original cgroup or task.
Although the other tasks may be disturbed, cgroup can provide some kind
of management via cpusets.

> While it's just an opinion, my preference would be to focus on reducing
> the cost and amount of scanning done -- particularly for threads. For
> example, all threads operate on the same address space but there can be
> significant overlap where all threads are potentially scanning the same
> areas or regions that the thread has no interest in. One option would be
> to track the highest and lowest pages accessed and only scan within
> those regions for example. The tricky part is that library pages may
> create very wide windows that render the tracking useless but it could
> at least be investigated. 

In general, I think it's good to reduce the scanning cost.

Why do you think there will be overlap between the threads of a process?
If my understanding were correctly, the threads will scan one by one
instead of simultaneously.  And how to determine whether a vma need to
be scanned or not?  For example, there may be only a small portion of
pages been accessed in a vma, but they may be accessed remotely and
consumes quite some inter-node bandwidth, so need to be migrated.

Best Regards,
Huang, Ying
