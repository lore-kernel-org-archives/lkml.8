Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B2C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E6521D81
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDaVdQvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgD2Rnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:43:48 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F1C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:43:47 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o139so1686549ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUC2c7qaVi26ZGKWMBOTx0/+sTgSLxjRbpYLLRvQLZ8=;
        b=eDaVdQvJuHitoEvv+FFtbMIBRroVqMfU+tjQMg7aEAFoQXhmpRuh/lHszkEdf1X9Ub
         g7lwqRZvjtB0MxIigoHP/vNgG+CJEejguqKc6KeSmi0+EUriGCbQSpkmGwV9yar5/wcC
         aY/NtJqBYDBQA/i2Byf+FWNAEP+4rQCUAkCTDwsOfLp/qond8/X4YAH/2iO36WqrZjdY
         QFGpQQqaMpHIox7oyDTVyFxj/VU2FnObbb58nUygQJxQw+Ng/ANauMMUHid6t69Y4bnM
         k45+v52GS2sOYhPZUJNM7QCtNddYZPs3tWPBTrjgJpB7dlJxg+uQ+5tvyA7rK7mJ3fWx
         kRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUC2c7qaVi26ZGKWMBOTx0/+sTgSLxjRbpYLLRvQLZ8=;
        b=ujEEGoy55tGwTuFDIjCZMXSBYt79+QAY/e2SDjHB6Sm72fpzYVUtbdK7ETN27GpcXr
         Kfhzr8XmxBKcEUkIX8F1KWQRbxV7SYHSg9vsRqLBzQnUAauD6gkEW37N9qXIKI05dQN1
         9q5sgYst/mTx38YDfNV8wYRKvuV6BoNOcZqbwawFJSH1SgWOQTwm3OARz0BqiZ3mvK+Z
         ANlOpxXkqJSNnEmeZJu1oyQ7atR6hZsHKu1tPm93Ts26DeER/HqdoW++ltMU1V/BNaMb
         0f67l2ImeQn9U4SmXcsTZzE9gM6QQT09J0IrxWDcfHGdTimhKy/3JuVD0ryRMCA22bkp
         pKtw==
X-Gm-Message-State: AGi0PuZp/z+OFeY7sTaPdUtRdni9gyKrd1KfqdyiKu0GitjrQvX/nVX2
        eLGk4Zu09yLaVtUBmmfdfR47Y+K8RLWFxpUaZCEZCQ==
X-Google-Smtp-Source: APiQypJoFGf572jCZ3dzXxWizg4289lgkS/VM9I6VCpSem3gJ+VpZPZdvIkbHkxj2bDNFJedH6togd1L5mpn9UPYHQI=
X-Received: by 2002:a25:4443:: with SMTP id r64mr53632222yba.41.1588182226158;
 Wed, 29 Apr 2020 10:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023101.82458-1-irogers@google.com> <20200323105939.GE1534489@krava>
In-Reply-To: <20200323105939.GE1534489@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Apr 2020 10:43:31 -0700
Message-ID: <CAP-5=fU4dUPwRA-XTw6B9Xtc5y7Z0jZzDHU=KFvNfbNXVsONkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf parse-events: fix memory leaks found on parse_events
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

On Mon, Mar 23, 2020 at 3:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Mar 18, 2020 at 07:31:00PM -0700, Ian Rogers wrote:
> > Memory leaks found by applying LLVM's libfuzzer on the parse_events
> > function.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> thanks,
> jirka

Ping.

> > ---
> >  tools/perf/util/parse-events.c | 2 ++
> >  tools/perf/util/parse-events.y | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 593b6b03785d..1e0bec5c0846 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >
> >               list_for_each_entry_safe(pos, tmp, &config_terms, list) {
> >                       list_del_init(&pos->list);
> > +                     if (pos->free_str)
> > +                             free(pos->val.str);
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
> >       }
> >       free(list_evsel);
> >  }
> > @@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
> >       }
> >       parse_events_terms__delete($2);
> >       parse_events_terms__delete(orig_terms);
> > +     free(pattern);
> >       free($1);
> >       $$ = list;
> >  #undef CLEANUP_YYABORT
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
