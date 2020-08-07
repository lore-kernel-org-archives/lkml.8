Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52125C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1D222CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSTCbOFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHGHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3DDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:16:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so659987plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KavQgWiDnpEcwfx7CyJKvpugGK8XihzNHzabDKjqOhU=;
        b=XSTCbOFKRdsH5jImrV6OWQjcJ0uDnB7G12jTKvKJSpgediBvJTfZ+93hZea/92OIkk
         iocuLcgwPizeNJmclFYFAVdhRLiKZiR/Khpfp6Oz++dUupl336xzJKqWapk3gfp1Fg2+
         GZE6UFvgsMMZBR5rmEz1QcUk5PLw3jGXEuVWyiW6CujA9HFYothFURFqYZXM+w/krFPE
         BzRwweOOhGHu4OxBP2JACxJpvw2GvQyFX262CQL9hyVcME9xTRgVkPO1qya47rkjTTmk
         APfUgwJBEAtUBYWsh881XIkb039QfmqJbpgfVaQ2vphi0i7bR5M8to800wbJ1xQap8Ah
         3fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KavQgWiDnpEcwfx7CyJKvpugGK8XihzNHzabDKjqOhU=;
        b=DYNulB0EKdc7i+V9kKhmRFkztuOFNUMjURhHtkmt4w/+TP4UwoWcG2OITaBhqWey9n
         ra6QS90Tgs+SrWG2KrBbaT9ga7CGEpDMyeATOLGMB14BuA8q+4UxpA6tUDOk2s6vJbem
         fg685gwn7HVBUcb8ZmG9b/rdBvaRvW96Nh1sq7JGWAQuxukg6aagxfrvcgsSGH3Iu/uO
         JN5OvJCeSCJ2+RoOi4ekx1CkVf27jdVpesOEJf9b8h52jj+9CrWJ2JcLtdyXcxo7f/FQ
         /H/h0pc0C+20CodYpuKo6GtVkwVvVTZOW5s34+j971erDjE+KxatR4AT09+e4h33QnJI
         2yKw==
X-Gm-Message-State: AOAM532SxNwYAG6gnZYOTArUgX3Uscb/A+Tx1i099mcdmIVPzzTQ6FnX
        qVCg+i3JJsbzDxOWTuwe81bXv11plU+3Og==
X-Google-Smtp-Source: ABdhPJxh6QslrNEUYR8sbmWChZd3Lr+kFBaUF/NqM7cuYit7wFmqXFGD27ufpuhD1ODlz+l80sJeEg==
X-Received: by 2002:a17:90a:110:: with SMTP id b16mr11966096pjb.235.1596784596707;
        Fri, 07 Aug 2020 00:16:36 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 22sm10758133pfh.157.2020.08.07.00.16.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 00:16:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf tools: Support Arm arch timer counter
Date:   Fri,  7 Aug 2020 15:16:17 +0800
Message-Id: <20200807071620.11907-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807071620.11907-1-leo.yan@linaro.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm arch timer can be used to calculate timestamp, the basic idea is
the arch timer's counter value can be recorded in the hardware tracing
data, e.g. the arch timer's counter value can be used for Arm CoreSight
(not now but might be implemented later) and Arm SPE.  So we need a way
to convert the arch timer's counter to the system time, the conversion
is dependent on some related parameters, e.g. 'time_shift', 'time_mult',
'time_offset', etc; furthermore, to handle the counter wrapping issue,
perf tool needs to know 'time_cycles' and 'time_mask' for correction.

This patch is to support Arm arch timer by reading out the relevant
parameters from the head of first mmaped page.  And these parameters
will be stored into the structure 'perf_arch_timer_conversion' for
later calculation timestamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build        |  1 +
 tools/perf/arch/arm64/util/arch_timer.c | 50 +++++++++++++++++++++++++
 tools/perf/util/arm_arch_timer.h        | 20 ++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
 create mode 100644 tools/perf/util/arm_arch_timer.h

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 5c13438c7bd4..77f4d7b30932 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,3 +1,4 @@
+perf-y += arch_timer.o
 perf-y += header.o
 perf-y += machine.o
 perf-y += perf_regs.o
diff --git a/tools/perf/arch/arm64/util/arch_timer.c b/tools/perf/arch/arm64/util/arch_timer.c
new file mode 100644
index 000000000000..dcc217c294fc
--- /dev/null
+++ b/tools/perf/arch/arm64/util/arch_timer.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <errno.h>
+
+#include <linux/stddef.h>
+#include <linux/perf_event.h>
+
+#include <linux/types.h>
+#include <asm/barrier.h>
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/synthetic-events.h"
+#include "../../../util/arm_arch_timer.h"
+
+int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
+				    struct perf_arch_timer_conversion *tc)
+{
+	bool cap_user_time_zero, cap_user_time_short;
+	u32 seq;
+	int i = 0;
+
+	while (1) {
+		seq = pc->lock;
+		/* Add barrier between the sequence lock and data accessing */
+		rmb();
+
+		tc->time_mult = pc->time_mult;
+		tc->time_shift = pc->time_shift;
+		tc->time_zero = pc->time_zero;
+		tc->time_cycles = pc->time_cycles;
+		tc->time_mask = pc->time_mask;
+		cap_user_time_zero = pc->cap_user_time_zero;
+		cap_user_time_short = pc->cap_user_time_short;
+
+		/* Add barrier between the data accessing and sequence lock */
+		rmb();
+		if (pc->lock == seq && !(seq & 1))
+			break;
+		if (++i > 10000) {
+			pr_debug("%s: failed to get perf_event_mmap_page lock\n",
+				 __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (!cap_user_time_zero || !cap_user_time_short)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
diff --git a/tools/perf/util/arm_arch_timer.h b/tools/perf/util/arm_arch_timer.h
new file mode 100644
index 000000000000..a3263cc4e5cf
--- /dev/null
+++ b/tools/perf/util/arm_arch_timer.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ARM_ARCH_TIMER_H
+#define __PERF_ARM_ARCH_TIMER_H
+
+#include <linux/types.h>
+
+struct perf_arch_timer_conversion {
+	u16 time_shift;
+	u32 time_mult;
+	u64 time_zero;
+	u64 time_cycles;
+	u64 time_mask;
+};
+
+struct perf_event_mmap_page;
+
+int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
+				    struct perf_arch_timer_conversion *tc);
+
+#endif // __PERF_ARM_ARCH_TIMER_H
-- 
2.17.1

