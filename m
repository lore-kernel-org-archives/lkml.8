Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76010C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CED2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE6zHJNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgDQRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729736AbgDQRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:48:08 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:48:08 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y19so1322765qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wsPmsmmn8SRkhSIfCVWBljACDK79MHy9k8ssFWuT9M=;
        b=GE6zHJNbphxfCZQSdvDHYtfPI1Gug1ZQZsf/hoWe5I2Ahsuwg4p77CgDOkKtulsIN0
         SrJrDmJsMWp36zHuHnf4Eea3KbMut4EIu5NfQAvUcQ4rVZRbEKdgy2B3m3zCdC+Qqxi/
         AXmTfhJf/S06hHkm83wcVMIlDri627O8xl8A+bd2doUty253UkPWJf/qKHAhdYlrXznF
         gO5+okr+vKckx1gANbkPEzUKHhskCfg3ppRUJ3sGLq72zjWt/hC8yw5Ro/GKDV3l67zj
         5MoPD+knEi3eSq2Y7fYnUz7VM3ZtfhCpeb1rsA74v/eRd068u97wib/nIEMCzj4QNQTA
         aWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wsPmsmmn8SRkhSIfCVWBljACDK79MHy9k8ssFWuT9M=;
        b=NLiF54IuP8MAdabPPoTv+RfFX6WOuSFA/Oump98rbjULQ75HxdJ+8TdklEg7jwfq6S
         iUQD/ix0BaRRQfzG4XbR/pGswx2Xzw7K3UGmMUF1gthWlgsGMucR0VNqU0t9e0t4lZ8Q
         ncS0iOSrgsVPNbvsQENe5BUR0qT6tUVoCfBLTM9tmJkm6RWu6LRqghNrqwMORHLptadG
         qiRelOQBEAFNl94m7cyONLc5OjoFmzCKcN8SND9b1go0o6gpTqzJLHSYm365FIOyEf3S
         Wqf9mLUrTe6NaFYZjNLHGTDZb57QOFPXApy/AV1FLytZsQVxPU8mvinKUFhODv0tkezS
         KDAw==
X-Gm-Message-State: AGi0PuZ5PapFpC1E0a3N49jB3iK1vfpZhtl5/MKVSDHsJYY0qLxmJXaW
        su7EvZsqyzdosFsIsFWZmGA=
X-Google-Smtp-Source: APiQypK+EM0hpd4qHDyWPiB7sMfYgrBXs0C30kTy19VbLfLUnBTlq9c0GimSbwOgn0CcZe5u8k7MRg==
X-Received: by 2002:ad4:548b:: with SMTP id q11mr3849363qvy.129.1587145686261;
        Fri, 17 Apr 2020 10:48:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h2sm3555839qkh.91.2020.04.17.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 10:48:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 739CF409A3; Fri, 17 Apr 2020 14:48:03 -0300 (-03)
Date:   Fri, 17 Apr 2020 14:48:03 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Message-ID: <20200417174803.GA21512@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V3:
> - There is no dependency among the 'capabilities'. If perf fails to read
>   one, it should not impact others. Continue to parse the rest of caps.
>   (Patch 1)
> - Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
>   2)
> - Combine the declaration plus assignment when possible (Patch 1 & 2)
> - Add check for script/report/c2c.. (Patch 13, 14 & 16)
> 
> Changes since V2:
> - Check strdup() in Patch 1
> - Split several patches into smaller patches
> 
> Changes since V1:
> - Rebase on top of commit 5100c2b77049 ("perf header: Add check for
>   unexpected use of reserved membrs in event attr")
> - Fix compling error with GCC9 in patch 1.
> 
> 
> The kernel patches have been merged into linux-next.
>   commit bbfd5e4fab63 ("perf/core: Add new branch sample type for HW
> index of raw branch records")
>   commit db278b90c326 ("perf/x86/intel: Output LBR TOS information
> correctly")
> 
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
> To determine if LBRs can be stitched, the maximum number of LBRs is
> required. Patch 1 - 4 retrieve the capabilities information from sysfs
> and save them in perf header.
> 
> Patch 5 - 12 implements the LBR stitching approach.
> 
> Users can use the options introduced in patch 13-16 to enable the LBR
> stitching approach for perf report, script, top and c2c.
> 
> Patch 17 adds a fast path for duplicate entries check. It benefits all
> call stack parsing, not just for stitch LBR call stack. It can be
> merged independently.
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

Next time provide the full test proggie, I had to expand those ... to
reproduce your results, all I have is in perf/core, some patches are
still to be processed, will continue later, have to stop now, see:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=13cfba6b741ff

For my testing, looks really great!

- Arnaldo
 
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
> Kan Liang (17):
>   perf pmu: Add support for PMU capabilities
>   perf header: Support CPU PMU capabilities
>   perf record: Clear HEADER_CPU_PMU_CAPS for non LBR call stack mode
>   perf stat: Clear HEADER_CPU_PMU_CAPS
>   perf machine: Remove the indent in resolve_lbr_callchain_sample
>   perf machine: Refine the function for LBR call stack reconstruction
>   perf machine: Factor out lbr_callchain_add_kernel_ip()
>   perf machine: Factor out lbr_callchain_add_lbr_ip()
>   perf thread: Add a knob for LBR stitch approach
>   perf tools: Save previous sample for LBR stitching approach
>   perf tools: Save previous cursor nodes for LBR stitching approach
>   perf tools: Stitch LBR call stack
>   perf report: Add option to enable the LBR stitching approach
>   perf script: Add option to enable the LBR stitching approach
>   perf top: Add option to enable the LBR stitching approach
>   perf c2c: Add option to enable the LBR stitching approach
>   perf hist: Add fast path for duplicate entries check
> 
>  tools/perf/Documentation/perf-c2c.txt         |  11 +
>  tools/perf/Documentation/perf-report.txt      |  11 +
>  tools/perf/Documentation/perf-script.txt      |  11 +
>  tools/perf/Documentation/perf-top.txt         |   9 +
>  .../Documentation/perf.data-file-format.txt   |  16 +
>  tools/perf/builtin-c2c.c                      |  12 +
>  tools/perf/builtin-record.c                   |   3 +
>  tools/perf/builtin-report.c                   |  12 +
>  tools/perf/builtin-script.c                   |  12 +
>  tools/perf/builtin-stat.c                     |   1 +
>  tools/perf/builtin-top.c                      |  11 +
>  tools/perf/util/branch.h                      |  19 +-
>  tools/perf/util/callchain.h                   |   8 +
>  tools/perf/util/env.h                         |   3 +
>  tools/perf/util/header.c                      | 108 +++++
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/hist.c                        |  23 +
>  tools/perf/util/machine.c                     | 423 +++++++++++++++---
>  tools/perf/util/pmu.c                         |  82 ++++
>  tools/perf/util/pmu.h                         |   9 +
>  tools/perf/util/sort.c                        |   2 +-
>  tools/perf/util/sort.h                        |   2 +
>  tools/perf/util/thread.c                      |   2 +
>  tools/perf/util/thread.h                      |  35 ++
>  tools/perf/util/top.h                         |   1 +
>  25 files changed, 757 insertions(+), 70 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
