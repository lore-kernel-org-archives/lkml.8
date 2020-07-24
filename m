Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E021C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36B22063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGXJSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:18:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728134AbgGXJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:18:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4A3DE6E6F2762F6A3B8;
        Fri, 24 Jul 2020 17:18:02 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 17:17:54 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
Subject: [PATCH 4/4] perf: arm-spe: Synthesize new events for ARMv8.3-SPE
Date:   Fri, 24 Jul 2020 17:16:07 +0800
Message-ID: <20200724091607.41903-5-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724091607.41903-1-liwei391@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize unaligned address access events and partial/empty
predicated SVE operation introduced by ARMv8.3-SPE.

They can be filtered by itrace options when reporting.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 11 ++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  3 +
 tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 93e063f22be5..fac8102c0149 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -197,6 +197,17 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_MISPRED))
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
+			if ((idx == 4 || idx == 8) &&
+			    (payload & BIT(EV_ALIGNMENT)))
+				decoder->record.type |= ARM_SPE_ALIGNMENT;
+
+			if ((idx == 4 || idx == 8) &&
+			    (payload & BIT(EV_PARTIAL_PREDICATE)))
+				decoder->record.type |= ARM_SPE_PARTIAL_PREDICATE;
+
+			if ((idx == 4 || idx == 8) &&
+			    (payload & BIT(EV_EMPTY_PREDICATE)))
+				decoder->record.type |= ARM_SPE_EMPTY_PREDICATE;
 			break;
 		case ARM_SPE_DATA_SOURCE:
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..d165418fcc13 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -39,6 +39,9 @@ enum arm_spe_sample_type {
 	ARM_SPE_TLB_MISS	= 1 << 5,
 	ARM_SPE_BRANCH_MISS	= 1 << 6,
 	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
+	ARM_SPE_ALIGNMENT	= 1 << 8,
+	ARM_SPE_PARTIAL_PREDICATE	= 1 << 9,
+	ARM_SPE_EMPTY_PREDICATE	= 1 << 10,
 };
 
 struct arm_spe_record {
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3882a5360ada..e36d6eea269b 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -53,6 +53,8 @@ struct arm_spe {
 	u8				sample_tlb;
 	u8				sample_branch;
 	u8				sample_remote_access;
+	u8				sample_alignment;
+	u8				sample_sve;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -62,6 +64,9 @@ struct arm_spe {
 	u64				tlb_access_id;
 	u64				branch_miss_id;
 	u64				remote_access_id;
+	u64				alignment_id;
+	u64				epred_sve_id;
+	u64				ppred_sve_id;
 
 	u64				kernel_start;
 
@@ -344,6 +349,30 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
+	if (spe->sample_alignment &&
+	    (record->type & ARM_SPE_ALIGNMENT)) {
+		err = arm_spe_synth_spe_events_sample(speq,
+						      spe->alignment_id);
+		if (err)
+			return err;
+	}
+
+	if (spe->sample_sve) {
+		if (record->type & ARM_SPE_EMPTY_PREDICATE) {
+			err = arm_spe_synth_spe_events_sample(
+					speq, spe->epred_sve_id);
+			if (err)
+				return err;
+		}
+
+		if (record->type & ARM_SPE_PARTIAL_PREDICATE) {
+			err = arm_spe_synth_spe_events_sample(
+					speq, spe->ppred_sve_id);
+			if (err)
+				return err;
+		}
+	}
+
 	return 0;
 }
 
@@ -907,6 +936,38 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 	}
 
+	if (spe->synth_opts.alignment) {
+		spe->sample_alignment = true;
+
+		/* Alignment */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->alignment_id = id;
+		arm_spe_set_event_name(evlist, id, "alignment");
+		id += 1;
+	}
+
+	if (spe->synth_opts.sve) {
+		spe->sample_sve = true;
+
+		/* Empty predicated SVE */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->epred_sve_id = id;
+		arm_spe_set_event_name(evlist, id, "sve-pred-empty");
+		id += 1;
+
+		/* Partial predicated SVE */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->ppred_sve_id = id;
+		arm_spe_set_event_name(evlist, id, "sve-pred-partial");
+		id += 1;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

