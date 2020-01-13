Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EFEC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jw+9Z/kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAMI5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:57:02 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:8003 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgAMI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578905820; x=1610441820;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=SPrb6++7x7JCO7KpCvNgGFIGaLQMGgn6a7ig17nmNPE=;
  b=jw+9Z/knad02RsHcvGlcoL8KgByUovLoociZ2ANrV7heUb7rL1SW0YJP
   BLpqM6XZkCuBDoTgilUiAvgNBZK/uvYt2DSRHgpyCOznOuOWdaYsbo7h7
   6DWWh2jkF/YepAkcQ2Ou88RQ6ta2GiQIi+YtrK3c0X/C2hJGkIbJekfNU
   c=;
IronPort-SDR: Klpwgfum2yeyPooMKCyR6tsd11bO0+2EH7onOHp/KalxKiehleT9oxOPf/BfGj6BvKfS+yI0ia
 I5jxkVJbaBiQ==
X-IronPort-AV: E=Sophos;i="5.69,428,1571702400"; 
   d="scan'208";a="11227170"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 13 Jan 2020 08:56:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 3F2CCA249B;
        Mon, 13 Jan 2020 08:56:55 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 13 Jan 2020 08:56:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.119) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 13 Jan 2020 08:56:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <mgorman@suse.de>,
        <brendanhiggins@google.com>, <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <rostedt@goodmis.org>, <brendan.d.gregg@gmail.com>,
        <amit@kernel.org>, <dwmw@amazon.com>
Subject: Re: [RFC PATCH 0/5] Introduce Data Access MONitor (DAMON)
Date:   Mon, 13 Jan 2020 09:56:12 +0100
Message-ID: <20200113085612.13552-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200110131522.29964-1-sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.119]
X-ClientProxiedBy: EX13D19UWA001.ant.amazon.com (10.43.160.169) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more recipients for comments.  The original RFC mail is available at:
https://lore.kernel.org/linux-mm/20200110131522.29964-1-sjpark@amazon.com/


Thanks,
SeongJae Park

On Fri, 10 Jan 2020 14:15:17 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This RFC patchset introduces a new kernel module for practical monitoring of
> data accesses, namely DAMON.
> 
> The patches are organized in the following sequence.  The first and second
> patch introduces the core logic and the raw level user interface of DAMON,
> respectively.  To provide a minimal reference to the raw level interfaces and
> for more convenient test of the DAMON itself, the third patch implements an
> user space wrapper tools for the DAMON.  The fourth patch adds a document for
> the DAMON, and finally the fifth patch provides DAMON's unit tests, which is
> using the kunit framework.
> 
> The patches are based on the v5.4 plus the back-ported kunit, which retrieved
> from v5.5-rc1.  You can also clone the complete git tree by:
> 
>     $ git clone git://github.com/sjp38/linux -b damon/rfc/v1
> 
> The web is also available:
> https://github.com/sjp38/linux/releases/tag/damon/rfc/v1
> 
> ----
> 
> DAMON is a kernel module that allows users to monitor the actual memory access
> pattern of specific user-space processes.  It aims to be 1) accurate enough to
> be useful for performance-centric domains, and 2) sufficiently light-weight so
> that it can be applied online.
> 
> For the goals, DAMON utilizes its two core mechanisms, called region-based
> sampling and adaptive regions adjustment.  The region-based sampling allows
> users to make their own trade-off between the quality and the overhead of the
> monitoring and set the upperbound of the monitoring overhead.  Further, the
> adaptive regions adjustment mechanism makes DAMON to maximize the quality and
> minimize the overhead with its best efforts while preserving the users
> configured trade-off.
> 
> 
> Background
> ==========
> 
> For performance-centric analysis and optimizations of memory management schemes
> (either that of kernel space or user space), the actual data access pattern of
> the workloads is highly useful.  The information need to be only reasonable
> rather than strictly correct, because some level of incorrectness can be
> handled in many performance-centric domains.  It also need to be taken within
> reasonably short time with only light-weight overhead.
> 
> Manually extracting such data is not easy and time consuming if the target
> workload is huge and complex, even for the developers of the programs.  There
> are a range of tools and techniques developed for general memory access
> investigations, and some of those could be partially used for this purpose.
> However, most of those are not practical or unscalable, mainly because those
> are designed with no consideration about the trade-off between the accuracy of
> the output and the overhead.
> 
> The memory access instrumentation techniques which is applied to many tools
> such as Intel PIN is essential for correctness required cases such as invalid
> memory access bug detections.  However, those usually incur high overhead which
> is unacceptable for many of the performance-centric domains.  Periodic access
> checks based on H/W or S/W access counting features (e.g., the Accessed bits of
> PTEs or the PG_Idle flags of pages) can dramatically decrease the overhead by
> forgiving some of the quality, compared to the instrumentation based
> techniques.  The reduced quality is still reasonable for many of the domains,
> but the overhead can arbitrarily increase as the size of the target workload
> grows.  Miniature-like static region based sampling can set the upperbound of
> the overhead, but it will now decrease the quality of the output as the size of
> the workload grows.
> 
> 
> Related Works
> =============
> 
> There are a number of researches[1,2,3,4,5,6] optimizing memory management
> mechanisms based on the actual memory access patterns that shows impressive
> results.  However, most of those has no deep consideration about the monitoring
> of the accesses itself.  Some of those focused on the overhead of the
> monitoring, but does not consider the accuracy scalability[6] or has additional
> dependencies[7].  Indeed, one recent research[5] about the proactive
> reclamation has also proposed[8] to the kernel community but the monitoring
> overhead was considered a main problem.
> 
> [1] Subramanya R Dulloor, Amitabha Roy, Zheguang Zhao, Narayanan Sundaram,
>     Nadathur Satish, Rajesh Sankaran, Jeff Jackson, and Karsten Schwan. 2016.
>     Data tiering in heterogeneous memory systems. In Proceedings of the 11th
>     European Conference on Computer Systems (EuroSys). ACM, 15.
> [2] Youngjin Kwon, Hangchen Yu, Simon Peter, Christopher J Rossbach, and Emmett
>     Witchel. 2016. Coordinated and efficient huge page management with ingens.
>     In 12th USENIX Symposium on Operating Systems Design and Implementation
>     (OSDI).  705–721.
> [3] Harald Servat, Antonio J Peña, Germán Llort, Estanislao Mercadal,
>     HansChristian Hoppe, and Jesús Labarta. 2017. Automating the application
>     data placement in hybrid memory systems. In 2017 IEEE International
>     Conference on Cluster Computing (CLUSTER). IEEE, 126–136.
> [4] Vlad Nitu, Boris Teabe, Alain Tchana, Canturk Isci, and Daniel Hagimont.
>     2018. Welcome to zombieland: practical and energy-efficient memory
>     disaggregation in a datacenter. In Proceedings of the 13th European
>     Conference on Computer Systems (EuroSys). ACM, 16.
> [5] Andres Lagar-Cavilla, Junwhan Ahn, Suleiman Souhlal, Neha Agarwal, Radoslaw
>     Burny, Shakeel Butt, Jichuan Chang, Ashwin Chaugule, Nan Deng, Junaid
>     Shahid, Greg Thelen, Kamil Adam Yurtsever, Yu Zhao, and Parthasarathy
>     Ranganathan.  2019. Software-Defined Far Memory in Warehouse-Scale
>     Computers.  In Proceedings of the 24th International Conference on
>     Architectural Support for Programming Languages and Operating Systems
>     (ASPLOS).  ACM, New York, NY, USA, 317–330.
>     DOI:https://doi.org/10.1145/3297858.3304053
> [6] Carl Waldspurger, Trausti Saemundsson, Irfan Ahmad, and Nohhyun Park.
>     2017. Cache Modeling and Optimization using Miniature Simulations. In 2017
>     USENIX Annual Technical Conference (ATC). USENIX Association, Santa
>     Clara, CA, 487–498.
>     https://www.usenix.org/conference/atc17/technical-sessions/
> [7] Haojie Wang, Jidong Zhai, Xiongchao Tang, Bowen Yu, Xiaosong Ma, and
>     Wenguang Chen. 2018. Spindle: Informed Memory Access Monitoring. In 2018
>     USENIX Annual Technical Conference (ATC). USENIX Association, Boston, MA,
>     561–574.  https://www.usenix.org/conference/atc18/presentation/wang-haojie
> [8] Jonathan Corbet. 2019. Proactively reclaiming idle memory. (2019).
>     https://lwn.net/Articles/787611/.
> 
> 
> Expected Use-cases
> ==================
> 
> A straightforward usecase of DAMON would be the program behavior analysis.
> With the DAMON output, users can confirm whether the program is running as
> intended or not.  This will be useful for debuggings and tests of design
> points.
> 
> The monitored results can also be useful for counting the dynamic working set
> size of workloads.  For the administration of memory overcommitted systems or
> selection of the environments (e.g., containers providing different amount of
> memory) for your workloads, this will be useful.
> 
> If you are a programmer, you can optimize your program by managing the memory
> based on the actual data access pattern.  For example, you can identify the
> dynamic hotness of your data using DAMON and call ``mlock()`` to keep your hot
> data in DRAM, or call ``madvise()`` with ``MADV_PAGEOUT`` to proactively
> reclaim cold data.  Even though your program is guaranteed to not encounter
> memory pressure, you can still improve the performance by applying the DAMON
> outputs for call of ``MADV_HUGEPAGE`` and ``MADV_NOHUGEPAGE``.  More creative
> optimizations would be possible.  Our evaluations of DAMON includes a
> straightforward optimization using the ``mlock()``.  Please refer to the below
> Evaluation section for more detail.
> 
> As DAMON incurs very low overhead, such optimizations can be applied not only
> offline, but also online.  Also, there is no reason to limit such optimizations
> to the user space.  Several parts of the kernel's memory management mechanisms
> could be also optimized using DAMON. The reclamation, the THP (de)promotion
> decisions, and the compaction would be such a candidates.  Nevertheless,
> current version of DAMON is not highly optimized for the online/in-kernel uses.
> 
> 
> Mechanisms of DAMON
> ===================
> 
> 
> Basic Access Check
> ------------------
> 
> DAMON basically reports what pages are how frequently accessed.  The report is
> passed to users in binary format via a ``result file`` which users can set it's
> path.  Note that the frequency is not an absolute number of accesses, but a
> relative frequency among the pages of the target workloads.
> 
> Users can also control the resolution of the reports by setting two time
> intervals, ``sampling interval`` and ``aggregation interval``.  In detail,
> DAMON checks access to each page per ``sampling interval``, aggregates the
> results (counts the number of the accesses to each page), and reports the
> aggregated results per ``aggregation interval``.  For the access check of each
> page, DAMON uses the Accessed bits of PTEs.
> 
> This is thus similar to the previously mentioned periodic access checks based
> mechanisms, which overhead is increasing as the size of the target process
> grows.
> 
> 
> Region Based Sampling
> ---------------------
> 
> To avoid the unbounded increase of the overhead, DAMON groups a number of
> adjacent pages that assumed to have same access frequencies into a region.  As
> long as the assumption (pages in a region have same access frequencies) is
> kept, only one page in the region is required to be checked.  Thus, for each
> ``sampling interval``, DAMON randomly picks one page in each region and clears
> its Accessed bit.  After one more ``sampling interval``, DAMON reads the
> Accessed bit of the page and increases the access frequency of the region if
> the bit has set meanwhile.  Therefore, the monitoring overhead is controllable
> by setting the number of regions.  DAMON allows users to set the minimal and
> maximum number of regions for the trade-off.
> 
> Except the assumption, this is almost same with the above-mentioned
> miniature-like static region based sampling.  In other words, this scheme
> cannot preserve the quality of the output if the assumption is not guaranteed.
> 
> 
> Adaptive Regions Adjustment
> ---------------------------
> 
> At the beginning of the monitoring, DAMON constructs the initial regions by
> evenly splitting the memory mapped address space of the process into the
> user-specified minimal number of regions.  In this initial state, the
> assumption is normally not kept and thus the quality could be low.  To keep the
> assumption as much as possible, DAMON adaptively merges and splits each region.
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.  Then,
> after it reports and clears the aggregated access frequency of each region, it
> splits each region into two regions if the total number of regions is smaller
> than the half of the user-specified maximum number of regions.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead while
> keeping the bounds users set for their trade-off.
> 
> 
> Applying Dynamic Memory Mappings
> --------------------------------
> 
> Only a number of small parts in the super-huge virtual address space of the
> processes is mapped to physical memory and accessed.  Thus, tracking the
> unmapped address regions is just wasteful.  However, tracking every memory
> mapping change might incur an overhead.  For the reason, DAMON applies the
> dynamic memory mapping changes to the tracking regions only for each of an
> user-specified time interval (``regions update interval``).
> 
> 
> Evaluations
> ===========
> 
> A prototype of DAMON has evaluated on an Intel Xeon E7-8837 machine using 20
> benchmarks that picked from SPEC CPU 2006, NAS, Tensorflow Benchmark,
> SPLASH-2X, and PARSEC 3 benchmark suite.  Nonethless, this section provides
> only summary of the results.  For more detail, please refer to the slides used
> for the introduction of DAMON at the Linux Plumbers Conference 2019[1] or the
> MIDDLEWARE'19 industrial track paper[2].
> 
> 
> Quality
> -------
> 
> We first traced and visualized the data access pattern of each workload.  We
> were able to confirm that the visualized results are reasonably accurate by
> manually comparing those with the source code of the workloads.
> 
> To see the usefulness of the monitoring, we optimized 9 memory intensive
> workloads among them for memory pressure situations using the DAMON outputs.
> In detail, we identified frequently accessed memory regions in each workload
> based on the DAMON results and protected them with ``mlock()`` system calls.
> The optimized versions consistently show speedup (2.55x in best case, 1.65x in
> average) under memory pressure situation.
> 
> 
> Overhead
> --------
> 
> We also measured the overhead of DAMON.  It was not only under the upperbound
> we set, but was much lower (0.6 percent of the bound in best case, 13.288
> percent of the bound in average).  This reduction of the overhead is mainly
> resulted from the adaptive regions adjustment.  We also compared the overhead
> with that of the straightforward periodic Accessed bit check-based monitoring,
> which checks the access of every page frame.  DAMON's overhead was much smaller
> than the straightforward mechanism by 94,242.42x in best case, 3,159.61x in
> average.
> 
> 
> References
> ==========
> 
> Prototypes of DAMON have introduced by an LPC kernel summit track talk[1] and
> two academic papers[2,3].  Please refer to those for more detailed information,
> especially the evaluations.
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
> 
> 
> SeongJae Park (5):
>   mm: Introduce Data Access MONitor (DAMON)
>   mm/damon: Add debugfs interface
>   mm/damon: Add minimal user-space tools
>   Documentation/admin-guide/mm: Add a document for DAMON
>   mm/damon: Add kunit tests
> 
>  .../admin-guide/mm/data_access_monitor.rst    |  235 +++
>  Documentation/admin-guide/mm/index.rst        |    1 +
>  mm/Kconfig                                    |   23 +
>  mm/Makefile                                   |    1 +
>  mm/damon-test.h                               |  571 ++++++++
>  mm/damon.c                                    | 1266 +++++++++++++++++
>  tools/damon/bin2txt.py                        |   64 +
>  tools/damon/damn                              |   36 +
>  tools/damon/heats.py                          |  358 +++++
>  tools/damon/nr_regions.py                     |  116 ++
>  tools/damon/record.py                         |  182 +++
>  tools/damon/report.py                         |   45 +
>  tools/damon/wss.py                            |  121 ++
>  13 files changed, 3019 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
>  create mode 100644 mm/damon-test.h
>  create mode 100644 mm/damon.c
>  create mode 100644 tools/damon/bin2txt.py
>  create mode 100644 tools/damon/damn
>  create mode 100644 tools/damon/heats.py
>  create mode 100644 tools/damon/nr_regions.py
>  create mode 100644 tools/damon/record.py
>  create mode 100644 tools/damon/report.py
>  create mode 100644 tools/damon/wss.py
> 
> -- 
> 2.17.1
> 
