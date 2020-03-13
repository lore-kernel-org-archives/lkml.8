Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE6C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E020751
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCMSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:35:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:28623 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgCMSeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506089"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:36 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 07/17] perf machine: Factor out lbr_callchain_add_kernel_ip()
Date:   Fri, 13 Mar 2020 11:33:09 -0700
Message-Id: <20200313183319.17739-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Both caller and callee needs to add kernel ip to callchain.
Factor out lbr_callchain_add_kernel_ip() to improve code readability.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 67 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cf2c97a6ef81..ef26f28eacea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2159,6 +2159,40 @@ static int remove_loops(struct branch_entry *l, int nr,
 	return nr;
 }
 
+static int lbr_callchain_add_kernel_ip(struct thread *thread,
+				       struct callchain_cursor *cursor,
+				       struct perf_sample *sample,
+				       struct symbol **parent,
+				       struct addr_location *root_al,
+				       u64 branch_from,
+				       bool callee, int end)
+{
+	struct ip_callchain *chain = sample->callchain;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int err, i;
+
+	if (callee) {
+		for (i = 0; i < end + 1; i++) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, chain->ips[i],
+					       false, NULL, NULL, branch_from);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	for (i = end; i >= 0; i--) {
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, chain->ips[i],
+				       false, NULL, NULL, branch_from);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2211,17 +2245,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
-		for (j = 0; j < i + 1; j++) {
-			ip = chain->ips[j];
-			branch = false;
-			flags = NULL;
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, branch_from,
+						  true, i);
+		if (err)
+			goto error;
+
 		/* Add LBR ip from first entries.to */
 		ip = entries[0].to;
 		branch = true;
@@ -2277,17 +2306,11 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 			goto error;
 
 		/* Add kernel ip */
-		for (j = lbr_nr + 1; j < mix_chain_nr; j++) {
-			ip = chain->ips[i + 1 - (j - lbr_nr)];
-			branch = false;
-			flags = NULL;
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, branch_from,
+						  false, i);
+		if (err)
+			goto error;
 	}
 	return 1;
 
-- 
2.17.1

