Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE0AC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0BA2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBYpEukE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBTF2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:28:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44303 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBTF2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:28:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id g3so1313977pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TeeLY19U9Qm1lmufQWPD8xckoKI640rgPBtuJB+/FwY=;
        b=IBYpEukEu5qXnwTS6Ec0BfReGEwKVlKusOwzm6vhP/FdeZ8stntycaOaV9jmlBFFoz
         cqN+gacOLi6g2ZfmJiqIBRIWmv8W7YycCTQop2YGsDaUCv4IVPc6GEdLMOrTJgCyoxQE
         YXDedXb+4g+xaGDSXd6DKqE7rZ4VE32DA5DWzvfYsca5Nn7sqigbWYBpbZKWDTNb7cGt
         /XaA4FKAFeJi32VjEulICOEBuR0RAM9yuNZvvook85eoMjwpzlOCsNuA6YcPwXjIZFPz
         fv0LCvigJktvn7hbrRLWzrlD5m239vgl/D08CBnwQQFFdSHrPkSu93V+5ZYEdmqYixmQ
         RyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TeeLY19U9Qm1lmufQWPD8xckoKI640rgPBtuJB+/FwY=;
        b=JkCMQfyyd5R2BCaSXi6nbqkri04BDaTYHNPe2pweHIWo+Z36/hpGG3CZn6SiDZC+2Z
         XKBt6drb//nw8kGh/+D410WnWDpbIlJDeaagEs+ncDkGBuQvm9Rt9slJdriv+N6szFF5
         UpKn0JS0rxDo0VvWZoBbVOGJmdC24FmFxF5P8v/qtCKILSoCjiR1corXqoJHQx97gVEt
         Jh6vkzOMSaXls76lFblwtSN+bMqVDhJKR/NSTwT9qd3+9eqOUPtuvBcCCiv0cjUi3bjm
         xBytXrweIl4KbYgEJpRMOui8PtK1zB1b51vvBbvQZssRvR9OyEPTw+J/nMdSZxO/ChUX
         CRBQ==
X-Gm-Message-State: APjAAAVMyLuVamg+mrmg8trJUgSWFoQLdIgWVoDNT8MGH7+5FJK454Oa
        9MBkMZpGMpVXpHEDDWH3nHyMVg==
X-Google-Smtp-Source: APXvYqxijhrS/R7MxxozM41eyGA8ujSLdJr2BX3YsxobItuF0mWIzrh8U/3IImToeQS4R7H7rkQF0A==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr31759212pfc.111.1582176529518;
        Wed, 19 Feb 2020 21:28:49 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:28:48 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 6/9] perf cs-etm: Support callchain for instruction sample
Date:   Thu, 20 Feb 2020 13:26:58 +0800
Message-Id: <20200220052701.7754-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now CoreSight has supported the thread stack; based on the thread stack
we can synthesize call chain for the instruction sample; the call chain
can be injected by option '--itrace=g'.

Note the stack event must be processed prior to synthesizing instruction
sample; this can ensure the thread stack to push and pop synchronously
with instruction sample and the thread stack can be generated correctly
for instruction samples.  Add a comment for related info.

Before:

  # perf script --itrace=g16l64i100
            main  1579        100      instructions:  ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  [...]

After:

  # perf script --itrace=g16l64i100

  main  1579        100      instructions:
          ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
          ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1b08b650b090..d9c22c145307 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include "auxtrace.h"
+#include "callchain.h"
 #include "color.h"
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
@@ -74,6 +75,7 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
+	struct ip_callchain *chain;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -251,6 +253,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	if (!tidq->prev_packet)
 		goto out_free;
 
+	if (etm->synth_opts.callchain) {
+		size_t sz = sizeof(struct ip_callchain);
+
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (etm->synth_opts.callchain_sz + 1) * sizeof(u64);
+		tidq->chain = zalloc(sz);
+		if (!tidq->chain)
+			goto out_free;
+	}
+
 	if (etm->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
 
@@ -273,6 +285,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 out_free:
 	zfree(&tidq->last_branch_rb);
 	zfree(&tidq->last_branch);
+	zfree(&tidq->chain);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
 out:
@@ -561,6 +574,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
+		zfree(&tidq->chain);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
 		zfree(&tidq);
@@ -1147,7 +1161,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	int insn_len;
 	u64 from_ip, to_ip;
 
-	if (etm->synth_opts.thread_stack) {
+	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
 		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
 		to_ip = cs_etm__first_executed_instr(tidq->packet);
 
@@ -1203,6 +1217,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
+	if (etm->synth_opts.callchain) {
+		thread_stack__sample(tidq->thread, tidq->packet->cpu,
+				     tidq->chain,
+				     etm->synth_opts.callchain_sz + 1,
+				     sample.ip, etm->kernel_start);
+		sample.callchain = tidq->chain;
+	}
+
 	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
 
@@ -1385,6 +1407,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
 	if (etm->synth_opts.last_branch)
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
@@ -1426,6 +1450,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	    tidq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq, tidq);
 
+	/*
+	 * The stack event must be processed prior to synthesizing
+	 * instruction sample; this can ensure the instruction samples
+	 * to generate correct thread stack.
+	 */
 	if (tidq->prev_packet->last_instr_taken_branch)
 		cs_etm__add_stack_event(etmq, tidq);
 
@@ -2776,7 +2805,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
 		etm->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
@@ -2788,6 +2816,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		etm->branches_filter |= PERF_IP_FLAG_RETURN |
 					PERF_IP_FLAG_TRACE_BEGIN;
 
+	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
+		symbol_conf.use_callchain = true;
+		if (callchain_register_param(&callchain_param) < 0) {
+			symbol_conf.use_callchain = false;
+			etm->synth_opts.callchain = false;
+		}
+	}
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.17.1

