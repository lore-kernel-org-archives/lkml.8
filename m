Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24892C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3720767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq9B/yMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCTS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:26:01 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41181 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:26:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id d5so2935792ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAuZ5tw5lKEWRwYrS4t2K3YVE1qFf5yYC3/QDtY6LpA=;
        b=eq9B/yMzD83gZKl8onYSVe1kBSqEMnm9UKp6UpnjkPodiaLkvaTx0o3L9PJtBqaXvZ
         IJ4UIsVvVz0tr4o9NtLxvn2WnUfXPJ7pNmFgrM9BRpm0S0zJhreDKiY/7NWkwq3j0Syt
         1s+Ngn7MXDiS8MQD2ioLYn3M51JsUGDoqaoDFe0uMEW92vPtzx+TYgjyskZ1eYFAcGmI
         5vULqgrrkCY4ZLuJ1qiDtB+TsZ9EKJ/JjTljn4BqtleUuD1oQxbNWKpZXgPShWEUDH1/
         owrGVpm+g9xf9JqP6Oy3tVpK2hjtYd8+3SX6M9P6S9HZW1DLpW5cLg2WP7gDn0A1fhgf
         Tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAuZ5tw5lKEWRwYrS4t2K3YVE1qFf5yYC3/QDtY6LpA=;
        b=WoFz25FsztRoUwyhOalsLgGHoS5/cj62VU0cXbKOnDlypn8CK1/TJ/2MdGzbGGOcRZ
         9HxcAkjEKzjeXKZJC4NClYd+TggsdqzBdmrfnOVPrQ094jXT6t/oiYSxygYyFWzxiqp9
         CyqB1kmNlGXbZrNwjxQAsoCO4RkJ2hlM2qG9rmnzNwQKjGhDVV/wjhjuuIam5u6yupO3
         TdcjLprQiOnx4AdjVBo2tWYmhb2SNACwNN2g+TPv8XvVJECGJmK1C1UgUslYE9tdcKju
         kgwi/L1WwbeoFJ4MgBOK4TaKrzqu6KQiQbRyH0jswan4r+KJudoDGE2/3gq9Rogr0U5D
         mkYg==
X-Gm-Message-State: ANhLgQ1hhS6Uvyjh7CF+jc4QL5xxEdTbvG/z3qCnP4YheCdtaPmGIkdN
        vDO17JG1c9QSzq8oDhkG63qnFxJ81ZU6JbUKGZUoxQ==
X-Google-Smtp-Source: ADFU+vuN7dISVFh18WjZo0+rmu386OeNrATWOHmGmrHsgQjtnCBy4vOqQjDzGI7BmyzEffTFRPamtrTHmm5cFwRE0to=
X-Received: by 2002:a25:c482:: with SMTP id u124mr14970611ybf.286.1584728758311;
 Fri, 20 Mar 2020 11:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200314042826.166953-1-irogers@google.com> <20200314142332.GB492969@krava>
 <CAP-5=fXZJidxHYeCqHcNPBArMe_aYwP0+u2dxiTD+V1fammK_Q@mail.gmail.com> <20200315093013.GC492969@krava>
In-Reply-To: <20200315093013.GC492969@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 Mar 2020 11:25:47 -0700
Message-ID: <CAP-5=fWmJdAC3GtwO3sf+725roY6T8s8GRvDJL4Rfqv+ByysGQ@mail.gmail.com>
Subject: Re: [PATCH] perf mem2node: avoid double free related to realloc
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 2:30 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Mar 14, 2020 at 09:49:37AM -0700, Ian Rogers wrote:
> > On Sat, Mar 14, 2020 at 7:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Mar 13, 2020 at 09:28:26PM -0700, Ian Rogers wrote:
> > > > Realloc of size zero is a free not an error, avoid this causing a double
> > > > free. Caught by clang's address sanitizer:
> > > >
> > > > ==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
> > > >     #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
> > > >     #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
> > > >     #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
> > > >     #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
> > > >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > > >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > > >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > > >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > > >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> > > >
> > > > 0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
> > > > freed by thread T0 here:
> > > >     #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
> > > >     #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
> > > >     #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> > > >     #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > > >     #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > > >     #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > > >     #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > > >     #7 0x564965942e41 in main tools/perf/perf.c:538:3
> > > >
> > > > previously allocated by thread T0 here:
> > > >     #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
> > > >     #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
> > > >     #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
> > > >     #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> > > >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> > > >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> > > >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> > > >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> > > >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/mem2node.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > > > index 797d86a1ab09..7f97aa69eb65 100644
> > > > --- a/tools/perf/util/mem2node.c
> > > > +++ b/tools/perf/util/mem2node.c
> > > > @@ -95,7 +95,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
> > > >
> > > >       /* Cut unused entries, due to merging. */
> > > >       tmp_entries = realloc(entries, sizeof(*entries) * j);
> > > > -     if (tmp_entries)
> > > > +     if (j == 0 || tmp_entries)
> > >
> > > nice catch.. I wonder if we should fail in here, or at least
> > > warn that there're no entris.. which is really strange ;-)
> >
> > The workload was the stream benchmark with perf c2c, but stream isn't
> > particularly long running. Not sure how j became 0, there's 2
> > possibilities in the code. The worry with a warning is the spam, so I
> > just wanted to make the code correct.
>
> I was wondering if we should fail completely,
> but we might break some c2c expected behaviour
>
> how about just WARN_ONCE pn j == 0, and then
> the lookup will fail already with:
>
>         if (WARN_ONCE(node < 0, "WARNING: failed to find node\n"))
>                 return;
>
> just get enough hints ;-)

Sorry for the delay. I sent a v2 hopefully doing what you asked :-)
https://lkml.org/lkml/2020/3/20/858

Thanks,
Ian

> jirka
>
> >
> > Thanks,
> > Ian
> >
> > > thanks,
> > > jirka
> > >
> > > >               entries = tmp_entries;
> > > >
> > > >       for (i = 0; i < j; i++) {
> > > > --
> > > > 2.25.1.481.gfbce0eb801-goog
> > > >
> > >
> >
>
