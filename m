Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799CC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBEF206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj3i7OsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgEMGcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgEMGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:32:28 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:32:27 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a10so4029753ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZBXcKq2rzqYGz9+5XGGqcnLBFUiUXkvaqb2HSO7NlI=;
        b=sj3i7OsUUItI5qMkwPlnLSqUEGr+DB7vwSBPH9SsM/0/fe76VCn7oGve5JfRoBYlaL
         hoR7nVvKPEcg7lDq0tccz1KLxGBG7T3iXskdlyfnRhbjdPo1ydeyuTOmk4xNIop0571u
         TCBHcQ6789Tr263gECNzDEp2fZ8KstnodUO2csOz+Jxng9AaraMeow6rlHCRD9tOCnc5
         IhgigVlIzOmVtw0fukHyKPMS14e6JnZ407y+SJO7NLTNKltCxOYD5HQEyDY8TLJlx669
         Yu7iwn9HFe0gCOfkUdrRwabpCO/eam48cCVpZpmrWkg9v0MkYiSpUc5cyGQLq0iqUZPP
         gRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZBXcKq2rzqYGz9+5XGGqcnLBFUiUXkvaqb2HSO7NlI=;
        b=DvoBTMZ+H1jIQGKNXYC7fjgm/zA/vOdLyxPQHOUZqBxOidZ17gsuId8/bCDD30h+Ri
         n6HID+jh3B0pNouipE9QcY1gJYqokQz57KFd6wB2p9kbmw148/BwYYStzt3ZN+cf3l9O
         fSRAH9Bn8maNDRy5F352Ktt57/lrjHoOYR2fOhKYcGV7BUWPHI4stgcOnOeX+fEdkgqV
         Fmmpfs5ENWXxUFUwZWquT29tN8TP7hWD3/VTmsXFiWnd7PXHkW5hV4bRh30lLVGWS1gI
         pCkBKz6+Wfn+N76Q8ZWYyGubDg+vlI/enANqn3+EuuqhT+xUtDkP/mSjZi63Zvea9cj+
         6sZg==
X-Gm-Message-State: AGi0Pub8SwyFc4PsiREpby6HX0/MNMrPZdxuoBo2GxSNNi2Ds6Hlm3Fs
        wSOt8yBfBANBohyok+VrHviVJPNumsnKRW44nyfbzA==
X-Google-Smtp-Source: APiQypK8buJkMEOunSPFpP7YZ+lzJiBxDfKQK5dRnS3DGY5oY/xXpimGLQ+naHo5pZnrh1rojeG54IJMqXTxyeggdLY=
X-Received: by 2002:a05:6902:4ee:: with SMTP id w14mr37374230ybs.383.1589351546920;
 Tue, 12 May 2020 23:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com> <20200507084445.GA2447905@krava>
 <20200511153207.GD28888@kernel.org> <CAP-5=fUEz6iBYfiwHgyGCuVNuPGAQN+Fgbcd4ZSn5cV_VAsFvw@mail.gmail.com>
In-Reply-To: <CAP-5=fUEz6iBYfiwHgyGCuVNuPGAQN+Fgbcd4ZSn5cV_VAsFvw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 May 2020 23:32:15 -0700
Message-ID: <CAP-5=fUj_htQNqqMkhqM6Az0iEh1ekU5AbLRPh_x4jRoagqzZA@mail.gmail.com>
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

On Mon, May 11, 2020 at 9:12 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, May 11, 2020 at 8:32 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, May 07, 2020 at 10:44:45AM +0200, Jiri Olsa escreveu:
> > > On Fri, May 01, 2020 at 10:33:21AM -0700, Ian Rogers wrote:
> > > > Add a test that all perf metrics (for your architecture) are parsable
> > > > with the simple expression parser. Attempt to parse all events in
> > > > metrics but only fail if the metric is for the current CPU. Fix bugs
> > > > in the expr parser, x86 and powerpc metrics. Improve debug messages
> > > > around add PMU config term failures.
> > > >
> > > > v4 rebases after Kajol Jain's patches and fixes an asprintf warning.
> > > > v3 adds parse event testing of ids and improves debug messages for add
> > > >   PMU. These messages are paticular visible with 'perf test 10
> > > >   -vvv'. It moves the testing logic from tests/expr.c to
> > > >   tests/pmu-events.c as suggested by John Garry
> > > >   <john.garry@huawei.com>.
> > > > v2 adds Fixes tags to commit messages for when broken metrics were
> > > >   first added. Adds a debug warning for division by zero in expr, and
> > > >   adds a workaround for id values in the expr test necessary for
> > > >   powerpc. It also fixes broken power8 and power9 metrics.
> > > >
> > > > Ian Rogers (12):
> > > >   perf expr: unlimited escaped characters in a symbol
> > > >   perf metrics: fix parse errors in cascade lake metrics
> > > >   perf metrics: fix parse errors in skylake metrics
> > > >   perf expr: allow ',' to be an other token
> > > >   perf expr: increase max other
> > > >   perf expr: parse numbers as doubles
> > > >   perf expr: debug lex if debugging yacc
> > > >   perf metrics: fix parse errors in power8 metrics
> > > >   perf metrics: fix parse errors in power9 metrics
> > > >   perf expr: print a debug message for division by zero
> > >
> > > heya,
> > > could we please get the 1st 10 patches in? they are important,
> > > and let's not block them with new versions for patches 11/12
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > The first ten patches are in, can we go with what Ian suggested for the
> > last two patches?

To follow up, I've resent the last two patches here:
https://lore.kernel.org/lkml/20200513001729.21155-1-irogers@google.com/
https://lore.kernel.org/lkml/20200513062752.3681-1-irogers@google.com/T/#t
The event parsing errors don't cause the test to fail in the latter.

Thanks,
Ian

> It seems sad not to make this test fail for broken event encodings, as
> perf test does a good job of swallowing the test's debug output
> (fork...). I was thinking that I'll split out the test and various
> fixes in:
> https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
> The test will only do something if there is a MetricExpr for an
> architecture. There are currently only MetricExpr for x86 and powerpc.
> I've tested power 9 with the test, which tests the expressions for
> power 8 but not the events, and everything passes. The area the test
> can fail is x86 and I should be able to get reasonable coverage there
> by grabbing cloud machines. When an x86 test fails it is hard to know
> what to do. In Jiri's Skylake case naively 'fixing' the expression to
> remove 'thresh=1' yields an expression that will only give the value
> 1. Perhaps a better 'fix' is just to remove the expressions in those
> cases and wait for someone like Intel to refresh them? If that
> expression will only work on a newer kernel then we need to identify a
> constraint, etc. However, we couldn't see thresh as an event parameter
> in a recent tree. Removing the expression seems like the most
> expedient fix to get the test in, so that new expressions don't break
> things :-)
>
> Thanks Arnaldo for following up on this!
>
> Ian
>
> > - Arnaldo
> >
> > > thanks,
> > > jirka
> > >
> > > >   perf parse-events: expand add PMU error/verbose messages
> > > >   perf test: improve pmu event metric testing
> > > >
> > > >  tools/perf/arch/x86/util/intel-pt.c           |  32 ++--
> > > >  .../arch/powerpc/power8/metrics.json          |   2 +-
> > > >  .../arch/powerpc/power9/metrics.json          |   2 +-
> > > >  .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
> > > >  .../arch/x86/skylakex/skx-metrics.json        |   4 +-
> > > >  tools/perf/tests/builtin-test.c               |   5 +
> > > >  tools/perf/tests/expr.c                       |   1 +
> > > >  tools/perf/tests/pmu-events.c                 | 156 +++++++++++++++++-
> > > >  tools/perf/tests/pmu.c                        |   4 +-
> > > >  tools/perf/tests/tests.h                      |   2 +
> > > >  tools/perf/util/expr.c                        |   1 +
> > > >  tools/perf/util/expr.h                        |   2 +-
> > > >  tools/perf/util/expr.l                        |  16 +-
> > > >  tools/perf/util/expr.y                        |  16 +-
> > > >  tools/perf/util/parse-events.c                |  29 +++-
> > > >  tools/perf/util/pmu.c                         |  33 ++--
> > > >  tools/perf/util/pmu.h                         |   2 +-
> > > >  17 files changed, 262 insertions(+), 55 deletions(-)
> > > >
> > > > --
> > > > 2.26.2.526.g744177e7f7-goog
> > > >
> > >
> >
> > --
> >
> > - Arnaldo
