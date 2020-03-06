Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C438EC3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882520848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scYZHDG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFHLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:11:23 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37974 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgCFHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:22 -0500
Received: by mail-pg1-f202.google.com with SMTP id x16so746196pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MCT7DNwgR6qw1U4p3b8YgGbTZNJBi3ETmrD4uQtrVI0=;
        b=scYZHDG4Mzz86t1zkSU9mtxDOpAuavzOLSSZ0IGVuhMrVqqYiCY6rCOMCNd+RafhvO
         8wYIylNfmCrU7T9g5IPecK1naiTphHfEauKCjgXK7tzjOD6fJUImQ9zbciHt+X0cxKc/
         TUkQUGdfyTmk4rFokm0npYb9bUveHDjkCyUI48N28CWeHO9bh6ELQuVdaOJEFjxFDhvg
         lAWZMLIY2DAdAtxXiUPLZKSszjtHaX5Lhc2uZ0fyEa3swB3jbV4Vt+8W2/bFhmfYCfjn
         K8nQozZupAVveeaZScX09YswSSAAvffABHLGBim22z/ESgF/3SGO5vPgKa7Bku3SLhfr
         2V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MCT7DNwgR6qw1U4p3b8YgGbTZNJBi3ETmrD4uQtrVI0=;
        b=gsitC4cqM1rJPSGNGLei1sss1oYHIWt3rfAc34+Y3fqCzMB2snn66NFfYBqP14AVrP
         Rt6+zCS4xcZkCeB3NASFhFdlrHduXBlvz/KayzX6ya7Kxozs7LH9aeLOSjo5p1wAvKIF
         xkZs59GDjW9JNELFngM8AWFZT+CvDoYkwNWxOCk5vZV3hcFjvJbeEPRmgJprK5gtePFn
         1qaygnPyW3oJ97fmymwCo7uHcK1W+VzGam7KJErPs00xuHOl5ifvrGO6mKB9XN7nNN05
         Dnin8AEK73DFZK+N/4hTbGPbc7Q4j+ORNYUmsXkjY29bFEsUjBWxamGwhf9Maa/qUAvX
         idRw==
X-Gm-Message-State: ANhLgQ0z8x9BZ62kbbeceVuboEHxcv42RqKP1fBQ8MLgdifsniHNw+N6
        pl7CG5QDrJWvlpVxBW5Uw2Iehmo0JYWy
X-Google-Smtp-Source: ADFU+vtQPFtlcRHnfJ1SIlJcPbV+QgbdFYQFdTmyLJhiWeMaHENxPnmx9NvCslbAI3PmzRY9IlF0YRojGJvJ
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr2112421pjt.102.1583478680435;
 Thu, 05 Mar 2020 23:11:20 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:11:08 -0800
In-Reply-To: <20200306071110.130202-1-irogers@google.com>
Message-Id: <20200306071110.130202-2-irogers@google.com>
Mime-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 1/3] tools: fix off-by 1 relative directory includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently working due to extra include paths in the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/asm/errno.h           | 14 +++++------
 tools/perf/arch/arm64/util/arm-spe.c     | 20 ++++++++--------
 tools/perf/arch/arm64/util/perf_regs.c   |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c |  4 ++--
 tools/perf/arch/x86/util/auxtrace.c      | 14 +++++------
 tools/perf/arch/x86/util/event.c         | 12 +++++-----
 tools/perf/arch/x86/util/header.c        |  4 ++--
 tools/perf/arch/x86/util/intel-bts.c     | 24 +++++++++----------
 tools/perf/arch/x86/util/intel-pt.c      | 30 ++++++++++++------------
 tools/perf/arch/x86/util/machine.c       |  6 ++---
 tools/perf/arch/x86/util/perf_regs.c     |  8 +++----
 tools/perf/arch/x86/util/pmu.c           |  6 ++---
 12 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
index ce3c5945a1c4..637189ec1ab9 100644
--- a/tools/include/uapi/asm/errno.h
+++ b/tools/include/uapi/asm/errno.h
@@ -1,18 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/uapi/asm/errno.h"
+#include "../../../arch/x86/include/uapi/asm/errno.h"
 #elif defined(__powerpc__)
-#include "../../arch/powerpc/include/uapi/asm/errno.h"
+#include "../../../arch/powerpc/include/uapi/asm/errno.h"
 #elif defined(__sparc__)
-#include "../../arch/sparc/include/uapi/asm/errno.h"
+#include "../../../arch/sparc/include/uapi/asm/errno.h"
 #elif defined(__alpha__)
-#include "../../arch/alpha/include/uapi/asm/errno.h"
+#include "../../../arch/alpha/include/uapi/asm/errno.h"
 #elif defined(__mips__)
-#include "../../arch/mips/include/uapi/asm/errno.h"
+#include "../../../arch/mips/include/uapi/asm/errno.h"
 #elif defined(__ia64__)
-#include "../../arch/ia64/include/uapi/asm/errno.h"
+#include "../../../arch/ia64/include/uapi/asm/errno.h"
 #elif defined(__xtensa__)
-#include "../../arch/xtensa/include/uapi/asm/errno.h"
+#include "../../../arch/xtensa/include/uapi/asm/errno.h"
 #else
 #include <asm-generic/errno.h>
 #endif
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 8d6821d9c3f6..27653be24447 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -11,17 +11,17 @@
 #include <linux/zalloc.h>
 #include <time.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/session.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/session.h"
 #include <internal/lib.h> // page_size
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/arm-spe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/arm-spe.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 2864e2e3776d..2833e101a7c6 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/perf_regs.h"
+#include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e9c436eeffc9..0a5242900248 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,8 +4,8 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
 
 #include <linux/kernel.h>
 
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 7abc9fd4cbec..3da506e13f49 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -7,13 +7,13 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include "../../util/header.h"
-#include "../../util/debug.h"
-#include "../../util/pmu.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/evlist.h"
+#include "../../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/pmu.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/evlist.h"
 
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index ac45015cc6ba..047dc00eafa6 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -3,12 +3,12 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-#include "../../util/event.h"
-#include "../../util/synthetic-events.h"
-#include "../../util/machine.h"
-#include "../../util/tool.h"
-#include "../../util/map.h"
-#include "../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/synthetic-events.h"
+#include "../../../util/machine.h"
+#include "../../../util/tool.h"
+#include "../../../util/map.h"
+#include "../../../util/debug.h"
 
 #if defined(__x86_64__)
 
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index aa6deb463bf3..578c8c568ffd 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -7,8 +7,8 @@
 #include <string.h>
 #include <regex.h>
 
-#include "../../util/debug.h"
-#include "../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/header.h"
 
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 26cee1052179..09f93800bffd 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -11,18 +11,18 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/mmap.h"
-#include "../../util/session.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/record.h"
-#include "../../util/tsc.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-bts.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/record.h"
+#include "../../../util/tsc.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-bts.h"
 #include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 7eea4fd7ce58..1643aed8c4c8 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -13,23 +13,23 @@
 #include <linux/zalloc.h>
 #include <cpuid.h>
 
-#include "../../util/session.h"
-#include "../../util/event.h"
-#include "../../util/evlist.h"
-#include "../../util/evsel.h"
-#include "../../util/evsel_config.h"
-#include "../../util/cpumap.h"
-#include "../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evsel_config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/mmap.h"
 #include <subcmd/parse-options.h>
-#include "../../util/parse-events.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/target.h"
-#include "../../util/tsc.h"
+#include "../../../util/parse-events.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/target.h"
+#include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
-#include "../../util/intel-pt.h"
+#include "../../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index e17e080e76f4..31679c35d493 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -5,9 +5,9 @@
 #include <stdlib.h>
 
 #include <internal/lib.h> // page_size
-#include "../../util/machine.h"
-#include "../../util/map.h"
-#include "../../util/symbol.h"
+#include "../../../util/machine.h"
+#include "../../../util/map.h"
+#include "../../../util/symbol.h"
 #include <linux/ctype.h>
 
 #include <symbol/kallsyms.h>
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index c218b83e063b..fca81b39b09f 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -5,10 +5,10 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../../perf-sys.h"
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
-#include "../../util/event.h"
+#include "../../../perf-sys.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e33ef5bc31c5..d48d608517fd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -4,9 +4,9 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/pmu.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/pmu.h"
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
-- 
2.25.1.481.gfbce0eb801-goog

