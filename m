Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10638C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160920661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujZpTeGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgBCCIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:08:21 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56013 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBCCIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:08:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so5588161pjz.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPbiPKqsfybk4TJ/Ddjt4sC7QShATZuIq5L3KhpJZK4=;
        b=ujZpTeGUmpJQDH+3gYR30Gjm1s5dT4duHB5zkpWarUSFlZ5yCodTYDifAZS+VjnQjD
         /rgkqGFGA79XzDqJqoQiVWoXgbXiVyLxlhJss+z6eW24E52kZ4igeHY4BcSBIKgF8SeJ
         hmO+dPwV/MxbFMGyAZivKIQXDAkpy2dNZcAZHJiwgSxP1x0Tq3vpTcRhsqfjgHzPzCY7
         FamBGbRRb4GZoB1IXaQ6o8qIaIqCCqIFpD8HHUAJfF8oUzDx3qAxxkqWtBcnDYMAq0oC
         zdWrO5eYSVRAYuHHgaa3LplEwuRBYVjb3GXf0ClkalCq3ZfHyIygCj0YV0d1tNjuFTQt
         eYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPbiPKqsfybk4TJ/Ddjt4sC7QShATZuIq5L3KhpJZK4=;
        b=ZNVHNRMbj78dSHpSw27IP2RAlGOZrHZ8OGd1gGycQgEGJ9+eUvJnEAm0qcG0NtV+8v
         vw0gn1sCOHGnAfZIqjBmlKB1iqapyzbvk6KtSkPYZJ2e7/GivW3WzP92mJeA0uxES+Cs
         Ty4lD5p8WM0ktJzH6ob3fIF40PfiP/R/OUiX14bYO7K/r9FcL/Amw9KOALce/Zb8O891
         s+iMU2bXVfhdmegO6r8INpJQTlY5d+cBk66WybIkNZ+cQZJ0+Ir6lfiUL+w0T19Wbs2k
         ZKATp3yRyT2AkTuBL836EK+Sgf4gpNku3tWfTd9UEILXThr5YNUnSLd/TNq7wSaTduhB
         gfjg==
X-Gm-Message-State: APjAAAXIOhsgy0Dqjc89F68i2svoTHe63i88IovvyIQql2NQEzuwazce
        /u4FiTUTtJ3RwHEn/ErDrpx7rw==
X-Google-Smtp-Source: APXvYqxc3AdfyGgoc/2ApkJH3zo4OwtIcOVIs/xUH6ZnND0aXXMcJrJ4Uu5OtqimlUBe4cofQ4IkhQ==
X-Received: by 2002:a17:90a:f317:: with SMTP id ca23mr16157184pjb.20.1580695697054;
        Sun, 02 Feb 2020 18:08:17 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:08:16 -0800 (PST)
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
Subject: [PATCH v4 5/5] perf cs-etm: Synchronize instruction sample with the thread stack
Date:   Mon,  3 Feb 2020 10:07:16 +0800
Message-Id: <20200203020716.31832-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203020716.31832-1-leo.yan@linaro.org>
References: <20200203020716.31832-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesized flow use 'tidq->packet' for instruction samples; on the
other hand, 'tidp->prev_packet' is used to generate the thread stack and
the branch samples, this results in the instruction samples using one
packet ahead than thread stack and branch samples ('tidp->prev_packet'
vs 'tidq->packet').

This leads to an instruction's callchain error as shows in below
example:

  main  1579        100      instructions:
  	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  	ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
  	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
  	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
  	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
  	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
  	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

In the callchain log, for the two continuous lines the up line contains
one child function info and the followed line contains the caller
function info, and so forth.  So the first two lines are:

  perf_event_update_userpage+0x4c  => the sampled instruction
  perf_event_update_userpage+0x48  => the parent function's calling

The child function and parent function both are the same function
perf_event_update_userpage(), but this isn't a recursive function, thus
the sequence for perf_event_update_userpage() calling itself shouldn't
never happen.  This callchain error is caused by the instruction sample
using an ahead packet than the thread stack, the thread stack is deferred
to process the new packet and misses to pop stack if it is just a return
packet.

To fix this issue, we can simply change to use 'tidq->prev_packet' to
generate the instruction samples, this allows the thread stack to push
and pop synchronously with instruction sample.  Finally, the callchain
can be displayed correctly as below:

  main  1579        100      instructions:
	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8f805657658d..410e40ce19f2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1414,7 +1414,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_packet *tmp;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
-	u64 instrs_executed = tidq->packet->instr_count;
+	u64 instrs_executed = tidq->prev_packet->instr_count;
 
 	tidq->period_instructions += instrs_executed;
 
@@ -1505,7 +1505,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			 * instruction)
 			 */
 			addr = cs_etm__instr_addr(etmq, trace_chan_id,
-						  tidq->packet, offset - 1);
+						  tidq->prev_packet,
+						  offset - 1);
 			ret = cs_etm__synth_instruction_sample(
 				etmq, tidq, addr,
 				etm->instructions_sample_period);
@@ -1525,7 +1526,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			 * instruction)
 			 */
 			addr = cs_etm__instr_addr(etmq, trace_chan_id,
-						  tidq->packet, offset - 1);
+						  tidq->prev_packet,
+						  offset - 1);
 			ret = cs_etm__synth_instruction_sample(
 				etmq, tidq, addr,
 				etm->instructions_sample_period);
-- 
2.17.1

