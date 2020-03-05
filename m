Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31157C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1D5206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCEWqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:5039 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgCEWpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674658"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:54 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 22/27] tools/power/x86/intel-speed-select: Improve CLX commands
Date:   Thu,  5 Mar 2020 14:45:33 -0800
Message-Id: <20200305224538.490864-23-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLX doesn't have capability to change the feature in the hardware, but
this acts as "--auto | -a" option. So even if user didn't specify the
option, use this as --auto | -a to set cpufreq scaling frequency limits.

Also remove perror with debug_printf as they don't bring any value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 386791aaeca1..a44ec2f76f52 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1162,7 +1162,7 @@ static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 	ret = clx_n_config(cpu);
 	if (ret) {
-		perror("isst_get_process_ctdp");
+		debug_printf("clx_n_config failed");
 	} else {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
 		struct isst_pbf_info *pbf_info;
@@ -1419,7 +1419,7 @@ static int set_clx_pbf_cpufreq_scaling_min_max(int cpu)
 
 	ret = clx_n_config(cpu);
 	if (ret) {
-		perror("set_clx_pbf_cpufreq_scaling_min_max");
+		debug_printf("cpufreq_scaling_min_max failed for CLX");
 		return ret;
 	}
 
@@ -1635,17 +1635,13 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int status = *(int *)arg4;
 
 	if (is_clx_n_platform()) {
+		ret = 0;
 		if (status) {
-			ret = 0;
-			if (auto_mode)
-				set_clx_pbf_cpufreq_scaling_min_max(cpu);
+			set_clx_pbf_cpufreq_scaling_min_max(cpu);
 
 		} else {
-			ret = -1;
-			if (auto_mode) {
-				set_scaling_max_to_cpuinfo_max(cpu);
-				set_scaling_min_to_cpuinfo_min(cpu);
-			}
+			set_scaling_max_to_cpuinfo_max(cpu);
+			set_scaling_min_to_cpuinfo_min(cpu);
 		}
 		goto disp_result;
 	}
-- 
2.24.1

