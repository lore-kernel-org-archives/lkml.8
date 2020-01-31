Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA6C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3F206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgAaFpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:45:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:30568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgAaFpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:45:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 21:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,384,1574150400"; 
   d="scan'208";a="253240731"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2020 21:45:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] tools/power/x86/intel-speed-select: Fix display for turbo-freq auto mode
Date:   Thu, 30 Jan 2020 21:45:17 -0800
Message-Id: <20200131054518.1644519-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mailbox command for the turbo-freq enable fails, then don't display
result for auto-mode. When turbo-freq enable fails, there is no point
to set CPU priorities.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c74b776adc61..7893ad2c34ab 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -43,6 +43,7 @@ static int out_format_json;
 static int cmd_help;
 static int force_online_offline;
 static int auto_mode;
+static int fact_enable_fail;
 
 /* clos related */
 static int current_clos = -1;
@@ -1581,6 +1582,8 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 disp_results:
 	if (status) {
 		isst_display_result(cpu, outf, "turbo-freq", "enable", ret);
+		if (ret)
+			fact_enable_fail = ret;
 	} else {
 		/* Since we modified TRL during Fact enable, restore it */
 		isst_set_trl_from_current_tdp(cpu, fact_trl);
@@ -1622,7 +1625,7 @@ static void set_fact_enable(int arg)
 					       NULL, &enable);
 	isst_ctdp_display_information_end(outf);
 
-	if (enable && auto_mode) {
+	if (!fact_enable_fail && enable && auto_mode) {
 		/*
 		 * When we adjust CLOS param, we have to set for siblings also.
 		 * So for the each user specified CPU, also add the sibling
-- 
2.24.1

