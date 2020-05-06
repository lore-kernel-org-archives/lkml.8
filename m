Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634DC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA4B215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778717;
	bh=wt5fOGYASbe0J3VL5I1WKasVyX85Pvev1JaIELOTVek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hx37+3TIW0rmrKj0TJcOFuHZmIS39G3ryA9+LdpUvcFQCtgPSEFpWDRf3gK0nb3+l
	 ozPGzbhpflcbqm8RXZZZcNND91Kz/LwA8QdMvQYe/xi6Kd2Ma4jvbrqkD8zg1Gy2HJ
	 R8sWdBKOkcX/4vwAPmSsSi18ke7LuBwyp3RGJPmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgEFPZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgEFPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19C21582;
        Wed,  6 May 2020 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778711;
        bh=wt5fOGYASbe0J3VL5I1WKasVyX85Pvev1JaIELOTVek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHKIEopY6wx/yTEXbdSmbj9nBrxKHYRohldVWWKYW0P3JOlfdWKY3+ZTsBi8uAcl2
         hXDMJzBY3v68hK2Ql3krgjMoNBuJcjeVSxlXU9w0a9weGSvZ+aXSinLjkpYOoOixy2
         xjvklXMrlDbVo3ftorqcjjp1B2kQZW04nFTqCBOg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/91] perf intel-pt: Consolidate thread-stack use condition
Date:   Wed,  6 May 2020 12:21:43 -0300
Message-Id: <20200506152234.21977-41-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The components of the condition do not change, so consolidate them in
one variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bdb84470f7d0..b3c45276b664 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -69,6 +69,7 @@ struct intel_pt {
 	bool est_tsc;
 	bool sync_switch;
 	bool mispred_all;
+	bool use_thread_stack;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -2029,8 +2030,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (!(state->type & INTEL_PT_BRANCH))
 		return 0;
 
-	if (pt->synth_opts.callchain || pt->synth_opts.add_callchain ||
-	    pt->synth_opts.thread_stack)
+	if (pt->use_thread_stack)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
 				    state->trace_nr, true, 0, 0);
@@ -3441,6 +3441,10 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
+	pt->use_thread_stack = pt->synth_opts.callchain ||
+			       pt->synth_opts.add_callchain ||
+			       pt->synth_opts.thread_stack;
+
 	err = intel_pt_synth_events(pt, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.21.1

