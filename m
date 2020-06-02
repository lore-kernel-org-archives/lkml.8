Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADFBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9092077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbdnBzxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFBSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFBSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:10:52 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57656C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:10:52 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a80so6735894ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGKwTci6YYFj61/UQ8F76TAav6aVCJJ87zLA3Eb57b4=;
        b=VbdnBzxKAr7bvKSydTVnepPMigJDFe2+HaY08Wbms61W3BnZpc5guWG0/w+7Ff0E4n
         HvQNb+CytYF3yFLEpiYhSiKERPowk/QLWtLiVZGdE5BsuSuqs/SstlwWX5TjRfs5krnd
         AP73/0onfP2GIc3TzdDEC8CP6hDbZL9kaKTH8uTZBA1pfrVZ23X5OJcbb7CYzqmotyDR
         sswMWJF7f4A6mdwqgcnT5F+eqt82c//tOsTbnL0/usYtm26kCLwsMBjZhTZil+/A+qI1
         PRWRli3ufRd9lUNX1kGrjewJ+XPmJbnUloqARYwWuqs9K/a6wp3Ye5ZVEg5ad4lgeBWp
         fw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGKwTci6YYFj61/UQ8F76TAav6aVCJJ87zLA3Eb57b4=;
        b=lcKIrNkLLen0heW1+WEbwE/Wk4+eh2CdhfA3dpz6gL8hOsWgD1Kl4cmnwwm+iBRxyo
         Rpq1dDaMUF8kDGNoTTDXejTaPXhD4ilsWX4UC2MPY6Swvdet+/GvVt3ONKx7ibPO2aOz
         kfUkLcKTGFAAhNBuyBumWHCJlVqHRKnoRh1TKHwtAnBGcIwe5IjlgDZK3EX5uBser5Zq
         wxsy56xioSopMbkOUeaUA5VlO34ljQyDMn5YHRYTgrhbNdF//ghtDDwvTOCXg8dlVidw
         aMM9rhfxEDs9f021+ZBygA8KBi15rw/6YIS8OiXualVt0s585Vrg5MzeeltVNizKGphI
         dszg==
X-Gm-Message-State: AOAM532j5kzkJjwvEg8pmNL7GYSEQNGDbJW7nmGAxRindmge+wKmJ8Iw
        bIOW0epQWn+cBZNOttcqp8KjxuH5chHuf76nGYH3Ew==
X-Google-Smtp-Source: ABdhPJz1GE0ISa9BaVBawCbwMiatHp1tGtlPlNyTSqa8jP7uIr3gfWiSwardxXZpiebg3qcxgpuhWwJb/jClELpw22s=
X-Received: by 2002:a5b:ec1:: with SMTP id a1mr19640161ybs.41.1591121451370;
 Tue, 02 Jun 2020 11:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200602115055.1168446-1-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Jun 2020 11:10:40 -0700
Message-ID: <CAP-5=fWF6e38zyMJR_DbRR7yHiYDDwNCMAjUcXz_anxAXSsBrA@mail.gmail.com>
Subject: Re: [PATCHv2 00/13] perf tests: Add metrics tests
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> changes for using metric result in another metric seem
> to change lot of core metric code, so it's better we
> have some more tests before we do that.
>
> v2 changes:
>   - some of the patches got accepted
>   - add missing free to patch 1 [Ian]
>   - factor pmu-events test functions and reuse it in the new test [Ian]
>   - add fake_pmu bool to parse_events interface [Ian]
>   - simplify metric tests
>   - use proper cover letter subject ;-)
>
> I actually reworked the 2 patches Ian acked so far,
> so I did not add them.
>
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric_test
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (13):
>       perf tools: Add fake pmu support
>       perf tools: Add fake_pmu bool to parse_events interface
>       perf tests: Factor check_parse_id function
>       perf tests: Add another metric parsing test
>       perf tools: Factor out parse_groups function
>       perf tools: Add fake_pmu to parse_events function
>       perf tools: Add map to parse_events function
>       perf tools: Add metricgroup__parse_groups_test function
>       perf tools: Factor out prepare_metric function
>       perf tools: Release metric_events rblist
>       perf tools: Add test_generic_metric function
>       perf tests: Add parse metric test for ipc metric
>       perf tests: Add parse metric test for frontend metric
>
>  tools/perf/arch/arm/util/cs-etm.c            |   2 +-
>  tools/perf/arch/arm64/util/arm-spe.c         |   2 +-
>  tools/perf/arch/powerpc/util/kvm-stat.c      |   2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c        |   2 +-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c |   2 +-
>  tools/perf/arch/x86/util/intel-bts.c         |   2 +-
>  tools/perf/arch/x86/util/intel-pt.c          |   6 ++--
>  tools/perf/builtin-stat.c                    |   9 +++---
>  tools/perf/builtin-trace.c                   |   4 +--
>  tools/perf/tests/Build                       |   1 +
>  tools/perf/tests/backward-ring-buffer.c      |   3 +-
>  tools/perf/tests/builtin-test.c              |   4 +++
>  tools/perf/tests/code-reading.c              |   2 +-
>  tools/perf/tests/event-times.c               |   2 +-
>  tools/perf/tests/evsel-roundtrip-name.c      |   4 +--
>  tools/perf/tests/hists_cumulate.c            |   2 +-
>  tools/perf/tests/hists_filter.c              |   4 +--
>  tools/perf/tests/hists_link.c                |   4 +--
>  tools/perf/tests/hists_output.c              |   2 +-
>  tools/perf/tests/keep-tracking.c             |   4 +--
>  tools/perf/tests/parse-events.c              |   2 +-
>  tools/perf/tests/parse-metric.c              | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/pmu-events.c                | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  tools/perf/tests/switch-tracking.c           |   8 ++---
>  tools/perf/tests/tests.h                     |   1 +
>  tools/perf/util/bpf-loader.c                 |   2 +-
>  tools/perf/util/metricgroup.c                |  74 ++++++++++++++++++++++++++++++++++++----------
>  tools/perf/util/metricgroup.h                |  10 +++++++
>  tools/perf/util/parse-events.c               |  29 +++++++++++-------
>  tools/perf/util/parse-events.h               |   5 ++--
>  tools/perf/util/parse-events.l               |   8 +++--
>  tools/perf/util/parse-events.y               |  41 ++++++++++++++++++++++++--
>  tools/perf/util/perf_api_probe.c             |   2 +-
>  tools/perf/util/record.c                     |   2 +-
>  tools/perf/util/stat-shadow.c                |  67 ++++++++++++++++++++++++++++++------------
>  tools/perf/util/stat.h                       |   3 ++
>  36 files changed, 527 insertions(+), 92 deletions(-)
>  create mode 100644 tools/perf/tests/parse-metric.c
>

Acked-by: Ian Rogers <irogers@google.com>
