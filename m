Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC390C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC24620773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyuCjdHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgIBNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIBNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA3C061247
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so4388212wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j/6HwVpyTsA7z9Vl2wmHYe3cw1hSDvl7Zz8h5YgOZds=;
        b=LyuCjdHibhK+0g4JwLQQC6maDrtpPyPg/SI0nRi5aHeSeNN15mJJ/yZahBcCK5nisE
         L1H9bET8yY/9jpbnUld3VVtC7cMedGjqSIrT0XoSJc72w1+iUZv9LJARI3dAS19DYBxG
         Feo4JMfzzk9irfIIud1MSy/KIC0KkttNforlY2Ue4ODv4iuKsMEn1RxtLDLJgZvheVtp
         cYPM+YuRiR9dWKqeVfEjlTMkL5kaw9Dt5Ik0f9mFtGoewTIcvUEh2zA0M757pK0h1c09
         nT4eLgK7sxE3hXq/WzWek522Vv5AHuiKqx0VoJmloD96h61lIljGHj96iIFhgPqUBCrC
         FB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/6HwVpyTsA7z9Vl2wmHYe3cw1hSDvl7Zz8h5YgOZds=;
        b=Pw6gGSA5IFlPHzLj5SAAn5c8llhuZd4x1OzbwTeYoDwgnJ6Nt1SD8qwUpRYf5vyM0b
         3O2OexaVsn5YgJacIcSHyvgCT7cEPq7I29CTp+TL3HxSs4PIYMdmLWdSvxJtBAdHe2CZ
         NvqnEm5Qh+0wnjOmWrGrnrD4NIusV5EKETL7SlFKDvPwbP1Ig9yDMCL0yM+CNUU2lPyb
         4stQiF+Y8eWoxuFqFEabXPbqWuVtDJUgRnCJZoc9NMTZadqTkX0f+0JUuSvfZ48VH1qS
         HxUTjOEuDbo8QRGyj/BmYm7TzrU7FnrSFjTDc6V9+OAnwqgj0HXWEy2hjCoAAI0wiOK3
         jUrQ==
X-Gm-Message-State: AOAM531DMtZQnG+N5gyf367c7krVNVHOWPEkVQFCOBybnu454J4e/2TB
        l9w+A7T6fs8IpzwQr/KuKpjTnA==
X-Google-Smtp-Source: ABdhPJxv1j236lvJcF+3Katowk9V9FtO/exIB7YHfzvekKndmDJpWZfyEeKGENDvsbOfw8GiAgUViA==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr724107wmb.54.1599052907420;
        Wed, 02 Sep 2020 06:21:47 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:46 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/6] perf tsc: Move out common functions from x86
Date:   Wed,  2 Sep 2020 14:21:26 +0100
Message-Id: <20200902132131.36304-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions perf_read_tsc_conversion() and perf_event__synth_time_conv()
should work as common functions rather than x86 specific, so move these
two functions out from arch/x86 folder and place them into util/tsc.c.

Since the function perf_event__synth_time_conv() will be linked in
util/tsc.c, remove its weak version.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/x86/util/tsc.c     | 73 +-----------------------------
 tools/perf/util/synthetic-events.c |  8 ----
 tools/perf/util/tsc.c              | 71 +++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 2f55afb14e1f..559365f8fe52 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -1,45 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdbool.h>
-#include <errno.h>
-
-#include <linux/stddef.h>
-#include <linux/perf_event.h>
-
 #include <linux/types.h>
-#include <asm/barrier.h>
-#include "../../../util/debug.h"
-#include "../../../util/event.h"
-#include "../../../util/synthetic-events.h"
-#include "../../../util/tsc.h"
-
-int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
-			     struct perf_tsc_conversion *tc)
-{
-	bool cap_user_time_zero;
-	u32 seq;
-	int i = 0;
-
-	while (1) {
-		seq = pc->lock;
-		rmb();
-		tc->time_mult = pc->time_mult;
-		tc->time_shift = pc->time_shift;
-		tc->time_zero = pc->time_zero;
-		cap_user_time_zero = pc->cap_user_time_zero;
-		rmb();
-		if (pc->lock == seq && !(seq & 1))
-			break;
-		if (++i > 10000) {
-			pr_debug("failed to get perf_event_mmap_page lock\n");
-			return -EINVAL;
-		}
-	}
 
-	if (!cap_user_time_zero)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
+#include "../../../util/tsc.h"
 
 u64 rdtsc(void)
 {
@@ -49,36 +11,3 @@ u64 rdtsc(void)
 
 	return low | ((u64)high) << 32;
 }
-
-int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
-				struct perf_tool *tool,
-				perf_event__handler_t process,
-				struct machine *machine)
-{
-	union perf_event event = {
-		.time_conv = {
-			.header = {
-				.type = PERF_RECORD_TIME_CONV,
-				.size = sizeof(struct perf_record_time_conv),
-			},
-		},
-	};
-	struct perf_tsc_conversion tc;
-	int err;
-
-	if (!pc)
-		return 0;
-	err = perf_read_tsc_conversion(pc, &tc);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	pr_debug2("Synthesizing TSC conversion information\n");
-
-	event.time_conv.time_mult  = tc.time_mult;
-	event.time_conv.time_shift = tc.time_shift;
-	event.time_conv.time_zero  = tc.time_zero;
-
-	return process(tool, &event, NULL, machine);
-}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 89b390623b63..3ca5d9399680 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2006,14 +2006,6 @@ int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct p
 	return 0;
 }
 
-int __weak perf_event__synth_time_conv(const struct perf_event_mmap_page *pc __maybe_unused,
-				       struct perf_tool *tool __maybe_unused,
-				       perf_event__handler_t process __maybe_unused,
-				       struct machine *machine __maybe_unused)
-{
-	return 0;
-}
-
 extern const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
 
 int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session *session,
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index bfa782421cbd..9e3f04ddddf8 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -1,7 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+
 #include <linux/compiler.h>
+#include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
+#include <asm/barrier.h>
+
+#include "event.h"
+#include "synthetic-events.h"
+#include "debug.h"
 #include "tsc.h"
 
 u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc)
@@ -25,6 +34,68 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 	       ((rem * tc->time_mult) >> tc->time_shift);
 }
 
+int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
+			     struct perf_tsc_conversion *tc)
+{
+	bool cap_user_time_zero;
+	u32 seq;
+	int i = 0;
+
+	while (1) {
+		seq = pc->lock;
+		rmb();
+		tc->time_mult = pc->time_mult;
+		tc->time_shift = pc->time_shift;
+		tc->time_zero = pc->time_zero;
+		cap_user_time_zero = pc->cap_user_time_zero;
+		rmb();
+		if (pc->lock == seq && !(seq & 1))
+			break;
+		if (++i > 10000) {
+			pr_debug("failed to get perf_event_mmap_page lock\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!cap_user_time_zero)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
+				struct perf_tool *tool,
+				perf_event__handler_t process,
+				struct machine *machine)
+{
+	union perf_event event = {
+		.time_conv = {
+			.header = {
+				.type = PERF_RECORD_TIME_CONV,
+				.size = sizeof(struct perf_record_time_conv),
+			},
+		},
+	};
+	struct perf_tsc_conversion tc;
+	int err;
+
+	if (!pc)
+		return 0;
+	err = perf_read_tsc_conversion(pc, &tc);
+	if (err == -EOPNOTSUPP)
+		return 0;
+	if (err)
+		return err;
+
+	pr_debug2("Synthesizing TSC conversion information\n");
+
+	event.time_conv.time_mult  = tc.time_mult;
+	event.time_conv.time_shift = tc.time_shift;
+	event.time_conv.time_zero  = tc.time_zero;
+
+	return process(tool, &event, NULL, machine);
+}
+
 u64 __weak rdtsc(void)
 {
 	return 0;
-- 
2.17.1

