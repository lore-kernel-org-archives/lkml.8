Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F010C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3F206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCEWpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:5023 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgCEWps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674617"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:48 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 08/27] tools/power/x86/intel-speed-select: Helpful warning for missing kernel interface
Date:   Thu,  5 Mar 2020 14:45:19 -0800
Message-Id: <20200305224538.490864-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device file "/dev/isst_interface" is not present, instead of
failing on access, check at the start and print a helpful warning.

Here CLX platform is an exception, which doesn't depend on the device
file. So continue for CLX platform.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 4773970cda9b..9bf461e57a34 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -2408,6 +2408,8 @@ static void print_version(void)
 
 static void cmdline(int argc, char **argv)
 {
+	const char *pathname = "/dev/isst_interface";
+	FILE *fp;
 	int opt;
 	int option_index = 0;
 	int ret;
@@ -2423,6 +2425,28 @@ static void cmdline(int argc, char **argv)
 		{ 0, 0, 0, 0 }
 	};
 
+	if (geteuid() != 0) {
+		fprintf(stderr, "Must run as root\n");
+		exit(0);
+	}
+
+	ret = update_cpu_model();
+	if (ret)
+		err(-1, "Invalid CPU model (%d)\n", cpu_model);
+	printf("Intel(R) Speed Select Technology\n");
+	printf("Executing on CPU model:%d[0x%x]\n", cpu_model, cpu_model);
+
+	if (!is_clx_n_platform()) {
+		fp = fopen(pathname, "rb");
+		if (!fp) {
+			fprintf(stderr, "Intel speed select drivers are not loaded on this system.\n");
+			fprintf(stderr, "Verify that kernel config includes CONFIG_INTEL_SPEED_SELECT_INTERFACE.\n");
+			fprintf(stderr, "If the config is included then this is not a supported platform.\n");
+			exit(0);
+		}
+		fclose(fp);
+	}
+
 	progname = argv[0];
 	while ((opt = getopt_long_only(argc, argv, "+c:df:hio:v", long_options,
 				       &option_index)) != -1) {
@@ -2457,20 +2481,10 @@ static void cmdline(int argc, char **argv)
 		}
 	}
 
-	if (geteuid() != 0) {
-		fprintf(stderr, "Must run as root\n");
-		exit(0);
-	}
-
 	if (optind > (argc - 2)) {
 		fprintf(stderr, "Feature name and|or command not specified\n");
 		exit(0);
 	}
-	ret = update_cpu_model();
-	if (ret)
-		err(-1, "Invalid CPU model (%d)\n", cpu_model);
-	printf("Intel(R) Speed Select Technology\n");
-	printf("Executing on CPU model:%d[0x%x]\n", cpu_model, cpu_model);
 	set_max_cpu_num();
 	store_cpu_topology();
 	set_cpu_present_cpu_mask();
-- 
2.24.1

