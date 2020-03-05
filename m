Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF251C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD297206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCEWqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:5028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgCEWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674641"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:51 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 17/27] tools/power/x86/intel-speed-select: Improve error display for base-freq feature
Date:   Thu,  5 Mar 2020 14:45:28 -0800
Message-Id: <20200305224538.490864-18-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds improved error display and handling for commands related
to base-freq feature. The changes include:
- Replace perror/fprintf with helpful error message
- Error for not specifying TDP level when required
- For CLX show help which shows limitation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 25 ++++++++++++++++---
 .../power/x86/intel-speed-select/isst-core.c  | 14 ++++++++++-
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 362a352e6266..95602f98a138 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1276,7 +1276,7 @@ static void clx_n_dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 	ret = clx_n_config(cpu);
 	if (ret) {
-		perror("isst_get_process_ctdp");
+		isst_display_error_info_message(1, "clx_n_config failed", 0, 0);
 	} else {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
 		struct isst_pbf_info *pbf_info;
@@ -1297,7 +1297,9 @@ static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_get_pbf_info(cpu, tdp_level, &pbf_info);
 	if (ret) {
-		perror("isst_get_pbf_info");
+		isst_display_error_info_message(1, "Failed to get base-freq info at this level", 1, tdp_level);
+		isst_ctdp_display_information_end(outf);
+		exit(1);
 	} else {
 		isst_pbf_display_information(cpu, outf, tdp_level, &pbf_info);
 		isst_get_pbf_info_complete(&pbf_info);
@@ -1317,7 +1319,7 @@ static void dump_pbf_config(int arg)
 	}
 
 	if (tdp_level == 0xff) {
-		fprintf(outf, "Invalid command: specify tdp_level\n");
+		isst_display_error_info_message(1, "Invalid command: specify tdp_level", 0, 0);
 		exit(1);
 	}
 
@@ -1635,7 +1637,7 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_set_pbf_fact_status(cpu, 1, status);
 	if (ret) {
-		perror("isst_set_pbf");
+		debug_printf("isst_set_pbf_fact_status failed");
 		if (auto_mode)
 			isst_pm_qos_config(cpu, 0, 0);
 	} else {
@@ -1667,10 +1669,25 @@ static void set_pbf_enable(int arg)
 		if (enable) {
 			fprintf(stderr,
 				"Enable Intel Speed Select Technology base frequency feature\n");
+			if (is_clx_n_platform()) {
+				fprintf(stderr,
+					"\tOn this platform this command doesn't enable feature in the hardware.\n");
+				fprintf(stderr,
+					"\tIt updates the cpufreq scaling_min_freq to match cpufreq base_frequency.\n");
+				exit(0);
+
+			}
 			fprintf(stderr,
 				"\tOptional Arguments: -a|--auto : Use priority of cores to set core-power associations\n");
 		} else {
 
+			if (is_clx_n_platform()) {
+				fprintf(stderr,
+					"\tOn this platform this command doesn't disable feature in the hardware.\n");
+				fprintf(stderr,
+					"\tIt updates the cpufreq scaling_min_freq to match cpuinfo_min_freq\n");
+				exit(0);
+			}
 			fprintf(stderr,
 				"Disable Intel Speed Select Technology base frequency feature\n");
 			fprintf(stderr,
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index f69c009ef6f6..7836f9f08af1 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -395,15 +395,27 @@ int isst_set_tdp_level(int cpu, int tdp_level)
 int isst_get_pbf_info(int cpu, int level, struct isst_pbf_info *pbf_info)
 {
 	struct isst_pkg_ctdp_level_info ctdp_level;
+	struct isst_pkg_ctdp pkg_dev;
 	int i, ret, core_cnt, max;
 	unsigned int req, resp;
 
+	ret = isst_get_ctdp_levels(cpu, &pkg_dev);
+	if (ret) {
+		isst_display_error_info_message(1, "Failed to get number of levels", 0, 0);
+		return ret;
+	}
+
+	if (level > pkg_dev.levels) {
+		isst_display_error_info_message(1, "Invalid level", 1, level);
+		return -1;
+	}
+
 	ret = isst_get_ctdp_control(cpu, level, &ctdp_level);
 	if (ret)
 		return ret;
 
 	if (!ctdp_level.pbf_support) {
-		fprintf(stderr, "base-freq feature is not present at this level:%d\n", level);
+		isst_display_error_info_message(1, "base-freq feature is not present at this level", 1, level);
 		return -1;
 	}
 
-- 
2.24.1

