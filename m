Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD64F2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9YYrwNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:07:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27161C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:07:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id t15so3358951iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3e4JFYXjF6q1OvbGcA6aKU4QTCIuU0l1tBCEJAmdwPg=;
        b=U9YYrwNo4SvHPhj96etFtH0UXHQfnKJYQOY2ST1j/yonEtY+tpxc6DdQ94vqrKX+Pm
         noXhrZ06X8sOwgF34zPNDSAFybAIG2SYutewjECVamEdKxoy0ndv3/P/xU9URWhlwli4
         n8lOAuh4EYqmvD57GxGlj+/XpCQxvQ4QJsmkbybbx94eyijkn3kewUHCH+pZoVh1K5bk
         Lj1NrcYMXyx+c7kJBzpRVsUyVadQCGAmfp/HFQbtJVlQHMVExdvrFULZvfmwzAb3dmDv
         AwuFJAnbgQ+p1dY+rwRYq77XgSMDAQAgswMfk2zp3tLt/T/oL7yOXfaFTX29+JFAafRQ
         Byqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3e4JFYXjF6q1OvbGcA6aKU4QTCIuU0l1tBCEJAmdwPg=;
        b=IBL2zX08Lp/31f3YmF93sgO6w3Z9zx2puZ+9Ehu11hDJH+gT7PyGOQ0QTk5MomjzEQ
         psVWoxCF6KJ2Xb8ePvevA/aht8QSV4FNeceGV4rL58WQjNCcHP4m59TjxWP1N+ws9065
         8eIWaeCj2uU9cN1YD9a9oQ2k3W5u8l0giW6ZiZNj2deaq4SPzeShEHCl2Acs5DBJ/MH9
         po1J64TXAUpjnGPt2xdFopHViAGWBd+l8vGWNV+73UG5m40evpmDV5WVVYGTEjyhVEnx
         4XSCG8Xwyd7yevfLMiWmo0gkfswCVImAIF//93bfkRML2Q/49R1V+9dsbHqCKhe06vQy
         8bCQ==
X-Gm-Message-State: AOAM530h2VLYt0XkTm46w5Qp7OQtoWvnOCplzPV93M/JUO1P9QmpGQ2b
        2l0Ts85FNq7jeGXHQeB94INAGj2jB0Di2STMZPMndA==
X-Google-Smtp-Source: ABdhPJyzPwmi6uJ4fRtjlctMeIfdwLLcFUCoZcOBr2Uv8ZAVYVfbVdqGmFAbApqklo5dPm6YVvsgWnElJnmn57d7sXA=
X-Received: by 2002:a02:866d:: with SMTP id e100mr107951jai.83.1597248424496;
 Wed, 12 Aug 2020 09:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200807071620.11907-1-leo.yan@linaro.org>
In-Reply-To: <20200807071620.11907-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 12 Aug 2020 10:06:53 -0600
Message-ID: <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
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

Hi Arnaldo,

On Fri, 7 Aug 2020 at 01:16, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch set is to enable Arm arch timer counter and Arm SPE is the
> first customer to use arch timer counter for its timestamp.
>
> Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
> to retrieve arch timer's parameters from mmaped page; patch 02 provides
> APIs for the conversion between arch timer's counter and time; patch 03
> adds a test for patches 01 and 02.
>
> As the first customer to use Arm arch timer counter in perf tool, patch
> 04 is to generate sample's timestamp for ARM SPE AUX trace data.
>
> This patch set has been rebased on perf/core branch with the latest
> commit c4735d990268 ("perf evsel: Don't set
> sample_regs_intr/sample_regs_user for dummy event").

The ARM SPE perf tools code is orphan and I don't have the cycles to
pick it up.  Leo has spent a lot of time in that code and as such I
suggest that he starts maintaining it, probably following the same
kind of arrangement you and I have for coresight.

Thanks,
Mathieu

>
> After changes:
>
>   # perf test 67 -v
>     67: Convert perf time to arch timer counter
>     --- start ---
>     test child forked, pid 5463
>     mmap size 528384B
>     1st event perf time 2231755083020 arch timer cnt 113097053477
>     test time           2231755087460 arch timer cnt 113097053699
>     2nd event perf time 2231755090680 arch timer cnt 113097053860
>     test child finished with 0
>     ---- end ----
>
>   Reports the SPE sample with timestamp:
>
>   $ perf script -F,+time
>     dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>
> Changes from v1:
> * Rebased on the latest perf/core branch;
> * Added a testing for Arm timer counter conversion (Ian Rogers).
>
>
> Leo Yan (4):
>   perf tools: Support Arm arch timer counter
>   perf arm_arch_timer: Convert between counter and timestamp
>   perf arm_arch_timer: Test conversion between counter and timestamp
>   perf arm-spe: Enable timestamp with arch timer counter
>
>  tools/perf/arch/arm64/include/arch-tests.h    |   6 +
>  tools/perf/arch/arm64/tests/Build             |   1 +
>  tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
>  .../tests/perf-time-to-arch-timer-counter.c   | 189 ++++++++++++++++++
>  tools/perf/arch/arm64/util/Build              |   1 +
>  tools/perf/arch/arm64/util/arch_timer.c       |  50 +++++
>  tools/perf/arch/arm64/util/arm-spe.c          |  17 ++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/arm-spe.c                     |  16 +-
>  tools/perf/util/arm-spe.h                     |   5 +
>  tools/perf/util/arm_arch_timer.c              |  28 +++
>  tools/perf/util/arm_arch_timer.h              |  23 +++
>  12 files changed, 339 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
>  create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
>  create mode 100644 tools/perf/util/arm_arch_timer.c
>  create mode 100644 tools/perf/util/arm_arch_timer.h
>
> --
> 2.17.1
>
