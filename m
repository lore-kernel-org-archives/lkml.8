Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21057C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E5C20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383833;
	bh=oJKe5r3enYIHI/9JXAP7ILpEmBjxMZdI1Za4GyV6cIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HM/j7Yni4BBOnTZUhguC5UfvyS0FYISFx8AWEF0pd2VQQ3T7tQUMlm55qG/fCqMyj
	 kC1T39OWwv6H3C06mGGcN1lhDuAcVpELuXmlKWSG38OSQb3d96XuMva8fr9Bz1Q0lJ
	 sLCnyIVAp6taQyaOZ+wJFnJI7yu4Ldq+zIosLboU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgDTL5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgDTL5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FDD21927;
        Mon, 20 Apr 2020 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383828;
        bh=oJKe5r3enYIHI/9JXAP7ILpEmBjxMZdI1Za4GyV6cIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbmCNCEqUmUvm7AtbV814CgOsYbAF24CIXqbOZsobDzzt7s0ZdoozIfdYRvr/JPB/
         ArqnUATGkVHAW5JtwoGHWp0VrEdUxCVmRCEcUsRms3giGEIH1MuRw/a8bo0u2y3aAs
         h3VZdj5++4woR+9xvvEWWNHBiTN55FoH1Rzbl/L8=
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
Subject: [PATCH 50/60] perf machine: Factor out lbr_callchain_add_kernel_ip()
Date:   Mon, 20 Apr 2020 08:53:06 -0300
Message-Id: <20200420115316.18781-51-acme@kernel.org>
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
 tools/perf/util/machine.c | 67 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0da540e6f803..a7f75fd43b0f 100644
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
 
-- 
2.21.1

