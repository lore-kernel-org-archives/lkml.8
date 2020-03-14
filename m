Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B92C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1478920637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7nblpYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCOCOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:14:42 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:51342 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgCOCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:14:41 -0400
Received: by mail-oi1-f201.google.com with SMTP id 16so8333389oii.18
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OdlDyP22xWR3iukZ6BIAXqjFyoG87PPBI1OEHmhmYzg=;
        b=N7nblpYKFSWiHR4C7o2uBIQ0yrDCqVY7JzbxwILu5MSzDlQpa176KvICe4UFvqGjTp
         4zjA8Z4OD7fsI1cEHxVpAxllS6ZaQH7E1o4jaD+IqnnJw7M9PY0uhX4jYOheFA1HuWJ7
         lByKB7zbxlmsY06LfbHpK0PertOtJfngT6JPW+w3+a04kHdfKO9oHyaEEGZ3NSPT9gSg
         2Ir7OZG51xSn5q8DXQYirEr+MGNdX5GZ2wEC/vWm4aZs5Ur/qv2Gt5XPTk9EGBksPtvf
         mRjj212EJMKNa/ImfBSyZw7OHAjiU70EJ8fZB7dbFsTnnuhU1qfNuvXnc2I6Zcx8ANLE
         E4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OdlDyP22xWR3iukZ6BIAXqjFyoG87PPBI1OEHmhmYzg=;
        b=rVBYaRnSkQjl1K1v/EJELh4sxFKguUBSg722MamYsEmErp2fvU+VQFm41eFtwWhFO6
         7Irb95wTIfYOQOLEYopHFX8lgAxDk/wvN8Bfga8HBQhYDIgXC+7gDJkNNnrTAv3zcTYR
         eXR8rIjNy1AVwEIiOEEr85hnUzpkfPrF/e0F/AZ9MnAESxVyAwAqUwbv5U8uLFn1Zaht
         Ft1HwzA87a1QKiHHXS8Si6eiI5M9cPBhAh0dYeFLYTkPfHUo6QlUhbKe2nc+UrzRoLgg
         9ozPUfWTkb2BnZ9YV8YJhBKbDgCfF+FkkdGyn7hniNytzjDRdg1XWq5MiETt7Uyf1xlI
         bqpg==
X-Gm-Message-State: ANhLgQ2fK3vb071kAHB5dUHCF+OA6u5q4BIU7ZzOAED4N9H+/YZU/krm
        hOqn4p8NJSdmv1jCDHdeBgvVBxmVrGqv
X-Google-Smtp-Source: ADFU+vuvgvEpt/9FO1yYRPr4PH2UMVclGaCFAYMBofq2DdoRP87MR/9gc9z+N1Zb0WJnwZSK8HqIWz+D+y0j
X-Received: by 2002:a17:90a:e38a:: with SMTP id b10mr5576509pjz.159.1584160110864;
 Fri, 13 Mar 2020 21:28:30 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:28:26 -0700
Message-Id: <20200314042826.166953-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] perf mem2node: avoid double free related to realloc
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem2node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 797d86a1ab09..7f97aa69eb65 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -95,7 +95,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 
 	/* Cut unused entries, due to merging. */
 	tmp_entries = realloc(entries, sizeof(*entries) * j);
-	if (tmp_entries)
+	if (j == 0 || tmp_entries)
 		entries = tmp_entries;
 
 	for (i = 0; i < j; i++) {
-- 
2.25.1.481.gfbce0eb801-goog

