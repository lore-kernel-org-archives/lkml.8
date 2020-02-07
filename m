Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A966C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD05522314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:22:51 -0500
Received: from foss.arm.com ([217.140.110.172]:41090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:22:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FFC91045;
        Fri,  7 Feb 2020 07:22:50 -0800 (PST)
Received: from e121896.default (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4204C3F6CF;
        Fri,  7 Feb 2020 07:22:47 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     jolsa@redhat.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 1/4] perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
Date:   Fri,  7 Feb 2020 15:21:39 +0000
Message-Id: <20200207152142.28662-2-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207152142.28662-1-james.clark@arm.com>
References: <20200127123108.GC1114818@krava>
 <20200207152142.28662-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

Create a new arm-spe-decoder directory for subsequent extensions and
move arm-spe-pkt-decoder.h/c to this directory. No code changes.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/Build                                       | 2 +-
 tools/perf/util/arm-spe-decoder/Build                       | 1 +
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c | 0
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h | 0
 tools/perf/util/arm-spe.c                                   | 2 +-
 5 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 07da6c790b63..0184510083c2 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,7 @@ perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-$(CONFIG_AUXTRACE) += arm-spe.o
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
new file mode 100644
index 000000000000..16efbc245028
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -0,0 +1 @@
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.c
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.h
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 53be12b23ff4..f3382a38d48e 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -23,7 +23,7 @@
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
-#include "arm-spe-pkt-decoder.h"
+#include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
 struct arm_spe {
 	struct auxtrace			auxtrace;
-- 
2.17.1

