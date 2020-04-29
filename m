Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52859C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C620757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWlYr3vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgD2RkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2RkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:40:20 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B828C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:40:19 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p7so1683734ybo.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybBditkV+/AGKhPyVVVgpY9CdlSiEk3WAof8CKaEm10=;
        b=dWlYr3vtUgKv6jBm/HIuLSNdLoGremE3/WGCDAHx1G5kddDrtBwS87GECWppJgIdVR
         l+UXGKRFDrzFu4pLdO8TbSbIvcD0ICaz7VMWJPvjuqV1OovJ+seCakxV2ZZ255VhwIoX
         QJ2yaG7Qw2+q6Ki/Fn/5Ng0teXONSX4ESXtrYVejET2siqnn4R/VJ2+MtA2rF/JvYs9E
         ykvc48AzGmFx7uDicaWyJEWR3BZoMY31N8m+qpzDZaLorVDRaVcPUVx6IyauAcQi4N4A
         itlfS3lRm/tqS8dyZe9XFbnJViUMvayi2iBLA8ZB694B6O/O9cstgmrk+CoAaoS/5fxC
         eeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybBditkV+/AGKhPyVVVgpY9CdlSiEk3WAof8CKaEm10=;
        b=oq4BV5cX64MU86/E3CX337kKuWBFDMXyAnvNndSdJeZWhq/q1TFzc1UCF0AjjIqMMg
         YG25LlFKmnXxcljhOTuJNgXBfMRjMDqFSj76pGUPgy4u1J+j84XWfdyHDcoLJnk3lqyp
         Wb/KYxVE49FK4mckADTpJyt2ooW3Vxh0d2jqObyE1CrlAzxg5iXJHMQaTcJTTs69Frzw
         uBIMDwZf+2mvXtMMJvAXNmr1rpvkDOctlHYfIyVFa+tkOGlgwrb8yKvaUVbc898kRuj/
         uVqrqwb0mn1sZu8JQVToWgXcYbjrBE3F7J4KZPJLddK7RN80VVBcpk738K5MQVuOZJ9J
         92bQ==
X-Gm-Message-State: AGi0PuYp+rdw37Pr+0tMvllT7OAqoD+LJeSOSc2eO29SULI+6y8NEcH4
        4or5TM4fW11O6HHgaigd4PcBVyCiej/VPQMT++cbow==
X-Google-Smtp-Source: APiQypKASn4PElNIyJDFDtW/vwaukbvSHYzKjw3SEO5GzYl9TBhuG0RRhCk3VtrEa98V+6GxmgK4STV1CP7055/XssE=
X-Received: by 2002:a25:3d86:: with SMTP id k128mr57128007yba.403.1588182018093;
 Wed, 29 Apr 2020 10:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200320182347.87675-1-irogers@google.com>
In-Reply-To: <20200320182347.87675-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Apr 2020 10:40:06 -0700
Message-ID: <CAP-5=fVM4bDJ3bTjvEfBi5oQnaev=9yZN+NwS9Rp2HoLsR0Auw@mail.gmail.com>
Subject: Re: [PATCH v2] perf mem2node: avoid double free related to realloc
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. This is missing an Acked-by:
v2 addressed Jiri's review comments:
https://lore.kernel.org/lkml/20200315093013.GC492969@krava/

Thanks,
Ian


On Fri, Mar 20, 2020 at 11:23 AM Ian Rogers <irogers@google.com> wrote:
>
> Realloc of size zero is a free not an error, avoid this causing a double
> free. Caught by clang's address sanitizer:
>
> ==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
>     #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
>     #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
>     #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
>     #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
>     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
>     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
>     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
>     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
>     #8 0x564965942e41 in main tools/perf/perf.c:538:3
>
> 0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
> freed by thread T0 here:
>     #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
>     #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
>     #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
>     #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
>     #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
>     #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
>     #7 0x564965942e41 in main tools/perf/perf.c:538:3
>
> previously allocated by thread T0 here:
>     #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
>     #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
>     #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
>     #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
>     #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
>     #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
>     #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
>     #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
>     #8 0x564965942e41 in main tools/perf/perf.c:538:3
>
> v2: add a WARN_ON_ONCE when the free condition arises.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/mem2node.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> index 797d86a1ab09..c84f5841c7ab 100644
> --- a/tools/perf/util/mem2node.c
> +++ b/tools/perf/util/mem2node.c
> @@ -1,5 +1,6 @@
>  #include <errno.h>
>  #include <inttypes.h>
> +#include <asm/bug.h>
>  #include <linux/bitmap.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
> @@ -95,7 +96,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
>
>         /* Cut unused entries, due to merging. */
>         tmp_entries = realloc(entries, sizeof(*entries) * j);
> -       if (tmp_entries)
> +       if (tmp_entries || WARN_ON_ONCE(j == 0))
>                 entries = tmp_entries;
>
>         for (i = 0; i < j; i++) {
> --
> 2.25.1.696.g5e7596f4ac-goog
>
