Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB845C11D81
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA8D20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdtuawAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBTF2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:28:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43315 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTF2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:28:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so1070023plq.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qJS90AGtzv8zo/QcaS91tWAyWP8Ec16yxwzg5jPJK6o=;
        b=vdtuawAOSZA6MY+y0V2xvFjBU+olrLq9EMduwvFStf/JjQcleL6nILGeTCtYp2rzi4
         VZnie9GBsMHQelivWTIBh9LraAyrTwRPZ9XgRG/ukaG/ICxmfD21HIGgv1Hlk1eiquLH
         +4YUbz1Osqs82SxBbwBf/Rwm5T5IVG86SnneVY96uY/WJf6H81hrSAfjRWAAk3RR3SnS
         GIOv53O8Lfh00200W3RisDDwzapZasqqrIsFGGGSaQSFg0pz5GCXGoSfbfRbK7aQxJ7+
         YNkVlTGobMmaKlCjzpwGZJiQYfhTADGvfg+1HYEr4cyAAkmea80t/1iNFHyi5yXCJF3o
         RkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qJS90AGtzv8zo/QcaS91tWAyWP8Ec16yxwzg5jPJK6o=;
        b=mmtPh35S0VSllcabbmnqsWE31kbbMDbVL+trYMCdsPtpsSgRbEb/zkzKJhMAwFzgin
         c+FJ3AP5YGsCdLyOs671lhGILQdRdKl6uPNgANVeOrvwZkQ7HnaGccqoKcwkUhWoZkCs
         asufchbqhOrZoEduhmKwkTHVVASY5rAzukLXwyQqEiKeOc7U2COAfRo6ZT5LtY+kFNr4
         VQB5fQVN1YYPar0ugRCEx8y0V1DuZYkOcdf5MxxC0y3AYQncOFwYFKiES5gcxloYkbLM
         iyAhbb9ltfE0l9AYrfJJB/ECzqpM2bbPsAMq6zXZuUD+nPkmS65mhIAV0ediCX4sv/VX
         mExQ==
X-Gm-Message-State: APjAAAVj6T4cYCLZQr7/yPbJ75QzybGVzuZEZrR6RVm/n9QY2DtO2xFT
        7rn79Oul0y1uvUe+oFVkIADyuMZudr/Miek3
X-Google-Smtp-Source: APXvYqxaFyHZklbL2af5UzEJyvN+4+cf0+aqM60nSUm7/DsE4K4fWHxRgsNE7NitZwKNMU+p3EYy+g==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr1573960pjb.94.1582176494302;
        Wed, 19 Feb 2020 21:28:14 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:28:13 -0800 (PST)
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
Subject: [PATCH v5 3/9] perf cs-etm: Refactor instruction size handling
Date:   Thu, 20 Feb 2020 13:26:55 +0800
Message-Id: <20200220052701.7754-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
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

Given the trace data can be MB and most likely that will be A64/A32 on
a lot of the current and future platforms, cs_etm__instr_addr() keeps a
single ISA type check for non T32, for this case it executes an
optimized calculation (addr + offset * 4).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 7cf30b5e0e20..f3ba2cfb634f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -935,6 +935,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
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
@@ -959,19 +979,19 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
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
+	/* Optimize calculation for non T32 */
+	if (packet->isa != CS_ETM_ISA_T32)
+		return addr + offset * 4;
+
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
@@ -1111,16 +1131,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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

