Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349C1C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A10206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H5xx1hYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD1NYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:24:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:34531 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgD1NYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588080288; x=1619616288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=0nBgDbWkkL0btShLwdKFd9djmc38MYuUvPYnrUpe5t0=;
  b=H5xx1hYhNOfl50kvoFZk040VmzKrkXAxuTtiL5VIKu7Iqe80NXBfaOp6
   1lnyQF0uTi79z4gX4tWmNGKWaWBD2TeKUZtAK0ydM71WyQXl90QowqqFp
   PYV4NU+JKRZRGc0KAdIk3iGMIg+pyzV8LPtlQGYaBJfX5mSsSDrJHkntl
   0=;
IronPort-SDR: fZHE7LdauWs0dCbKhjTtsYn/SWrUHKZ2Y3p1CFZPiDdVZijrK5qeofbGBgqdEkrT6poAgnKvf6
 0Sc+22ouvZwg==
X-IronPort-AV: E=Sophos;i="5.73,327,1583193600"; 
   d="scan'208";a="27918772"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Apr 2020 13:24:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 19452A1F49;
        Tue, 28 Apr 2020 13:24:29 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Apr 2020 13:24:28 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.247) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Apr 2020 13:24:10 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v9 00/15] Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Apr 2020 15:23:42 +0200
Message-ID: <20200428132342.21745-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132704.00003f79@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.247]
X-ClientProxiedBy: EX13D40UWC004.ant.amazon.com (10.43.162.175) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 13:27:04 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 27 Apr 2020 14:04:27 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Introduction
> > ============
> > 
> > Memory management decisions can be improved if finer data access information is
> > available.  However, because such finer information usually comes with higher
> > overhead, most systems including Linux forgives the potential benefit and rely
> > on only coarse information or some light-weight heuristics.  The pseudo-LRU and
> > the aggressive THP promotions are such examples.
> > 
> > A number of data access pattern awared memory management optimizations (refer
> > to 'Appendix A' for more details) consistently say the potential benefit is not
> > small.  However, none of those has successfully merged to the mainline Linux
> > kernel mainly due to the absence of a scalable and efficient data access
> > monitoring mechanism.  Refer to 'Appendix B' to see the limitations of existing
> > memory monitoring mechanisms.
> > 
> > DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> > enough to be used for the DRAM level memory management (a straightforward
> > DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> > to be applied online (compared to a straightforward access monitoring scheme,
> > DAMON is up to 94,242.42x lighter) and 3) keeps predefined upper-bound overhead
> > regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> > C' if you interested in how it is possible, and 'Appendix F' to know how the
> > numbers collected.
> > 
> > DAMON has mainly designed for the kernel's memory management mechanisms.
> > However, because it is implemented as a standalone kernel module and provides
> > several interfaces, it can be used by a wide range of users including kernel
> > space programs, user space programs, programmers, and administrators.  DAMON
> > is now supporting the monitoring only, but it will also provide simple and
> > convenient data access pattern awared memory managements by itself.  Refer to
> > 'Appendix D' for more detailed expected usages of DAMON.
> > 
[...]
> > 
> > Future Plans
> > ============
> > 
> > This patchset is only for the first stage of DAMON.  As soon as this patchset
> > is merged, official patchsets for below future plans will be posted.
> > 
[...]
> > 
> > Support Various Address Spaces
> > ------------------------------
> > 
> > Currently, DAMON supports virtual memory address spaces using PTE Accessed bits
> > as its access checking primitive.  However, the core design of DAMON is not
> > dependent to such implementation details.  In a future, DAMON will decouple
> > those and support various address spaces including physical memory.  It will
> > further allow users to configure and even implement the primitives by
> > themselves for their special usecase.  Monitoring of page cache, NUMA nodes,
> > specific files, or block devices would be examples of such usecases.
> > 
> > An RFC patchset for this plan is already available
> > (https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/).
> > 
[...]
> > 
> > Patch History
> > =============
> > 
> > The most biggest change in this version is support of minimal region size,
> > which defaults to 'PAGE_SIZE'.  This change will reduce unnecessary region
> > splits and thus improve the quality of the output.  In a future, we will be
> > able to make this configurable for support of various access check primitives
> > such as PMUs.
> 
> That is a good improvement.  Might be interesting to consider taking
> hugepages into account as well.

Thanks!  Kudos to Stefan and you for giving me the comments for the change.

As abovely mentioned in 'Future Plans' section, DAMON will be highly
configurable.  You can see the plan in more detail via the RFC patchset[1].
Thus, the minimal region size will also be able to configured as users want,
including the size of the hugepage.

[1] https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/

> 
> One issue I've noted is that we have a degeneracy problem with the current
> region merging and splitting that perhaps could do with a small tweak.
> 
> Currently we can end with a very small number of regions because there
> is no limit on how many regions can be merged in a give pass for merging.
> However, splitting only doubles the number of regions.
> 
> I've been experimenting with a few loops of the splitting algorithm to ensure
> we don't end up stuck with limited regions.  I think the problem we are working
> around can be roughly described as:
> 
> 1) Program allocates a lot of memory - not really touching much of it.
> 2) Damon fuses the large memory allocations in to one region because the
>    access counts are always near 0. 
> 3) Program finishes setup.
> 4) Program accesses a few pages in the huge reason a lot, but not that much
>    for most of the rest.  Taking an extreme option, the page in the middle
>    gets all the accesses and the other 1G on either side gets none.
> 5) As a split always breaks the page in two, the chances of significantly
>    different values for the two resulting regions is low (as we only sample
>    the hot page occasionally).
> 
> If we just run the splits twice if the number of regions < max regions / 4
> then over time we should eventually get a region with the single hot page in it.
> We will get there faster if we split more (keeping below max regions).
> 
> As we always remain below max regions, we are still obeying the fixed
> maximum overhead and actually monitoring at closer to the desired granularity.

Good point.  However, as you also mentioned, DAMON will slowly, but eventually
adjust the regions appropriately.

And yes, your suggested solution will work pretty well.  Indeed, my one
previous colleague found this problem on a few of special workloads and tried
the solution you suggested.  The improvement was clear.

However, I didn't adopt the solution due to below reasons.

First, IMHO, this is an accuracy improvement, rather than bug fix.  But the
extent of the enhancement didn't seem very critical to me.  Most of other
workloads didn't show such problem (and thus improvement).  Even with the
workloads showing the problem, the problem was not seem so critical.

Second, if the low accuracy is problem, users could get higher accuracy by
simply adjusting the sampling interval and/or aggregation interval to lower
value.  This is the supposed way to trade the accuracy with the overhead.

Finally, I would like to keep code as simple as it can.

For same reasons, I would like to keep the code as currently is until real user
problem is reported.  If you have different opinions, please feel free to yell
at me.


Thanks,
SeongJae Park

> 
> Jonathan
> 
> > 
> > Changes from v8
> > (https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/)
> >  - Make regions always aligned by minimal region size that can be changed
> >    (Stefan Nuernberger)
> >  - Store binary format version in the recording file (Stefan Nuernberger)
> >  - Use 'int' for pid instead of 'unsigned long' (Stefan Nuernberger)
> >  - Fix a race condition in damon thread termination (Stefan Nuernberger)
> >  - Optimize random value generation and recording (Stefan Nuernberger)
> >  - Clean up commit messages and comments (Stefan Nuernberger)
> >  - Clean up code (Stefan Nuernberger)
> >  - Use explicit signalling and 'do_exit()' for damon thread termination 
> >  - Add more typos to spelling.txt
> >  - Update the performance evaluation results
> >  - Describe future plans in the cover letter
> > 
> > Changes from v7
> > (https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/)
> >  - Cleanup variable names (Jonathan Cameron)
> >  - Split sampling address setup from access_check() (Jonathan Cameron)
> >  - Make sampling address to always locate in the region (Jonathan Cameron)
> >  - Make initial region's sampling addr to be old (Jonathan Cameron)
> >  - Split kdamond on/off function to seperate functions (Jonathan Cameron)
> >  - Fix wrong kernel doc comments (Jonathan Cameron)
> >  - Reset 'last_accessed' to false in kdamond_check_access() if necessary
> >  - Rebase on v5.6
> > 
> > Changes from v6
> > (https://lore.kernel.org/linux-mm/20200224123047.32506-1-sjpark@amazon.com/)
> >  - Wordsmith cover letter (Shakeel Butt)
> >  - Cleanup code and commit messages (Jonathan Cameron)
> >  - Avoid kthread_run() under spinlock critical section (Jonathan Cameron)
> >  - Use kthread_stop() (Jonathan Cameron)
> >  - Change tracepoint to trace regions (Jonathan Cameron)
> >  - Implement API from the beginning (Jonathan Cameron)
> >  - Fix typos (Jonathan Cameron)
> >  - Fix access checking to properly handle regions smaller than single page
> >    (Jonathan Cameron)
> >  - Add found typos to 'scripts/spelling.txt'
> >  - Add recent evaluation results including DAMON-based Operation Schemes
> > 
> > Changes from v5
> > (https://lore.kernel.org/linux-mm/20200217103110.30817-1-sjpark@amazon.com/)
> >  - Fix minor bugs (sampling, record attributes, debugfs and user space tool)
> >  - selftests: Add debugfs interface tests for the bugs
> >  - Modify the user space tool to use its self default values for parameters
> >  - Fix pmg huge page access check
> > 
> > Changes from v4
> > (https://lore.kernel.org/linux-mm/20200210144812.26845-1-sjpark@amazon.com/)
> >  - Add 'Reviewed-by' for the kunit tests patch (Brendan Higgins)
> >  - Make the unit test to depedns on 'DAMON=y' (Randy Dunlap and kbuild bot)
> >    Reported-by: kbuild test robot <lkp@intel.com>
> >  - Fix m68k module build issue
> >    Reported-by: kbuild test robot <lkp@intel.com>
> >  - Add selftests
> >  - Seperate patches for low level users from core logics for better reading
> >  - Clean up debugfs interface
> >  - Trivial nitpicks
> > 
> > Changes from v3
> > (https://lore.kernel.org/linux-mm/20200204062312.19913-1-sj38.park@gmail.com/)
> >  - Fix i386 build issue
> >    Reported-by: kbuild test robot <lkp@intel.com>
> >  - Increase the default size of the monitoring result buffer to 1 MiB
> >  - Fix misc bugs in debugfs interface
> > 
> > Changes from v2
> > (https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/)
> >  - Move MAINTAINERS changes to last commit (Brendan Higgins)
> >  - Add descriptions for kunittest: why not only entire mappings and what the 4
> >    input sets are trying to test (Brendan Higgins)
> >  - Remove 'kdamond_need_stop()' test (Brendan Higgins)
> >  - Discuss about the 'perf mem' and DAMON (Peter Zijlstra)
> >  - Make CV clearly say what it actually does (Peter Zijlstra)
> >  - Answer why new module (Qian Cai)
> >  - Diable DAMON by default (Randy Dunlap)
> >  - Change the interface: Seperate recording attributes
> >    (attrs, record, rules) and allow multiple kdamond instances
> >  - Implement kernel API interface
> > 
> > Changes from v1
> > (https://lore.kernel.org/linux-mm/20200120162757.32375-1-sjpark@amazon.com/)
> >  - Rebase on v5.5
> >  - Add a tracepoint for integration with other tracers (Kirill A. Shutemov)
> >  - document: Add more description for the user space tool (Brendan Higgins)
> >  - unittest: Improve readability (Brendan Higgins)
> >  - unittest: Use consistent name and helpers function (Brendan Higgins)
> >  - Update PG_Young to avoid reclaim logic interference (Yunjae Lee)
> > 
> > Changes from RFC
> > (https://lore.kernel.org/linux-mm/20200110131522.29964-1-sjpark@amazon.com/)
> >  - Specify an ambiguous plan of access pattern based mm optimizations
> >  - Support loadable module build
> >  - Cleanup code
> > 
> > SeongJae Park (15):
> >   scripts/spelling: Add a few more typos
> >   mm/page_ext: Export lookup_page_ext() to GPL modules
> >   mm: Introduce Data Access MONitor (DAMON)
> >   mm/damon: Implement region based sampling
> >   mm/damon: Adaptively adjust regions
> >   mm/damon: Apply dynamic memory mapping changes
> >   mm/damon: Implement callbacks
> >   mm/damon: Implement access pattern recording
> >   mm/damon: Add debugfs interface
> >   mm/damon: Add tracepoints
> >   tools: Add a minimal user-space tool for DAMON
> >   Documentation/admin-guide/mm: Add a document for DAMON
> >   mm/damon: Add kunit tests
> >   mm/damon: Add user space selftests
> >   MAINTAINERS: Update for DAMON
> > 
> >  .../admin-guide/mm/data_access_monitor.rst    |  428 +++++
> >  Documentation/admin-guide/mm/index.rst        |    1 +
> >  MAINTAINERS                                   |   12 +
> >  include/linux/damon.h                         |   78 +
> >  include/trace/events/damon.h                  |   43 +
> >  mm/Kconfig                                    |   23 +
> >  mm/Makefile                                   |    1 +
> >  mm/damon-test.h                               |  615 +++++++
> >  mm/damon.c                                    | 1494 +++++++++++++++++
> >  mm/page_ext.c                                 |    1 +
> >  scripts/spelling.txt                          |    8 +
> >  tools/damon/.gitignore                        |    1 +
> >  tools/damon/_dist.py                          |   36 +
> >  tools/damon/_recfile.py                       |   23 +
> >  tools/damon/bin2txt.py                        |   67 +
> >  tools/damon/damo                              |   37 +
> >  tools/damon/heats.py                          |  362 ++++
> >  tools/damon/nr_regions.py                     |   91 +
> >  tools/damon/record.py                         |  212 +++
> >  tools/damon/report.py                         |   45 +
> >  tools/damon/wss.py                            |   97 ++
> >  tools/testing/selftests/damon/Makefile        |    7 +
> >  .../selftests/damon/_chk_dependency.sh        |   28 +
> >  tools/testing/selftests/damon/_chk_record.py  |  108 ++
> >  .../testing/selftests/damon/debugfs_attrs.sh  |  139 ++
> >  .../testing/selftests/damon/debugfs_record.sh |   50 +
> >  26 files changed, 4007 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
> >  create mode 100644 include/linux/damon.h
> >  create mode 100644 include/trace/events/damon.h
> >  create mode 100644 mm/damon-test.h
> >  create mode 100644 mm/damon.c
> >  create mode 100644 tools/damon/.gitignore
> >  create mode 100644 tools/damon/_dist.py
> >  create mode 100644 tools/damon/_recfile.py
> >  create mode 100644 tools/damon/bin2txt.py
> >  create mode 100755 tools/damon/damo
> >  create mode 100644 tools/damon/heats.py
> >  create mode 100644 tools/damon/nr_regions.py
> >  create mode 100644 tools/damon/record.py
> >  create mode 100644 tools/damon/report.py
> >  create mode 100644 tools/damon/wss.py
> >  create mode 100644 tools/testing/selftests/damon/Makefile
> >  create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
> >  create mode 100644 tools/testing/selftests/damon/_chk_record.py
> >  create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> >  create mode 100755 tools/testing/selftests/damon/debugfs_record.sh
