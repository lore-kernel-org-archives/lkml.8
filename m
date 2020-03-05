Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A30C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE8A24656
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCEWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEWpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674600"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:45 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/27] tools/power/x86/intel-speed-select: Enhance core-power info command
Date:   Thu,  5 Mar 2020 14:45:14 -0800
Message-Id: <20200305224538.490864-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to CLOS enable status, also show the core-power feature
status. This will help why clos enable status didn't give desired
results as the core-power feature may be disabled or unsupported.

The new display looks as follows:

$intel-speed-select core-power info
Intel(R) Speed Select Technology
..
 package-0
  die-0
    cpu-0
      core-power
        support-status:supported
        enable-status:enabled
        clos-enable-status:1
        priority-type:0

In the above display "support-status" and "enable-status", shows the
status of the core-power feature and "clos-enable-status", shows the
status of the clos.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-config.c  |  9 +++++++--
 .../power/x86/intel-speed-select/isst-display.c | 17 ++++++++++++++++-
 tools/power/x86/intel-speed-select/isst.h       |  4 +++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c0de18e10cda..405b03cba248 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1754,8 +1754,13 @@ static void get_clos_info_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	ret = isst_clos_get_clos_information(cpu, &enable, &prio_type);
 	if (ret)
 		perror("isst_clos_get_info");
-	else
-		isst_clos_display_clos_information(cpu, outf, enable, prio_type);
+	else {
+		int cp_state, cp_cap;
+
+		isst_read_pm_config(cpu, &cp_state, &cp_cap);
+		isst_clos_display_clos_information(cpu, outf, enable, prio_type,
+						   cp_state, cp_cap);
+	}
 }
 
 static void dump_clos_info(int arg)
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 3d70be2a9f61..30377acb909d 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -589,7 +589,8 @@ void isst_clos_display_information(int cpu, FILE *outf, int clos,
 }
 
 void isst_clos_display_clos_information(int cpu, FILE *outf,
-					int clos_enable, int type)
+					int clos_enable, int type,
+					int state, int cap)
 {
 	char header[256];
 	char value[256];
@@ -605,7 +606,21 @@ void isst_clos_display_clos_information(int cpu, FILE *outf,
 	snprintf(header, sizeof(header), "core-power");
 	format_and_print(outf, 4, header, NULL);
 
+	snprintf(header, sizeof(header), "support-status");
+	if (cap)
+		snprintf(value, sizeof(value), "supported");
+	else
+		snprintf(value, sizeof(value), "unsupported");
+	format_and_print(outf, 5, header, value);
+
 	snprintf(header, sizeof(header), "enable-status");
+	if (state)
+		snprintf(value, sizeof(value), "enabled");
+	else
+		snprintf(value, sizeof(value), "disabled");
+	format_and_print(outf, 5, header, value);
+
+	snprintf(header, sizeof(header), "clos-enable-status");
 	snprintf(value, sizeof(value), "%d", clos_enable);
 	format_and_print(outf, 5, header, value);
 
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index ad5aa6341d0f..53e147a9a295 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -245,7 +245,9 @@ extern void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 
 extern int isst_clos_get_clos_information(int cpu, int *enable, int *type);
 extern void isst_clos_display_clos_information(int cpu, FILE *outf,
-					       int clos_enable, int type);
+					       int clos_enable, int type,
+					       int state, int cap);
 extern int is_clx_n_platform(void);
 extern int get_cpufreq_base_freq(int cpu);
+extern int isst_read_pm_config(int cpu, int *cp_state, int *cp_cap);
 #endif
-- 
2.24.1

