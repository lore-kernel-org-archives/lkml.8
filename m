Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F2C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E26022208
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZBa6d/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD2RpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2RpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:45:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:45:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o10so2603336qtr.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pNOTE8azPZYAJ5CF5910AMNX6/C9i6fDy25Mv94mhz4=;
        b=JZBa6d/pK58LBnmNrQVv70YqrHdZMC/mIq6EFekSKHVk4QKYcZ9DKsR7IFaX1ezQqF
         rxBUMHkcpM+JER7TGAkH4bgsF/ycLewrICblSU5GKaC+Jd2tMBCToXR0sOwjdTQpAERS
         U3lrgaCJ3DK4GzLnmD7bGyCaI7h3SUPqnS+sRSlL6iGV1qg6nzmqNH6emWvuBCEEBKC5
         UnNpmMXT7oCJTNY52yc6qL8tN6jMhE0ILf8V/9af3EaJEYqVBYy2aGMBRI9pOpXMqZ2C
         CPmvTyXystgMU8PWvL4XyLt6VupcJ8v/18U6sKfYEOSDt+Ilhn14XXzkgZ1rJyicvXsS
         ew3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNOTE8azPZYAJ5CF5910AMNX6/C9i6fDy25Mv94mhz4=;
        b=A7/qhhMEMUx+SCJc7BW1VOgTOCGzYQ0cZgGfYAFEqH24WV2po5D5qQNq57xNhKpm4L
         jRv0QWirqOk3+0SBGuqHAOixV7FXzGl1QWTzLXmIcDevZpw4girToxPfcryEppzM8tVp
         VQDqnMQDA3q1Mb3KeT8bUs+SAr/+c54lghS3o8Pg62ohqdJuxVt+MdFqD+CEeVJ1/8l6
         XwD4Z0xMYyFAUHaOAXQ8NcNxZscN2oDxtCHaL/kH+KNN/EOWE5cQzMTL01ccpxz821yH
         GfqyIErP2yQewJB5YKMCl+0cnCsqYZnHjFqrNEm6mhQNDrH2IGXzW1Fzve1dJjlA/w/F
         InMw==
X-Gm-Message-State: AGi0Puavu04f8jWKtWk+N3ohGNiQ2PmhaVyBDy+nCjWyyB1wUb3oqn1l
        DG+8DpHQPHh+4VOoQYcTlfk=
X-Google-Smtp-Source: APiQypJTivveO3QdfW4n4Eg7AgkLY8zCK/ZzTUznwp2YMjpvJp8BoeOA1PeXPUKLQJqR9mLrycspKQ==
X-Received: by 2002:ac8:189c:: with SMTP id s28mr35452140qtj.65.1588182311757;
        Wed, 29 Apr 2020 10:45:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u7sm15862418qkj.51.2020.04.29.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:45:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7226409A3; Wed, 29 Apr 2020 14:45:08 -0300 (-03)
Date:   Wed, 29 Apr 2020 14:45:08 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf mem2node: avoid double free related to realloc
Message-ID: <20200429174508.GC30487@kernel.org>
References: <20200320182347.87675-1-irogers@google.com>
 <CAP-5=fVM4bDJ3bTjvEfBi5oQnaev=9yZN+NwS9Rp2HoLsR0Auw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVM4bDJ3bTjvEfBi5oQnaev=9yZN+NwS9Rp2HoLsR0Auw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 10:40:06AM -0700, Ian Rogers escreveu:
> Ping. This is missing an Acked-by:
> v2 addressed Jiri's review comments:
> https://lore.kernel.org/lkml/20200315093013.GC492969@krava/

Jiri?
 
> Thanks,
> Ian
> 
> 
> On Fri, Mar 20, 2020 at 11:23 AM Ian Rogers <irogers@google.com> wrote:
> >
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
> > v2: add a WARN_ON_ONCE when the free condition arises.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/mem2node.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > index 797d86a1ab09..c84f5841c7ab 100644
> > --- a/tools/perf/util/mem2node.c
> > +++ b/tools/perf/util/mem2node.c
> > @@ -1,5 +1,6 @@
> >  #include <errno.h>
> >  #include <inttypes.h>
> > +#include <asm/bug.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/kernel.h>
> >  #include <linux/zalloc.h>
> > @@ -95,7 +96,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
> >
> >         /* Cut unused entries, due to merging. */
> >         tmp_entries = realloc(entries, sizeof(*entries) * j);
> > -       if (tmp_entries)
> > +       if (tmp_entries || WARN_ON_ONCE(j == 0))
> >                 entries = tmp_entries;
> >
> >         for (i = 0; i < j; i++) {
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >

-- 

- Arnaldo
