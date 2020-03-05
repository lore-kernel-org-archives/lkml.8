Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB8BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA082073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCEWrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:47:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgCEWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674622"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:48 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 10/27] tools/power/x86/intel-speed-select: Enhance --info option
Date:   Thu,  5 Mar 2020 14:45:21 -0800
Message-Id: <20200305224538.490864-11-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional information, which will allow user to detect available
features. This will allow users to check presence of features before
continue to test.
A sample output:

$sudo ./intel-speed-select --info

Intel(R) Speed Select Technology
Executing on CPU model:85[0x55]
Platform: API version : 1
Platform: Driver version : 1
Platform: mbox supported : 1
Platform: mmio supported : 0
Intel(R) SST-PP (feature perf-profile) is not supported
Only performance level 0 (base level) is present
TDP level change control is locked
Intel(R) SST-TF (feature turbo-freq) is supported
Intel(R) SST-BF (feature base-freq) is supported
Intel(R) SST-CP (feature core-power) is supported

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 74 +++++++++++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 2 files changed, 76 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 5302a552f87f..65110d06394f 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -846,12 +846,85 @@ static int isst_fill_platform_info(void)
 	return 0;
 }
 
+static void isst_print_extended_platform_info(void)
+{
+	int cp_state, cp_cap, fact_support = 0, pbf_support = 0;
+	struct isst_pkg_ctdp_level_info ctdp_level;
+	struct isst_pkg_ctdp pkg_dev;
+	int ret, i, j;
+	FILE *filep;
+
+	for (i = 0; i < 256; ++i) {
+		char path[256];
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings", i);
+		filep = fopen(path, "r");
+		if (filep)
+			break;
+	}
+
+	if (!filep)
+		return;
+
+	fclose(filep);
+
+	ret = isst_get_ctdp_levels(i, &pkg_dev);
+	if (ret)
+		return;
+
+	if (pkg_dev.enabled) {
+		fprintf(outf, "Intel(R) SST-PP (feature perf-profile) is supported\n");
+	} else {
+		fprintf(outf, "Intel(R) SST-PP (feature perf-profile) is not supported\n");
+		fprintf(outf, "Only performance level 0 (base level) is present\n");
+	}
+
+	if (pkg_dev.locked)
+		fprintf(outf, "TDP level change control is locked\n");
+	else
+		fprintf(outf, "TDP level change control is unlocked, max level: %d \n", pkg_dev.levels);
+
+	for (j = 0; j <= pkg_dev.levels; ++j) {
+		ret = isst_get_ctdp_control(i, j, &ctdp_level);
+		if (ret)
+			continue;
+
+		if (!fact_support && ctdp_level.fact_support)
+			fact_support = 1;
+
+		if (!pbf_support && ctdp_level.pbf_support)
+			pbf_support = 1;
+	}
+
+	if (fact_support)
+		fprintf(outf, "Intel(R) SST-TF (feature turbo-freq) is supported\n");
+	else
+		fprintf(outf, "Intel(R) SST-TF (feature turbo-freq) is not supported\n");
+
+	if (pbf_support)
+		fprintf(outf, "Intel(R) SST-BF (feature base-freq) is supported\n");
+	else
+		fprintf(outf, "Intel(R) SST-BF (feature base-freq) is not supported\n");
+
+	ret = isst_read_pm_config(i, &cp_state, &cp_cap);
+	if (cp_cap)
+		fprintf(outf, "Intel(R) SST-CP (feature core-power) is supported\n");
+	else
+		fprintf(outf, "Intel(R) SST-CP (feature core-power) is not supported\n");
+}
+
 static void isst_print_platform_information(void)
 {
 	struct isst_if_platform_info platform_info;
 	const char *pathname = "/dev/isst_interface";
 	int fd;
 
+	if (is_clx_n_platform()) {
+		fprintf(stderr, "\nThis option in not supported on this platform\n");
+		exit(0);
+	}
+
 	fd = open(pathname, O_RDWR);
 	if (fd < 0)
 		err(-1, "%s open failed", pathname);
@@ -867,6 +940,7 @@ static void isst_print_platform_information(void)
 			platform_info.mbox_supported);
 		fprintf(outf, "Platform: mmio supported : %d\n",
 			platform_info.mmio_supported);
+		isst_print_extended_platform_info();
 	}
 
 	close(fd);
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 53e147a9a295..639d3d649480 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -196,6 +196,8 @@ extern int isst_send_msr_command(unsigned int cpu, unsigned int command,
 				 int write, unsigned long long *req_resp);
 
 extern int isst_get_ctdp_levels(int cpu, struct isst_pkg_ctdp *pkg_dev);
+extern int isst_get_ctdp_control(int cpu, int config_index,
+				 struct isst_pkg_ctdp_level_info *ctdp_level);
 extern int isst_get_coremask_info(int cpu, int config_index,
 			   struct isst_pkg_ctdp_level_info *ctdp_level);
 extern int isst_get_process_ctdp(int cpu, int tdp_level,
-- 
2.24.1

