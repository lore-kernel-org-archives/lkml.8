Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10DAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2E5206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgCEWrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:47:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgCEWpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674597"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:45 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 02/27] tools/power/x86/intel-speed-select: Make target CPU optional for core-power info
Date:   Thu,  5 Mar 2020 14:45:13 -0800
Message-Id: <20200305224538.490864-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "-c" is a mandatory option for "core-power info" command. Make
this optional as this is a per package/die property. When not specified,
it will print info for every package/die.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 3f019f4f90df..c0de18e10cda 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1763,19 +1763,17 @@ static void dump_clos_info(int arg)
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel Speed Select Technology core power information\n");
-		fprintf(stderr, "\tSpecify targeted cpu id with [--cpu|-c]\n");
-		exit(0);
-	}
-
-	if (!max_target_cpus) {
-		fprintf(stderr,
-			"Invalid target cpu. Specify with [-c|--cpu]\n");
+		fprintf(stderr, "\t Optionally specify targeted cpu id with [--cpu|-c]\n");
 		exit(0);
 	}
 
 	isst_ctdp_display_information_start(outf);
-	for_each_online_target_cpu_in_set(get_clos_info_for_cpu, NULL,
-					  NULL, NULL, NULL);
+	if (max_target_cpus)
+		for_each_online_target_cpu_in_set(get_clos_info_for_cpu, NULL,
+						  NULL, NULL, NULL);
+	else
+		for_each_online_package_in_set(get_clos_info_for_cpu, NULL,
+					       NULL, NULL, NULL);
 	isst_ctdp_display_information_end(outf);
 
 }
-- 
2.24.1

