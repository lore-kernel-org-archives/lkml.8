Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F07C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7ED206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgAaFpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:45:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:30568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgAaFpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:45:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 21:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,384,1574150400"; 
   d="scan'208";a="253240732"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2020 21:45:21 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] tools/power/x86/intel-speed-select: Avoid duplicate names for json parsing
Date:   Thu, 30 Jan 2020 21:45:18 -0800
Message-Id: <20200131054518.1644519-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131054518.1644519-1-srinivas.pandruvada@linux.intel.com>
References: <20200131054518.1644519-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the command
"intel-speed-select perf-profile info":

There are two instances of “speed-select-turbo-freq” underneath
“perf-profile-level-0” for each package. When we load the output into
python with json.load(), the second instance overwrites the first.

Result is that we can only access:
"speed-select-turbo-freq": {
            "bucket-0": {
              "high-priority-cores-count": "2",
              "high-priority-max-frequency(MHz)": "3000",
              "high-priority-max-avx2-frequency(MHz)": "2800",
              "high-priority-max-avx512-frequency(MHz)": "2600"
            },
Because it is a duplicate of "speed-select-turbo-freq": "disabled"
Same is true for "speed-select-base-freq".

To avoid this add "-properties" suffix for the second instance to
differentiate.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 4fb0c1d49d64..3d70be2a9f61 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -178,7 +178,7 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 	char header[256];
 	char value[256];
 
-	snprintf(header, sizeof(header), "speed-select-base-freq");
+	snprintf(header, sizeof(header), "speed-select-base-freq-properties");
 	format_and_print(outf, disp_level, header, NULL);
 
 	snprintf(header, sizeof(header), "high-priority-base-frequency(MHz)");
@@ -224,7 +224,7 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 	char value[256];
 	int j;
 
-	snprintf(header, sizeof(header), "speed-select-turbo-freq");
+	snprintf(header, sizeof(header), "speed-select-turbo-freq-properties");
 	format_and_print(outf, base_level, header, NULL);
 	for (j = 0; j < ISST_FACT_MAX_BUCKETS; ++j) {
 		if (fact_bucket != 0xff && fact_bucket != j)
-- 
2.24.1

