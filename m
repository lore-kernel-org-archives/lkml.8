Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A120C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61309206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCEWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:5035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgCEWpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674643"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:52 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 18/27] tools/power/x86/intel-speed-select: Improve error display for turbo-freq feature
Date:   Thu,  5 Mar 2020 14:45:29 -0800
Message-Id: <20200305224538.490864-19-srinivas.pandruvada@linux.intel.com>
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
to turbo-freq feature. The changes include:
- Replace perror/fprintf with helpful error message
- Error for not specifying TDP level when required
- Show error for invalid bucket number
- Show message to enable core-power before enabling turbo-freq feature

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 15 ++++---
 .../power/x86/intel-speed-select/isst-core.c  | 41 ++++++++++++++++---
 .../x86/intel-speed-select/isst-display.c     | 16 +++++++-
 tools/power/x86/intel-speed-select/isst.h     |  2 +-
 4 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 95602f98a138..48915470c572 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1712,12 +1712,15 @@ static void dump_fact_config_for_cpu(int cpu, void *arg1, void *arg2,
 	struct isst_fact_info fact_info;
 	int ret;
 
-	ret = isst_get_fact_info(cpu, tdp_level, &fact_info);
-	if (ret)
-		perror("isst_get_fact_bucket_info");
-	else
+	ret = isst_get_fact_info(cpu, tdp_level, fact_bucket, &fact_info);
+	if (ret) {
+		isst_display_error_info_message(1, "Failed to get turbo-freq info at this level", 1, tdp_level);
+		isst_ctdp_display_information_end(outf);
+		exit(1);
+	} else {
 		isst_fact_display_information(cpu, outf, tdp_level, fact_bucket,
 					      fact_avx, &fact_info);
+	}
 }
 
 static void dump_fact_config(int arg)
@@ -1735,7 +1738,7 @@ static void dump_fact_config(int arg)
 	}
 
 	if (tdp_level == 0xff) {
-		fprintf(outf, "Invalid command: specify tdp_level\n");
+		isst_display_error_info_message(1, "Invalid command: specify tdp_level\n", 0, 0);
 		exit(1);
 	}
 
@@ -1763,7 +1766,7 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_set_pbf_fact_status(cpu, 0, status);
 	if (ret) {
-		perror("isst_set_fact");
+		debug_printf("isst_set_pbf_fact_status failed");
 		if (auto_mode)
 			isst_pm_qos_config(cpu, 0, 0);
 
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 7836f9f08af1..89b3068a2685 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -516,7 +516,7 @@ int isst_set_pbf_fact_status(int cpu, int pbf, int enable)
 	} else {
 
 		if (enable && !ctdp_level.sst_cp_enabled)
-			fprintf(stderr, "Make sure to execute before: core-power enable\n");
+			isst_display_error_info_message(0, "Make sure to execute before: core-power enable", 0, 0);
 
 		if (ctdp_level.pbf_enabled)
 			req = BIT(17);
@@ -603,18 +603,30 @@ int isst_get_fact_bucket_info(int cpu, int level,
 	return 0;
 }
 
-int isst_get_fact_info(int cpu, int level, struct isst_fact_info *fact_info)
+int isst_get_fact_info(int cpu, int level, int fact_bucket, struct isst_fact_info *fact_info)
 {
 	struct isst_pkg_ctdp_level_info ctdp_level;
+	struct isst_pkg_ctdp pkg_dev;
 	unsigned int resp;
-	int ret;
+	int j, ret, print;
+
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
 
 	ret = isst_get_ctdp_control(cpu, level, &ctdp_level);
 	if (ret)
 		return ret;
 
 	if (!ctdp_level.fact_support) {
-		fprintf(stderr, "turbo-freq feature is not present at this level:%d\n", level);
+		isst_display_error_info_message(1, "turbo-freq feature is not present at this level", 1, level);
 		return -1;
 	}
 
@@ -632,8 +644,25 @@ int isst_get_fact_info(int cpu, int level, struct isst_fact_info *fact_info)
 	fact_info->lp_clipping_ratio_license_avx512 = (resp >> 16) & 0xff;
 
 	ret = isst_get_fact_bucket_info(cpu, level, fact_info->bucket_info);
+	if (ret)
+		return ret;
 
-	return ret;
+	print = 0;
+	for (j = 0; j < ISST_FACT_MAX_BUCKETS; ++j) {
+		if (fact_bucket != 0xff && fact_bucket != j)
+			continue;
+
+		if (!fact_info->bucket_info[j].high_priority_cores_count)
+			break;
+
+		print = 1;
+	}
+	if (!print) {
+		isst_display_error_info_message(1, "Invalid bucket", 0, 0);
+		return -1;
+	}
+
+	return 0;
 }
 
 int isst_set_trl(int cpu, unsigned long long trl)
@@ -769,7 +798,7 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		}
 
 		if (ctdp_level->fact_support) {
-			ret = isst_get_fact_info(cpu, i,
+			ret = isst_get_fact_info(cpu, i, 0xff,
 						 &ctdp_level->fact_info);
 			if (ret)
 				return ret;
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 0667b405f17f..bf9422336fab 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -222,7 +222,21 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 	struct isst_fact_bucket_info *bucket_info = fact_info->bucket_info;
 	char header[256];
 	char value[256];
-	int j;
+	int print = 0, j;
+
+	for (j = 0; j < ISST_FACT_MAX_BUCKETS; ++j) {
+		if (fact_bucket != 0xff && fact_bucket != j)
+			continue;
+
+		if (!bucket_info[j].high_priority_cores_count)
+			break;
+
+		print = 1;
+	}
+	if (!print) {
+		fprintf(stderr, "Invalid bucket\n");
+		return;
+	}
 
 	snprintf(header, sizeof(header), "speed-select-turbo-freq-properties");
 	format_and_print(outf, base_level, header, NULL);
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 69fa2c3c70c3..2e1afd856a78 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -219,7 +219,7 @@ extern int isst_set_pbf_fact_status(int cpu, int pbf, int enable);
 extern int isst_get_pbf_info(int cpu, int level,
 			     struct isst_pbf_info *pbf_info);
 extern void isst_get_pbf_info_complete(struct isst_pbf_info *pbf_info);
-extern int isst_get_fact_info(int cpu, int level,
+extern int isst_get_fact_info(int cpu, int level, int fact_bucket,
 			      struct isst_fact_info *fact_info);
 extern int isst_get_fact_bucket_info(int cpu, int level,
 				     struct isst_fact_bucket_info *bucket_info);
-- 
2.24.1

