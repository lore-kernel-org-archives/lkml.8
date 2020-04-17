Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F74C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187E121D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c3aVoAsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDQHGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:06:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1830 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgDQHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587107159; x=1618643159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=XOqBKAS6mZdabqMz+4mSgKnmFRPA/0mQeLYHxuXQFyM=;
  b=c3aVoAswThsxNL12muIji5Zap0A3sHXX4qzo03WX3hte4K4DCMEisJBL
   W8AqRytyX8AofuJgAmd5XOsCcka9DqNML/vNGDineVpoU/pVGPzzJbTCR
   sAk2ExbDpUwRN5KfiElnWLB1x/NJghtDkmP8/mdv52oTxduHEhv2uUmRO
   c=;
IronPort-SDR: 2e3i0skHvYdIwTWJpLGKbaJjT2XI2on6Twzq3YSZF1yb62BIrI+tS31A0OAOzSH6ZcJjYkZaev
 WD1PR4VMlEog==
X-IronPort-AV: E=Sophos;i="5.72,394,1580774400"; 
   d="scan'208";a="26002062"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Apr 2020 07:05:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id E8F2AA2212;
        Fri, 17 Apr 2020 07:05:36 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 07:05:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.239) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 07:05:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Date:   Fri, 17 Apr 2020 09:05:08 +0200
Message-ID: <20200417070508.32243-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87eespyxld.fsf@yhuang-dev.intel.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D40UWC003.ant.amazon.com (10.43.162.246) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 16:14:38 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:

> Mel Gorman <mgorman@techsingularity.net> writes:
> 
> > On Tue, Apr 14, 2020 at 04:19:51PM +0800, Huang Ying wrote:
> >> In current AutoNUMA implementation, the page tables of the processes
> >> are scanned periodically to trigger the NUMA hint page faults.  The
> >> scanning runs in the context of the processes, so will delay the
> >> running of the processes.  In a test with 64 threads pmbench memory
> >> accessing benchmark on a 2-socket server machine with 104 logical CPUs
> >> and 256 GB memory, there are more than 20000 latency outliers that are
> >> > 1 ms in 3600s run time.  These latency outliers are almost all
> >> caused by the AutoNUMA page table scanning.  Because they almost all
> >> disappear after applying this patch to scan the page tables
> >> asynchronously.
> >> 
> >> Because there are idle CPUs in system, the asynchronous running page
> >> table scanning code can run on these idle CPUs instead of the CPUs the
> >> workload is running on.
> >> 
> >> So on system with enough idle CPU time, it's better to scan the page
> >> tables asynchronously to take full advantages of these idle CPU time.
> >> Another scenario which can benefit from this is to scan the page
> >> tables on some service CPUs of the socket, so that the real workload
> >> can run on the isolated CPUs without the latency outliers caused by
> >> the page table scanning.
> >> 
> >> But it's not perfect to scan page tables asynchronously too.  For
> >> example, on system without enough idle CPU time, the CPU time isn't
> >> scheduled fairly because the page table scanning is charged to the
> >> workqueue thread instead of the process/thread it works for.  And
> >> although the page tables are scanned for the target process, it may
> >> run on a CPU that is not in the cpuset of the target process.
> >> 
> >> One possible solution is to let the system administrator to choose the
> >> better behavior for the system via a sysctl knob (implemented in the
> >> patch).  But it's not perfect too.  Because every user space knob adds
> >> maintenance overhead.
> >> 
> >> A better solution may be to back-charge the CPU time to scan the page
> >> tables to the process/thread, and find a way to run the work on the
> >> proper cpuset.  After some googling, I found there's some discussion
> >> about this as in the following thread,
> >> 
> >> https://lkml.org/lkml/2019/6/13/1321
> >> 
> >> So this patch may be not ready to be merged by upstream yet.  It
> >> quantizes the latency outliers caused by the page table scanning in
> >> AutoNUMA.  And it provides a possible way to resolve the issue for
> >> users who cares about it.  And it is a potential customer of the work
> >> related to the cgroup-aware workqueue or other asynchronous execution
> >> mechanisms.
> >> 
> >
> > The caveats you list are the important ones and the reason why it was
> > not done asynchronously. In an earlier implementation all the work was
> > done by a dedicated thread and ultimately abandoned.
> >
> > There is no guarantee there is an idle CPU available and one that is
> > local to the thread that should be doing the scanning. Even if there is,
> > it potentially prevents another task from scheduling on an idle CPU and
> > similarly other workqueue tasks may be delayed waiting on the scanner. The
> > hiding of the cost is also problematic because the CPU cost is hidden
> > and mixed with other unrelated workqueues. It also has the potential
> > to mask bugs. Lets say for example there is a bug whereby a task is
> > scanning excessively, that can be easily missed when the work is done by
> > a workqueue.
> 
> Do you think something like cgroup-aware workqueue is a solution deserve
> to be tried when it's available?  It will not hide the scanning cost,
> because the CPU time will be charged to the original cgroup or task.
> Although the other tasks may be disturbed, cgroup can provide some kind
> of management via cpusets.
> 
> > While it's just an opinion, my preference would be to focus on reducing
> > the cost and amount of scanning done -- particularly for threads. For
> > example, all threads operate on the same address space but there can be
> > significant overlap where all threads are potentially scanning the same
> > areas or regions that the thread has no interest in. One option would be
> > to track the highest and lowest pages accessed and only scan within
> > those regions for example. The tricky part is that library pages may
> > create very wide windows that render the tracking useless but it could
> > at least be investigated. 
> 
> In general, I think it's good to reduce the scanning cost.

I think the main idea of DAMON[1] might be able to applied here.  Have you
considered it?

[1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/


Thanks,
SeongJae Park

> 
> Why do you think there will be overlap between the threads of a process?
> If my understanding were correctly, the threads will scan one by one
> instead of simultaneously.  And how to determine whether a vma need to
> be scanned or not?  For example, there may be only a small portion of
> pages been accessed in a vma, but they may be accessed remotely and
> consumes quite some inter-node bandwidth, so need to be migrated.
> 
> Best Regards,
> Huang, Ying
> 
