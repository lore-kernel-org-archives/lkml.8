Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E52320752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7rlF9TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgEKQMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:12:16 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE70FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:12:15 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f5so5393982ybo.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqN9AGaAhR7RBO+3l9SsAJEzKa39y0egU4dXupH54kY=;
        b=Y7rlF9TOV6zhIA1Zzic8NHBE+p/CEj6W88Y/TCv3jy/QW8ptFA+8NO9fxXUF+rfzVS
         Ii17YFgiPzN+yOO3BdApP1HSwtHVqxaenvcDdWoAP3D0JzGFSXpiOFPNipE8jr5krKH7
         ppLU+CEOXzqz4XlE7OMA2wJnOeg5GcOWbpEyNrdBL4t7YidgD0Atal5Qk5PRBwWFRNnu
         cxXVGp2AgyrSEVkjhqq6zHcYoQewU5/LVoT1XK8CzoIqHslwJFjuj5mL3NPNTAw53SHF
         9VoX3vqquxkONktfdPcSIdOgg0rvI4I3/O3bVwzFht+Ku/6AzjSm/iQM3W/fctiSijxC
         LSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqN9AGaAhR7RBO+3l9SsAJEzKa39y0egU4dXupH54kY=;
        b=pW3WoJvJGNZr4UBhZyQCtPfnUF4n5c16pArLTK7Su7PmA0IUnXmTBAnnz7fzg5rS4F
         ZC70o64czGpaVOY08qxqwzDFXbe0MSdWqvRItAQfDjtBBySuAxS+tzvpoL53sjrg8TtO
         cW7Pj+7oUIebNuEUY4ImOjeba2RVw2K4y8nK65g9AgwVkXVqzf1oX8P9j0Aa+tuIFfa2
         ZCLDXxduRWFbuVGj9NArpgZXvIyeckYNnavEF24oglYiZ2GntB2uBhQ+VnLa+AF3LmZd
         2JbFIJS7vfBIUQKyPe2aUbk74lJ+nT5id2CSJphh8x5Yh2RX/LeJujm5x22Y4bZ0Rocz
         uMTw==
X-Gm-Message-State: AGi0PuaSnbCED6urhJNjWc2QVWPM/TlFXE7x4a0YEwgZ2Me7e8CUNwfA
        nOD8Ob2zIzTm3FR1C3+HcyYfwEHUuhR9tAHHbDqfrA==
X-Google-Smtp-Source: APiQypIiKprf8EslABf6yfeHSNjiyAFXJ5DlN3r4W8p3jZgvtDLlsuGQCy81kS/CIzIXWXHb2MTm96Z5P5+x8kU2pQE=
X-Received: by 2002:a25:4446:: with SMTP id r67mr26279018yba.41.1589213534584;
 Mon, 11 May 2020 09:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com> <20200507084445.GA2447905@krava>
 <20200511153207.GD28888@kernel.org>
In-Reply-To: <20200511153207.GD28888@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 May 2020 09:12:03 -0700
Message-ID: <CAP-5=fUEz6iBYfiwHgyGCuVNuPGAQN+Fgbcd4ZSn5cV_VAsFvw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] perf metric fixes and test
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:32 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 07, 2020 at 10:44:45AM +0200, Jiri Olsa escreveu:
> > On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> > > Add a test that all perf metrics (for your architecture) are parsable
> > > with the simple expression parser. Attempt to parse all events in
> > > metrics but only fail if the metric is for the current CPU. Fix bugs
> > > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > > around add PMU config term failures.
> > >
> > > v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> > > v3 adds parse event testing of ids and improves debug messages for add
> > >   PMU. These messages are paticular visible with 'perf test 10
> > >   -vvv'. It moves the testing logic from tests/expr.c to
> > >   tests/pmu-events.c as suggested by John Garry
> > >   <john.garry@huawei.com>.
> > > v2 adds Fixes tags to commit messages for when broken metrics were
> > >   first added. Adds a debug warning for division by zero in expr, and
> > >   adds a workaround for id values in the expr test necessary for
> > >   powerpc. It also fixes broken power8 and power9 metrics.
> > >
> > > Ian Rogers (12):
> > >   perf expr: unlimited escaped characters in a symbol
> > >   perf metrics: fix parse errors in cascade lake metrics
> > >   perf metrics: fix parse errors in skylake metrics
> > >   perf expr: allow ',' to be an other token
> > >   perf expr: increase max other
> > >   perf expr: parse numbers as doubles
> > >   perf expr: debug lex if debugging yacc
> > >   perf metrics: fix parse errors in power8 metrics
> > >   perf metrics: fix parse errors in power9 metrics
> > >   perf expr: print a debug message for division by zero
> >
> > heya,
> > could we please get the 1st 10 patches in? they are important,
> > and let's not block them with new versions for patches 11/12
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> The first ten patches are in, can we go with what Ian suggested for the
> last two patches?

It seems sad not to make this test fail for broken event encodings, as
perf test does a good job of swallowing the test's debug output
(fork...). I was thinking that I'll split out the test and various
fixes in:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
The test will only do something if there is a MetricExpr for an
architecture. There are currently only MetricExpr for x86 and powerpc.
I've tested power 9 with the test, which tests the expressions for
power 8 but not the events, and everything passes. The area the test
can fail is x86 and I should be able to get reasonable coverage there
by grabbing cloud machines. When an x86 test fails it is hard to know
what to do. In Jiri's Skylake case naively 'fixing' the expression to
remove 'thresh=1' yields an expression that will only give the value
1. Perhaps a better 'fix' is just to remove the expressions in those
cases and wait for someone like Intel to refresh them? If that
expression will only work on a newer kernel then we need to identify a
constraint, etc. However, we couldn't see thresh as an event parameter
in a recent tree. Removing the expression seems like the most
expedient fix to get the test in, so that new expressions don't break
things :-)

Thanks Arnaldo for following up on this!

Ian

> - Arnaldo
>
> > thanks,
> > jirka
> >
> > >   perf parse-events: expand add PMU error/verbose messages
> > >   perf test: improve pmu event metric testing
> > >
> > >  tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
> > >  .../arch/powerpc/power8/metrics.json          |   2 +-
> > >  .../arch/powerpc/power9/metrics.json          |   2 +-
> > >  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
> > >  .../arch/x86/skylakex/skx-metrics.json        |   4 +-
> > >  tools/perf/tests/builtin-test.c               |   5 +
> > >  tools/perf/tests/expr.c                       |   1 +
> > >  tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
> > >  tools/perf/tests/pmu.c                        |   4 +-
> > >  tools/perf/tests/tests.h                      |   2 +
> > >  tools/perf/util/expr.c                        |   1 +
> > >  tools/perf/util/expr.h                        |   2 +-
> > >  tools/perf/util/expr.l                        |  16 +-
> > >  tools/perf/util/expr.y                        |  16 +-
> > >  tools/perf/util/parse-events.c                |  29 +++-
> > >  tools/perf/util/pmu.c                         |  33 ++--
> > >  tools/perf/util/pmu.h                         |   2 +-
> > >  17 files changed, 262 insertions(+), 55 deletions(-)
> > >
> > > --
> > > 2.26.2.526.g744177e7f7-goog
> > >
> >
>
> --
>
> - Arnaldo
