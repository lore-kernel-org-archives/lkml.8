Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E13C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E49206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgQSPSm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgBCCHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:07:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42426 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:07:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so2592402plt.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dvPytXJSrMRsfo04SBdUfjJdiPgt8LyFDxEpmk5VQM=;
        b=LgQSPSm8xD41YyMhV/kmpwWl8wf3WsOqLeZJdYT2DNy/R5BQKfdA2baKU1+GP1G4mg
         bYgvniW2Fs6jLybrVJCEEW/4Vf9sYJd78wkVFycv/ulCJ2TwqJvP3HM5biZ5aZj0PmuQ
         4ROmVfi0rKOcCcl7axf4M7lIb+36sezchU860j3D2UCzcOrgsAbQo4SbiQdSIzyu2JJ2
         4TAyZ5UuU3j/rBEzSJ1LcayeRPtx8rCMYVyVDdJlfm329UA7MupRi12mAWXxW0YGHi5R
         APJmVVi5IsS6X45T5jCrTasH0G6DKII799A8b3Mf+WldUt0PvktPkyMnEmWnmp2f6S0d
         rmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dvPytXJSrMRsfo04SBdUfjJdiPgt8LyFDxEpmk5VQM=;
        b=pQ0W4bgY4xdxc4L0VzLwwzs8xqagG/NQPZddJHCQOpDU6CciyP3getACGxH7KaWRfR
         SAHc9yyB2HCWDBbkPfXS0Ml4OhLp00xV8HCg92ih/GfdWekQQfImbi2Vk61L6Qf7L1K4
         pQhM7uBvyzkbDN/nogqd/jNCLdcMu45piGcJneU4A6eHRes1CpNFpBw0V90GENZaWkKq
         dV4qoCF7wZCxB0HyeqHpGlpLqiYEplDN/nLLz9y+nqSDUgnKRvzTWxXrehnFBxABQX/M
         XRBCb4L0Dp60sa5Bm0NKt3d4vdFCFucT46IlBFJmtYuIVwR/auf7nrzAXhiL22y+HI33
         uzZg==
X-Gm-Message-State: APjAAAWDxbqwQsVowGJ1c6Os/sp0fV8J6SgKhAbyFKBbV7LMcqQ7b67I
        Wfv9ZlS8sIaZCKsAI4fojp9Bgg==
X-Google-Smtp-Source: APXvYqyz0+2AuaA9hd6WscvD6V3lb9cm/CSKMRryBXAPHaPGt3Dp5pXwKuPEVelgEaumOMIGwi3sfg==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr15550715plm.328.1580695666435;
        Sun, 02 Feb 2020 18:07:46 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:07:46 -0800 (PST)
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
Subject: [PATCH v4 1/5] perf cs-etm: Refactor instruction size handling
Date:   Mon,  3 Feb 2020 10:07:12 +0800
Message-Id: <20200203020716.31832-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203020716.31832-1-leo.yan@linaro.org>
References: <20200203020716.31832-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cs-etm.c has several functions which need to know instruction size
based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
two functions both calculate the instruction size separately with its
duplicated code.  Furthermore, adding new features later which might
require to calculate instruction size as well.

For this reason, this patch refactors the code to introduce a new
function cs_etm__instr_size(), this function is central place to
calculate the instruction size based on ISA type and instruction
address.

For a neat implementation, cs_etm__instr_addr() will always execute the
loop without checking ISA type, this allows cs_etm__instr_size() and
cs_etm__instr_addr() have no any duplicate code with each other and both
functions are independent and can be changed separately without breaking
anything.  As a side effect, cs_etm__instr_addr() will do a few more
iterations for A32/A64 instructions, this would be fine if consider perf
is a tool running in the user space.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 48 +++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 720108bd8dba..cb6fcc2acca0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -918,6 +918,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
 }
 
+static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
+				     u8 trace_chan_id,
+				     enum cs_etm_isa isa,
+				     u64 addr)
+{
+	int insn_len;
+
+	/*
+	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
+	 * cs_etm__t32_instr_size().
+	 */
+	if (isa == CS_ETM_ISA_T32)
+		insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
+	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
+	else
+		insn_len = 4;
+
+	return insn_len;
+}
+
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
 	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
@@ -942,19 +962,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
-	if (packet->isa == CS_ETM_ISA_T32) {
-		u64 addr = packet->start_addr;
+	u64 addr = packet->start_addr;
 
-		while (offset) {
-			addr += cs_etm__t32_instr_size(etmq,
-						       trace_chan_id, addr);
-			offset--;
-		}
-		return addr;
+	while (offset) {
+		addr += cs_etm__instr_size(etmq, trace_chan_id,
+					   packet->isa, addr);
+		offset--;
 	}
 
-	/* Assume a 4 byte instruction size (A32/A64) */
-	return packet->start_addr + offset * 4;
+	return addr;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
@@ -1094,16 +1110,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 		return;
 	}
 
-	/*
-	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
-	 * cs_etm__t32_instr_size().
-	 */
-	if (packet->isa == CS_ETM_ISA_T32)
-		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
-							  sample->ip);
-	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
-	else
-		sample->insn_len = 4;
+	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+					      packet->isa, sample->ip);
 
 	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
 			   sample->insn_len, (void *)sample->insn);
-- 
2.17.1

