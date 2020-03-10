Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462ADC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F097822525
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmE1CvYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJRVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:21:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33420 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:21:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id r7so1518377oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JvjzFLriWxQvRBmw6WKMxpjn3gjpugMaTHYOYYJCAGQ=;
        b=qmE1CvYPmRbdieA8HMRBxWbcRhAyA4kT0V39pAhHP3BOgxy7kkXLlQXpiHFXYTi0mT
         aXWjGA7z6wvyGn6OjYetLBhEu9xFRCiSgJJsigJSCkrxf3mbW8IOarmjDSqmpF8oIzWH
         bFfcGXluNjDP9Y75Awn6fFEUzYkUkZABeFT4GZLGSko7ZNulLgKNthkg0bEC7yFiG1WQ
         P377nck8dP8fbKt2+vxb6yzJi+UYFy6tJfWfX5fbtu7dHPVijsFKRNZ2omzJy76lcXYP
         ArA8iaBqO+bNPJSo1C4iy4lu79AiWuyXRqlWcBtC6Zcq58KIAXF3FJL++UWoEAvAgf7F
         QHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JvjzFLriWxQvRBmw6WKMxpjn3gjpugMaTHYOYYJCAGQ=;
        b=HaESCGZKMRNbKSGS3HTLKm+rzE2ITldNsbFhxkARVEzfSThI1jSitn6NKiRVpsRybE
         zIyAlpLoA71XoL5R+fZrh0ad/dk65/iqXtpK81yB4AAc5ZzuCphqvkUqwUApxnx1M0Qf
         SUz8azdkRydVwxIShQs5MPohbtn5t9At0/PpP6J/WrHc+mv46Lmv+7ww365z4tX2+bO2
         GjHoeZ9trsH1aH7oNLBhMWFhGJPt2MAAER6RoYUFRUZBxRnuBKIpl8cfHPjpnPydpzrO
         xSxiNsP+ZVZmRkl+Y9tf46IydmTWLu7LN/y6dZQWDm6IRVlwb0yNlfT2yNNlJwwLdLlo
         Nc7w==
X-Gm-Message-State: ANhLgQ1FtSo07Gs5Ru2ghSIwVVBt0MwZ5nv7aBb9+9/sDs2dREq4UyQj
        E0uOTldWSx9gpjlCS/zjYhXdgTpE+Ki1IJpxtCdMEg==
X-Google-Smtp-Source: ADFU+vv2J65HvNEccUploUu0urgAHzhJZ6gUEUWFT8Y+cj/5NDva+12Es9wt5KAHnHVlNsu58M6iT/buNmzuoq4iDHU=
X-Received: by 2002:aca:4183:: with SMTP id o125mr1878707oia.125.1583860905722;
 Tue, 10 Mar 2020 10:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200224123047.32506-1-sjpark@amazon.com>
In-Reply-To: <20200224123047.32506-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Mar 2020 10:21:34 -0700
Message-ID: <CALvZod4RCHWJ30m08Lqk1zxpU2-BnZ=iQjfdxGid3bjAuLSJDA@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        sj38.park@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 4:31 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Memory management decisions can be improved if finer data access informat=
ion is
> available.  However, because such finer information usually comes with hi=
gher
> overhead, most systems including Linux forgives the potential improvement=
 and
> rely on only coarse information or some light-weight heuristics.  The
> pseudo-LRU and the aggressive THP promotions are such examples.
>
> A number of experimental data access pattern awared memory management

why experimental? [5,8] are deployed across Google fleet.

> optimizations (refer to 'Appendix A' for more details) say the sacrifices=
 are
> huge.

It depends. For servers where stranded CPUs are common, the cost is
not that huge.

> However, none of those has successfully adopted to Linux kernel mainly

adopted? I think you mean accepted or merged

> due to the absence of a scalable and efficient data access monitoring
> mechanism.  Refer to 'Appendix B' to see the limitations of existing memo=
ry
> monitoring mechanisms.
>
> DAMON is a data access monitoring subsystem for the problem.  It is 1) ac=
curate
> enough to be used for the DRAM level memory management (a straightforward
> DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight e=
nough
> to be applied online (compared to a straightforward access monitoring sch=
eme,
> DAMON is up to 94.242.42x lighter)

94.242.42x ?

> and 3) keeps predefined upper-bound overhead
> regardless of the size of target workloads (thus scalable).  Refer to 'Ap=
pendix
> C' if you interested in how it is possible.
>
> DAMON has mainly designed for the kernel's memory management mechanisms.
> However, because it is implemented as a standalone kernel module and prov=
ides
> several interfaces, it can be used by a wide range of users including ker=
nel
> space programs, user space programs, programmers, and administrators.  DA=
MON
> is now supporting the monitoring only, but it will also provide simple an=
d
> convenient data access pattern awared memory managements by itself.  Refe=
r to
> 'Appendix D' for more detailed expected usages of DAMON.
>
>
> Visualized Outputs of DAMON
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> For intuitively understanding of DAMON, I made web pages[1-8] showing the
> visualized dynamic data access pattern of various realistic workloads, wh=
ich I
> picked up from PARSEC3 and SPLASH-2X bechmark suites.  The figures are
> generated using the user space tool in 10th patch of this patchset.
>
> There are pages showing the heatmap format dynamic access pattern of each
> workload for heap area[1], mmap()-ed area[2], and stack[3] area.  I split=
ted
> the entire address space to the three area because there are huge unmappe=
d
> regions between the areas.
>
> You can also show how the dynamic working set size of each workload is
> distributed[4], and how it is chronologically changing[5].
>
> The most important characteristic of DAMON is its promise of the upperbou=
nd of
> the monitoring overhead.  To show whether DAMON keeps the promise well, I
> visualized the number of monitoring operations required for each 5
> milliseconds, which is configured to not exceed 1000.  You can show the
> distribution of the numbers[6] and how it changes chronologically[7].
>
> [1] https://damonitor.github.io/reports/latest/by_image/heatmap.0.png.htm=
l
> [2] https://damonitor.github.io/reports/latest/by_image/heatmap.1.png.htm=
l
> [3] https://damonitor.github.io/reports/latest/by_image/heatmap.2.png.htm=
l
> [4] https://damonitor.github.io/reports/latest/by_image/wss_sz.png.html
> [5] https://damonitor.github.io/reports/latest/by_image/wss_time.png.html
> [6] https://damonitor.github.io/reports/latest/by_image/nr_regions_sz.png=
.html
> [7] https://damonitor.github.io/reports/latest/by_image/nr_regions_time.p=
ng.html
>
>
> Data Access Monitoring-based Operation Schemes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As 'Appendix D' describes, DAMON can be used for data access monitoring-b=
ased
> operation schemes (DAMOS).  RFC patchsets for DAMOS are already available
> (https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.co=
m/).
>
> By applying a very simple scheme for THP promotion/demotion with a latest
> version of the patchset (not posted yet), DAMON achieved 18x lower memory=
 space
> overhead compared to THP while preserving about 50% of the THP performanc=
e
> benefit with SPLASH-2X benchmark suite.
>
> The detailed setup and number will be posted soon with the next RFC patch=
set
> for DAMOS.  The posting is currently scheduled for tomorrow.
>
>
> Frequently Asked Questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> Q: Why DAMON is not integrated with perf?
> A: From the perspective of perf like profilers, DAMON can be thought of a=
s a
> data source in kernel, like the tracepoints, the pressure stall informati=
on
> (psi), or the idle page tracking.  Thus, it is easy to integrate DAMON wi=
th the
> profilers.  However, this patchset doesn't provide a fancy perf integrati=
on
> because current step of DAMON development is focused on its core logic on=
ly.
> That said, DAMON already provides two interfaces for user space programs,=
 which
> based on debugfs and tracepoint, respectively.  Using the tracepoint inte=
rface,
> you can use DAMON with perf.  This patchset also provides a debugfs inter=
face
> based user space tool for DAMON.  It can be used to record, visualize, an=
d
> analyze data access patterns of target processes in a convenient way.

Oh it is monitoring at the process level.

>
> Q: Why a new module, instead of extending perf or other tools?
> A: First, DAMON aims to be used by other programs including the kernel.
> Therefore, having dependency to specific tools like perf is not desirable=
.
> Second, because it need to be lightweight as much as possible so that it =
can be
> used online, any unnecessary overhead such as kernel - user space context
> switching cost should be avoided.  These are the two most biggest reasons=
 why
> DAMON is implemented in the kernel space.  The idle page tracking subsyst=
em
> would be the kernel module that most seems similar to DAMON.  However, it=
s own
> interface is not compatible with DAMON.  Also, the internal implementatio=
n of
> it has no common part to be reused by DAMON.
>
> Q: Can 'perf mem' provide the data required for DAMON?
> A: On the systems supporting 'perf mem', yes.  DAMON is using the PTE Acc=
essed
> bits in low level.  Other H/W or S/W features that can be used for the pu=
rpose
> could be used.  However, as explained with above question, DAMON need to =
be
> implemented in the kernel space.
>
>
> Evaluations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A prototype of DAMON has evaluated on an Intel Xeon E7-8837 machine using=
 20
> benchmarks that picked from SPEC CPU 2006, NAS, Tensorflow Benchmark,
> SPLASH-2X, and PARSEC 3 benchmark suite.  Nonethless, this section provid=
es
> only summary of the results.  For more detail, please refer to the slides=
 used
> for the introduction of DAMON at the Linux Plumbers Conference 2019[1] or=
 the
> MIDDLEWARE'19 industrial track paper[2].

The paper [2] is behind a paywall, upload it somewhere for free access.

>
>
> Quality
> -------
>
> We first traced and visualized the data access pattern of each workload. =
 We
> were able to confirm that the visualized results are reasonably accurate =
by
> manually comparing those with the source code of the workloads.
>
> To see the usefulness of the monitoring, we optimized 9 memory intensive
> workloads among them for memory pressure situations using the DAMON outpu=
ts.
> In detail, we identified frequently accessed memory regions in each workl=
oad
> based on the DAMON results and protected them with ``mlock()`` system cal=
ls.

Did you change the applications to add mlock() or was it done
dynamically through some new interface? The hot memory / working set
changes, so, dynamically m[un]locking makes sense.

> The optimized versions consistently show speedup (2.55x in best case, 1.6=
5x in
> average) under memory pressure.
>

Do tell more about these 9 workloads and how they were evaluated. How
memory pressure was induced? Did you overcommit the memory? How many
workloads were running concurrently? How was the performance isolation
between the workloads? Is this speedup due to triggering oom-killer
earlier under memory pressure or something else?

>
> Overhead
> --------
>
> We also measured the overhead of DAMON.  It was not only under the upperb=
ound
> we set, but was much lower (0.6 percent of the bound in best case, 13.288
> percent of the bound in average).

Why the upperbound you set matters?

> This reduction of the overhead is mainly
> resulted from its core mechanism called adaptive regions adjustment.  Ref=
er to
> 'Appendix D' for more detail about the mechanism.  We also compared the
> overhead of DAMON with that of a straightforward periodic access check-ba=
sed
> monitoring.

What is periodic access check-based monitoring?

> DAMON's overhead was smaller than it by 94,242.42x in best case,
> 3,159.61x in average.
>
> The latest version of DAMON running with its default configuration consum=
es
> only up to 1% of CPU time when applied to realistic workloads in PARSEC3 =
and
> SPLASH-2X and makes no visible slowdown to the target processes.

What about the number of processes? The alternative mechanism in [5,8]
are whole machine monitoring. Thousands of processes run on a machine.
How does this work monitoring thousands of processes compared to
[5,8].

Using sampling the cost/overhead is configurable but I would like to
know at what cost? Will the accuracy be good enough for the given
use-case?

>
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Prototypes of DAMON have introduced by an LPC kernel summit track talk[1]=
 and
> two academic papers[2,3].  Please refer to those for more detailed inform=
ation,
> especially the evaluations.  The latest version of the patchsets has also
> introduced by an LWN artice[4].
>
> [1] SeongJae Park, Tracing Data Access Pattern with Bounded Overhead and
>     Best-effort Accuracy. In The Linux Kernel Summit, September 2019.
>     https://linuxplumbersconf.org/event/4/contributions/548/
> [2] SeongJae Park, Yunjae Lee, Heon Y. Yeom, Profiling Dynamic Data Acces=
s
>     Patterns with Controlled Overhead and Quality. In 20th ACM/IFIP
>     International Middleware Conference Industry, December 2019.
>     https://dl.acm.org/doi/10.1145/3366626.3368125
> [3] SeongJae Park, Yunjae Lee, Yunhee Kim, Heon Y. Yeom, Profiling Dynami=
c Data
>     Access Patterns with Bounded Overhead and Accuracy. In IEEE Internati=
onal
>     Workshop on Foundations and Applications of Self- Systems (FAS 2019),=
 June
>     2019.
> [4] Jonathan Corbet, Memory-management optimization with DAMON. In Linux =
Weekly
>     News (LWN), Feb 2020. https://lwn.net/Articles/812707/
>
>
> Sequence Of Patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The patches are organized in the following sequence.  The first patch
> introduces DAMON module, it's data structures, and data structure related
> common functions.  Following three patches (2nd to 4th) implement the cor=
e
> logics of DAMON, namely regions based sampling, adaptive regions adjustme=
nt,
> and dynamic memory mapping chage adoption, one by one.
>
> Following five patches are for low level users of DAMON.  The 5th patch
> implements callbacks for each of monitoring steps so that users can do wh=
atever
> they want with the access patterns.  The 6th one implements recording of =
access
> patterns in DAMON for better convenience and efficiency.  Each of next th=
ree
> patches (7th to 9th) respectively adds a programmable interface for other
> kernel code, a debugfs interface for privileged people and/or programs in=
 user
> space, and a tracepoint for other tracepoints supporting tracers such as =
perf.
>
> Two patches for high level users of DAMON follows.  To provide a minimal
> reference to the debugfs interface and for high level use/tests of the DA=
MON,
> the next patch (10th) implements an user space tool.  The 11th patch adds=
 a
> document for administrators of DAMON.
>
> Next two patches are for tests.  The 12th and 13th patches provide unit t=
ests
> (based on kunit) and user space tests (based on kselftest) respectively.
>
> Finally, the last patch (14th) updates the MAINTAINERS file.
>
> The patches are based on the v5.5.  You can also clone the complete git
> tree:
>
>     $ git clone git://github.com/sjp38/linux -b damon/patches/v6
>
> The web is also available:
> https://github.com/sjp38/linux/releases/tag/damon/patches/v6
>
>
> Patch History
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Changes from v5
> (https://lore.kernel.org/linux-mm/20200217103110.30817-1-sjpark@amazon.co=
m/)
>  - Fix minor bugs (sampling, record attributes, debugfs and user space to=
ol)
>  - selftests: Add debugfs interface tests for the bugs
>  - Modify the user space tool to use its self default values for paramete=
rs
>  - Fix pmg huge page access check
>
> Changes from v4
> (https://lore.kernel.org/linux-mm/20200210144812.26845-1-sjpark@amazon.co=
m/)
>  - Add 'Reviewed-by' for the kunit tests patch (Brendan Higgins)
>  - Make the unit test to depedns on 'DAMON=3Dy' (Randy Dunlap and kbuild =
bot)
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Fix m68k module build issue
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Add selftests
>  - Seperate patches for low level users from core logics for better readi=
ng
>  - Clean up debugfs interface
>  - Trivial nitpicks
>
> Changes from v3
> (https://lore.kernel.org/linux-mm/20200204062312.19913-1-sj38.park@gmail.=
com/)
>  - Fix i386 build issue
>    Reported-by: kbuild test robot <lkp@intel.com>
>  - Increase the default size of the monitoring result buffer to 1 MiB
>  - Fix misc bugs in debugfs interface
>
> Changes from v2
> (https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.co=
m/)
>  - Move MAINTAINERS changes to last commit (Brendan Higgins)
>  - Add descriptions for kunittest: why not only entire mappings and what =
the 4
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
> (https://lore.kernel.org/linux-mm/20200120162757.32375-1-sjpark@amazon.co=
m/)
>  - Rebase on v5.5
>  - Add a tracepoint for integration with other tracers (Kirill A. Shutemo=
v)
>  - document: Add more description for the user space tool (Brendan Higgin=
s)
>  - unittest: Improve readability (Brendan Higgins)
>  - unittest: Use consistent name and helpers function (Brendan Higgins)
>  - Update PG_Young to avoid reclaim logic interference (Yunjae Lee)
>
> Changes from RFC
> (https://lore.kernel.org/linux-mm/20200110131522.29964-1-sjpark@amazon.co=
m/)
>  - Specify an ambiguous plan of access pattern based mm optimizations
>  - Support loadable module build
>  - Cleanup code
>
> SeongJae Park (14):
>   mm: Introduce Data Access MONitor (DAMON)
>   mm/damon: Implement region based sampling
>   mm/damon: Adaptively adjust regions
>   mm/damon: Apply dynamic memory mapping changes
>   mm/damon: Implement callbacks
>   mm/damon: Implement access pattern recording
>   mm/damon: Implement kernel space API
>   mm/damon: Add debugfs interface
>   mm/damon: Add a tracepoint for result writing
>   tools: Add a minimal user-space tool for DAMON
>   Documentation/admin-guide/mm: Add a document for DAMON
>   mm/damon: Add kunit tests
>   mm/damon: Add user selftests
>   MAINTAINERS: Update for DAMON
>
>  .../admin-guide/mm/data_access_monitor.rst    |  414 +++++
>  Documentation/admin-guide/mm/index.rst        |    1 +
>  MAINTAINERS                                   |   12 +
>  include/linux/damon.h                         |   71 +
>  include/trace/events/damon.h                  |   32 +
>  mm/Kconfig                                    |   23 +
>  mm/Makefile                                   |    1 +
>  mm/damon-test.h                               |  604 +++++++
>  mm/damon.c                                    | 1427 +++++++++++++++++
>  mm/page_ext.c                                 |    1 +
>  tools/damon/.gitignore                        |    1 +
>  tools/damon/_dist.py                          |   36 +
>  tools/damon/bin2txt.py                        |   64 +
>  tools/damon/damo                              |   37 +
>  tools/damon/heats.py                          |  358 +++++
>  tools/damon/nr_regions.py                     |   89 +
>  tools/damon/record.py                         |  212 +++
>  tools/damon/report.py                         |   45 +
>  tools/damon/wss.py                            |   95 ++
>  tools/testing/selftests/damon/Makefile        |    7 +
>  .../selftests/damon/_chk_dependency.sh        |   28 +
>  tools/testing/selftests/damon/_chk_record.py  |   89 +
>  .../testing/selftests/damon/debugfs_attrs.sh  |  139 ++
>  .../testing/selftests/damon/debugfs_record.sh |   50 +
>  24 files changed, 3836 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
>  create mode 100644 include/linux/damon.h
>  create mode 100644 include/trace/events/damon.h
>  create mode 100644 mm/damon-test.h
>  create mode 100644 mm/damon.c
>  create mode 100644 tools/damon/.gitignore
>  create mode 100644 tools/damon/_dist.py
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
> --
> 2.17.1
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Appendix A: Related Works
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> There are a number of researches[1,2,3,4,5,6] optimizing memory managemen=
t
> mechanisms based on the actual memory access patterns that shows impressi=
ve
> results.  However, most of those has no deep consideration about the moni=
toring
> of the accesses itself.  Some of those focused on the overhead of the
> monitoring, but does not consider the accuracy scalability[6] or has addi=
tional
> dependencies[7].  Indeed, one recent research[5] about the proactive
> reclamation has also proposed[8] to the kernel community but the monitori=
ng
> overhead was considered a main problem.
>
> [1] Subramanya R Dulloor, Amitabha Roy, Zheguang Zhao, Narayanan Sundaram=
,
>     Nadathur Satish, Rajesh Sankaran, Jeff Jackson, and Karsten Schwan. 2=
016.
>     Data tiering in heterogeneous memory systems. In Proceedings of the 1=
1th
>     European Conference on Computer Systems (EuroSys). ACM, 15.
> [2] Youngjin Kwon, Hangchen Yu, Simon Peter, Christopher J Rossbach, and =
Emmett
>     Witchel. 2016. Coordinated and efficient huge page management with in=
gens.
>     In 12th USENIX Symposium on Operating Systems Design and Implementati=
on
>     (OSDI).  705=E2=80=93721.
> [3] Harald Servat, Antonio J Pe=C3=B1a, Germ=C3=A1n Llort, Estanislao Mer=
cadal,
>     HansChristian Hoppe, and Jes=C3=BAs Labarta. 2017. Automating the app=
lication
>     data placement in hybrid memory systems. In 2017 IEEE International
>     Conference on Cluster Computing (CLUSTER). IEEE, 126=E2=80=93136.
> [4] Vlad Nitu, Boris Teabe, Alain Tchana, Canturk Isci, and Daniel Hagimo=
nt.
>     2018. Welcome to zombieland: practical and energy-efficient memory
>     disaggregation in a datacenter. In Proceedings of the 13th European
>     Conference on Computer Systems (EuroSys). ACM, 16.
> [5] Andres Lagar-Cavilla, Junwhan Ahn, Suleiman Souhlal, Neha Agarwal, Ra=
doslaw
>     Burny, Shakeel Butt, Jichuan Chang, Ashwin Chaugule, Nan Deng, Junaid
>     Shahid, Greg Thelen, Kamil Adam Yurtsever, Yu Zhao, and Parthasarathy
>     Ranganathan.  2019. Software-Defined Far Memory in Warehouse-Scale
>     Computers.  In Proceedings of the 24th International Conference on
>     Architectural Support for Programming Languages and Operating Systems
>     (ASPLOS).  ACM, New York, NY, USA, 317=E2=80=93330.
>     DOI:https://doi.org/10.1145/3297858.3304053
> [6] Carl Waldspurger, Trausti Saemundsson, Irfan Ahmad, and Nohhyun Park.
>     2017. Cache Modeling and Optimization using Miniature Simulations. In=
 2017
>     USENIX Annual Technical Conference (ATC). USENIX Association, Santa
>     Clara, CA, 487=E2=80=93498.
>     https://www.usenix.org/conference/atc17/technical-sessions/
> [7] Haojie Wang, Jidong Zhai, Xiongchao Tang, Bowen Yu, Xiaosong Ma, and
>     Wenguang Chen. 2018. Spindle: Informed Memory Access Monitoring. In 2=
018
>     USENIX Annual Technical Conference (ATC). USENIX Association, Boston,=
 MA,
>     561=E2=80=93574.  https://www.usenix.org/conference/atc18/presentatio=
n/wang-haojie
> [8] Jonathan Corbet. 2019. Proactively reclaiming idle memory. (2019).
>     https://lwn.net/Articles/787611/.
>
>
> Appendix B: Limitations of Other Access Monitoring Techniques
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The memory access instrumentation techniques which are applied to
> many tools such as Intel PIN is essential for correctness required cases =
such
> as memory access bug detections or cache level optimizations.  However, t=
hose
> usually incur exceptionally high overhead which is unacceptable.
>
> Periodic access checks based on access counting features (e.g., PTE Acces=
sed
> bits or PG_Idle flags) can reduce the overhead.  It sacrifies some of the
> quality but it's still ok to many of this domain.  However, the overhead
> arbitrarily increase as the size of the target workload grows.  Miniature=
-like
> static region based sampling can set the upperbound of the overhead, but =
it
> will now decrease the quality of the output as the size of the workload g=
rows.
>
> DAMON is another solution that overcomes the limitations.  It is 1) accur=
ate
> enough for this domain, 2) light-weight so that it can be applied online,=
 and
> 3) allow users to set the upper-bound of the overhead, regardless of the =
size
> of target workloads.  It is implemented as a simple and small kernel modu=
le to
> support various users in both of the user space and the kernel space.  Re=
fer to
> 'Evaluations' section below for detailed performance of DAMON.
>
> For the goals, DAMON utilizes its two core mechanisms, which allows light=
weight
> overhead and high quality of output, repectively.  To show how DAMON prom=
ises
> those, refer to 'Mechanisms of DAMON' section below.
>
>
> Appendix C: Mechanisms of DAMON
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>
> Basic Access Check
> ------------------
>
> DAMON basically reports what pages are how frequently accessed.  The repo=
rt is
> passed to users in binary format via a ``result file`` which users can se=
t it's
> path.  Note that the frequency is not an absolute number of accesses, but=
 a
> relative frequency among the pages of the target workloads.
>
> Users can also control the resolution of the reports by setting two time
> intervals, ``sampling interval`` and ``aggregation interval``.  In detail=
,
> DAMON checks access to each page per ``sampling interval``, aggregates th=
e
> results (counts the number of the accesses to each page), and reports the
> aggregated results per ``aggregation interval``.

Why is "aggregation interval" important? User space can just poll
after such interval.

> For the access check of each
> page, DAMON uses the Accessed bits of PTEs.
>
> This is thus similar to the previously mentioned periodic access checks b=
ased
> mechanisms, which overhead is increasing as the size of the target proces=
s
> grows.
>
>
> Region Based Sampling
> ---------------------
>
> To avoid the unbounded increase of the overhead, DAMON groups a number of
> adjacent pages that assumed to have same access frequencies into a region=
.  As
> long as the assumption (pages in a region have same access frequencies) i=
s
> kept, only one page in the region is required to be checked.  Thus, for e=
ach
> ``sampling interval``, DAMON randomly picks one page in each region and c=
lears
> its Accessed bit.  After one more ``sampling interval``, DAMON reads the
> Accessed bit of the page and increases the access frequency of the region=
 if
> the bit has set meanwhile.  Therefore, the monitoring overhead is control=
lable
> by setting the number of regions.  DAMON allows users to set the minimal =
and
> maximum number of regions for the trade-off.
>
> Except the assumption, this is almost same with the above-mentioned
> miniature-like static region based sampling.  In other words, this scheme
> cannot preserve the quality of the output if the assumption is not guaran=
teed.
>

So, the spatial locality is assumed.

>
> Adaptive Regions Adjustment
> ---------------------------
>
> At the beginning of the monitoring, DAMON constructs the initial regions =
by
> evenly splitting the memory mapped address space of the process into the
> user-specified minimal number of regions.  In this initial state, the
> assumption is normally not kept and thus the quality could be low.  To ke=
ep the
> assumption as much as possible, DAMON adaptively merges and splits each r=
egion.
> For each ``aggregation interval``, it compares the access frequencies of

Oh aggregation interval is used for merging event.

> adjacent regions and merges those if the frequency difference is small.  =
Then,
> after it reports and clears the aggregated access frequency of each regio=
n, it
> splits each region into two regions if the total number of regions is sma=
ller
> than the half of the user-specified maximum number of regions.
>

What's the equilibrium/stable state here?

> In this way, DAMON provides its best-effort quality and minimal overhead =
while
> keeping the bounds users set for their trade-off.
>
>
> Applying Dynamic Memory Mappings
> --------------------------------
>
> Only a number of small parts in the super-huge virtual address space of t=
he
> processes is mapped to physical memory and accessed.  Thus, tracking the
> unmapped address regions is just wasteful.  However, tracking every memor=
y
> mapping change might incur an overhead.  For the reason, DAMON applies th=
e
> dynamic memory mapping changes to the tracking regions only for each of a=
n
> user-specified time interval (``regions update interval``).
>
>
> Appendix D: Expected Use-cases
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> A straightforward usecase of DAMON would be the program behavior analysis=
.
> With the DAMON output, users can confirm whether the program is running a=
s
> intended or not.  This will be useful for debuggings and tests of design
> points.
>
> The monitored results can also be useful for counting the dynamic working=
 set
> size of workloads.  For the administration of memory overcommitted system=
s or
> selection of the environments (e.g., containers providing different amoun=
t of
> memory) for your workloads, this will be useful.
>
> If you are a programmer, you can optimize your program by managing the me=
mory
> based on the actual data access pattern.  For example, you can identify t=
he
> dynamic hotness of your data using DAMON and call ``mlock()`` to keep you=
r hot
> data in DRAM, or call ``madvise()`` with ``MADV_PAGEOUT`` to proactively
> reclaim cold data.  Even though your program is guaranteed to not encount=
er
> memory pressure, you can still improve the performance by applying the DA=
MON
> outputs for call of ``MADV_HUGEPAGE`` and ``MADV_NOHUGEPAGE``.  More crea=
tive
> optimizations would be possible.  Our evaluations of DAMON includes a
> straightforward optimization using the ``mlock()``.  Please refer to the =
below
> Evaluation section for more detail.
>
> As DAMON incurs very low overhead, such optimizations can be applied not =
only
> offline, but also online.  Also, there is no reason to limit such optimiz=
ations
> to the user space.  Several parts of the kernel's memory management mecha=
nisms
> could be also optimized using DAMON. The reclamation, the THP (de)promoti=
on
> decisions, and the compaction would be such a candidates.  DAMON will con=
tinue
> its development to be highly optimized for the online/in-kernel uses.
>
>
> A Future Plan: Data Access Monitoring-based Operation Schemes
> -------------------------------------------------------------
>
> As described in the above section, DAMON could be helpful for actual acce=
ss
> based memory management optimizations.  Nevertheless, users who want to d=
o such
> optimizations should run DAMON, read the traced data (either online or
> offline), analyze it, plan a new memory management scheme, and apply the =
new
> scheme by themselves.  It must be easier than the past, but could still r=
equire
> some level of efforts.  In its next development stage, DAMON will reduce =
some
> of such efforts by allowing users to specify some access based memory
> management rules for their specific processes.
>
> Because this is just a plan, the specific interface is not fixed yet, but=
 for
> example, users will be allowed to write their desired memory management r=
ules
> to a special file in a DAMON specific format.  The rules will be somethin=
g like
> 'if a memory region of size in a range is keeping a range of hotness for =
more
> than a duration, apply specific memory management rule using madvise() or
> mlock() to the region'.  For example, we can imagine rules like below:
>
>     # format is: <min/max size> <min/max frequency (0-99)> <duration> <ac=
tion>
>
>     # if a region of a size keeps a very high access frequency for more t=
han
>     # 100ms, lock the region in the main memory (call mlock()). But, if t=
he
>     # region is larger than 500 MiB, skip it. The exception might be help=
ful
>     # if the system has only, say, 600 MiB of DRAM, a region of size larg=
er
>     # than 600 MiB cannot be locked in the DRAM at all.
>     na 500M 90 99 100ms mlock
>
>     # if a region keeps a high access frequency for more than 100ms, put =
the
>     # region on the head of the LRU list (call madvise() with MADV_WILLNE=
ED).
>     na na 80 90 100ms madv_willneed
>
>     # if a region keeps a low access frequency for more than 100ms, put t=
he
>     # region on the tail of the LRU list (call madvise() with MADV_COLD).
>     na na 10 20 100ms madv_cold
>
>     # if a region keeps a very low access frequency for more than 100ms, =
swap
>     # out the region immediately (call madvise() with MADV_PAGEOUT).
>     na na 0 10 100ms madv_pageout
>
>     # if a region of a size bigger than 2MB keeps a very high access freq=
uency
>     # for more than 100ms, let the region to use huge pages (call madvise=
()
>     # with MADV_HUGEPAGE).
>     2M na 90 99 100ms madv_hugepage
>
>     # If a regions of a size bigger than > 2MB keeps no high access frequ=
ency
>     # for more than 100ms, avoid the region from using huge pages (call
>     # madvise() with MADV_NOHUGEPAGE).
>     2M na 0 25 100ms madv_nohugepage
>
> An RFC patchset for this is available:
> https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.com=
/

I do want to question the actual motivation of the design followed by this =
work.

With the already present Page Idle Tracking feature in the kernel, I
can envision that the region sampling and adaptive region adjustments
can be done in the user space. Due to sampling, the additional
overhead will be very small and configurable.

Additionally the proposed mechanism has inherent assumption of the
presence of spatial locality (for virtual memory) in the monitored
processes which is very workload dependent.

Given that the the same mechanism can be implemented in the user space
within tolerable overhead and is workload dependent, why it should be
done in the kernel? What exactly is the advantage of implementing this
in kernel?

thanks,
Shakeel
