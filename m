Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E942166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFXhlmOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgCDNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:33:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40503 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:33:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id o10so1305628qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kTXA8aTzCHMRyfe5aJq/9SLfxVVPRldNDGrbwHGiHHQ=;
        b=PFXhlmOCyYEsN/iqu5F9fR+m+MhhNVTZ/suAXJ0e+tU35cmZ85UC65Ji6kbaujvkF/
         oPs0vwMEpyg6QWOjkQmNqlK5oj9b4ZYlxYmMoebe9qOfl05Wy1p3n9Ded9LYv3iQGEcJ
         1yvv2tLIJItHvLDNZglNtAM5kDJhbWJhJOHB4gKHQ1ClHRXZ8ThnSPDWD41bUvlEl5Ai
         wkol60LFZlFGQg3+EfhHVOvZQSKl5aBzRnXQkeaEJ2j4G+3W8rXR2/Eph2kJjvapGre0
         s2PoUxG/fB/UoMn5rvlnAvk9D6+rb4McF0/SSsWhkmg30rh4RAifYmgy7HSuoGELBLQh
         h7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTXA8aTzCHMRyfe5aJq/9SLfxVVPRldNDGrbwHGiHHQ=;
        b=rL4zz2y3JppDvf/tDiQDKW/9Pa21Y4LKgzMmPCUCfwdemjypleqgniSEG6XTdNA9+4
         MlkhupY2q0onG6NtdLe4EdMqOYnthtnBFiKFEU97DpI+XwX8qu2gJZWk+z5YTJn0RgVt
         l6DBVTUYG41y5WMWd/VQN+1ygDVcKTFgSJTm93knh5oNJb55qimeIefeJdQ6cy8aYIfS
         ddJ5UB3Mq3DCK8S/Aga3C4jw0NwWocV2/YKWDGt8/vJbsQIASzPQibMbzZ3dcFP91b2f
         7KsrrBpxUGaCc+Jg7TKST7fP9why5CfZQjNH6Jwcl/jBhER8jhpzmCf3X943fOdhznko
         92pA==
X-Gm-Message-State: ANhLgQ1MoYJD+pmbbs+ZIW29HcfpkMhLQ/i5Jwzcu4hCWehWZcupgT8r
        YwC7m2P/IY7I/natZ6KQZ3TCno7pNyWTFQ==
X-Google-Smtp-Source: ADFU+vvViPSlkYX6V+W3Ecv34xL9NoUhYvO8SniOo6wKPfCRxs8VxDcK/KvhJ8D9ekIqA5izsP0cLg==
X-Received: by 2002:ac8:3798:: with SMTP id d24mr2420435qtc.178.1583328786690;
        Wed, 04 Mar 2020 05:33:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x7sm7846059qkx.110.2020.03.04.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 05:33:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0C8B403AD; Wed,  4 Mar 2020 10:33:02 -0300 (-03)
Date:   Wed, 4 Mar 2020 10:33:02 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
Message-ID: <20200304133302.GA12612@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228163011.19358-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The kernel patches have been merged into linux-next.
>   commit bbfd5e4fab63 ("perf/core: Add new branch sample type for HW
> index of raw branch records")
>   commit db278b90c326 ("perf/x86/intel: Output LBR TOS information
> correctly")

I saw it landed in tip/perf/core, going thru this patchset now.

Thanks,

- Arnaldo
 
> Start from Haswell, Linux perf can utilize the existing Last Branch
> Record (LBR) facility to record call stack. However, the depth of the
> reconstructed LBR call stack limits to the number of LBR registers.
> E.g. on skylake, the depth of reconstructed LBR call stack is <= 32
> That's because HW will overwrite the oldest LBR registers when it's
> full.
> 
> However, the overwritten LBRs may still be retrieved from previous
> sample. At that moment, HW hasn't overwritten the LBR registers yet.
> Perf tools can stitch those overwritten LBRs on current call stacks to
> get a more complete call stack.
> 
> To determine if LBRs can be stitched, the physical index of LBR
> registers is required. A new branch sample type is introduced to dump
> the physical index of the most recent LBR aka Top-of-Stack (TOS)
> information for perf tools.
> Patch 1 & 2 extend struct branch_stack to support the new branch sample
> type, PERF_SAMPLE_BRANCH_HW_INDEX.
> 
> Since the output format of PERF_SAMPLE_BRANCH_STACK will be changed
> when the new branch sample type is set, an older version of perf tool
> may parse the perf.data incorrectly. Furthermore, there is no warning
> if this case happens. Because current perf header never check for
> unknown input bits in attr. Patch 3 adds check for event attr. (Can be
> merged independently.)
> 
> Besides the physical index, the maximum number of LBRs is required as
> well. Patch 4 & 5 retrieve the capabilities information from sysfs
> and save them in perf header.
> 
> Patch 6 & 7 implements the LBR stitching approach.
> 
> Users can use the options introduced in patch 8-11 to enable the LBR
> stitching approach for perf report, script, top and c2c.
> 
> Patch 12 adds a fast path for duplicate entries check. It benefits all
> call stack parsing, not just for stitch LBR call stack. It can be
> merged independently.
> 
> 
> The stitching approach base on LBR call stack technology. The known
> limitations of LBR call stack technology still apply to the approach,
> e.g. Exception handing such as setjmp/longjmp will have calls/returns
> not match.
> This approach is not full proof. There can be cases where it creates
> incorrect call stacks from incorrect matches. There is no attempt
> to validate any matches in another way. So it is not enabled by default.
> However in many common cases with call stack overflows it can recreate
> better call stacks than the default lbr call stack output. So if there
> are problems with LBR overflows this is a possible workaround.
> 
> Regression:
> Users may collect LBR call stack on a machine with new perf tool and
> new kernel (support LBR TOS). However, they may parse the perf.data with
> old perf tool (not support LBR TOS). The old tool doesn't check
> attr.branch_sample_type. Users probably get incorrect information
> without any warning.
> 
> Performance impact:
> The processing time may increase with the LBR stitching approach
> enabled. The impact depends on the increased depth of call stacks.
> 
> For a simple test case tchain_edit with 43 depth of call stacks.
> perf record --call-graph lbr -- ./tchain_edit
> perf report --stitch-lbr
> 
> Without --stitch-lbr, perf report only display 32 depth of call stacks.
> With --stitch-lbr, perf report can display all 43 depth of call stacks.
> The depth of call stacks increase 34.3%.
> 
> Correspondingly, the processing time of perf report increases 39%,
> Without --stitch-lbr:                           11.0 sec
> With --stitch-lbr:                              15.3 sec
> 
> The source code of tchain_edit.c is something similar as below.
> noinline void f43(void)
> {
>         int i;
>         for (i = 0; i < 10000;) {
> 
>                 if(i%2)
>                         i++;
>                 else
>                         i++;
>         }
> }
> 
> noinline void f42(void)
> {
>         int i;
>         for (i = 0; i < 100; i++) {
>                 f43();
>                 f43();
>                 f43();
>         }
> }
> 
> noinline void f41(void)
> {
>         int i;
>         for (i = 0; i < 100; i++) {
>                 f42();
>                 f42();
>                 f42();
>         }
> }
> noinline void f40(void)
> {
>         f41();
> }
> 
> ... ...
> 
> noinline void f32(void)
> {
>         f33();
> }
> 
> noinline void f31(void)
> {
>         int i;
> 
>         for (i = 0; i < 10000; i++) {
>                 if(i%2)
>                         i++;
>                 else
>                         i++;
>         }
> 
>         f32();
> }
> 
> noinline void f30(void)
> {
>         f31();
> }
> 
> ... ...
> 
> noinline void f1(void)
> {
>         f2();
> }
> 
> int main()
> {
>         f1();
> }
> 
> Kan Liang (12):
>   perf tools: Add hw_idx in struct branch_stack
>   perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
>   perf header: Add check for event attr
>   perf pmu: Add support for PMU capabilities
>   perf header: Support CPU PMU capabilities
>   perf machine: Refine the function for LBR call stack reconstruction
>   perf tools: Stitch LBR call stack
>   perf report: Add option to enable the LBR stitching approach
>   perf script: Add option to enable the LBR stitching approach
>   perf top: Add option to enable the LBR stitching approach
>   perf c2c: Add option to enable the LBR stitching approach
>   perf hist: Add fast path for duplicate entries check approach
> 
>  tools/include/uapi/linux/perf_event.h         |   8 +-
>  tools/perf/Documentation/perf-c2c.txt         |  11 +
>  tools/perf/Documentation/perf-report.txt      |  11 +
>  tools/perf/Documentation/perf-script.txt      |  11 +
>  tools/perf/Documentation/perf-top.txt         |   9 +
>  .../Documentation/perf.data-file-format.txt   |  16 +
>  tools/perf/builtin-c2c.c                      |   6 +
>  tools/perf/builtin-record.c                   |   3 +
>  tools/perf/builtin-report.c                   |   6 +
>  tools/perf/builtin-script.c                   |  76 ++--
>  tools/perf/builtin-stat.c                     |   1 +
>  tools/perf/builtin-top.c                      |  11 +
>  tools/perf/tests/sample-parsing.c             |   7 +-
>  tools/perf/util/branch.h                      |  27 +-
>  tools/perf/util/callchain.h                   |  12 +-
>  tools/perf/util/cs-etm.c                      |   1 +
>  tools/perf/util/env.h                         |   3 +
>  tools/perf/util/event.h                       |   1 +
>  tools/perf/util/evsel.c                       |  20 +-
>  tools/perf/util/evsel.h                       |   6 +
>  tools/perf/util/header.c                      | 147 ++++++
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/hist.c                        |  26 +-
>  tools/perf/util/intel-pt.c                    |   2 +
>  tools/perf/util/machine.c                     | 424 +++++++++++++++---
>  tools/perf/util/perf_event_attr_fprintf.c     |   1 +
>  tools/perf/util/pmu.c                         |  87 ++++
>  tools/perf/util/pmu.h                         |  12 +
>  .../scripting-engines/trace-event-python.c    |  30 +-
>  tools/perf/util/session.c                     |   8 +-
>  tools/perf/util/sort.c                        |   2 +-
>  tools/perf/util/sort.h                        |   2 +
>  tools/perf/util/synthetic-events.c            |   6 +-
>  tools/perf/util/thread.c                      |   2 +
>  tools/perf/util/thread.h                      |  34 ++
>  tools/perf/util/top.h                         |   1 +
>  36 files changed, 900 insertions(+), 131 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
