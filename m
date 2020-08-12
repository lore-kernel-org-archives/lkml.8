Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3873B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597258419;
	bh=ob0YNPXTTHZfIK1XdcvKuT/oboSKu10JmM4vnIxq/6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dgnXwctPgspDb8b5r3/gV1BBOXuQgy2lszmN5TDDKzdYhGqCHI4lk/i93WJBM5eOa
	 u7/YzFx7722dC4kDQUqcQl0FzHm4efaVWYp6AaFvuiqZwnobkA1VVOJUaZznNovhuj
	 ztEWM2Eh5/abAMp6ePl1gac505H3PXh4N9w7kxqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLSxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:53:37 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.180.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EAF20774;
        Wed, 12 Aug 2020 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597258417;
        bh=ob0YNPXTTHZfIK1XdcvKuT/oboSKu10JmM4vnIxq/6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsQ3aIi0mwCDiIEVxGfuQzhed3zoRC0TG//2lkCHxuQI8/z6hs+PBx7YC+U+cauOU
         Jqi7/e/6ooGMMn97m88xS/h1AspMJ29YNKKGd/fF5QT0GwpOyjcSBP/TdFMalm3bpR
         zpg91P3xLyWELyY3Up0vmAG+B+7cw0EPG6gLCcag=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 805644097F; Wed, 12 Aug 2020 15:53:34 -0300 (-03)
Date:   Wed, 12 Aug 2020 15:53:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
Message-ID: <20200812185334.GN13995@kernel.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> Hi Arnaldo,
> 
> On Fri, 7 Aug 2020 at 01:16, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch set is to enable Arm arch timer counter and Arm SPE is the
> > first customer to use arch timer counter for its timestamp.
> >
> > Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
> > to retrieve arch timer's parameters from mmaped page; patch 02 provides
> > APIs for the conversion between arch timer's counter and time; patch 03
> > adds a test for patches 01 and 02.
> >
> > As the first customer to use Arm arch timer counter in perf tool, patch
> > 04 is to generate sample's timestamp for ARM SPE AUX trace data.
> >
> > This patch set has been rebased on perf/core branch with the latest
> > commit c4735d990268 ("perf evsel: Don't set
> > sample_regs_intr/sample_regs_user for dummy event").
> 
> The ARM SPE perf tools code is orphan and I don't have the cycles to
> pick it up.  Leo has spent a lot of time in that code and as such I
> suggest that he starts maintaining it, probably following the same
> kind of arrangement you and I have for coresight.

Thats ok with me, I think we should reflect that on the MAINTAINERS
file, right?

We have this already:

PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
R:      John Garry <john.garry@huawei.com>
R:      Will Deacon <will@kernel.org>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:      Supported
F:      tools/perf/pmu-events/arch/arm64/

I think we should have entries for CoreSight and ARM SPE, one listing
you as the maintainer and the other listing Leo, right?

Leo, it would be good for you to try and find someone at your
organization or elsewhere that could help with this, this way I would
wait a bit, see if someone else Acks it, and collect those, processing
it from you after a while if nobody chimes in.

Please continue providing 'perf test' regression tests, etc, to help
with maintaining this code being checked.

- Arnaldo
 
> Thanks,
> Mathieu
> 
> >
> > After changes:
> >
> >   # perf test 67 -v
> >     67: Convert perf time to arch timer counter
> >     --- start ---
> >     test child forked, pid 5463
> >     mmap size 528384B
> >     1st event perf time 2231755083020 arch timer cnt 113097053477
> >     test time           2231755087460 arch timer cnt 113097053699
> >     2nd event perf time 2231755090680 arch timer cnt 113097053860
> >     test child finished with 0
> >     ---- end ----
> >
> >   Reports the SPE sample with timestamp:
> >
> >   $ perf script -F,+time
> >     dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >
> > Changes from v1:
> > * Rebased on the latest perf/core branch;
> > * Added a testing for Arm timer counter conversion (Ian Rogers).
> >
> >
> > Leo Yan (4):
> >   perf tools: Support Arm arch timer counter
> >   perf arm_arch_timer: Convert between counter and timestamp
> >   perf arm_arch_timer: Test conversion between counter and timestamp
> >   perf arm-spe: Enable timestamp with arch timer counter
> >
> >  tools/perf/arch/arm64/include/arch-tests.h    |   6 +
> >  tools/perf/arch/arm64/tests/Build             |   1 +
> >  tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
> >  .../tests/perf-time-to-arch-timer-counter.c   | 189 ++++++++++++++++++
> >  tools/perf/arch/arm64/util/Build              |   1 +
> >  tools/perf/arch/arm64/util/arch_timer.c       |  50 +++++
> >  tools/perf/arch/arm64/util/arm-spe.c          |  17 ++
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/arm-spe.c                     |  16 +-
> >  tools/perf/util/arm-spe.h                     |   5 +
> >  tools/perf/util/arm_arch_timer.c              |  28 +++
> >  tools/perf/util/arm_arch_timer.h              |  23 +++
> >  12 files changed, 339 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
> >  create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
> >  create mode 100644 tools/perf/util/arm_arch_timer.c
> >  create mode 100644 tools/perf/util/arm_arch_timer.h
> >
> > --
> > 2.17.1
> >

-- 

- Arnaldo
