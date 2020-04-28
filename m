Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C0C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A01206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD1M12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:27:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2121 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbgD1M10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:27:26 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 62CFED82C3633676EF21;
        Tue, 28 Apr 2020 13:27:23 +0100 (IST)
Received: from localhost (10.47.94.202) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 28 Apr
 2020 13:27:21 +0100
Date:   Tue, 28 Apr 2020 13:27:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/15] Introduce Data Access MONitor (DAMON)
Message-ID: <20200428132704.00003f79@Huawei.com>
In-Reply-To: <20200427120442.24179-1-sjpark@amazon.com>
References: <20200427120442.24179-1-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.202]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 14:04:27 +0200
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Introduction
> ============
> 
> Memory management decisions can be improved if finer data access information is
> available.  However, because such finer information usually comes with higher
> overhead, most systems including Linux forgives the potential benefit and rely
> on only coarse information or some light-weight heuristics.  The pseudo-LRU and
> the aggressive THP promotions are such examples.
> 
> A number of data access pattern awared memory management optimizations (refer
> to 'Appendix A' for more details) consistently say the potential benefit is not
> small.  However, none of those has successfully merged to the mainline Linux
> kernel mainly due to the absence of a scalable and efficient data access
> monitoring mechanism.  Refer to 'Appendix B' to see the limitations of existing
> memory monitoring mechanisms.
> 
> DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> enough to be used for the DRAM level memory management (a straightforward
> DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> to be applied online (compared to a straightforward access monitoring scheme,
> DAMON is up to 94,242.42x lighter) and 3) keeps predefined upper-bound overhead
> regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> C' if you interested in how it is possible, and 'Appendix F' to know how the
> numbers collected.
> 
> DAMON has mainly designed for the kernel's memory management mechanisms.
> However, because it is implemented as a standalone kernel module and provides
> several interfaces, it can be used by a wide range of users including kernel
> space programs, user space programs, programmers, and administrators.  DAMON
> is now supporting the monitoring only, but it will also provide simple and
> convenient data access pattern awared memory managements by itself.  Refer to
> 'Appendix D' for more detailed expected usages of DAMON.
> 
> 
> Boring? Here Are Something Colorful
> ===================================
> 
> For intuitive understanding of DAMON, I made web pages[1-8] showing the
> visualized dynamic data access pattern of various realistic workloads in
> PARSEC3 and SPLASH-2X bechmark suites.  The figures are generated using the
> user space tool in 10th patch of this patchset.
> 
> There are pages showing the heatmap format dynamic access pattern of each
> workload for heap area[1], mmap()-ed area[2], and stack[3] area.  I splitted
> the entire address space to the three area because there are huge unmapped
> regions between the areas.
> 
> You can also show how the dynamic working set size of each workload is
> distributed[4], and how it is chronologically changing[5].
> 
> The most important characteristic of DAMON is its promise of the upperbound of
> the monitoring overhead.  To show whether DAMON keeps the promise well, I
> visualized the number of monitoring operations required for each 5
> milliseconds, which is configured to not exceed 1000.  You can show the
> distribution of the numbers[6] and how it changes chronologically[7].
> 
> [1] https://damonitor.github.io/reports/latest/by_image/heatmap.0.png.html
> [2] https://damonitor.github.io/reports/latest/by_image/heatmap.1.png.html
> [3] https://damonitor.github.io/reports/latest/by_image/heatmap.2.png.html
> [4] https://damonitor.github.io/reports/latest/by_image/wss_sz.png.html
> [5] https://damonitor.github.io/reports/latest/by_image/wss_time.png.html
> [6] https://damonitor.github.io/reports/latest/by_image/nr_regions_sz.png.html
> [7] https://damonitor.github.io/reports/latest/by_image/nr_regions_time.png.html
> 
> 
> Future Plans
> ============
> 
> This patchset is only for the first stage of DAMON.  As soon as this patchset
> is merged, official patchsets for below future plans will be posted.
> 
> 
> Automate Data Access Pattern-aware Memory Management
> ----------------------------------------------------
> 
> Though DAMON provides the monitoring feature, implementing data access pattern
> aware memory management schemes could be difficult to beginners.  DAMON will be
> able to do most of the work by itself in near future.  Users will be required
> to only describe what kind of data access monitoring-based operation schemes
> they want.
> 
> By applying a very simple scheme for THP promotion/demotion with a latest
> version of the patchset (not posted yet), DAMON achieved 18x lower memory space
> overhead compared to THP while preserving about 50% of the THP performance
> benefit with SPLASH-2X benchmark suite.
> 
> An RFC patchset for this plan is already available
> (https://lore.kernel.org/linux-mm/20200407100007.3894-1-sjpark@amazon.com/).
> 
> 
> Support Various Address Spaces
> ------------------------------
> 
> Currently, DAMON supports virtual memory address spaces using PTE Accessed bits
> as its access checking primitive.  However, the core design of DAMON is not
> dependent to such implementation details.  In a future, DAMON will decouple
> those and support various address spaces including physical memory.  It will
> further allow users to configure and even implement the primitives by
> themselves for their special usecase.  Monitoring of page cache, NUMA nodes,
> specific files, or block devices would be examples of such usecases.
> 
> An RFC patchset for this plan is already available
> (https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/).
> 
> 
> Frequently Asked Questions
> ==========================
> 
> Q: Why a new module, instead of extending perf or other tools?
> A: First, DAMON aims to be used by other programs including the kernel.
> Therefore, having dependency to specific tools like perf is not desirable.
> Second, because it need to be lightweight as much as possible so that it can be
> used online, any unnecessary overhead such as kernel - user space context
> switching cost should be avoided.  These are the two most biggest reasons why
> DAMON is implemented in the kernel space.  The idle page tracking subsystem
> would be the kernel module that most seems similar to DAMON.  However, its own
> interface is not compatible with DAMON.  Also, the internal implementation of
> it has no common part to be reused by DAMON.
> 
> Q: Can 'perf mem' or PMUs used instead of DAMON?
> A: No.  Roughly speaking, DAMON has two seperate layers.  The low layer is
> access check of pages, and the higher layer is its core mechanisms for overhead
> controlling.  For the low layer, DAMON is now using the PTE Accessed bits.
> Other H/W or S/W features that can be used for the access check of pages, such
> as 'perf mem', PMU, or even page idle, could be used instead in the layer.
> However, those could not alternate the high layer of DAMON.
> 
> 
> Evaluations
> ===========
> 
> We evaluated DAMON's overhead, monitoring quality and usefulness using 25
> realistic workloads on my QEMU/KVM based virtual machine.
> 
> DAMON is lightweight.  It consumes only -0.18% more system memory and up to 1%
> CPU time.  It makes target worloads only 0.55% slower.
> 
> DAMON is accurate and useful for memory management optimizations.  An
> experimental DAMON-based operation scheme for THP removes 66.2% of THP memory
> overheads while preserving 54.78% of THP speedup.  Another experimental
> DAMON-based 'proactive reclamation' implementation reduced 88.15% of
> residentail sets and 22.30% of system memory footprint while incurring only
> 2.91% runtime overhead in best case (parsec3/freqmine).
> 
> NOTE that the experimentail THP optimization and proactive reclamation are not
> for production, just only for proof of concepts.
> 
> Please refer to 'Appendix E' for detailed evaluation setup and results.
> 
> 
> References
> ==========
> 
> Prototypes of DAMON have introduced by an LPC kernel summit track talk[1] and
> two academic papers[2,3].  Please refer to those for more detailed information,
> especially the evaluations.  The latest version of the patchsets has also
> introduced by an LWN artice[4].
> 
> [1] SeongJae Park, Tracing Data Access Pattern with Bounded Overhead and
>     Best-effort Accuracy. In The Linux Kernel Summit, September 2019.
>     https://linuxplumbersconf.org/event/4/contributions/548/
> [2] SeongJae Park, Yunjae Lee, Heon Y. Yeom, Profiling Dynamic Data Access
>     Patterns with Controlled Overhead and Quality. In 20th ACM/IFIP
>     International Middleware Conference Industry, December 2019.
>     https://dl.acm.org/doi/10.1145/3366626.3368125
> [3] SeongJae Park, Yunjae Lee, Yunhee Kim, Heon Y. Yeom, Profiling Dynamic Data
>     Access Patterns with Bounded Overhead and Accuracy. In IEEE International
>     Workshop on Foundations and Applications of Self- Systems (FAS 2019), June
>     2019.
> [4] Jonathan Corbet, Memory-management optimization with DAMON. In Linux Weekly
>     News (LWN), Feb 2020. https://lwn.net/Articles/812707/
> 
> 
> Baseline and Complete Git Trees
> ===============================
> 
> The patches are based on the v5.6.  You can also clone the complete git
> tree:
> 
>     $ git clone git://github.com/sjp38/linux -b damon/patches/v9
> 
> The web is also available:
> https://github.com/sjp38/linux/releases/tag/damon/patches/v9
> 
> This patchset contains patches for the stabled main logic of DAMON only.  The
> latest DAMON development tree is also available at:
> https://github.com/sjp38/linux/tree/damon/master
> 
> 
> Sequence Of Patches
> ===================
> 
> The patches are organized in the following sequence.  The first two patches are
> preparation of DAMON patchset.  The 1st patch adds typos found in previous
> versions of DAMON patchset to 'scripts/spelling.txt' so that the typos can be
> caught by 'checkpatch.pl'.  The 2nd patch exports 'lookup_page_ext()' to GPL
> modules so that it can be used by DAMON even though it is built as a loadable
> module.
> 
> Next four patches implement the core of DAMON and it's programming interface.
> The 3rd patch introduces DAMON module, it's data structures, and data structure
> related common functions.  Each of following three patches (4nd to 6th)
> implements the core mechanisms of DAMON, namely regions based sampling,
> adaptive regions adjustment, and dynamic memory mapping chage adoption,
> respectively, with programming interface supports of those.
> 
> Following four patches are for low level users of DAMON.  The 7th patch
> implements callbacks for each of monitoring steps so that users can do whatever
> they want with the access patterns.  The 8th one implements recording of access
> patterns in DAMON for better convenience and efficiency.  Each of next two
> patches (9th and 10th) respectively adds a debugfs interface for privileged
> people and/or programs in user space, and a tracepoint for other tracepoints
> supporting tracers such as perf.
> 
> Two patches for high level users of DAMON follows.  To provide a minimal
> reference to the debugfs interface and for high level use/tests of the DAMON,
> the next patch (11th) implements an user space tool.  The 12th patch adds a
> document for administrators of DAMON.
> 
> Next two patches are for tests.  The 13th and 14th patches provide unit tests
> (based on kunit) and user space tests (based on kselftest), respectively.
> 
> Finally, the last patch (15th) updates the MAINTAINERS file.
> 
> 
> Patch History
> =============
> 
> The most biggest change in this version is support of minimal region size,
> which defaults to 'PAGE_SIZE'.  This change will reduce unnecessary region
> splits and thus improve the quality of the output.  In a future, we will be
> able to make this configurable for support of various access check primitives
> such as PMUs.

That is a good improvement.  Might be interesting to consider taking
hugepages into account as well.

One issue I've noted is that we have a degeneracy problem with the current
region merging and splitting that perhaps could do with a small tweak.

Currently we can end with a very small number of regions because there
is no limit on how many regions can be merged in a give pass for merging.
However, splitting only doubles the number of regions.

I've been experimenting with a few loops of the splitting algorithm to ensure
we don't end up stuck with limited regions.  I think the problem we are working
around can be roughly described as:

1) Program allocates a lot of memory - not really touching much of it.
2) Damon fuses the large memory allocations in to one region because the
   access counts are always near 0. 
3) Program finishes setup.
4) Program accesses a few pages in the huge reason a lot, but not that much
   for most of the rest.  Taking an extreme option, the page in the middle
   gets all the accesses and the other 1G on either side gets none.
5) As a split always breaks the page in two, the chances of significantly
   different values for the two resulting regions is low (as we only sample
   the hot page occasionally).

If we just run the splits twice if the number of regions < max regions / 4
then over time we should eventually get a region with the single hot page in it.
We will get there faster if we split more (keeping below max regions).

As we always remain below max regions, we are still obeying the fixed
maximum overhead and actually monitoring at closer to the desired granularity.

Jonathan

> 
> Changes from v8
> (https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/)
>  - Make regions always aligned by minimal region size that can be changed
>    (Stefan Nuernberger)
>  - Store binary format version in the recording file (Stefan Nuernberger)
>  - Use 'int' for pid instead of 'unsigned long' (Stefan Nuernberger)
>  - Fix a race condition in damon thread termination (Stefan Nuernberger)
>  - Optimize random value generation and recording (Stefan Nuernberger)
>  - Clean up commit messages and comments (Stefan Nuernberger)
>  - Clean up code (Stefan Nuernberger)
>  - Use explicit signalling and 'do_exit()' for damon thread termination 
>  - Add more typos to spelling.txt
>  - Update the performance evaluation results
>  - Describe future plans in the cover letter
> 
> Changes from v7
> (https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/)
>  - Cleanup variable names (Jonathan Cameron)
>  - Split sampling address setup from access_check() (Jonathan Cameron)
>  - Make sampling address to always locate in the region (Jonathan Cameron)
>  - Make initial region's sampling addr to be old (Jonathan Cameron)
>  - Split kdamond on/off function to seperate functions (Jonathan Cameron)
>  - Fix wrong kernel doc comments (Jonathan Cameron)
>  - Reset 'last_accessed' to false in kdamond_check_access() if necessary
>  - Rebase on v5.6
> 
> Changes from v6
> (https://lore.kernel.org/linux-mm/20200224123047.32506-1-sjpark@amazon.com/)
>  - Wordsmith cover letter (Shakeel Butt)
>  - Cleanup code and commit messages (Jonathan Cameron)
>  - Avoid kthread_run() under spinlock critical section (Jonathan Cameron)
>  - Use kthread_stop() (Jonathan Cameron)
>  - Change tracepoint to trace regions (Jonathan Cameron)
>  - Implement API from the beginning (Jonathan Cameron)
>  - Fix typos (Jonathan Cameron)
>  - Fix access checking to properly handle regions smaller than single page
>    (Jonathan Cameron)
>  - Add found typos to 'scripts/spelling.txt'
>  - Add recent evaluation results including DAMON-based Operation Schemes
> 
> Changes from v5
> (https://lore.kernel.org/linux-mm/20200217103110.30817-1-sjpark@amazon.com/)
>  - Fix minor bugs (sampling, record attributes, debugfs and user space tool)
>  - selftests: Add debugfs interface tests for the bugs
>  - Modify the user space tool to use its self default values for parameters
>  - Fix pmg huge page access check
> 
> Changes from v4
> (https://lore.kernel.org/linux-mm/20200210144812.26845-1-sjpark@amazon.com/)
>  - Add 'Reviewed-by' for the kunit tests patch (Brendan Higgins)
>  - Make the unit test to depedns on 'DAMON=y' (Randy Dunlap and kbuild bot)
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Fix m68k module build issue
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Add selftests
>  - Seperate patches for low level users from core logics for better reading
>  - Clean up debugfs interface
>  - Trivial nitpicks
> 
> Changes from v3
> (https://lore.kernel.org/linux-mm/20200204062312.19913-1-sj38.park@gmail.com/)
>  - Fix i386 build issue
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Increase the default size of the monitoring result buffer to 1 MiB
>  - Fix misc bugs in debugfs interface
> 
> Changes from v2
> (https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/)
>  - Move MAINTAINERS changes to last commit (Brendan Higgins)
>  - Add descriptions for kunittest: why not only entire mappings and what the 4
>    input sets are trying to test (Brendan Higgins)
>  - Remove 'kdamond_need_stop()' test (Brendan Higgins)
>  - Discuss about the 'perf mem' and DAMON (Peter Zijlstra)
>  - Make CV clearly say what it actually does (Peter Zijlstra)
>  - Answer why new module (Qian Cai)
>  - Diable DAMON by default (Randy Dunlap)
>  - Change the interface: Seperate recording attributes
>    (attrs, record, rules) and allow multiple kdamond instances
>  - Implement kernel API interface
> 
> Changes from v1
> (https://lore.kernel.org/linux-mm/20200120162757.32375-1-sjpark@amazon.com/)
>  - Rebase on v5.5
>  - Add a tracepoint for integration with other tracers (Kirill A. Shutemov)
>  - document: Add more description for the user space tool (Brendan Higgins)
>  - unittest: Improve readability (Brendan Higgins)
>  - unittest: Use consistent name and helpers function (Brendan Higgins)
>  - Update PG_Young to avoid reclaim logic interference (Yunjae Lee)
> 
> Changes from RFC
> (https://lore.kernel.org/linux-mm/20200110131522.29964-1-sjpark@amazon.com/)
>  - Specify an ambiguous plan of access pattern based mm optimizations
>  - Support loadable module build
>  - Cleanup code
> 
> SeongJae Park (15):
>   scripts/spelling: Add a few more typos
>   mm/page_ext: Export lookup_page_ext() to GPL modules
>   mm: Introduce Data Access MONitor (DAMON)
>   mm/damon: Implement region based sampling
>   mm/damon: Adaptively adjust regions
>   mm/damon: Apply dynamic memory mapping changes
>   mm/damon: Implement callbacks
>   mm/damon: Implement access pattern recording
>   mm/damon: Add debugfs interface
>   mm/damon: Add tracepoints
>   tools: Add a minimal user-space tool for DAMON
>   Documentation/admin-guide/mm: Add a document for DAMON
>   mm/damon: Add kunit tests
>   mm/damon: Add user space selftests
>   MAINTAINERS: Update for DAMON
> 
>  .../admin-guide/mm/data_access_monitor.rst    |  428 +++++
>  Documentation/admin-guide/mm/index.rst        |    1 +
>  MAINTAINERS                                   |   12 +
>  include/linux/damon.h                         |   78 +
>  include/trace/events/damon.h                  |   43 +
>  mm/Kconfig                                    |   23 +
>  mm/Makefile                                   |    1 +
>  mm/damon-test.h                               |  615 +++++++
>  mm/damon.c                                    | 1494 +++++++++++++++++
>  mm/page_ext.c                                 |    1 +
>  scripts/spelling.txt                          |    8 +
>  tools/damon/.gitignore                        |    1 +
>  tools/damon/_dist.py                          |   36 +
>  tools/damon/_recfile.py                       |   23 +
>  tools/damon/bin2txt.py                        |   67 +
>  tools/damon/damo                              |   37 +
>  tools/damon/heats.py                          |  362 ++++
>  tools/damon/nr_regions.py                     |   91 +
>  tools/damon/record.py                         |  212 +++
>  tools/damon/report.py                         |   45 +
>  tools/damon/wss.py                            |   97 ++
>  tools/testing/selftests/damon/Makefile        |    7 +
>  .../selftests/damon/_chk_dependency.sh        |   28 +
>  tools/testing/selftests/damon/_chk_record.py  |  108 ++
>  .../testing/selftests/damon/debugfs_attrs.sh  |  139 ++
>  .../testing/selftests/damon/debugfs_record.sh |   50 +
>  26 files changed, 4007 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
>  create mode 100644 include/linux/damon.h
>  create mode 100644 include/trace/events/damon.h
>  create mode 100644 mm/damon-test.h
>  create mode 100644 mm/damon.c
>  create mode 100644 tools/damon/.gitignore
>  create mode 100644 tools/damon/_dist.py
>  create mode 100644 tools/damon/_recfile.py
>  create mode 100644 tools/damon/bin2txt.py
>  create mode 100755 tools/damon/damo
>  create mode 100644 tools/damon/heats.py
>  create mode 100644 tools/damon/nr_regions.py
>  create mode 100644 tools/damon/record.py
>  create mode 100644 tools/damon/report.py
>  create mode 100644 tools/damon/wss.py
>  create mode 100644 tools/testing/selftests/damon/Makefile
>  create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
>  create mode 100644 tools/testing/selftests/damon/_chk_record.py
>  create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
>  create mode 100755 tools/testing/selftests/damon/debugfs_record.sh
> 


