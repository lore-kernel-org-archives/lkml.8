Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC005C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07C32098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgDVMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728561AbgDVMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A5C03C1AA;
        Wed, 22 Apr 2020 05:17:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJc-0007ej-Tv; Wed, 22 Apr 2020 14:17:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 814111C0450;
        Wed, 22 Apr 2020 14:17:15 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:15 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: Refine the function for LBR call stack
 reconstruction
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319202517.23423-7-kan.liang@linux.intel.com>
References: <20200319202517.23423-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783514.28353.13696059456680339171.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e48b8311ca4538ec716196a1625812b045999f21
Gitweb:        https://git.kernel.org/tip/e48b8311ca4538ec716196a1625812b045999f21
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:06 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf machine: Refine the function for LBR call stack reconstruction

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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-7-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 111 +++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index be1bd92..0da540e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2214,6 +2214,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	bool branch;
 	struct branch_flags *flags;
 	int mix_chain_nr;
+	int err;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2239,50 +2240,90 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
