Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF08C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DC5206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCEWpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:5023 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCEWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674620"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:48 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 09/27] tools/power/x86/intel-speed-select: Enhance help
Date:   Thu,  5 Mar 2020 14:45:20 -0800
Message-Id: <20200305224538.490864-10-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance help message which adds some example. The changes include:
- Print help when options are not recognized.
- For CLX, display only options which are applicable.
- Sort options in alphatical order.
- Disply help() instead of error:
"Feature name and|or command not specified"
- Remove duplicate display of
Intel(R) Speed Select Technology

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 9bf461e57a34..5302a552f87f 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -2368,11 +2368,18 @@ void process_command(int argc, char **argv,
 
 static void usage(void)
 {
-	printf("Intel(R) Speed Select Technology\n");
+	if (is_clx_n_platform()) {
+		fprintf(stderr, "\nThere is limited support of Intel Speed Select features on this platform.\n");
+		fprintf(stderr, "Everything is pre-configured using BIOS options, this tool can't enable any feature in the hardware.\n\n");
+	}
+
 	printf("\nUsage:\n");
 	printf("intel-speed-select [OPTIONS] FEATURE COMMAND COMMAND_ARGUMENTS\n");
-	printf("\nUse this tool to enumerate and control the Intel Speed Select Technology features,\n");
-	printf("\nFEATURE : [perf-profile|base-freq|turbo-freq|core-power]\n");
+	printf("\nUse this tool to enumerate and control the Intel Speed Select Technology features:\n");
+	if (is_clx_n_platform())
+		printf("\nFEATURE : [perf-profile|base-freq]\n");
+	else
+		printf("\nFEATURE : [perf-profile|base-freq|turbo-freq|core-power]\n");
 	printf("\nFor help on each feature, use -h|--help\n");
 	printf("\tFor example:  intel-speed-select perf-profile -h\n");
 
@@ -2385,17 +2392,29 @@ static void usage(void)
 	printf("\t\tDefault: Die scoped for all dies in the system with multiple dies/package\n");
 	printf("\t\t\t Or Package scoped for all Packages when each package contains one die\n");
 	printf("\t[-d|--debug] : Debug mode\n");
+	printf("\t[-f|--format] : output format [json|text]. Default: text\n");
 	printf("\t[-h|--help] : Print help\n");
 	printf("\t[-i|--info] : Print platform information\n");
 	printf("\t[-o|--out] : Output file\n");
 	printf("\t\t\tDefault : stderr\n");
-	printf("\t[-f|--format] : output format [json|text]. Default: text\n");
 	printf("\t[-v|--version] : Print version\n");
 
 	printf("\nResult format\n");
 	printf("\tResult display uses a common format for each command:\n");
 	printf("\tResults are formatted in text/JSON with\n");
 	printf("\t\tPackage, Die, CPU, and command specific results.\n");
+
+	printf("\nExamples\n");
+	printf("\tTo get platform information:\n");
+	printf("\t\tintel-speed-select --info\n");
+	printf("\tTo get full perf-profile information dump:\n");
+	printf("\t\tintel-speed-select perf-profile info\n");
+	printf("\tTo get full base-freq information dump:\n");
+	printf("\t\tintel-speed-select base-freq info -l 0\n");
+	if (!is_clx_n_platform()) {
+		printf("\tTo get full turbo-freq information dump:\n");
+		printf("\t\tintel-speed-select turbo-freq info -l 0\n");
+	}
 	exit(1);
 }
 
@@ -2482,7 +2501,7 @@ static void cmdline(int argc, char **argv)
 	}
 
 	if (optind > (argc - 2)) {
-		fprintf(stderr, "Feature name and|or command not specified\n");
+		usage();
 		exit(0);
 	}
 	set_max_cpu_num();
-- 
2.24.1

