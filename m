Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F72C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF824673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANTWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:22:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:48040 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbgANTWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="423259147"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 11:22:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/5] tools/power/x86/intel-speed-select: Add support for core-power discovery
Date:   Tue, 14 Jan 2020 11:22:14 -0800
Message-Id: <20200114192217.580364-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
References: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that BIOS may not enable core-power feature. In this case
this additional interface will allow to enable from this utility. Also
the information dump, includes the current status of core-power.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-core.c  | 55 +++++++++++++++++++
 .../x86/intel-speed-select/isst-display.c     | 11 ++++
 tools/power/x86/intel-speed-select/isst.h     |  6 ++
 3 files changed, 72 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index d14c7bcd327a..81a119f688a3 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -6,6 +6,44 @@
 
 #include "isst.h"
 
+int isst_write_pm_config(int cpu, int cp_state)
+{
+	unsigned int req, resp;
+	int ret;
+
+	if (cp_state)
+		req = BIT(16);
+	else
+		req = 0;
+
+	ret = isst_send_mbox_command(cpu, WRITE_PM_CONFIG, PM_FEATURE, 0, req,
+				     &resp);
+	if (ret)
+		return ret;
+
+	debug_printf("cpu:%d WRITE_PM_CONFIG resp:%x\n", cpu, resp);
+
+	return 0;
+}
+
+int isst_read_pm_config(int cpu, int *cp_state, int *cp_cap)
+{
+	unsigned int resp;
+	int ret;
+
+	ret = isst_send_mbox_command(cpu, READ_PM_CONFIG, PM_FEATURE, 0, 0,
+				     &resp);
+	if (ret)
+		return ret;
+
+	debug_printf("cpu:%d READ_PM_CONFIG resp:%x\n", cpu, resp);
+
+	*cp_state = resp & BIT(16);
+	*cp_cap = resp & BIT(0) ? 1 : 0;
+
+	return 0;
+}
+
 int isst_get_ctdp_levels(int cpu, struct isst_pkg_ctdp *pkg_dev)
 {
 	unsigned int resp;
@@ -36,6 +74,7 @@ int isst_get_ctdp_levels(int cpu, struct isst_pkg_ctdp *pkg_dev)
 int isst_get_ctdp_control(int cpu, int config_index,
 			  struct isst_pkg_ctdp_level_info *ctdp_level)
 {
+	int cp_state, cp_cap;
 	unsigned int resp;
 	int ret;
 
@@ -50,6 +89,15 @@ int isst_get_ctdp_control(int cpu, int config_index,
 	ctdp_level->fact_enabled = !!(resp & BIT(16));
 	ctdp_level->pbf_enabled = !!(resp & BIT(17));
 
+	ret = isst_read_pm_config(cpu, &cp_state, &cp_cap);
+	if (ret) {
+		debug_printf("cpu:%d pm_config is not supported \n", cpu);
+	} else {
+		debug_printf("cpu:%d pm_config SST-CP state:%d cap:%d \n", cpu, cp_state, cp_cap);
+		ctdp_level->sst_cp_support = cp_cap;
+		ctdp_level->sst_cp_enabled = cp_state;
+	}
+
 	debug_printf(
 		"cpu:%d CONFIG_TDP_GET_TDP_CONTROL resp:%x fact_support:%d pbf_support: %d fact_enabled:%d pbf_enabled:%d\n",
 		cpu, resp, ctdp_level->fact_support, ctdp_level->pbf_support,
@@ -779,6 +827,13 @@ int isst_pm_qos_config(int cpu, int enable_clos, int priority_type)
 			debug_printf("Turbo-freq feature must be disabled first\n");
 			return -EINVAL;
 		}
+		ret = isst_write_pm_config(cpu, 0);
+		if (ret)
+			perror("isst_write_pm_config\n");
+	} else {
+		ret = isst_write_pm_config(cpu, 1);
+		if (ret)
+			perror("isst_write_pm_config\n");
 	}
 
 	ret = isst_send_mbox_command(cpu, CONFIG_CLOS, CLOS_PM_QOS_CONFIG, 0, 0,
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 040dd09d5eee..1d1439036c12 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -418,6 +418,17 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
+		snprintf(header, sizeof(header),
+			 "speed-select-core-power");
+		if (ctdp_level->sst_cp_support) {
+			if (ctdp_level->sst_cp_enabled)
+				snprintf(value, sizeof(value), "enabled");
+			else
+				snprintf(value, sizeof(value), "disabled");
+		} else
+			snprintf(value, sizeof(value), "unsupported");
+		format_and_print(outf, base_level + 4, header, value);
+
 		if (is_clx_n_platform()) {
 			if (ctdp_level->pbf_support)
 				_isst_pbf_display_information(cpu, outf,
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index cdf0f8a6dbbf..ad5aa6341d0f 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -69,6 +69,10 @@
 #define PM_CLOS_OFFSET				0x08
 #define PQR_ASSOC_OFFSET			0x20
 
+#define READ_PM_CONFIG				0x94
+#define WRITE_PM_CONFIG				0x95
+#define PM_FEATURE				0x03
+
 #define DISP_FREQ_MULTIPLIER 100
 
 struct isst_clos_config {
@@ -119,6 +123,8 @@ struct isst_pkg_ctdp_level_info {
 	int pbf_support;
 	int fact_enabled;
 	int pbf_enabled;
+	int sst_cp_support;
+	int sst_cp_enabled;
 	int tdp_ratio;
 	int active;
 	int tdp_control;
-- 
2.24.1

