Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8250C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8066208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgIJVfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:35:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:36678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgIJNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:49:45 -0400
IronPort-SDR: frqBtvOmunPIHcp1EguglE5KgQk7rF5LOew8jdvSBZ3P1dZUthBRVrHzIfI6KtOGrfIyir9Nj4
 LzpvlF9dE/fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="138048791"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="138048791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 06:48:40 -0700
IronPort-SDR: 5me4/pk7ERgAtI+5xYHyCxd56QWCM/wVxFhBWOaD/G94rA2ePtZRaZ6/LSqW5yi144PMxfYG1/
 /2XeBU2IYuew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="300557767"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2020 06:48:40 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf tools: Rename group to topdown
Date:   Thu, 10 Sep 2020 06:44:58 -0700
Message-Id: <20200910134501.11352-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910134501.11352-1-kan.liang@linux.intel.com>
References: <20200910134501.11352-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The group.h/c only include TopDown group related functions. The name
"group" is too generic and inaccurate. Use the name "topdown" to
replace it.

Move topdown related functions to a dedicated file, topdown.c.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/Build                |  2 +-
 .../perf/arch/x86/util/{group.c => topdown.c} |  2 +-
 tools/perf/builtin-stat.c                     | 51 +-----------------
 tools/perf/util/Build                         |  1 +
 tools/perf/util/topdown.c                     | 53 +++++++++++++++++++
 tools/perf/util/{group.h => topdown.h}        |  6 ++-
 6 files changed, 61 insertions(+), 54 deletions(-)
 rename tools/perf/arch/x86/util/{group.c => topdown.c} (95%)
 create mode 100644 tools/perf/util/topdown.c
 rename tools/perf/util/{group.h => topdown.h} (52%)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 47f9c56e744f..347c39b960eb 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -3,7 +3,7 @@ perf-y += tsc.o
 perf-y += pmu.o
 perf-y += kvm-stat.o
 perf-y += perf_regs.o
-perf-y += group.o
+perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
 
diff --git a/tools/perf/arch/x86/util/group.c b/tools/perf/arch/x86/util/topdown.c
similarity index 95%
rename from tools/perf/arch/x86/util/group.c
rename to tools/perf/arch/x86/util/topdown.c
index e2f8034b8973..597e963fb3e7 100644
--- a/tools/perf/arch/x86/util/group.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include "api/fs/fs.h"
-#include "util/group.h"
+#include "util/topdown.h"
 
 /*
  * Check whether we can use a group for top down.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..5583e22ca808 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -56,7 +56,7 @@
 #include "util/cpumap.h"
 #include "util/thread_map.h"
 #include "util/counts.h"
-#include "util/group.h"
+#include "util/topdown.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/string2.h"
@@ -1495,55 +1495,6 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
-static int topdown_filter_events(const char **attr, char **str, bool use_group)
-{
-	int off = 0;
-	int i;
-	int len = 0;
-	char *s;
-
-	for (i = 0; attr[i]; i++) {
-		if (pmu_have_event("cpu", attr[i])) {
-			len += strlen(attr[i]) + 1;
-			attr[i - off] = attr[i];
-		} else
-			off++;
-	}
-	attr[i - off] = NULL;
-
-	*str = malloc(len + 1 + 2);
-	if (!*str)
-		return -1;
-	s = *str;
-	if (i - off == 0) {
-		*s = 0;
-		return 0;
-	}
-	if (use_group)
-		*s++ = '{';
-	for (i = 0; attr[i]; i++) {
-		strcpy(s, attr[i]);
-		s += strlen(s);
-		*s++ = ',';
-	}
-	if (use_group) {
-		s[-1] = '}';
-		*s = 0;
-	} else
-		s[-1] = 0;
-	return 0;
-}
-
-__weak bool arch_topdown_check_group(bool *warn)
-{
-	*warn = false;
-	return false;
-}
-
-__weak void arch_topdown_group_warn(void)
-{
-}
-
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index cd5e41960e64..eebbd5223cae 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -101,6 +101,7 @@ perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
+perf-y += topdown.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
new file mode 100644
index 000000000000..a085b3c77c27
--- /dev/null
+++ b/tools/perf/util/topdown.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include "pmu.h"
+#include "topdown.h"
+
+int topdown_filter_events(const char **attr, char **str, bool use_group)
+{
+	int off = 0;
+	int i;
+	int len = 0;
+	char *s;
+
+	for (i = 0; attr[i]; i++) {
+		if (pmu_have_event("cpu", attr[i])) {
+			len += strlen(attr[i]) + 1;
+			attr[i - off] = attr[i];
+		} else
+			off++;
+	}
+	attr[i - off] = NULL;
+
+	*str = malloc(len + 1 + 2);
+	if (!*str)
+		return -1;
+	s = *str;
+	if (i - off == 0) {
+		*s = 0;
+		return 0;
+	}
+	if (use_group)
+		*s++ = '{';
+	for (i = 0; attr[i]; i++) {
+		strcpy(s, attr[i]);
+		s += strlen(s);
+		*s++ = ',';
+	}
+	if (use_group) {
+		s[-1] = '}';
+		*s = 0;
+	} else
+		s[-1] = 0;
+	return 0;
+}
+
+__weak bool arch_topdown_check_group(bool *warn)
+{
+	*warn = false;
+	return false;
+}
+
+__weak void arch_topdown_group_warn(void)
+{
+}
diff --git a/tools/perf/util/group.h b/tools/perf/util/topdown.h
similarity index 52%
rename from tools/perf/util/group.h
rename to tools/perf/util/topdown.h
index f36c7e31780a..e3d70e95f4f1 100644
--- a/tools/perf/util/group.h
+++ b/tools/perf/util/topdown.h
@@ -1,8 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef GROUP_H
-#define GROUP_H 1
+#ifndef TOPDOWN_H
+#define TOPDOWN_H 1
 
 bool arch_topdown_check_group(bool *warn);
 void arch_topdown_group_warn(void);
 
+int topdown_filter_events(const char **attr, char **str, bool use_group);
+
 #endif
-- 
2.17.1

