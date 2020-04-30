Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B840C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70361206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4c8tebj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD3Vj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726447AbgD3Vj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:39:27 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:39:27 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e16so1751683ybn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPXfTr1PUEcnQYtzL1SCshQ9U2tFp7AGyjQ19zmlJjw=;
        b=I4c8tebjA8xZu+gCahs2SQsh2UhWZwfhlg2Vi1C87wPDXbGFYgn3NggM+qTInIc7Lv
         bHT2i1H/HmuUNdJWQnQlQgushXfKcCzOOAxmFpOi+QFYpbB/1JCfCNmrlIbXYz/vBhuR
         jIAf2TuGuNViTa5AXvBYu0IXLarBA1mZwgc0d98D6qJxKRc0uQWcY/TcjW2nv4470QGu
         vAk6m0442JovQ23wQbzubdY/skvhRhv7GPC/es08YjonG3l7FvyKltFrhbT2sxkS2dpK
         QkOIXndoaRFCIyH7vby+NtrHwcSM5amM8LRS5wtsu3yJnigqW4BYCGAI6McQUdMv/qEn
         WfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPXfTr1PUEcnQYtzL1SCshQ9U2tFp7AGyjQ19zmlJjw=;
        b=VOY78L0Brd3ayJNLMfGpP89MiUOtvzn2isaoQPr2DBLHLeD09lwBm9OYlY6hwMGn+t
         1DLAZTGKyHwIdOFSC/O7bMfvqpsiLJ4afAG8oOJ2jJdA2iL3Oso21QOWyYtjUYUa6BgO
         DmHEson+oKuCM6SX5m0yijP4OIwOJcLb5EcF4W3/xbauoEX7rxSjSlawuG2snpIijSi0
         /pdD7B1p9By3pKIq3LAlVdGYPC2VegWfm2Tzsxlvq/64cM1aoQ/qTxSeQHpzMgzEKE9w
         YwSEsMviMZigBG2H4qPSE6Y1f5kAjVdfWHuayekB4FK2jc9pDSC4kFnVmYWgqSF4ydWc
         KoAQ==
X-Gm-Message-State: AGi0PuYbO+8ZZ3j42JqYfs1SvpgYAF/PHquTNhLwlmlESu+32RMjKZhm
        hptq9Y7TDEavuS652wgrtNp0uz15WhRC1tshSQX02g==
X-Google-Smtp-Source: APiQypL90WKJDRpQGilXJkYtJHzlvF+LQNlLF+84WBLdncmlNH9kzIV/1eg3WPm0jXEuCHVIFNa7trQZ8Gwq25E93MU=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr1358771ybs.286.1588282765903;
 Thu, 30 Apr 2020 14:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023101.82458-1-irogers@google.com> <20200429175420.GD30487@kernel.org>
In-Reply-To: <20200429175420.GD30487@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Apr 2020 14:39:14 -0700
Message-ID: <CAP-5=fWTAbyOXr5GghrbvfkaZ6EzH7GNDJiiDJkFqeF5mPgDeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf parse-events: fix memory leaks found on parse_events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
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

On Wed, Apr 29, 2020 at 10:54 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Mar 18, 2020 at 07:31:00PM -0700, Ian Rogers escreveu:
> > Memory leaks found by applying LLVM's libfuzzer on the parse_events
> > function.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
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
>
> I'm applying it but only after changing it to zfree(&pos->free_str), to
> make sure that any othe rcode that may still hold a pointer to pos will
> see a NULL in ->free_str and crash sooner rather than later.
>
> >                       free(pos);
> >               }
> >               return -EINVAL;
>
> And the following should be in a different patch
>
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
>
> And this one in another, I'll fix this up, but please try in the future
> to provide different patches for different fixes, so that if we
> eventually find out that one of the unrelated fixes is wrong, then we
> can revert the patch more easily with 'git revert' instead of having to
> do a patch that reverts just part of the bigger hodge-podge patch.
>
> If you go and have a track record of doing this as piecemeal as
> possible, I will in turn feel more confident of processing your patches
> in a faster fashion ;-) :-)

Thanks, at some point I'd like to get libfuzzer with asan working for
more than just me so that we don't backslide. It'd also make the
reproductions easier to share.

Ian

> Thanks,
>
> - Arnaldo
>
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
> --
>
> - Arnaldo
