Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C99C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A54321974
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnXAYetq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD3IQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:16:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60089 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgD3IQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588234561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWFBCycrzpYryQQUalteW2/Qk7N32f3MKAGykOY2kJY=;
        b=QnXAYetqBeO4/Zsgqk6qcQNidNTmQY5WZZ0Api1io4QSLHJZbrNmja0Uun95B9nIn+ENr9
        h4juGz43deMKWS0Fyvk5KqfhP+z7xXayogUzHGURoUNGCxttJ2wyofX0/1SLvmVdeniDtX
        J2VUvqfuOjGElCRh5vxtSspwUmht0c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-x9Pn4iPLMIutuPhv_WeicQ-1; Thu, 30 Apr 2020 04:15:55 -0400
X-MC-Unique: x9Pn4iPLMIutuPhv_WeicQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE791872FE0;
        Thu, 30 Apr 2020 08:15:53 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACA3E5D9F1;
        Thu, 30 Apr 2020 08:15:47 +0000 (UTC)
Date:   Thu, 30 Apr 2020 10:15:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf mem2node: avoid double free related to realloc
Message-ID: <20200430081541.GA1681583@krava>
References: <20200320182347.87675-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320182347.87675-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:23:47AM -0700, Ian Rogers wrote:
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

I overlooked v2 for this, sry

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

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
>  	/* Cut unused entries, due to merging. */
>  	tmp_entries = realloc(entries, sizeof(*entries) * j);
> -	if (tmp_entries)
> +	if (tmp_entries || WARN_ON_ONCE(j == 0))
>  		entries = tmp_entries;
>  
>  	for (i = 0; i < j; i++) {
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

