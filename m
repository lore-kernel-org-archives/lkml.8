Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D62C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD836208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgEHNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729952AbgEHNFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9916C05BD43;
        Fri,  8 May 2020 06:05:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gR-0007Im-Fy; Fri, 08 May 2020 15:04:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A9801C04D0;
        Fri,  8 May 2020 15:04:50 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:49 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf mem2node: Avoid double free related to realloc
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320182347.87675-1-irogers@google.com>
References: <20200320182347.87675-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158894308995.8414.15377663667170562789.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     266150c94c69429cf6d18e130237224a047f5061
Gitweb:        https://git.kernel.org/tip/266150c94c69429cf6d18e130237224a047f5061
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Fri, 20 Mar 2020 11:23:47 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf mem2node: Avoid double free related to realloc

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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200320182347.87675-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mem2node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 797d86a..c84f584 100644
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
