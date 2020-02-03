Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731AC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22504206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UL8rKCDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBCCIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:08:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36617 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBCCIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:08:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so6954405pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zLBjuDshYyKGh29JrHXXA2RwDnDnZ6HsXu4YPesaNrg=;
        b=UL8rKCDZGk+zegMWKjyJtACT3K8kOy1pdAvhJdEIwOzmwX/39OQknYQ/fko0L0H6bq
         VxJRKcShD/OZ6Y6JTNGivaUlZGep0VhWRB+MqH8PpKIemtUVtEx0nz90k7lSEjS0K6X3
         TWcCYXgxTdnXaQdNEx68oQQCM4UJ2DATrM6Rp4Pk0IBIy1ALsYRpVrQF6yTP2zpGpdzv
         ZxH42Afv/rPNeOgosWgqSjYpDPhI8h81IQJ+iu7P3l4wEXAmD4wbcZMX8IU6F51dAv0u
         g/IxzuPnKJrIR3AxDnxk9AFzHgaztyGc/wPNbmNprXVP7JJKSfLpusgREiScUAL8nz2d
         IqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zLBjuDshYyKGh29JrHXXA2RwDnDnZ6HsXu4YPesaNrg=;
        b=WV5Zd1TG+FBYIdj10I12sQNOcrXSYcJsWPo0h3Y8SKtG4GXU/ADPvGB2T/o+avFFtr
         ndfc2xkdb9uUxSU8iJorT4hzkA3XSsmhcpHj0rlgCunxPGTBKju/UB2+H8xAmMDee/Ia
         fnuNwXBaSVpYXqIiKVNL0PO+iQ4W7zVDEgRRrelXfVBGEYxv2opY0EjJZKlkzCpt5nwB
         RjaF7mGUGn6w37lz6GiKcGg8KoQhuHAITtou8RuOKiqPha1G9XsvapnN0XupO74MMrJh
         iD6c750JxvYbhtsuto5itHMQ4BejGNC5v+TyscPzxMOm09G8PKsZgMYTkNfFSUSeZgbj
         XPZQ==
X-Gm-Message-State: APjAAAXXhBPE1SZBp/hf0HwX216Amm5hx8EY3q42NPeDF1/+sooIEm/r
        5Et5R+HRkA/sCMH5BRlAOEqBaw==
X-Google-Smtp-Source: APXvYqw2Ye52QXrHtjtwWigL5rnaQVrweMI9RHuDrOefS0T6F8vVwdD5YsgCGq4XwL6sNDYNa4Bmww==
X-Received: by 2002:a63:7419:: with SMTP id p25mr6552388pgc.430.1580695689643;
        Sun, 02 Feb 2020 18:08:09 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:08:09 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/5] perf cs-etm: Support callchain for instruction sample
Date:   Mon,  3 Feb 2020 10:07:15 +0800
Message-Id: <20200203020716.31832-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203020716.31832-1-leo.yan@linaro.org>
References: <20200203020716.31832-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now CoreSight has supported the thread stack; based on the thread stack
we can synthesize call chain for the instruction sample; the call chain
can be injected by option '--itrace=g'.

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
 tools/perf/util/cs-etm.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 617facef24cc..8f805657658d 100644
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
@@ -544,6 +557,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
+		zfree(&tidq->chain);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
 		zfree(&tidq);
@@ -1126,7 +1140,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	int insn_len;
 	u64 from_ip, to_ip;
 
-	if (etm->synth_opts.thread_stack) {
+	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
 		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
 		to_ip = cs_etm__first_executed_instr(tidq->packet);
 
@@ -1182,6 +1196,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
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
 
@@ -1364,6 +1386,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
 	if (etm->synth_opts.last_branch)
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
@@ -2733,7 +2757,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
 		etm->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
@@ -2745,6 +2768,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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

