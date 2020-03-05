Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3411DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A55D206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgCEWqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:5036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgCEWpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674650"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:53 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 20/27] tools/power/x86/intel-speed-select: Improve core-power result and error display
Date:   Thu,  5 Mar 2020 14:45:31 -0800
Message-Id: <20200305224538.490864-21-srinivas.pandruvada@linux.intel.com>
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
to core-power feature. The changes include:
- Replace perror with helpful error message
- Use ordered priority for SKX based platform by default as the
proportional priority is not supported
- Don't show weight and epp in help and also give error when user
tries to set them in SKX based platforms
- Range check for epp and weights and display error

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 87 +++++++++++--------
 .../power/x86/intel-speed-select/isst-core.c  | 10 ++-
 .../x86/intel-speed-select/isst-display.c     |  5 +-
 3 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2ab902c18bcc..7a8a315ac8d1 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1361,7 +1361,7 @@ static int set_clos_param(int cpu, int clos, int epp, int wt, int min, int max)
 
 	ret = isst_pm_get_clos(cpu, clos, &clos_config);
 	if (ret) {
-		perror("isst_pm_get_clos");
+		isst_display_error_info_message(1, "isst_pm_get_clos failed", 0, 0);
 		return ret;
 	}
 	clos_config.clos_min = min;
@@ -1370,7 +1370,7 @@ static int set_clos_param(int cpu, int clos, int epp, int wt, int min, int max)
 	clos_config.clos_prop_prio = wt;
 	ret = isst_set_clos(cpu, clos, &clos_config);
 	if (ret) {
-		perror("isst_pm_set_clos");
+		isst_display_error_info_message(1, "isst_set_clos failed", 0, 0);
 		return ret;
 	}
 
@@ -1577,7 +1577,7 @@ static int set_core_priority_and_min(int cpu, int mask_size,
 		debug_printf("Associate cpu: %d clos: %d\n", i, clos);
 		ret = isst_clos_associate(i, clos);
 		if (ret) {
-			perror("isst_clos_associate");
+			isst_display_error_info_message(1, "isst_clos_associate failed", 0, 0);
 			return ret;
 		}
 	}
@@ -1593,14 +1593,14 @@ static int set_pbf_core_power(int cpu)
 
 	ret = isst_get_ctdp_levels(cpu, &pkg_dev);
 	if (ret) {
-		perror("isst_get_ctdp_levels");
+		debug_printf("isst_get_ctdp_levels failed");
 		return ret;
 	}
 	debug_printf("Current_level: %d\n", pkg_dev.current_level);
 
 	ret = isst_get_pbf_info(cpu, pkg_dev.current_level, &pbf_info);
 	if (ret) {
-		perror("isst_get_pbf_info");
+		debug_printf("isst_get_pbf_info failed");
 		return ret;
 	}
 	debug_printf("p1_high: %d p1_low: %d\n", pbf_info.p1_high,
@@ -1610,13 +1610,13 @@ static int set_pbf_core_power(int cpu)
 					pbf_info.core_cpumask,
 					pbf_info.p1_high, pbf_info.p1_low);
 	if (ret) {
-		perror("set_core_priority_and_min");
+		debug_printf("set_core_priority_and_min failed");
 		return ret;
 	}
 
 	ret = isst_pm_qos_config(cpu, 1, 1);
 	if (ret) {
-		perror("isst_pm_qos_config");
+		debug_printf("isst_pm_qos_config failed");
 		return ret;
 	}
 
@@ -1666,7 +1666,7 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	}
 
 	if (auto_mode && !status)
-		isst_pm_qos_config(cpu, 0, 0);
+		isst_pm_qos_config(cpu, 0, 1);
 
 disp_result:
 	if (status)
@@ -1933,9 +1933,12 @@ static void enable_clos_qos_config(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
+	if (is_skx_based_platform())
+		clos_priority_type = 1;
+
 	ret = isst_pm_qos_config(cpu, status, clos_priority_type);
 	if (ret)
-		perror("isst_pm_qos_config");
+		isst_display_error_info_message(1, "isst_pm_qos_config failed", 0, 0);
 
 	if (status)
 		isst_display_result(cpu, outf, "core-power", "enable",
@@ -1953,9 +1956,11 @@ static void set_clos_enable(int arg)
 		if (enable) {
 			fprintf(stderr,
 				"Enable core-power for a package/die\n");
-			fprintf(stderr,
-				"\tClos Enable: Specify priority type with [--priority|-p]\n");
-			fprintf(stderr, "\t\t 0: Proportional, 1: Ordered\n");
+			if (!is_skx_based_platform()) {
+				fprintf(stderr,
+					"\tClos Enable: Specify priority type with [--priority|-p]\n");
+				fprintf(stderr, "\t\t 0: Proportional, 1: Ordered\n");
+			}
 		} else {
 			fprintf(stderr,
 				"Disable core-power: [No command arguments are required]\n");
@@ -1986,7 +1991,7 @@ static void dump_clos_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 	ret = isst_pm_get_clos(cpu, current_clos, &clos_config);
 	if (ret)
-		perror("isst_pm_get_clos");
+		isst_display_error_info_message(1, "isst_pm_get_clos failed", 0, 0);
 	else
 		isst_clos_display_information(cpu, outf, current_clos,
 					      &clos_config);
@@ -2002,7 +2007,8 @@ static void dump_clos_config(int arg)
 		exit(0);
 	}
 	if (current_clos < 0 || current_clos > 3) {
-		fprintf(stderr, "Invalid clos id\n");
+		isst_display_error_info_message(1, "Invalid clos id\n", 0, 0);
+		isst_ctdp_display_information_end(outf);
 		exit(0);
 	}
 
@@ -2023,7 +2029,7 @@ static void get_clos_info_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_clos_get_clos_information(cpu, &enable, &prio_type);
 	if (ret)
-		perror("isst_clos_get_info");
+		isst_display_error_info_message(1, "isst_clos_get_info failed", 0, 0);
 	else {
 		int cp_state, cp_cap;
 
@@ -2069,7 +2075,7 @@ static void set_clos_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	clos_config.clos_desired = clos_desired;
 	ret = isst_set_clos(cpu, current_clos, &clos_config);
 	if (ret)
-		perror("isst_set_clos");
+		isst_display_error_info_message(1, "isst_set_clos failed", 0, 0);
 	else
 		isst_display_result(cpu, outf, "core-power", "config", ret);
 }
@@ -2081,26 +2087,27 @@ static void set_clos_config(int arg)
 			"Set core-power configuration for one of the four clos ids\n");
 		fprintf(stderr,
 			"\tSpecify targeted clos id with [--clos|-c]\n");
-		fprintf(stderr, "\tSpecify clos EPP with [--epp|-e]\n");
-		fprintf(stderr,
-			"\tSpecify clos Proportional Priority [--weight|-w]\n");
+		if (!is_skx_based_platform()) {
+			fprintf(stderr, "\tSpecify clos EPP with [--epp|-e]\n");
+			fprintf(stderr,
+				"\tSpecify clos Proportional Priority [--weight|-w]\n");
+		}
 		fprintf(stderr, "\tSpecify clos min in MHz with [--min|-n]\n");
 		fprintf(stderr, "\tSpecify clos max in MHz with [--max|-m]\n");
-		fprintf(stderr, "\tSpecify clos desired in MHz with [--desired|-d]\n");
 		exit(0);
 	}
 
 	if (current_clos < 0 || current_clos > 3) {
-		fprintf(stderr, "Invalid clos id\n");
+		isst_display_error_info_message(1, "Invalid clos id\n", 0, 0);
 		exit(0);
 	}
-	if (clos_epp < 0 || clos_epp > 0x0F) {
-		fprintf(stderr, "clos epp is not specified, default: 0\n");
+	if (!is_skx_based_platform() && (clos_epp < 0 || clos_epp > 0x0F)) {
+		fprintf(stderr, "clos epp is not specified or invalid, default: 0\n");
 		clos_epp = 0;
 	}
-	if (clos_prop_prio < 0 || clos_prop_prio > 0x0F) {
+	if (!is_skx_based_platform() && (clos_prop_prio < 0 || clos_prop_prio > 0x0F)) {
 		fprintf(stderr,
-			"clos frequency weight is not specified, default: 0\n");
+			"clos frequency weight is not specified or invalid, default: 0\n");
 		clos_prop_prio = 0;
 	}
 	if (clos_min < 0) {
@@ -2108,11 +2115,11 @@ static void set_clos_config(int arg)
 		clos_min = 0;
 	}
 	if (clos_max < 0) {
-		fprintf(stderr, "clos max is not specified, default: 25500 MHz\n");
+		fprintf(stderr, "clos max is not specified, default: Max frequency (ratio 0xff)\n");
 		clos_max = 0xff;
 	}
-	if (clos_desired < 0) {
-		fprintf(stderr, "clos desired is not specified, default: 0\n");
+	if (clos_desired) {
+		fprintf(stderr, "clos desired is not supported on this platform\n");
 		clos_desired = 0x00;
 	}
 
@@ -2133,7 +2140,7 @@ static void set_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_clos_associate(cpu, current_clos);
 	if (ret)
-		perror("isst_clos_associate");
+		debug_printf("isst_clos_associate failed");
 	else
 		isst_display_result(cpu, outf, "core-power", "assoc", ret);
 }
@@ -2152,15 +2159,14 @@ static void set_clos_assoc(int arg)
 	}
 
 	if (current_clos < 0 || current_clos > 3) {
-		fprintf(stderr, "Invalid clos id\n");
+		isst_display_error_info_message(1, "Invalid clos id\n", 0, 0);
 		exit(0);
 	}
 	if (max_target_cpus)
 		for_each_online_target_cpu_in_set(set_clos_assoc_for_cpu, NULL,
 						  NULL, NULL, NULL);
 	else {
-		fprintf(stderr,
-			"Invalid target cpu. Specify with [-c|--cpu]\n");
+		isst_display_error_info_message(1, "Invalid target cpu. Specify with [-c|--cpu]", 0, 0);
 	}
 }
 
@@ -2171,7 +2177,7 @@ static void get_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 	ret = isst_clos_get_assoc_status(cpu, &clos);
 	if (ret)
-		perror("isst_clos_get_assoc_status");
+		isst_display_error_info_message(1, "isst_clos_get_assoc_status failed", 0, 0);
 	else
 		isst_clos_display_assoc_information(cpu, outf, clos);
 }
@@ -2185,8 +2191,7 @@ static void get_clos_assoc(int arg)
 	}
 
 	if (!max_target_cpus) {
-		fprintf(stderr,
-			"Invalid target cpu. Specify with [-c|--cpu]\n");
+		isst_display_error_info_message(1, "Invalid target cpu. Specify with [-c|--cpu]", 0, 0);
 		exit(0);
 	}
 
@@ -2366,6 +2371,10 @@ static void parse_cmd_args(int argc, int start, char **argv)
 			break;
 		case 'e':
 			clos_epp = atoi(optarg);
+			if (is_skx_based_platform()) {
+				isst_display_error_info_message(1, "epp can't be specified on this platform", 0, 0);
+				exit(0);
+			}
 			break;
 		case 'n':
 			clos_min = atoi(optarg);
@@ -2377,9 +2386,17 @@ static void parse_cmd_args(int argc, int start, char **argv)
 			break;
 		case 'p':
 			clos_priority_type = atoi(optarg);
+			if (is_skx_based_platform() && !clos_priority_type) {
+				isst_display_error_info_message(1, "Invalid clos priority type: proportional for this platform", 0, 0);
+				exit(0);
+			}
 			break;
 		case 'w':
 			clos_prop_prio = atoi(optarg);
+			if (is_skx_based_platform()) {
+				isst_display_error_info_message(1, "weight can't be specified on this platform", 0, 0);
+				exit(0);
+			}
 			break;
 		default:
 			printf("no match\n");
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 89b3068a2685..67c9b1139631 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -917,17 +917,19 @@ int isst_pm_qos_config(int cpu, int enable_clos, int priority_type)
 		}
 		ret = isst_write_pm_config(cpu, 0);
 		if (ret)
-			perror("isst_write_pm_config\n");
+			isst_display_error_info_message(0, "WRITE_PM_CONFIG command failed, ignoring error\n", 0, 0);
 	} else {
 		ret = isst_write_pm_config(cpu, 1);
 		if (ret)
-			perror("isst_write_pm_config\n");
+			isst_display_error_info_message(0, "WRITE_PM_CONFIG command failed, ignoring error\n", 0, 0);
 	}
 
 	ret = isst_send_mbox_command(cpu, CONFIG_CLOS, CLOS_PM_QOS_CONFIG, 0, 0,
 				     &resp);
-	if (ret)
+	if (ret) {
+		isst_display_error_info_message(1, "CLOS_PM_QOS_CONFIG command failed", 0, 0);
 		return ret;
+	}
 
 	debug_printf("cpu:%d CLOS_PM_QOS_CONFIG resp:%x\n", cpu, resp);
 
@@ -939,7 +941,7 @@ int isst_pm_qos_config(int cpu, int enable_clos, int priority_type)
 		req = req & ~BIT(1);
 
 	if (priority_type > 1)
-		fprintf(stderr, "Invalid priority type: Changing type to ordered\n");
+		isst_display_error_info_message(1, "Invalid priority type: Changing type to ordered", 0, 0);
 
 	if (priority_type)
 		req = req | BIT(2);
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index bf9422336fab..ed51d8b79c41 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -599,7 +599,10 @@ void isst_clos_display_information(int cpu, FILE *outf, int clos,
 	format_and_print(outf, 5, header, value);
 
 	snprintf(header, sizeof(header), "clos-max");
-	snprintf(value, sizeof(value), "%d MHz", clos_config->clos_max * DISP_FREQ_MULTIPLIER);
+	if (clos_config->clos_max == 0xff)
+		snprintf(value, sizeof(value), "Max Turbo frequency");
+	else
+		snprintf(value, sizeof(value), "%d MHz", clos_config->clos_max * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, 5, header, value);
 
 	snprintf(header, sizeof(header), "clos-desired");
-- 
2.24.1

