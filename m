Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9FC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4852067C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO3E7ihU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBCBxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:53:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46503 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBCBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:53:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so6917226pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovSiMu6eDg8baSn4QabjoCI5Td3xLx7krHbZCycw6hU=;
        b=eO3E7ihUXPiMjX8jGUakX3FEHjLd2ZMiVPSuyOuH5f9C5BIMM76Prjrie2GEQAeQzr
         zfWwdrs8YnD4mEdB9cDpPd3bwTDSmwm6lZjin8ULJ94omHChZLlFTdFOWqYlmebYpdHz
         vG768/8ONU5r1nsx01y3DfoStJ5nrpL+2fK4hEpWITgM0lCIygkPh65bcTMkRhaSnYkY
         cH8FtUcSyTQzCoE1CZkPhDQvnWMk0F3uSEI1Q7S6HK/sq5C2zRfqO/0BpLI8CSak73Nl
         kqMjxtdvzzr5HTbttXtdNrUJ3bAkeb+u2jnmnxH9KkmSTVU4+V69aejkzAjMhFAlDqdt
         CIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovSiMu6eDg8baSn4QabjoCI5Td3xLx7krHbZCycw6hU=;
        b=RKKBCpb+YqPmqHM6rkLbHB7pgZAyBEhx/IdooiKClzpMH6rVzkQslXmPdkttiJcAI2
         Int3K2ppz4REalf/MCPKflvzhxq02fEirkw8NFwkZR136X0rUBAG9ZMP6th10znq+g5s
         k+WuaBoTi605PU8HZUkx7T9Yz7dIXD6xWeHAavQqfff9153cVRThqhsh7TyubleHziTG
         2FtTi6diq4YwYBK6AsmcbyJydGCTVJkY4tVPjrlA8pLwrKxpyEgBQIk0lgQEf0gMx3GR
         8eSirNrJDVrxP21vF8WZ81Gsj87Znm+dsgY3zotFENltBgGuMP0mw7mq2f4lKbOXa5uQ
         m08w==
X-Gm-Message-State: APjAAAUac18qc+UGfp+YWPr+LftlK2Gqt+NCLWBsnTm7lX/3HN1n3RRZ
        v0BFC5VpuJrW8WaByNwn0QDSfg==
X-Google-Smtp-Source: APXvYqxlO9/tml5cbTSe/F/G4LZUuePd8W1y1ke8p1Q3ox/374edCW1lA0+O9W0i9RosVX44mEj7bQ==
X-Received: by 2002:a63:fe43:: with SMTP id x3mr23657136pgj.119.1580694784305;
        Sun, 02 Feb 2020 17:53:04 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:53:03 -0800 (PST)
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
Subject: [PATCH v3 4/5] perf cs-etm: Optimize copying last branches
Date:   Mon,  3 Feb 2020 09:52:02 +0800
Message-Id: <20200203015203.27882-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203015203.27882-1-leo.yan@linaro.org>
References: <20200203015203.27882-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an instruction range packet can generate multiple instruction
samples, these samples share the same last branches; it's not necessary
to copy the same last branches repeatedly for these samples within the
same packet.

This patch moves out the last branches copying from function
cs_etm__synth_instruction_sample(), and execute it prior to generating
instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c5a05f728eac..dbddf1eec2be 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1134,10 +1134,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
-	if (etm->synth_opts.last_branch) {
-		cs_etm__copy_last_branch_rb(etmq, tidq);
+	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
-	}
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(event, &sample,
@@ -1407,6 +1405,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 */
 		u64 instrs_over = instrs_executed;
 
+		/* Prepare last branches for instruction sample */
+		if (etm->synth_opts.last_branch)
+			cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * 'head' is the instructions number of the head in the new
 		 * packet, it combines with the tail of previous packet to
@@ -1526,6 +1528,11 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Generate a last branch event for the branches left in the
 		 * circular buffer at the end of the trace.
@@ -1533,7 +1540,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		 * Use the address of the end of the last reported execution
 		 * range
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
@@ -1587,11 +1594,16 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	 */
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Use the address of the end of the last reported execution
 		 * range.
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
-- 
2.17.1

