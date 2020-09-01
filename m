Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A412071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bv76ZB9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIAIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgIAIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FCC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so540475wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4gvXc12qVIjgGy8JvwWEOwfpDxFdYPq0XNHLJKuwBc=;
        b=Bv76ZB9k6IQ9u20oZwBRN0DhH3ss88u1vysr96Hh6+mrLd16Ket25CqLL3l5sskH76
         PrvqWZ4lmIVzk4dG/orpdGv9vhEZ9mWmM3f0dmSgf3zj3EHC/ChFUIBS4wKlm9ndCRA7
         EonVgFD/6E1G9yqDv78+GKCqFXnAtpgU3++zjxqYv0Ltm/VV5UDUeLAdLUskDECOXP5L
         x7MagC8fQ5FKdARnrl49wO/GEfJ0slgqWXQtmIrazaxZpHz1IbEy2wRcgcoZqhM6iwa4
         YFIbNAINME9w+czDQMpK0lgvynan4ROFFsH93gsB2b7NERSqP3kCnxSEXX3+pv/UsU+A
         ykRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T4gvXc12qVIjgGy8JvwWEOwfpDxFdYPq0XNHLJKuwBc=;
        b=S3jY8KJwIp2Tn5XzptbjrBGjU2Qe5xcIC3J4RlV7wT82jzSFLheKcYKKnV5LKVZybA
         R3Gfs9sqd94JYchupiYqR2C6VlKfm3A0MiqL2c8/CqogApKwgcfPPZ+jy2WuMw+eO390
         smX9axfBYzS9psvxrJj/Q8shsd5fOVgTwbFCyGnnwQ8z+4Xb/Fid40RZlDL6KXuqHeIv
         /DjFLlTYoyBLGg+JY+Pft2jLVYPJGMP2oOqeQWT60flzsdTJZvkV7ax6D9nZYCM5Uwfk
         d8h3emVN0xK8nWQlrFkOI7/PK7Ol1JdkvOl+n8c9vKg7jFVZcfj8ASQVu4kswK3Mihkr
         Yw8g==
X-Gm-Message-State: AOAM532Nq01s/dJyn8wPYGcd+fw5HzVd0sfg/qN0Tn5P2AfQ9/KyvxoN
        LzSuej2TMYo2Udu8rveVi4kAxw==
X-Google-Smtp-Source: ABdhPJxSEJFBnq0gM2nO525bh55/D+VdhotDCTSDlnbiGo7Ht4Ydl1NdjFeDdDgxjBNszP1QLcn7ww==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr676475wrx.139.1598949525489;
        Tue, 01 Sep 2020 01:38:45 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:44 -0700 (PDT)
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
Subject: [PATCH v2 11/14] perf arm-spe: Fill address info for samples
Date:   Tue,  1 Sep 2020 09:38:12 +0100
Message-Id: <20200901083815.13755-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Arm SPE backend decoder has passed virtual and physical
addresses info through packet, these addresses info can be filled into
the synthesize samples, finally the address info can be used for memory
profiling.

This patch divides into two functions for generating samples:
  - arm_spe__synth_mem_sample() is for synthesizing memory accessing and
    TLB related samples;
  - arm_spe__synth_branch_sample() is to synthesize branch samples which
    is mainly for branch miss prediction.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 52 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 305ab725b3ba..44e73e0ff4e7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -238,7 +238,6 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
 	sample->pid = speq->pid;
 	sample->tid = speq->tid;
-	sample->addr = record->to_ip;
 	sample->period = 1;
 	sample->cpu = speq->cpu;
 
@@ -262,18 +261,37 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 	return ret;
 }
 
-static int
-arm_spe_synth_spe_events_sample(struct arm_spe_queue *speq,
-				u64 spe_events_id)
+static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
+				     u64 spe_events_id)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
+	union perf_event *event = speq->event_buf;
+	struct perf_sample sample = { 0 };
+
+	arm_spe_prep_sample(spe, speq, event, &sample);
+
+	sample.id = spe_events_id;
+	sample.stream_id = spe_events_id;
+	sample.addr = record->addr;
+	sample.phys_addr = record->phys_addr;
+
+	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
+}
+
+static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
+					u64 spe_events_id)
+{
+	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
 	union perf_event *event = speq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample = { 0 };
 
 	arm_spe_prep_sample(spe, speq, event, &sample);
 
 	sample.id = spe_events_id;
 	sample.stream_id = spe_events_id;
+	sample.addr = record->to_ip;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -286,15 +304,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->l1d_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_L1D_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->l1d_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id);
 			if (err)
 				return err;
 		}
@@ -302,15 +318,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_llc) {
 		if (record->type & ARM_SPE_LLC_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->llc_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_LLC_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->llc_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id);
 			if (err)
 				return err;
 		}
@@ -318,31 +332,27 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_tlb) {
 		if (record->type & ARM_SPE_TLB_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->tlb_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_TLB_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->tlb_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id);
 			if (err)
 				return err;
 		}
 	}
 
 	if (spe->sample_branch && (record->type & ARM_SPE_BRANCH_MISS)) {
-		err = arm_spe_synth_spe_events_sample(speq,
-						      spe->branch_miss_id);
+		err = arm_spe__synth_branch_sample(speq, spe->branch_miss_id);
 		if (err)
 			return err;
 	}
 
 	if (spe->sample_remote_access &&
 	    (record->type & ARM_SPE_REMOTE_ACCESS)) {
-		err = arm_spe_synth_spe_events_sample(speq,
-						      spe->remote_access_id);
+		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id);
 		if (err)
 			return err;
 	}
-- 
2.20.1

