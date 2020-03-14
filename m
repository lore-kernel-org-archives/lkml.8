Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE63C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115BC20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjZqb4hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCOBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:35:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46322 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCOBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:35:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id f28so19900269qkk.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyh7Hx4P5azfX0v8IUQDrnTKYHqh3YH9V1fzoLax7D4=;
        b=HjZqb4hMbE+P/gX5sK4vL0TAQV0kiEwHksv2Vw9O9KQGXap9nZ8sbJ9yTF/uJ2EHGQ
         OvEo8DHfjMOEqRv9n9GxLjow4jcZHGuInWbX4gy66qrR1S668/PGWJhcyDn/NxhY7wiP
         kR4IJTyadLrL3Bg0rMxhNI1pSX1Ab2URRn9J1tC/42tL5ocwETcTIkzXj0EuvXpjYfQH
         jWC/W+mHUjXcWUrU7j8QWvRvgdGAaP+Hj775QvYKr8uIwa4l7yNyWSjXJzkY93FC0fMM
         FSTnW5LXa6DfAKL95sCQeASBlVzX2iTPjPxBSQAhE37EhOKprgpzNw0Cp+ah42U2WSoL
         E92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyh7Hx4P5azfX0v8IUQDrnTKYHqh3YH9V1fzoLax7D4=;
        b=N6oe8fWfUeRQG8mePOUbsx9kqel/itwWPasMPcrTVid4tyZWI5KVCyOPdlt88M81+9
         JDS8P+a06+Gb0dmhtQVAGYkoXPHVEPSzD9EFWcEAFlGVFf1q7AGM7og/g7VJAII8JlaI
         K46PH5tWHk0GaGvCF8ORoNlAbm0MRgyMML6QaChV0t927aKCX+6+XvE3p3KP/F/5Aftv
         vPimAcbKqv7y4bOnxIj6S73vopAkCWkHJf7Fvvqym1sCyDf6pjnG4pPNuOBtsd2e4le1
         Eze4+75anroxP0D+ubq/joLBaJ45/InrVbneNv+z9Z9J4s6yP8lnMeaLRj45xXm44MEv
         MY4g==
X-Gm-Message-State: ANhLgQ3iUIYbhwo7pPmPkbKmnORNAn9U/RDtJ/6o8RTPJQCP46tq9ALy
        1GL4eU24ym9wz2IVWyqxxYBwjmzY3CZ1WNpPvnMNyoGi
X-Google-Smtp-Source: ADFU+vubTNjzoYc+Mt1YwQiEPLfMUjhYM0Zp2sjxCXIPNaBYloJFyw4DarM1wVm87d4QoiH9nnB79GsfpgvxqJrzDlI=
X-Received: by 2002:a25:6c0a:: with SMTP id h10mr23810528ybc.47.1584204891686;
 Sat, 14 Mar 2020 09:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200313230249.78825-1-irogers@google.com> <20200314135925.GA492969@krava>
In-Reply-To: <20200314135925.GA492969@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Mar 2020 09:54:40 -0700
Message-ID: <CAP-5=fWO8Ufw9EmjC3TsOJwbzqQsv4OBtNiGAjiMtRtRo60yJQ@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: fix 3 use after frees
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 6:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Mar 13, 2020 at 04:02:49PM -0700, Ian Rogers wrote:
> > Reproducible with a clang asan build and then running perf test in
> > particular 'Parse event definition strings'.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index a14995835d85..593b6b03785d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >               evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
> >                                   auto_merge_stats, NULL);
> >               if (evsel) {
> > -                     evsel->pmu_name = name;
> > +                     evsel->pmu_name = name ? strdup(name) : NULL;
> >                       evsel->use_uncore_alias = use_uncore_alias;
> >                       return 0;
> >               } else {
> > @@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >               evsel->snapshot = info.snapshot;
> >               evsel->metric_expr = info.metric_expr;
> >               evsel->metric_name = info.metric_name;
> > -             evsel->pmu_name = name;
> > +             evsel->pmu_name = name ? strdup(name) : NULL;
>
> so it's pmu->name pointer.. does pmu get destroyed before the evsel?
> also should we free that then like below?
>
> >               evsel->use_uncore_alias = use_uncore_alias;
> >               evsel->percore = config_term_percore(&evsel->config_terms);
> >       }
> > @@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> >                               if (!parse_events_add_pmu(parse_state, list,
> >                                                         pmu->name, head,
> >                                                         true, true)) {
> > -                                     pr_debug("%s -> %s/%s/\n", config,
> > +                                     pr_debug("%s -> %s/%s/\n", str,
>
> nice catch ;-)
>
> >                                                pmu->name, alias->str);
> >                                       ok++;
> >                               }
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 816d930d774e..15ccd193483f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1287,6 +1287,7 @@ void perf_evsel__exit(struct evsel *evsel)
>         perf_thread_map__put(evsel->core.threads);
>         zfree(&evsel->group_name);
>         zfree(&evsel->name);
> +       zfree(&evsel->pmu_name);
>         perf_evsel__object.fini(evsel);
>  }

Agreed on the zfree! I'll upload a v2 with it. I've tested with
address sanitizer in case of double frees, etc. I haven't yet fuzz
tested the latest version of parse events, libfuzz detects memory
leaks between iterations so I expect there will be future small
patches like this coming.

Thanks,
Ian
