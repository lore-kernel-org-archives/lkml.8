Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95850C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6AB206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCEWqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:5026 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCEWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674640"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:51 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 16/27] tools/power/x86/intel-speed-select: Improve output of perf-profile commands
Date:   Thu,  5 Mar 2020 14:45:27 -0800
Message-Id: <20200305224538.490864-17-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve output of perf-profile commands:
get-config-enabled
get-lock-status

Instead of showing 0/1, show meaningful strings. Also show error when
command is failed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 20 +++++++++++--------
 .../x86/intel-speed-select/isst-display.c     | 10 +++++++---
 tools/power/x86/intel-speed-select/isst.h     |  2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 75c8e1a933ef..362a352e6266 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -953,6 +953,7 @@ static void isst_print_platform_information(void)
 	exit(0);
 }
 
+static char *local_str0, *local_str1;
 static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				 void *arg4)
 {
@@ -962,13 +963,14 @@ static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	fn_ptr = arg1;
 	ret = fn_ptr(cpu, arg2);
 	if (ret)
-		perror("get_tdp_*");
+		isst_display_error_info_message(1, "get_tdp_* failed", 0, 0);
 	else
 		isst_ctdp_display_core_info(cpu, outf, arg3,
-					    *(unsigned int *)arg4);
+					    *(unsigned int *)arg4,
+					    local_str0, local_str1);
 }
 
-#define _get_tdp_level(desc, suffix, object, help)                                \
+#define _get_tdp_level(desc, suffix, object, help, str0, str1)			\
 	static void get_tdp_##object(int arg)                                    \
 	{                                                                         \
 		struct isst_pkg_ctdp ctdp;                                        \
@@ -979,6 +981,8 @@ static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				help);                                            \
 			exit(0);                                                  \
 		}                                                                 \
+		local_str0 = str0;						  \
+		local_str1 = str1;						  \
 		isst_ctdp_display_information_start(outf);                        \
 		if (max_target_cpus)                                              \
 			for_each_online_target_cpu_in_set(                        \
@@ -992,12 +996,12 @@ static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		isst_ctdp_display_information_end(outf);                          \
 	}
 
-_get_tdp_level("get-config-levels", levels, levels, "TDP levels");
-_get_tdp_level("get-config-version", levels, version, "TDP version");
-_get_tdp_level("get-config-enabled", levels, enabled, "TDP enable status");
+_get_tdp_level("get-config-levels", levels, levels, "Max TDP level", NULL, NULL);
+_get_tdp_level("get-config-version", levels, version, "TDP version", NULL, NULL);
+_get_tdp_level("get-config-enabled", levels, enabled, "perf-profile enable status", "disabled", "enabled");
 _get_tdp_level("get-config-current_level", levels, current_level,
-	       "Current TDP Level");
-_get_tdp_level("get-lock-status", levels, locked, "TDP lock status");
+	       "Current TDP Level", NULL, NULL);
+_get_tdp_level("get-lock-status", levels, locked, "TDP lock status", "unlocked", "locked");
 
 struct isst_pkg_ctdp clx_n_pkg_dev;
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 943226d1dd4e..0667b405f17f 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -289,7 +289,7 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 }
 
 void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
-				 unsigned int val)
+				 unsigned int val, char *str0, char *str1)
 {
 	char header[256];
 	char value[256];
@@ -301,8 +301,12 @@ void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
 	format_and_print(outf, 2, header, NULL);
 	snprintf(header, sizeof(header), "cpu-%d", cpu);
 	format_and_print(outf, 3, header, NULL);
-
-	snprintf(value, sizeof(value), "%u", val);
+	if (str0 && !val)
+		snprintf(value, sizeof(value), "%s", str0);
+	else if (str1 && val)
+		snprintf(value, sizeof(value), "%s", str1);
+	else
+		snprintf(value, sizeof(value), "%u", val);
 	format_and_print(outf, 4, prefix, value);
 
 	format_and_print(outf, 1, NULL, NULL);
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 4950d2368ff8..69fa2c3c70c3 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -208,7 +208,7 @@ extern void isst_get_process_ctdp_complete(int cpu,
 extern void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 					  struct isst_pkg_ctdp *pkg_dev);
 extern void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
-					unsigned int val);
+					unsigned int val, char *str0, char *str1);
 extern void isst_ctdp_display_information_start(FILE *outf);
 extern void isst_ctdp_display_information_end(FILE *outf);
 extern void isst_pbf_display_information(int cpu, FILE *outf, int level,
-- 
2.24.1

