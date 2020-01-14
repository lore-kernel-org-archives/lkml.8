Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A58C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A39224670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANTW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:22:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:48040 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="423259150"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 11:22:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/5] tools/power/x86/intel-speed-select: Fix result display for turbo-freq auto mode
Date:   Tue, 14 Jan 2020 11:22:15 -0800
Message-Id: <20200114192217.580364-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
References: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The turbo-freq enable with auto mode, prints result for the last possible
CPU, which is not correct when either CPU is not present or user wants
command to be limited to a single die/package. For example, in the
below command user wants to limit to die/package 0, but the
"turbo-freq --auto" result is displayed using the other package.

$ sudo intel-speed-select -c 0 turbo-freq enable -a
Intel(R) Speed Select Technology
 package-0
  die-0
    cpu-0
      turbo-freq
        enable:success
 package--1
  die-0
    cpu-31
      turbo-freq --auto
        enable:success

Since we do have to traverse all CPUs, don't display CPU info for
"turbo-freq --auto", as we already displayed the result for
turbo-freq enable with the CPU information.

With the fix, the same command results in:

$ sudo intel-speed-select -c 0 turbo-freq enable -a
Intel(R) Speed Select Technology
package-0
  die-0
    cpu-0
      turbo-freq
        enable:success
      turbo-freq --auto
        enable:success

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c |  2 +-
 .../power/x86/intel-speed-select/isst-display.c  | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 944183f9ed5a..e22a694e6410 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1638,7 +1638,7 @@ static void set_fact_enable(int arg)
 			if (ret)
 				goto error_disp;
 		}
-		isst_display_result(i, outf, "turbo-freq --auto", "enable", 0);
+		isst_display_result(-1, outf, "turbo-freq --auto", "enable", 0);
 	}
 
 	return;
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 1d1439036c12..4fb0c1d49d64 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -645,13 +645,15 @@ void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 	char header[256];
 	char value[256];
 
-	snprintf(header, sizeof(header), "package-%d",
-		 get_physical_package_id(cpu));
-	format_and_print(outf, 1, header, NULL);
-	snprintf(header, sizeof(header), "die-%d", get_physical_die_id(cpu));
-	format_and_print(outf, 2, header, NULL);
-	snprintf(header, sizeof(header), "cpu-%d", cpu);
-	format_and_print(outf, 3, header, NULL);
+	if (cpu >= 0) {
+		snprintf(header, sizeof(header), "package-%d",
+			 get_physical_package_id(cpu));
+		format_and_print(outf, 1, header, NULL);
+		snprintf(header, sizeof(header), "die-%d", get_physical_die_id(cpu));
+		format_and_print(outf, 2, header, NULL);
+		snprintf(header, sizeof(header), "cpu-%d", cpu);
+		format_and_print(outf, 3, header, NULL);
+	}
 	snprintf(header, sizeof(header), "%s", feature);
 	format_and_print(outf, 4, header, NULL);
 	snprintf(header, sizeof(header), "%s", cmd);
-- 
2.24.1

