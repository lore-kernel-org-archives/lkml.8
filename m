Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB920C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C109F2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hSGxZXL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHTHLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:11:41 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16389 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgHTHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597907499; x=1629443499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=8eYpAR681chumFtUVHT4O5U5Ye5aFsGlvA09RlvhVzE=;
  b=hSGxZXL4lgHtlwxD+j2bThX5fJVf0rIDZ0M+k8jtLs8ThcfPGYjzBqWH
   FstILICX3QIkYb53C0dDgWfVxhfzT3+/kQTdLdPY/yCa4m57Ztyuw+dwu
   rkqxMr+fd01DUJDK4zUAROwcVDWkU8SZ6KJJ83/joyM7r8Dwua3zz9U2y
   k=;
X-IronPort-AV: E=Sophos;i="5.76,332,1592870400"; 
   d="scan'208";a="50288937"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Aug 2020 07:11:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 562B9A20E8;
        Thu, 20 Aug 2020 07:11:26 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:11:25 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.38) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:11:09 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        "Du, Fan" <fan.du@intel.com>, <foersleo@amazon.de>,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v7 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Thu, 20 Aug 2020 09:10:52 +0200
Message-ID: <20200820071052.24271-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6RS66aSFjWHvpbjuinz2mwbGDnz+gh5L7dp+c3D_Zy1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 18:21:44 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Aug 18, 2020 at 12:25 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Changes from Previous Version
> > =============================
> >
> > - Use 42 as the fake target id for paddr instead of -1
> > - Fix a typo
> >
> > Introduction
> > ============
> >
> > DAMON[1] programming interface users can extend DAMON for any address space by
> > configuring the address-space specific low level primitives with appropriate
> > ones including their own implementations.  However, because the implementation
> > for the virtual address space is only available now, the users should implement
> > their own for other address spaces.  Worse yet, the user space users who rely
> > on the debugfs interface and user space tool, cannot implement their own.
> >
> > This patchset implements another reference implementation of the low level
> > primitives for the physical memory address space.  With this change, hence, the
> > kernel space users can monitor both the virtual and the physical address spaces
> > by simply changing the configuration in the runtime.  Further, this patchset
> > links the implementation to the debugfs interface and the user space tool for
> > the user space users.
> >
> > Note that the implementation supports only the user memory, as same to the idle
> > page access tracking feature.
> >
> > [1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/
> >
> 
> I am still struggling to find the benefit of this feature the way it
> is implemented i.e. region based physical address space monitoring.
> What exactly am I supposed to do for a given hot (or cold) physical
> region? In a containerized world, that region can contain pages from
> any cgroup. I can not really do anything about the accesses PHY-DAMON
> provides me for a region.

Technically speaking, this patchset introduces an implementation of DAMON's low
level primitives for physical address space of LRU-listed pages.  In other
words, it is not designed for cgroups case.  Also, please note that this
patchset is only RFC, because it aims to only show the future plan of DAMON and
get opinions about the concept before being serious.  It will be serious only
after the DAMON patchset is merged.  Maybe I didn' made this point clear in the
CV, sorry.  I will state this clearly in the next spin.

However, owing to the flexible design of DAMON, you can still use DAMON for
cgroups case, though you need to make some efforts.  There could be a number of
ways.

First, you could figure out the physical address regions for the target
cgroups by yourself, set the target regions by yourself in 'damon_ctx' object
and pass it to 'damon_start()'.  For dynamic page allocations, you could check
if a monitored region belongs to your target cgroup or not from your action
making code, which could be implemented in the '->sample_cb()' or
'->aggregate_cb()' callbacks.

Note that you can even update the regions inside the callbacks.  That is, you
can remove regions containing pages of other containers, add new pages
allocated for your target containers, adjust regions having pages of both other
container and your target containers to represent only your target container's.

Second, you could expand DAMON for cgroups by implementing your own low level
primitives.  You could also reuse some of the current implementation.  For
example, you could implement only '->init_target_regions' and
'->update_target_regions' callbacks again so that only the pages of your target
cgroup belongs in the target regions.  However, if you need to monitor
non-LRU-listed pages, you should implement '->prepare_access_checks()' and
'->check_accesses()' callbacks.

> 
> Now if you give me per-page information that would be useful as I can
> at least get per-cgroup accesses (idle or re-use data) but that would
> be as costly as Page Idle Tracking.

So, seems you are saying about the 'adaptive regions adjustment' disabled page
granularity monitoring case.

Indeed.  Same information comes with same overhead.  Moreover, in the page
granularity monitoring case, DAMON will make more space overhead (at least 8
bytes per page), because DAMON will represent each page as a physical address
region having start address and end address, while Idle Pages Tracking can use
only pfn.  I'm planning optimizations for this page granularity case as a
future work.

However, if you don't strictly need page granularity accuracy, you could reduce
the overhead by using larger granularity.  That is, you can set the monitoring
granularity as you want while the adaptive regions adjustment is disabled.  You
could even use variable granularity in this case using the callbacks mentioned
above.


So, DAMON is a framework rather than a tool.  Though it comes with basic
applications using DAMON as a framework (e.g., the virtual address space low
primitives implementation, DAMON debugfs interface, and the DAMON user space
tool) that could be useful in simple use cases, you need to code your
application on it if your use cases are out of the simple cases.  I will also
develop more of such applications for more use-cases, but it will be only after
the framework is complete enough to be merged in the mainline.


Thanks,
SeongJae Park
