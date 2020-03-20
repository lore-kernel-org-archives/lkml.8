Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C99C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186320784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CU06efIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:23:57 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48027 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:23:57 -0400
Received: by mail-pf1-f202.google.com with SMTP id h191so5133016pfe.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RMPXYe/vR5ct6qGO4irRpO9ggqjWQLrULMnyekYeYdA=;
        b=CU06efIQZInxH335XVehXng0U+lS//aZfnaXxvf0I2ImUfFSVaakHLgoP/P2TI4ezk
         X1bS7ff5J9PuTwD3G3siGmY6So6qmAl7PFskKQTCgPd25wnt769kl8x9l2Apf9BkotnG
         ShNZxWCskCFjJSirTG4wL/8STJVJPY5LoGahYYkbHz8+vyQrLWtwdGPIgXya4IhGGE8e
         KCHoyClSc1YOlYFWSOcepT1K/TGGchJFQwAvJrRMehnN4ShkdlSMdsAshg00Ra8p6yWd
         HWuZS1MnWkF+hmTHh23tcAkJ3fJZLMChDyG1EN1S3cXQLf4P9+j7vNXx4c8oDKRjD07u
         ucWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RMPXYe/vR5ct6qGO4irRpO9ggqjWQLrULMnyekYeYdA=;
        b=IHM5+2Yy7tZd+jKrwe6kgMbmfAyURCovf5Bzv8fJVN0k6XFlf/auhcPgrUfNXcY3On
         wDH3cQnzKrLnDqwlfG72cTtGLU00tqQXco1JLA73NePPpjdMPI1TP4MTEMn8Pn8Ovb0N
         0knFuIjtaZr6UkPpUXlxuZdi1djmrypRwN6hVg7wL1Y28oSlKOtweV3h+CNqXYTI5mQq
         jPNtWUIZcOY8eT51nQYLbggkqmT94xOgrMMP00w6m0dv8vb2n40/CeMPXB4g3dTCZcQm
         JlHCus2m8GOssHbm+a4bO1GKPf4n1gMTIenDiF7lYIrYgZ3yl4MY5nM7Y3zZNTBqH45Y
         ecpg==
X-Gm-Message-State: ANhLgQ1jh88TJcOtNl3LErC7QWoZ/tNkgHpnNgg1IWYGd7WW8zVpN8bm
        5Q/JjH3s7HTo6Mbn8vgYjMgiWSQIh+EO
X-Google-Smtp-Source: ADFU+vu7Ekr81cC6q+QtWqmhrDj4TMQcXjgygXB8DtY5pc1UlFHaNo/fQ80zM0Suh8w7hOCADMV5UkHFh4f1
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr10818804pjo.1.1584728633692;
 Fri, 20 Mar 2020 11:23:53 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:23:47 -0700
Message-Id: <20200320182347.87675-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] perf mem2node: avoid double free related to realloc
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realloc of size zero is a free not an error, avoid this causing a double
free. Caught by clang's address sanitizer:

==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
    #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
    #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
    #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
    #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
    #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #8 0x564965942e41 in main tools/perf/perf.c:538:3

0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
freed by thread T0 here:
    #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
    #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
    #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #7 0x564965942e41 in main tools/perf/perf.c:538:3

previously allocated by thread T0 here:
    #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
    #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
    #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
    #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #8 0x564965942e41 in main tools/perf/perf.c:538:3

v2: add a WARN_ON_ONCE when the free condition arises.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem2node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 797d86a1ab09..c84f5841c7ab 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -1,5 +1,6 @@
 #include <errno.h>
 #include <inttypes.h>
+#include <asm/bug.h>
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -95,7 +96,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 
 	/* Cut unused entries, due to merging. */
 	tmp_entries = realloc(entries, sizeof(*entries) * j);
-	if (tmp_entries)
+	if (tmp_entries || WARN_ON_ONCE(j == 0))
 		entries = tmp_entries;
 
 	for (i = 0; i < j; i++) {
-- 
2.25.1.696.g5e7596f4ac-goog

