Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD51C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77D620663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMJQ2U7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGOCe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:34:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so1350734pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KavQgWiDnpEcwfx7CyJKvpugGK8XihzNHzabDKjqOhU=;
        b=iMJQ2U7dEi1geqHvfpNGXrY4QnmvwVq219ObiLYGs6v0UXO+THe0zQB1ofJs5LvMIi
         f/G0gSSDCJRhlVmPgfsb7fKXk+wVdXD7V7QMte5wmVXwMxqF8wVCcjT/hcOjYBXqyKp4
         yQA6sCEWzHCl+ubCKekCBtsyoEUnrIbK4tDxtOPucZuXID7kdN7ZLzJpg6vcMF/H3Wlb
         qO4bd5ljR6HbZB3VBWJWuD754GniGI6T1gjV602zVKlTVR4JvyuzWxYA60PjiDM88Y5K
         7t+A8tEWgWsBBkfdHibjgjt0hZ9ZHyPYN2+31fZU1mm8hfDfZr6VmRbRM6aaoROCHs11
         NIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KavQgWiDnpEcwfx7CyJKvpugGK8XihzNHzabDKjqOhU=;
        b=TR7FBHScpbc56o3MCoEwhcOnz60vh9kFfWX/m3E4HdlnV6IWXwiZv37G/uH1S0sKHV
         sXbhPNajpBcGzoj97PBHjzSFOaKxFm6BPv+3yrljR6WSwCw5hvOnIQxPwxQOfLmoWaYa
         uV3svSRfa6R2PYVrinpvCc1WgkMznqkXHQpJ6k97EX/aluIBGvTJ0x41dGEYl/nejJsP
         RhApuqWq7T8EQyeSelxLegGfkVyEwIfU9Uox/xt66VLN8sUTiA0RE7H/OXqlW4yeF8zO
         gzvsqLIT+NL6UasozRSl7i7py00NfqM4WqArvujWR4JyCK3KIAPYbnB49JWhgT68fehq
         zJHQ==
X-Gm-Message-State: AOAM531RzzBBzJgUxsrJNvQY/zo8h1QjYddQskEeHtK72fAeuEo0RhXW
        n8agzECRGTyPHGmUU08WQBP1Sg==
X-Google-Smtp-Source: ABdhPJyuX/PPdFg3FA7cBhpyblKzpviZgMYSKyBVd0JJJ4AkfessZxjEaDNYahjf//kGOMrTC7sieQ==
X-Received: by 2002:a65:4502:: with SMTP id n2mr5935332pgq.132.1594780468613;
        Tue, 14 Jul 2020 19:34:28 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id f131sm382645pgc.14.2020.07.14.19.34.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:34:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] perf tools: Support Arm arch timer counter
Date:   Wed, 15 Jul 2020 10:33:59 +0800
Message-Id: <20200715023401.23988-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715023401.23988-1-leo.yan@linaro.org>
References: <20200715023401.23988-1-leo.yan@linaro.org>
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

