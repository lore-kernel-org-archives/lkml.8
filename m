Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D835FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB020206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEWpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674596"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 01/27] tools/power/x86/intel-speed-select: Warn for invalid package id
Date:   Thu,  5 Mar 2020 14:45:12 -0800
Message-Id: <20200305224538.490864-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU is offline, we can't get package id. So print error for this
and don't use output.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c922cfd7ba50..3f019f4f90df 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -261,6 +261,10 @@ static void for_each_online_package_in_set(void (*callback)(int, void *, void *,
 		if (die_id < 0)
 			die_id = 0;
 		pkg_id = get_physical_package_id(i);
+		if (pkg_id < 0) {
+			fprintf(stderr, "Failed to get package id, CPU %d may be offline\n", i);
+			continue;
+		}
 		/* Create an unique id for package, die combination to store */
 		pkg_id = (MAX_PACKAGE_COUNT * pkg_id + die_id);
 
@@ -362,6 +366,10 @@ static void set_cpu_present_cpu_mask(void)
 				die_id = 0;
 
 			pkg_id = get_physical_package_id(i);
+			if (pkg_id < 0) {
+				fprintf(stderr, "Failed to get package id, CPU %d may be offline\n", i);
+				continue;
+			}
 			if (pkg_id < MAX_PACKAGE_COUNT &&
 			    die_id < MAX_DIE_PER_PACKAGE) {
 				int core_id = get_physical_core_id(i);
-- 
2.24.1

