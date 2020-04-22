Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91045C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799C621D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgDVMXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728304AbgDVMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6459C03C1A8;
        Wed, 22 Apr 2020 05:17:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJX-0007e4-Cm; Wed, 22 Apr 2020 14:17:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 094841C02FC;
        Wed, 22 Apr 2020 14:17:15 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:14 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: Factor out lbr_callchain_add_kernel_ip()
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
In-Reply-To: <20200319202517.23423-8-kan.liang@linux.intel.com>
References: <20200319202517.23423-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783453.28353.8426037370722698037.tip-bot2@tip-bot2>
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

Commit-ID:     dd3e249a0c0ad88098922803b149c788bb364c23
Gitweb:        https://git.kernel.org/tip/dd3e249a0c0ad88098922803b149c788bb364c23
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:07 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf machine: Factor out lbr_callchain_add_kernel_ip()

Both caller and callee needs to add kernel ip to callchain.  Factor out
lbr_callchain_add_kernel_ip() to improve code readability.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-8-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 67 +++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0da540e..a7f75fd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2190,6 +2190,40 @@ static int remove_loops(struct branch_entry *l, int nr,
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
@@ -2242,17 +2276,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 
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
@@ -2308,17 +2337,11 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
 
