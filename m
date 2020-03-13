Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA24C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687C20751
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCMSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:35:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:28623 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgCMSeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506083"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:34 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 06/17] perf machine: Refine the function for LBR call stack reconstruction
Date:   Fri, 13 Mar 2020 11:33:08 -0700
Message-Id: <20200313183319.17739-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

LBR only collect the user call stack. To reconstruct a call stack, both
kernel call stack and user call stack are required. The function
resolve_lbr_callchain_sample() mix the kernel call stack and user call
stack.
Now, with the help of HW idx, perf tool can reconstruct a more complete
call stack by adding some user call stack from previous sample. However,
current implementation is hard to be extended to support it.

Current code path for resolve_lbr_callchain_sample()

  for (j = 0; j < mix_chain_nr; j++) {
       if (ORDER_CALLEE) {
             if (kernel callchain)
                  Fill callchain info
             else if (LBR callchain)
                  Fill callchain info
       } else {
             if (LBR callchain)
                  Fill callchain info
             else if (kernel callchain)
                  Fill callchain info
       }
       add_callchain_ip();
  }

With the patch,

  if (ORDER_CALLEE) {
       for (j = 0; j < NUM of kernel callchain) {
             Fill callchain info
             add_callchain_ip();
       }
       for (; j < mix_chain_nr) {
             Fill callchain info
             add_callchain_ip();
       }
  } else {
       for (; j < NUM of LBR callchain) {
             Fill callchain info
             add_callchain_ip();
       }
       for (j = 0; j < mix_chain_nr) {
             Fill callchain info
             add_callchain_ip();
       }
  }

No functional changes.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 111 ++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9021e5b6a2a9..cf2c97a6ef81 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2183,6 +2183,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	bool branch;
 	struct branch_flags *flags;
 	int mix_chain_nr;
+	int err;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2208,50 +2209,90 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	 */
 	mix_chain_nr = i + 1 + lbr_nr + 1;
 
-	for (j = 0; j < mix_chain_nr; j++) {
-		int err;
-
-		branch = false;
-		flags = NULL;
-
-		if (callchain_param.order == ORDER_CALLEE) {
-			if (j < i + 1)
-				ip = chain->ips[j];
-			else if (j > i + 1) {
-				k = j - i - 2;
-				ip = entries[k].from;
-				branch = true;
-				flags = &entries[k].flags;
-			} else {
-				ip = entries[0].to;
-				branch = true;
-				flags = &entries[0].flags;
-				branch_from = entries[0].from;
-			}
-		} else {
-			if (j < lbr_nr) {
-				k = lbr_nr - j - 1;
-				ip = entries[k].from;
-				branch = true;
-				flags = &entries[k].flags;
-			} else if (j > lbr_nr)
-				ip = chain->ips[i + 1 - (j - lbr_nr)];
-			else {
-				ip = entries[0].to;
-				branch = true;
-				flags = &entries[0].flags;
-				branch_from = entries[0].from;
-			}
+	if (callchain_param.order == ORDER_CALLEE) {
+		/* Add kernel ip */
+		for (j = 0; j < i + 1; j++) {
+			ip = chain->ips[j];
+			branch = false;
+			flags = NULL;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
 		}
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		branch = true;
+		flags = &entries[0].flags;
+		branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       branch, flags, NULL,
+				       branch_from);
+		if (err)
+			goto error;
 
+		/* Add LBR ip from entries.from one by one. */
+		for (j = i + 2; j < mix_chain_nr; j++) {
+			k = j - i - 2;
+			ip = entries[k].from;
+			branch = true;
+			flags = &entries[k].flags;
+
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
+	} else {
+		/* Add LBR ip from entries.from one by one. */
+		for (j = 0; j < lbr_nr; j++) {
+			k = lbr_nr - j - 1;
+			ip = entries[k].from;
+			branch = true;
+			flags = &entries[k].flags;
+
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
+
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		branch = true;
+		flags = &entries[0].flags;
+		branch_from = entries[0].from;
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       branch, flags, NULL,
 				       branch_from);
 		if (err)
-			return (err < 0) ? err : 0;
+			goto error;
+
+		/* Add kernel ip */
+		for (j = lbr_nr + 1; j < mix_chain_nr; j++) {
+			ip = chain->ips[i + 1 - (j - lbr_nr)];
+			branch = false;
+			flags = NULL;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
 	}
 	return 1;
+
+error:
+	return (err < 0) ? err : 0;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
-- 
2.17.1

