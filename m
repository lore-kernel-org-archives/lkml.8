Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B31C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD6206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5E/IDtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIAIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIAIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A9C061247
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so325610wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGZEMSAJ/+KpI41IbIOIytfHUTobv/W7rivd/M7D32g=;
        b=u5E/IDtl6chlv/wJnDGBg5rc3mCp9iSXOSB1XSzeG9juqKnnqifBHvEQeI0eO9rMML
         PfPFlP4lfpqm4+c5ky4mMfuXnq0k3+YSSj7bmYs+N9Q/CXwyF1jMV0c4NANYOJOevpp4
         Ep3LArmn+GBktLaxxXpy/+SDlkvw+k4Lu2U9JMAvJdqWVBmLNW6ysQflShARQxvbyGpZ
         bGCURT6f0YwIH1/pFHP46mJLD14ScezF0ftxjGB93w5FJom+EkgXJQ7I64vKZXi5S3u2
         GmKWvT5NHyBO/Qsa2vpj7Cm9D7UZTuKclRLTfrYdnDN9C+mDRCOVMDYsRwLXCv39LkQZ
         afuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGZEMSAJ/+KpI41IbIOIytfHUTobv/W7rivd/M7D32g=;
        b=kdrT4GMqZvtwRpT37mWwmM9djfzOJx5zsEiDsoJSBpaEyPiBZjZSl3vxxG5z1ETL2h
         X64y/XbHCD1LVmfNWDphmdkjL265EQ5Ju7SXgvmWGWPOWYNfb6Ld1tOEITcgVht3w3vB
         aY/OyL/aerkch/Q2K/w7WV1R0FLFTNtuaALo4G8Q4IQo0ML5UrVRch5bR9tErOCU/Chi
         T0fVAVuLkNSg4poYow/FWdVJx25XrYPJ7JgZrLRidNiSk/MlokmpFCw4x34FAJpEPpLN
         taOIY+NVfPYDvMjLXHBM3FLGj6tMK/p5xsZerpqmiTNiyUvXtfZqE5DFQPbbkwV4K8a5
         hCfg==
X-Gm-Message-State: AOAM533aNYVla72lzLSvRWGx//tM69ZLAOPqEyuhZ4CzW6c0lzt5ByBW
        kSR71gtk9HnGce8S/fGr6XkZRg==
X-Google-Smtp-Source: ABdhPJwjNbAo0a+Yp91UFIEVkMVpRePxx3DdyuqGORAi3L7hXKUqmD4p1+1bD+cAEYnT45obDpgsVQ==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr663202wmf.119.1598949528226;
        Tue, 01 Sep 2020 01:38:48 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 13/14] perf arm-spe: Set sample's data source field
Date:   Tue,  1 Sep 2020 09:38:14 +0100
Message-Id: <20200901083815.13755-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
 tools/perf/util/arm-spe.c | 63 +++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7f44ef8c89f1..142149f732b3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -264,7 +264,7 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 }
 
 static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
-				     u64 spe_events_id)
+				     u64 spe_events_id, u64 data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -277,6 +277,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->addr;
 	sample.phys_addr = record->phys_addr;
+	sample.data_src = data_src;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -311,21 +312,60 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
 	return false;
 }
 
+static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
+{
+	union perf_mem_data_src	data_src = { 0 };
+
+	if (record->op == ARM_SPE_LD)
+		data_src.mem_op = PERF_MEM_OP_LOAD;
+	else
+		data_src.mem_op = PERF_MEM_OP_STORE;
+
+	if (record->type & ARM_SPE_L1D_MISS) {
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src.mem_lvl = PERF_MEM_LVL_MISS | PERF_MEM_LVL_L1;
+	} else if (record->type & ARM_SPE_L1D_ACCESS) {
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
+	} else if (record->type & ARM_SPE_LLC_MISS) {
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src.mem_lvl = PERF_MEM_LVL_MISS | PERF_MEM_LVL_L3;
+	} else if (record->type & ARM_SPE_LLC_ACCESS) {
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
+	} else if (record->type & ARM_SPE_REMOTE_ACCESS) {
+		data_src.mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src.mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_REM_CCE1;
+	}
+
+	if (record->type & ARM_SPE_TLB_MISS)
+		data_src.mem_dtlb = PERF_MEM_TLB_WK | PERF_MEM_TLB_MISS;
+	else if (record->type & ARM_SPE_TLB_ACCESS)
+		data_src.mem_dtlb = PERF_MEM_TLB_WK | PERF_MEM_TLB_HIT;
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
 
+	data_src = arm_spe__synth_data_source(record);
+
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_L1D_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -333,13 +373,15 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_llc) {
 		if (record->type & ARM_SPE_LLC_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_LLC_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -347,13 +389,15 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_tlb) {
 		if (record->type & ARM_SPE_TLB_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_TLB_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -367,13 +411,14 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_remote_access &&
 	    (record->type & ARM_SPE_REMOTE_ACCESS)) {
-		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id);
+		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id,
+						data_src);
 		if (err)
 			return err;
 	}
 
 	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
-		err = arm_spe__synth_mem_sample(speq, spe->memory_id);
+		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
 	}
-- 
2.20.1

