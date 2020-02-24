Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F79C38BFF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66A620CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBXWAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:00:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:22327 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgBXWAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:00:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284477368"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 14:00:38 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/5] perf util: Factor out sysctl__nmi_watchdog_enabled()
Date:   Mon, 24 Feb 2020 13:59:22 -0800
Message-Id: <1582581564-184429-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

NMI watchdog status is required for metric group constraint examination.
Factor out sysctl__nmi_watchdog_enabled() to retrieve the NMI watchdog
status.

Users may count more than one metric groups each time. If so, the NMI
watchdog status may be retrieved several times. To reduce the overhead,
cache the NMI watchdog status.

Replace the NMI watchdog status checking in print_footer() by
sysctl__nmi_watchdog_enabled().

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/stat-display.c |  6 ++----
 tools/perf/util/util.c         | 18 ++++++++++++++++++
 tools/perf/util/util.h         |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bc31fcc..16efdba 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include "cgroup.h"
 #include <api/fs/fs.h>
+#include "util.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -1097,7 +1098,6 @@ static void print_footer(struct perf_stat_config *config)
 {
 	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
-	int n;
 
 	if (!config->null_run)
 		fprintf(output, "\n");
@@ -1131,9 +1131,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (config->print_free_counters_hint &&
-	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
-	    n > 0)
+	if (config->print_free_counters_hint && sysctl__nmi_watchdog_enabled())
 		fprintf(output,
 "Some events weren't counted. Try disabling the NMI watchdog:\n"
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 969ae56..d707c96 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -55,6 +55,24 @@ int sysctl__max_stack(void)
 	return sysctl_perf_event_max_stack;
 }
 
+bool sysctl__nmi_watchdog_enabled(void)
+{
+	static bool cached;
+	static bool nmi_watchdog;
+	int value;
+
+	if (cached)
+		return nmi_watchdog;
+
+	if (sysctl__read_int("kernel/nmi_watchdog", &value) < 0)
+		return false;
+
+	nmi_watchdog = (value > 0) ? true : false;
+	cached = true;
+
+	return nmi_watchdog;
+}
+
 bool test_attr__enabled;
 
 bool perf_host  = true;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9969b8b..f486fdd 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -29,6 +29,8 @@ size_t hex_width(u64 v);
 
 int sysctl__max_stack(void);
 
+bool sysctl__nmi_watchdog_enabled(void);
+
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
 #define KVER_VERSION(x)		(((x) >> 16) & 0xff)
-- 
2.7.4

