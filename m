Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B835FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F82221744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c29IyM4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHFDIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHFDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43161C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so4075380pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtIFr9V+38JciMu7a09ovCgS+FpJy/RDzZrQx+D8B9s=;
        b=c29IyM4L87WW6sG/Ob52S/9UIHL8xebG1GTIfoQ1Qj0DoqI3iOS+PKV7zuaZ7Yybc1
         HGjiIhIoB5Ui27JYMp8HsyNVwW/ck5V7tenY9Dl9Pc/3193y6yV2U5Pc0m1wpORSbs+8
         XYlFPFDEAsGWkqm9UO+kmct184xR1G+2OjeuE8T1rPoGIuv3+VWXd3nCssiv8iP/XkgO
         4/hrbRFDjdV/YNRXkud4l3IVMfz6sMEDYRjeUy7IifTNjYQmj7j1KFU1Y0AZXH7HQbBf
         ES/tK2Dr1SwhiIFv+D4yMvD+pJVqEyGhwLCIcO9UxeREahFKicVlDa6TXc6hgJTQP1i2
         zJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CtIFr9V+38JciMu7a09ovCgS+FpJy/RDzZrQx+D8B9s=;
        b=E9+NYNynLBOrWQA6PRXnDnFtXcw2k9WlOyAUaC+IejuayeFic0onecSjgiTD72KTL5
         mfcMGDoe11SmixA9a8FCwN7+CGGxCPpV8NtbNg8HRwDlDj0Y5Ia8+ONekkLP0TBNjeck
         yr9Tb9dHi+kj1aswrvYfV8RC6tQi6nK36llgVzhMCwMjni5EDU6lZI47UMn0r0T30+Eb
         Eic7HvbSgqSu4XodhN8OGbYk9yQaYdHUF2F7EtID+ZW2i04z3d+RdlL+wR50beKCK+c2
         oqOcDXap5CtvQEX5pkh0Wv/tnisglb8qKA6yiVLM4hX9sdS01PAsYIdFCS/Rb0D9rMe9
         /whA==
X-Gm-Message-State: AOAM533/KaY8VhOf0nmhdnelgzaenlzDho1WQIj08LUgDIRc8iX2OwuR
        bzvuTEnAcw2sNesQcY/qVgjmdw==
X-Google-Smtp-Source: ABdhPJy+3yd1Pv+kOu4RYnKe844SAyd0w/HM0uj0IM0CLqUCKuf1HFXbvT5+teukdX+PVTQYOtwPUg==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr6020238plq.128.1596683330762;
        Wed, 05 Aug 2020 20:08:50 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id c139sm5472502pfb.65.2020.08.05.20.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 11/11] perf arm-spe: Set sample's data source field
Date:   Thu,  6 Aug 2020 11:07:27 +0800
Message-Id: <20200806030727.30267-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sample structure contains the field 'data_src' which is used to
tell the detailed info for data operations, e.g. this field indicates
the data operation is loading or storing, on which cache level, it's
snooping or remote accessing, etc.  At the end, the 'data_src' will be
parsed by perf memory tool to display human readable strings.

This patch is to fill the 'data_src' field in the synthesized samples
base on different types.  Now support types for Level 1 dcache miss,
Level 1 dcache hit, Last level cache miss, Last level cache access,
TLB miss, TLB hit, remote access for other socket.

Note, current perf tool can display statistics for L1/L2/L3 caches but
it doesn't support the 'last level cache'.  To fit into current
implementation, 'data_src' field uses L3 cache for last level cache.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 87 +++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 74308a72b000..3114f059fc2f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -259,7 +259,7 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 }
 
 static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
-				     u64 spe_events_id)
+				     u64 spe_events_id, u64 data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -272,6 +272,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->addr;
 	sample.phys_addr = record->phys_addr;
+	sample.data_src = data_src;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -293,21 +294,74 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
+static u64 arm_spe__synth_data_source(const struct arm_spe_record *record,
+				      int type)
+{
+	union perf_mem_data_src	data_src = { 0 };
+
+	if (record->op == ARM_SPE_LD)
+		data_src.mem_op = PERF_MEM_OP_LOAD;
+	else
+		data_src.mem_op = PERF_MEM_OP_STORE;
+
+	switch (type) {
+	case ARM_SPE_L1D_MISS:
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src.mem_lvl = PERF_MEM_LVL_MISS | PERF_MEM_LVL_L1;
+		break;
+	case ARM_SPE_L1D_ACCESS:
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
+		break;
+	case ARM_SPE_LLC_MISS:
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src.mem_lvl = PERF_MEM_LVL_MISS | PERF_MEM_LVL_L3;
+		break;
+	case ARM_SPE_LLC_ACCESS:
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
+		break;
+	case ARM_SPE_TLB_MISS:
+		data_src.mem_dtlb = PERF_MEM_TLB_WK | PERF_MEM_TLB_MISS;
+		break;
+	case ARM_SPE_TLB_ACCESS:
+		data_src.mem_dtlb = PERF_MEM_TLB_WK | PERF_MEM_TLB_HIT;
+		break;
+	case ARM_SPE_REMOTE_ACCESS:
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_REM_CCE1;
+		break;
+	default:
+		break;
+	}
+
+	return data_src.val;
+}
+
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
 	struct arm_spe *spe = speq->spe;
+	u64 data_src;
 	int err;
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_L1D_MISS);
+
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_L1D_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_L1D_ACCESS);
+
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -315,13 +369,21 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_llc) {
 		if (record->type & ARM_SPE_LLC_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_LLC_MISS);
+
+			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_LLC_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_LLC_ACCESS);
+
+			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -329,13 +391,19 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_tlb) {
 		if (record->type & ARM_SPE_TLB_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_TLB_MISS);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_TLB_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id);
+			data_src = arm_spe__synth_data_source(record,
+							      ARM_SPE_TLB_ACCESS);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -349,7 +417,10 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_remote_access &&
 	    (record->type & ARM_SPE_REMOTE_ACCESS)) {
-		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id);
+		data_src = arm_spe__synth_data_source(record,
+						      ARM_SPE_REMOTE_ACCESS);
+		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id,
+						data_src);
 		if (err)
 			return err;
 	}
-- 
2.17.1

