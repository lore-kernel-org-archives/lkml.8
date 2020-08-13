Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F511C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA03C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrpBvjuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHMQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:18:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:18:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 77so6023320ilc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7pJyanhH1tO91vA1YlND/mRfZB6nVNysM8FFOuLJ5k=;
        b=OrpBvjuMBhIQcbMieNnyvz3hQPEY8Lq+Qom+Ny8VadQIzYnk9t6KDkSR1UTOBKwRd0
         Ydeg54huoZOYnqE63AcqSROQH3J3bdWFFZ557tHk/bdL7LzXuWlJbND+FN0yjSRhoNSe
         0+huvsrMt/xrDsmh99wTTFBXyrto40fvM+kUi2UMLN7XJUVP+eeMDkdy78QsG+mjcZ3d
         IikfIdEBxLcmsLJR1F8OMNAtecow0a7WSrAd0Sit9d+0FIJZ5iXzVBBciE8nTrp+M/Pd
         qnzxyBKynPE0Bzh3NUdHmkzsR/rloiTMc/hslL8ki+14kqc0HHv4aaTDPcF6xEYjvUeP
         8KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7pJyanhH1tO91vA1YlND/mRfZB6nVNysM8FFOuLJ5k=;
        b=YaxtIoY/Y3L4GXhOZBFZTsfNsy3mmfyafWrNboWzTajsP+uIQdKdQt0wglph4kShkK
         hAfUB1XZDSoVt1Uh+xdNhqOfYMjXfWrzOQILv2flWSNROmR+bZHoKlVynbCvtcymCp4h
         RjfrLzmO+b30LrbM27LELxouT5L5ccPkkzRlpzlF6PxDnogeX2fMZkeKbgDVeKNgxQZ9
         mP3rG+LUCAWWxixCZmk/dd4zx5HsYxUAI45+rUl/gD80q5Pl79I877NIR1DwFMLX+AtU
         JGIQttwYDU7/Aujkbu9NeV73PRgBGdwxCFqFyn+ljJXTR6MPJzIyE0x5IYCGhg8s7IT6
         kIPg==
X-Gm-Message-State: AOAM533pY4DNoN6qkgSjA+bS1UvoQXBvp8POlRf/7XGIf17CKcToHmQS
        okNB4jFYok8wvohrD0Z8Hn+N97CUM1ObO8LOtR9VZA==
X-Google-Smtp-Source: ABdhPJz5CWU+9zrlZMv5nBBuV9FsFdayw4hBlOTzbXrPI70pNf+v06QGZHcim59yM9rAoLEqaBWHqzpc/6G29prqu2Y=
X-Received: by 2002:a92:5209:: with SMTP id g9mr5558583ilb.72.1597335480586;
 Thu, 13 Aug 2020 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200807071620.11907-1-leo.yan@linaro.org> <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org>
In-Reply-To: <20200812185334.GN13995@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 13 Aug 2020 10:17:49 -0600
Message-ID: <CANLsYkyXX-xF-_v_NsdyF1L7v8z1JUUgFtzFPxBU6nxLP6TVNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 12:53, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> > Hi Arnaldo,
> >
> > On Fri, 7 Aug 2020 at 01:16, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > This patch set is to enable Arm arch timer counter and Arm SPE is the
> > > first customer to use arch timer counter for its timestamp.
> > >
> > > Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
> > > to retrieve arch timer's parameters from mmaped page; patch 02 provides
> > > APIs for the conversion between arch timer's counter and time; patch 03
> > > adds a test for patches 01 and 02.
> > >
> > > As the first customer to use Arm arch timer counter in perf tool, patch
> > > 04 is to generate sample's timestamp for ARM SPE AUX trace data.
> > >
> > > This patch set has been rebased on perf/core branch with the latest
> > > commit c4735d990268 ("perf evsel: Don't set
> > > sample_regs_intr/sample_regs_user for dummy event").
> >
> > The ARM SPE perf tools code is orphan and I don't have the cycles to
> > pick it up.  Leo has spent a lot of time in that code and as such I
> > suggest that he starts maintaining it, probably following the same
> > kind of arrangement you and I have for coresight.
>
> Thats ok with me, I think we should reflect that on the MAINTAINERS
> file, right?
>

I agree, it is time to sort out this part.

> We have this already:
>
> PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> R:      John Garry <john.garry@huawei.com>
> R:      Will Deacon <will@kernel.org>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Supported
> F:      tools/perf/pmu-events/arch/arm64/
>
> I think we should have entries for CoreSight and ARM SPE, one listing
> you as the maintainer and the other listing Leo, right?
>

Yes - I'll send you a patch for that once v5.9-rc1 comes out (unless
you want it now).

> Leo, it would be good for you to try and find someone at your
> organization or elsewhere that could help with this, this way I would
> wait a bit, see if someone else Acks it, and collect those, processing
> it from you after a while if nobody chimes in.
>

Right, the same kind of arrangement you and I have for coresight.  So
far this has worked quite well and I don't see a need to proceed
differently.

> Please continue providing 'perf test' regression tests, etc, to help
> with maintaining this code being checked.

Those are quite useful.

>
> - Arnaldo
>
> > Thanks,
> > Mathieu
> >
> > >
> > > After changes:
> > >
> > >   # perf test 67 -v
> > >     67: Convert perf time to arch timer counter
> > >     --- start ---
> > >     test child forked, pid 5463
> > >     mmap size 528384B
> > >     1st event perf time 2231755083020 arch timer cnt 113097053477
> > >     test time           2231755087460 arch timer cnt 113097053699
> > >     2nd event perf time 2231755090680 arch timer cnt 113097053860
> > >     test child finished with 0
> > >     ---- end ----
> > >
> > >   Reports the SPE sample with timestamp:
> > >
> > >   $ perf script -F,+time
> > >     dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >     dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >     dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >     dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >     dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >     dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> > >
> > > Changes from v1:
> > > * Rebased on the latest perf/core branch;
> > > * Added a testing for Arm timer counter conversion (Ian Rogers).
> > >
> > >
> > > Leo Yan (4):
> > >   perf tools: Support Arm arch timer counter
> > >   perf arm_arch_timer: Convert between counter and timestamp
> > >   perf arm_arch_timer: Test conversion between counter and timestamp
> > >   perf arm-spe: Enable timestamp with arch timer counter
> > >
> > >  tools/perf/arch/arm64/include/arch-tests.h    |   6 +
> > >  tools/perf/arch/arm64/tests/Build             |   1 +
> > >  tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
> > >  .../tests/perf-time-to-arch-timer-counter.c   | 189 ++++++++++++++++++
> > >  tools/perf/arch/arm64/util/Build              |   1 +
> > >  tools/perf/arch/arm64/util/arch_timer.c       |  50 +++++
> > >  tools/perf/arch/arm64/util/arm-spe.c          |  17 ++
> > >  tools/perf/util/Build                         |   1 +
> > >  tools/perf/util/arm-spe.c                     |  16 +-
> > >  tools/perf/util/arm-spe.h                     |   5 +
> > >  tools/perf/util/arm_arch_timer.c              |  28 +++
> > >  tools/perf/util/arm_arch_timer.h              |  23 +++
> > >  12 files changed, 339 insertions(+), 2 deletions(-)
> > >  create mode 100644 tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
> > >  create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
> > >  create mode 100644 tools/perf/util/arm_arch_timer.c
> > >  create mode 100644 tools/perf/util/arm_arch_timer.h
> > >
> > > --
> > > 2.17.1
> > >
>
> --
>
> - Arnaldo
