Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C5C206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCEWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:5026 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCEWpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674630"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:50 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 13/27] tools/power/x86/intel-speed-select: Check feature status first
Date:   Thu,  5 Mar 2020 14:45:24 -0800
Message-Id: <20200305224538.490864-14-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before looking for information about the base-freq or turbo-freq details,
first check if the feature is supported at that level. If not print error
and return.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-core.c  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 2f3921cd87f3..732d9a5eacf1 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -394,9 +394,19 @@ int isst_set_tdp_level(int cpu, int tdp_level)
 
 int isst_get_pbf_info(int cpu, int level, struct isst_pbf_info *pbf_info)
 {
+	struct isst_pkg_ctdp_level_info ctdp_level;
 	int i, ret, core_cnt, max;
 	unsigned int req, resp;
 
+	ret = isst_get_ctdp_control(cpu, level, &ctdp_level);
+	if (ret)
+		return ret;
+
+	if (!ctdp_level.pbf_support) {
+		fprintf(stderr, "base-freq feature is not present at this level:%d\n", level);
+		return -1;
+	}
+
 	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
 
 	core_cnt = get_core_count(get_physical_package_id(cpu), get_physical_die_id(cpu));
@@ -492,6 +502,10 @@ int isst_set_pbf_fact_status(int cpu, int pbf, int enable)
 		else
 			req &= ~BIT(17);
 	} else {
+
+		if (enable && !ctdp_level.sst_cp_enabled)
+			fprintf(stderr, "Make sure to execute before: core-power enable\n");
+
 		if (ctdp_level.pbf_enabled)
 			req = BIT(17);
 
@@ -579,9 +593,19 @@ int isst_get_fact_bucket_info(int cpu, int level,
 
 int isst_get_fact_info(int cpu, int level, struct isst_fact_info *fact_info)
 {
+	struct isst_pkg_ctdp_level_info ctdp_level;
 	unsigned int resp;
 	int ret;
 
+	ret = isst_get_ctdp_control(cpu, level, &ctdp_level);
+	if (ret)
+		return ret;
+
+	if (!ctdp_level.fact_support) {
+		fprintf(stderr, "turbo-freq feature is not present at this level:%d\n", level);
+		return -1;
+	}
+
 	ret = isst_send_mbox_command(cpu, CONFIG_TDP,
 				     CONFIG_TDP_GET_FACT_LP_CLIPPING_RATIO, 0,
 				     level, &resp);
-- 
2.24.1

