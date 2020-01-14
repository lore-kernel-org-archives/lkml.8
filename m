Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0302C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A034F24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgANTWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:22:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:48042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgANTWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="423259154"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 11:22:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/5] tools/power/x86/intel-speed-select: Change the order for clos disable
Date:   Tue, 14 Jan 2020 11:22:16 -0800
Message-Id: <20200114192217.580364-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
References: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In turbo-freq or base-freq auto mode, for disable, first disable the feature and
then disable clos.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index e22a694e6410..84baba34d311 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1384,14 +1384,10 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		goto disp_result;
 	}
 
-	if (auto_mode) {
-		if (status) {
-			ret = set_pbf_core_power(cpu);
-			if (ret)
-				goto disp_result;
-		} else {
-			isst_pm_qos_config(cpu, 0, 0);
-		}
+	if (auto_mode && status) {
+		ret = set_pbf_core_power(cpu);
+		if (ret)
+			goto disp_result;
 	}
 
 	ret = isst_set_pbf_fact_status(cpu, 1, status);
@@ -1408,6 +1404,9 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		}
 	}
 
+	if (auto_mode && !status)
+		isst_pm_qos_config(cpu, 0, 0);
+
 disp_result:
 	if (status)
 		isst_display_result(cpu, outf, "base-freq", "enable",
@@ -1496,14 +1495,10 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
-	if (auto_mode) {
-		if (status) {
-			ret = isst_pm_qos_config(cpu, 1, 1);
-			if (ret)
-				goto disp_results;
-		} else {
-			isst_pm_qos_config(cpu, 0, 0);
-		}
+	if (auto_mode && status) {
+		ret = isst_pm_qos_config(cpu, 1, 1);
+		if (ret)
+			goto disp_results;
 	}
 
 	ret = isst_set_pbf_fact_status(cpu, 0, status);
@@ -1524,6 +1519,9 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 			ret = isst_set_trl(cpu, fact_trl);
 		if (ret && auto_mode)
 			isst_pm_qos_config(cpu, 0, 0);
+	} else {
+		if (auto_mode)
+			isst_pm_qos_config(cpu, 0, 0);
 	}
 
 disp_results:
-- 
2.24.1

