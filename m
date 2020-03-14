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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B4DC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F137020637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsE47yVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCOBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:39:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43183 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCOBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:39:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id x1so15078618qkx.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecMdX/kkcgeI1bF1MRkVwY4khKwFUay4TKuNBxqnWmk=;
        b=QsE47yVsnRi4mH/Ae9IkEz9gz4BC2eK+ktKXwyAIUyrPZgka87atHyWuUntrbWXx6K
         5O9jjvQuM2JyWxS7EZxGwMNfx0kX2CiwRRUwjdGzEhWopOqj4hxl5eWexOQkYQg+LlCj
         RFIWS9yj/KRTuquJfPaLd6wjP+GeXrjxeWXW5TTb8dea50oPDfulpjvJdBwOD8Rn+6EJ
         dZXEf0rxId4IUN0pHvISieWW609kh+mKs5hDjbWgY/5NGf5k91QaKf8t0juiwX771QG2
         jWsbyWbdOjhEkxd+2eMbaGKlMcuJsCd+M8JCJ2231jk0muQbUxR+8BMt7qy2AlZrS74/
         8AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecMdX/kkcgeI1bF1MRkVwY4khKwFUay4TKuNBxqnWmk=;
        b=n5nAiNBBTAlnUhIFSlBw0Ug312KRl6gvoGbrvGKaixSW+cTS4lIo4d/SKXnU8h1xKK
         R2bbsbEZ0Xcky5zPYDosup+daTpyRAz0efm1lx8wSYlz2AkmoasGvnbVfaQppGBXCiKD
         5u+cfE3D7XNbHUoMw8+hpNFoo7lxurcCRStERRCf6gB9VHtbYaizPDMjNjwPOIKxNDFM
         7poRRZwZsndEXMam4QGKHvNpyWO8W5SvVZFDLtshz6/c2p+bjMC3um/k4zt6dCC7oAhO
         pwYlguVjvmEHLVkAyvMbP7u3/WQQNnzgsoR+w0+yPv9mBHYMEWsQ7OXZpPnapSUSn3mV
         /WJw==
X-Gm-Message-State: ANhLgQ0w0uev0e07M7FiunTxfQ2I3BJ0ABtyPetv9rpGjf57mnGd8CeC
        B9xDa5t/qowyVXpuCdWwFKSp5KeWZL2NEYAdn3pKEqwt
X-Google-Smtp-Source: ADFU+vtOa6oagrl7UbWimFolLhARnqCo+lGIn00mrmW3AhyF192jiQVS5CfC0m0cO4nIO7G8SMb6EHmpHE2qlWBx0SY=
X-Received: by 2002:a25:908a:: with SMTP id t10mr12174650ybl.177.1584204589078;
 Sat, 14 Mar 2020 09:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200314042826.166953-1-irogers@google.com> <20200314142332.GB492969@krava>
In-Reply-To: <20200314142332.GB492969@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Mar 2020 09:49:37 -0700
Message-ID: <CAP-5=fXZJidxHYeCqHcNPBArMe_aYwP0+u2dxiTD+V1fammK_Q@mail.gmail.com>
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

On Sat, Mar 14, 2020 at 7:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Mar 13, 2020 at 09:28:26PM -0700, Ian Rogers wrote:
> > Realloc of size zero is a free not an error, avoid this causing a double
> > free. Caught by clang's address sanitizer:
> >
> > ==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
> >     #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
> >     #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
> >     #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
> >     #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
> >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> >
> > 0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
> > freed by thread T0 here:
> >     #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
> >     #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
> >     #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> >     #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> >     #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> >     #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> >     #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> >     #7 0x564965942e41 in main tools/perf/perf.c:538:3
> >
> > previously allocated by thread T0 here:
> >     #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
> >     #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
> >     #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
> >     #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
> >     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
> >     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
> >     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
> >     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
> >     #8 0x564965942e41 in main tools/perf/perf.c:538:3
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/mem2node.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > index 797d86a1ab09..7f97aa69eb65 100644
> > --- a/tools/perf/util/mem2node.c
> > +++ b/tools/perf/util/mem2node.c
> > @@ -95,7 +95,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
> >
> >       /* Cut unused entries, due to merging. */
> >       tmp_entries = realloc(entries, sizeof(*entries) * j);
> > -     if (tmp_entries)
> > +     if (j == 0 || tmp_entries)
>
> nice catch.. I wonder if we should fail in here, or at least
> warn that there're no entris.. which is really strange ;-)

The workload was the stream benchmark with perf c2c, but stream isn't
particularly long running. Not sure how j became 0, there's 2
possibilities in the code. The worry with a warning is the spam, so I
just wanted to make the code correct.

Thanks,
Ian

> thanks,
> jirka
>
> >               entries = tmp_entries;
> >
> >       for (i = 0; i < j; i++) {
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
