Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C6C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802FC2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLqJ5V/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCSD4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:56:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36277 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSD4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:56:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so1165280qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 20:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OL5W/cXAcaO5++QZJaWBgs8McWwwSxdm+ZdDM1yl8To=;
        b=HLqJ5V/99EmI9c1QpuWro6BvQeXa3sXgHXMp6UHqO8bf1kE2ciOQxvhgojY9LTcRih
         On6HWoRo0zYxLLawU9zNURkL48jhgLITm0b9ut781uxGSIafauaMiOq81Ugro9n0zGux
         AWF2StH00lgs7LHsRjvAaA5nolggOe8jXLd3FPxpSlCRh0dEBR/PQzaJcbbrkJAqFQBK
         L351nT925WTEDLHVqvZjIURdJWxwfxxPAYR0ldZfzPyGwUkss6Qy2gCWokxyKcewavbJ
         QmFDatE0Qe7qpzWNf66L82Zsmlvo41RrT5ax5uaIPSdrpfZ7NADgcRlhbKAmIWoo/dAY
         nSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OL5W/cXAcaO5++QZJaWBgs8McWwwSxdm+ZdDM1yl8To=;
        b=LhQoPqr/Y4u2QcwgDH8Fo6LLvk+gCvhgIH0OP9hnnWkz89ifxj248EIti3lAkwl4hI
         6sthVlbcM67sC2BBZ/ff4faT0ZWNBauIuUEiM55mjAPwa7XhjIKC348rLrLDEDSWai9Y
         etvRn0T22ozOh4QmaJOUt3kYcu2bxEHWyf3kxOfPbBeISDU85BzYYz2nHZcduibEO1J2
         4+mTup9mG7rwpUxk3vHZZ+SC1j6wNI2SO/Cj9BKgwiawPTVLdl5Croa2/0BCYrydfpH4
         SM6L46meDnQuDt4Hn7pxMS5QsU6f80A+WMFOhaPp5tqYN7va8aoqIIu4fE3/V6hi+gx4
         DF+w==
X-Gm-Message-State: ANhLgQ0dXyLNRK8qq3HQ/ia7gyP4SdAVSxqzTMwwox/elq5l1Z1X7dq8
        sBRh2cj4py+zclezWzeV/szkwj3F16lFhh+/90VHeg==
X-Google-Smtp-Source: ADFU+vtWuMfbBkluyYlSkgrzZn6ofaN7osU/iy+ACcP2SEbdBQHxCB1T5qtpRBhN51rasqDRYjEEWh81ofMZAR+u6ow=
X-Received: by 2002:a25:c482:: with SMTP id u124mr1628208ybf.286.1584590198061;
 Wed, 18 Mar 2020 20:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316041431.19607-1-irogers@google.com> <20200318104011.GF821557@krava>
In-Reply-To: <20200318104011.GF821557@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 Mar 2020 20:56:26 -0700
Message-ID: <CAP-5=fXQzLMuv-6EWGdFY1p5oLjV9301k1tkYL+R7qYHQR6wXA@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: fix memory leaks found on parse_events
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

On Wed, Mar 18, 2020 at 3:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Mar 15, 2020 at 09:14:31PM -0700, Ian Rogers wrote:
> > Memory leaks found by applying LLVM's libfuzzer on the parse_events
> > function.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/evlist.c        | 2 ++
> >  tools/perf/util/parse-events.c | 2 ++
> >  tools/perf/util/parse-events.y | 3 ++-
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 5b9f2ca50591..6485d1438f75 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -125,8 +125,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
> >  void perf_evlist__exit(struct perf_evlist *evlist)
> >  {
> >       perf_cpu_map__put(evlist->cpus);
> > +     perf_cpu_map__put(evlist->all_cpus);
>
> ugh, yes, could you please put it to separate libperf patch?

Done. https://lkml.org/lkml/2020/3/18/1318

> >       perf_thread_map__put(evlist->threads);
> >       evlist->cpus = NULL;
> > +     evlist->all_cpus = NULL;
>
> there's already change adding this waiting on the list:
>   https://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com/

I'm not seeing this in perf/core on
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
The previous thread mentions Arnaldo porting it. It is only 1
statement so I've left it in.

> >       evlist->threads = NULL;
> >       fdarray__exit(&evlist->pollfd);
> >  }
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index a14995835d85..997862224292 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >
> >               list_for_each_entry_safe(pos, tmp, &config_terms, list) {
> >                       list_del_init(&pos->list);
> > +                     if (pos->free_str)
> > +                             free(pos->val.str);
>
> ack, would be nice to have  perf_evsel__free_config_terms generalized
> to work directly over config terms list, so we'd have only single
> cleanup function
>
> >                       free(pos);
> >               }
> >               return -EINVAL;
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 94f8bcd83582..8212cc771667 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
> >
> >       list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
> >               list_del_init(&evsel->core.node);
> > -             perf_evsel__delete(evsel);
> > +             evsel__delete(evsel);
>
> ack
>
> >       }
> >       free(list_evsel);
> >  }
> > @@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
> >       }
> >       parse_events_terms__delete($2);
> >       parse_events_terms__delete(orig_terms);
> > +     free(pattern);
>
> ack
>
> could you please send the separate change for libperf?
> and synchronize with that other patch mentioned above

Done-ish. Thanks,
Ian

> thanks,
> jirka
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200318104011.GF821557%40krava.
