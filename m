Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B872071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383841;
	bh=mK/jtIU2H36LkD2SMmTlMnuQ9BkCxfEfsnrcSSvfuVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCUhFsEilgVt1rOezfau3iYoqG+6QjzoSo8QnPQ4592kHu1zx/CFfJpcJ9pSoGcpH
	 BScT4A7hg21EtJicdsGPbIBPePIzd8P2QAWZ2CKP3NhQEYKtVbbRMmYJII0Zr/dP2r
	 mro+hPDPNLCL+L9TB9+ahU4QopsRJH5x0BdIw6L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDTL5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgDTL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B5F20724;
        Mon, 20 Apr 2020 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383838;
        bh=mK/jtIU2H36LkD2SMmTlMnuQ9BkCxfEfsnrcSSvfuVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIcQlCWfxQ1hRl8AKjtRpI0dbNjFL/cb1Blq+SULWQS9n7CxVpFVnFnFVHUTWd8DC
         HNF6mDJftEcWaOwq9cBXaAAXJBsZM1FgvjaHhc5+ORaJPCT4QHs3mH3l/W/mB3a9kE
         yGgPJPoYiR4zUCXSA11cTpzXsrT3I/dkBJxo+ric=
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
Subject: [PATCH 52/60] perf thread: Add a knob for LBR stitch approach
Date:   Mon, 20 Apr 2020 08:53:08 -0300
Message-Id: <20200420115316.18781-53-acme@kernel.org>
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

The LBR stitch approach should be disabled by default. Because

- The stitching approach base on LBR call stack technology. The known
  limitations of LBR call stack technology still apply to the approach,
  e.g. Exception handing such as setjmp/longjmp will have calls/returns
  not match.

- This approach is not foolproof. There can be cases where it creates
  incorrect call stacks from incorrect matches. There is no attempt to
  validate any matches in another way.

The 'lbr_stitch_enable' is used to indicate whether enable LBR stitch
approach, which is disabled by default. The following patch will
introduce a new option for each tools to enable the LBR stitch
approach.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-10-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 1 +
 tools/perf/util/thread.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 28b719388028..1f080db23615 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -47,6 +47,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->tid = tid;
 		thread->ppid = -1;
 		thread->cpu = -1;
+		thread->lbr_stitch_enable = false;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
 		init_rwsem(&thread->namespaces_lock);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 20b96b5d1f15..95294050cff2 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -46,6 +46,9 @@ struct thread {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+
+	/* LBR call stack stitch */
+	bool			lbr_stitch_enable;
 };
 
 struct machine;
-- 
2.21.1

