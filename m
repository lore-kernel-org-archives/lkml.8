Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA06C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A3F21744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383829;
	bh=sEL+5jzjb+p4Og2B/stXdQpoK2rzusgjEidnB5s45d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OztjKKqpJFfFsbCv88M/HYyRIUnQ/16RnO+xNpSbM0daFQvTl3M2DpyzC2WoKP2UF
	 0XKT1JM4kvcf1dh7wbxMzxwOAuxymqSZOEbGkiZbDSBIC607317/t4RIrmsYTu9BAe
	 8UN8q95NMUvwNqi3vZXn38fXPwCGsNjhct0LwEy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDTL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgDTL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F61D20857;
        Mon, 20 Apr 2020 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383823;
        bh=sEL+5jzjb+p4Og2B/stXdQpoK2rzusgjEidnB5s45d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1S4f1RTgHK44k/eoOcKAWoOt7N/mds5IUGGrDR/XbLPSRSOb40FMSoLCntYKvd6J
         EAn9IngsRYbPx/saQxH17xH0rys0NFKp9A7XKwC7JsqfefcDFIXpTKDZe/TLnnqgkp
         0SgMnMFXWmeUu7ubyBGbJcFs+cQu8wGPlStpLpUc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/60] perf machine: Refine the function for LBR call stack reconstruction
Date:   Mon, 20 Apr 2020 08:53:05 -0300
Message-Id: <20200420115316.18781-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/util/machine.c | 111 ++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index be1bd9277471..0da540e6f803 100644
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
-- 
2.21.1

