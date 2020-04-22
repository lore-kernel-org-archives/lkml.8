Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C7C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E842073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZ/j6m/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgDVRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDVRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:37:50 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040BC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:37:50 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g6so1593910ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvchBBJ/WwaFIxgW3jUEXDO2se5wBjDY362C+NkJt50=;
        b=gZ/j6m/TeamenU55WqtoAp7NKHXhZKqYfBH4qxEZyLZm0N/7V9dS8fabqBVVTbugsw
         NhxdOb+U/ZMXiFCZj3ajZYdoA8C3rj2GGjcXq/InEuaCYK3+poB5Fgy7/mysw3ohOyWI
         tW/isuparEDFppE+7z0axRXQbPo6vPOTvxsecFt9do+xmfMJa9XQfJ9E2syD2gT8HpUZ
         5I2w2a4GIRkEDe96NCxB23CzgecZj5/TAjZcdRWcUYkONft+0qZVwB/KyGAMISatW8Xb
         gmJqk/x854PyiyYsh9QBPf3UiYoFvzJ3GDJpoV6AaYm4eE6Rhk3DJo+qscdtVNGdUwL6
         DoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvchBBJ/WwaFIxgW3jUEXDO2se5wBjDY362C+NkJt50=;
        b=fnr+epM/xyzZPrx7Pd/9xx1m5RpYm+F9P47ulVOOl8fz9wMMjkOPtcjf57e/cyssAH
         B7HX9YRNL5WwABZCrlPXgz99R2Yc6i9wSNKAkTEgGj34ffYrZO+VPmV7rJth2ysuypLu
         i4ymzIz26ZJxTOOKTCqVBap41QRMvM++mhG3MTGxDD02NHwb0w12RpyGT1RyEJdcputi
         7LpvjbylZ7XVs29c94MRRTmu2UXvlMGWyOdm4+nDGX6RlzuD4A603Y1kzqrShePzvYxG
         AwLZEBftWflVPrJWXFMy8w5uNSLPnJwZU8Oi+qDujON3IA0s3wUChbV0ZfTqFRYX3TP/
         Huvg==
X-Gm-Message-State: AGi0PuaCsZ36FVoVYzg3ZFLe3mTTJKC4dq9PiO2URIWOYdA+YLwREaQp
        q56wYXK8BPk0gjXCNAM9lvf+3p/xn4ZxpBswjQVHNg==
X-Google-Smtp-Source: APiQypL6vw7XO1lCCkx51b4Dhc5vH9P6D4+6D0RbIFAR4t9MitkKtdEPV7uVqP8CHwv9SYO/D4Zo6KmQLXPWbzuUmvY=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr37108524ybc.47.1587577069276;
 Wed, 22 Apr 2020 10:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200421061103.109440-1-irogers@google.com> <20200422084635.GF962614@krava>
In-Reply-To: <20200422084635.GF962614@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 10:37:38 -0700
Message-ID: <CAP-5=fUSC0mR6uvw6OpXzy_0m2YtfgHrGOW_z7xpLa71vQ3zxA@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: add dummy event during system wide synthesis
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 1:46 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Apr 20, 2020 at 11:11:03PM -0700, Ian Rogers wrote:
> > During the processing of /proc during event synthesis new processes may
> > start. Add a dummy event if /proc is to be processed, to capture mmaps
> > for starting processes. This reuses the existing logic for
> > initial-delay.
> >
> > v2 fixes the dummy event configuration and a branch stack issue.
>
> heya,
> it's breaking attr tests for me:
>
> [jolsa@krava perf]$ sudo ./perf test -v 17
> 17: Setup struct perf_event_attr                          :
> --- start ---
> test child forked, pid 1046560
> running './tests/attr/test-record-graph-default'
> running './tests/attr/test-record-raw'
> running './tests/attr/test-record-branch-filter-any'
> running './tests/attr/test-record-freq'
> running './tests/attr/test-record-branch-any'
> running './tests/attr/test-stat-group1'
> running './tests/attr/test-record-no-samples'
> running './tests/attr/test-record-graph-dwarf'
> running './tests/attr/test-stat-C0'
> running './tests/attr/test-stat-basic'
> running './tests/attr/test-record-group'
> running './tests/attr/test-record-branch-filter-k'
> running './tests/attr/test-stat-group'
> running './tests/attr/test-record-C0'
> expected config=0, got 9
> expected sample_type=391, got 455
> expected disabled=1, got 0
> FAILED './tests/attr/test-record-C0' - match failure
> test child finished with -1
> ---- end ----
> Setup struct perf_event_attr: FAILED!
>
> jirka

Thanks, fixed in v3:
https://lore.kernel.org/lkml/20200422173615.59436-1-irogers@google.com/

Ian

> >
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 19 ++++++++++++++-----
> >  tools/perf/util/evsel.c     |  5 ++++-
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..8d1e93351298 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
> >       int rc = 0;
> >
> >       /*
> > -      * For initial_delay we need to add a dummy event so that we can track
> > -      * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> > -      * real events, the ones asked by the user.
> > +      * For initial_delay or system wide, we need to add a dummy event so
> > +      * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> > +      * event synthesis.
> >        */
> > -     if (opts->initial_delay) {
> > +     if (opts->initial_delay || target__has_cpu(&opts->target)) {
> >               if (perf_evlist__add_dummy(evlist))
> >                       return -ENOMEM;
> >
> > +             /* Disable tracking of mmaps on lead event. */
> >               pos = evlist__first(evlist);
> >               pos->tracking = 0;
> > +             /* Set up dummy event. */
> >               pos = evlist__last(evlist);
> >               pos->tracking = 1;
> > -             pos->core.attr.enable_on_exec = 1;
> > +             /*
> > +              * Enable the dummy event when the process is forked for
> > +              * initial_delay, immediately for system wide.
> > +              */
> > +             if (opts->initial_delay)
> > +                     pos->core.attr.enable_on_exec = 1;
> > +             else
> > +                     pos->immediate = 1;
> >       }
> >
> >       perf_evlist__config(evlist, opts, &callchain_param);
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 6a571d322bb2..ca8f9533d8f9 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
> >       }
> >
> >       /*
> > +      * A dummy event never triggers any actual counter and therefore
> > +      * cannot be used with branch_stack.
> > +      *
> >        * For initial_delay, a dummy event is added implicitly.
> >        * The software event will trigger -EOPNOTSUPP error out,
> >        * if BRANCH_STACK bit is set.
> >        */
> > -     if (opts->initial_delay && is_dummy_event(evsel))
> > +     if (is_dummy_event(evsel))
> >               perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> >  }
> >
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
> >
>
