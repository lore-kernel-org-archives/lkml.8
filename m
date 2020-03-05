Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99829C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74860206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCEWp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:5026 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgCEWpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674626"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 11/27] tools/power/x86/intel-speed-select: Add an API for error/information print
Date:   Thu,  5 Mar 2020 14:45:22 -0800
Message-Id: <20200305224538.490864-12-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common API which can be used to print all error and information
messages. In this way a common format can be used.

For json output an error index in suffixed to make unique error key.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      |  5 +++
 .../x86/intel-speed-select/isst-display.c     | 44 +++++++++++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 3 files changed, 51 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 65110d06394f..360fa00f9c7a 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -69,6 +69,11 @@ struct cpu_topology {
 	short die_id;
 };
 
+FILE *get_output_file(void)
+{
+	return outf;
+}
+
 void debug_printf(const char *format, ...)
 {
 	va_list args;
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index ec737e101e52..943226d1dd4e 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -515,15 +515,18 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 	format_and_print(outf, 1, NULL, NULL);
 }
 
+static int start;
 void isst_ctdp_display_information_start(FILE *outf)
 {
 	last_level = 0;
 	format_and_print(outf, 0, "start", NULL);
+	start = 1;
 }
 
 void isst_ctdp_display_information_end(FILE *outf)
 {
 	format_and_print(outf, 0, NULL, NULL);
+	start = 0;
 }
 
 void isst_pbf_display_information(int cpu, FILE *outf, int level,
@@ -686,3 +689,44 @@ void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 
 	format_and_print(outf, 1, NULL, NULL);
 }
+
+void isst_display_error_info_message(int error, char *msg, int arg_valid, int arg)
+{
+	FILE *outf = get_output_file();
+	static int error_index;
+	char header[256];
+	char value[256];
+
+	if (!out_format_is_json()) {
+		if (arg_valid)
+			snprintf(value, sizeof(value), "%s %d", msg, arg);
+		else
+			snprintf(value, sizeof(value), "%s", msg);
+
+		if (error)
+			fprintf(outf, "Error: %s\n", value);
+		else
+			fprintf(outf, "Information: %s\n", value);
+		return;
+	}
+
+	if (!start)
+		format_and_print(outf, 0, "start", NULL);
+
+	if (error)
+		snprintf(header, sizeof(header), "Error%d", error_index++);
+	else
+		snprintf(header, sizeof(header), "Information:%d", error_index++);
+	format_and_print(outf, 1, header, NULL);
+
+	snprintf(header, sizeof(header), "message");
+	if (arg_valid)
+		snprintf(value, sizeof(value), "%s %d", msg, arg);
+	else
+		snprintf(value, sizeof(value), "%s", msg);
+
+	format_and_print(outf, 2, header, value);
+	format_and_print(outf, 1, NULL, NULL);
+	if (!start)
+		format_and_print(outf, 0, NULL, NULL);
+}
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 639d3d649480..4950d2368ff8 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -172,6 +172,7 @@ extern int get_cpu_count(int pkg_id, int die_id);
 extern int get_core_count(int pkg_id, int die_id);
 
 /* Common interfaces */
+FILE *get_output_file(void);
 extern void debug_printf(const char *format, ...);
 extern int out_format_is_json(void);
 extern int get_physical_package_id(int cpu);
@@ -252,4 +253,5 @@ extern void isst_clos_display_clos_information(int cpu, FILE *outf,
 extern int is_clx_n_platform(void);
 extern int get_cpufreq_base_freq(int cpu);
 extern int isst_read_pm_config(int cpu, int *cp_state, int *cp_cap);
+extern void isst_display_error_info_message(int error, char *msg, int arg_valid, int arg);
 #endif
-- 
2.24.1

