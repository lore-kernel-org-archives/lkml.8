Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C955C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C2920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Of8tEyWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgE2WxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgE2WxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:53:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD53C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:52:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y64so3113060qkc.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yoJxkIZuytfBIhWSsDjy/P3tKkkJb3VYIbwuTayFWQQ=;
        b=Of8tEyWtyNhQpcs3rTWO17z8l5n1PWZ4yMfB4ASgiNHdL6/TmMQCV+onOjXiY5Xo8p
         URuy8JRLmJVpsGZ9tatL342tXpXXWi0t7DRBxI8bLVW5h6Pxdd5YgggtXdxzQY0o95EA
         qhOuAZ8vqyG4KVazjmhYihFbNocHQmQ9nazone4h2uRoqp/+82cTVGMwDuumGXUesmKL
         d37BFn5wexchBDvnPUkv2cOYqVU1bwDLlqo0Dpku+3wzVb+0zmbvRh3KX/mTmqbV+hWt
         CaOBCednHaiEt1SVnPnfatOU9CpZFoj9oi/PlhA5ux+k+QIPhn9psFZ+va4agsgCZZCS
         etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yoJxkIZuytfBIhWSsDjy/P3tKkkJb3VYIbwuTayFWQQ=;
        b=TXvQjaOuxp5XaPuLumbUzVzqG/jwxTUlhH5XE1h7ncVqZCW0LfVfvHZdRZT/gFa+o9
         GMEhmu9jz4lqyFWYDjTHQE92Vzm2j6kJszzMLPifT+vg4+VnRIIcEv1EysB0Cz35Ahxa
         FeM2UgAQbhoqbI27Upg7ukPkxMEiXk16erbuvkKpW+hYjl7V8GBXW6E58L4ryOoapp9/
         K32TO9SreyZ8cGqnjzSLFIaZC0HUi2Dqvcsvvrefmnb8fnyxD1mchwBhQMy50WIMLbCr
         wSRZGHPQGjXK0W7hpmKBCdwXkqM6R7OIrBijyDnEeZdpdLXnXireYzR1WCpLLsTmHIiD
         O3sg==
X-Gm-Message-State: AOAM5318m9DVpLwY4io7z7cxXJhfqA0pjxWVwN+SfXUZocZG24CfKiy2
        PwKNgpP0VPnq2cZDulD4VdmYtR3KgS/Q
X-Google-Smtp-Source: ABdhPJwyCPlHIC0eJZ/KDG144kO3D3QGAeNy73l/f7BF4NHjsUy8B5COTUYtqUxbonsOCX1DZ2gkMesWVlDq
X-Received: by 2002:a0c:b797:: with SMTP id l23mr10982109qve.160.1590792777886;
 Fri, 29 May 2020 15:52:57 -0700 (PDT)
Date:   Fri, 29 May 2020 15:52:32 -0700
Message-Id: <20200529225232.207532-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] perf libdw: Fix off-by 1 relative directory includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently working due to extra include paths in the build.

Before:
$ cd tools/perf/arch/arm64/util
$ ls -la ../../util/unwind-libdw.h
ls: cannot access '../../util/unwind-libdw.h': No such file or directory

After:
$ ls -la ../../../util/unwind-libdw.h
-rw-r----- 1 irogers irogers 553 Apr 17 14:31 ../../../util/unwind-libdw.h
---
 tools/perf/arch/arm64/util/unwind-libdw.c   | 6 +++---
 tools/perf/arch/powerpc/util/unwind-libdw.c | 6 +++---
 tools/perf/arch/x86/util/unwind-libdw.c     | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
index 7623d85e77f3..a50941629649 100644
--- a/tools/perf/arch/arm64/util/unwind-libdw.c
+++ b/tools/perf/arch/arm64/util/unwind-libdw.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
-#include "../../util/unwind-libdw.h"
-#include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../../util/unwind-libdw.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/event.h"
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
index abf2dbc7f829..7b2d96ec28e3 100644
--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
 #include <linux/kernel.h>
-#include "../../util/unwind-libdw.h"
-#include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../../util/unwind-libdw.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/event.h"
 
 /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
 static const int special_regs[3][2] = {
diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/arch/x86/util/unwind-libdw.c
index fda8f4206ee4..eea2bf87232b 100644
--- a/tools/perf/arch/x86/util/unwind-libdw.c
+++ b/tools/perf/arch/x86/util/unwind-libdw.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
-#include "../../util/unwind-libdw.h"
-#include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../../util/unwind-libdw.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/event.h"
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
-- 
2.27.0.rc2.251.g90737beb825-goog

