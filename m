Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A792BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811CB21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+xmGzTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHFDIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHFDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B1C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so13683536plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QMhndAdtiDl6QVFwKn0jdgPxeijswHWcwE0ZEgDVZg=;
        b=j+xmGzToIh481LyZDzxWTvkDYxRanatPc8nLXH4SOPoMJx7zz+UhSgD5rQMlftEXsg
         XoUVggxkDbpdrXwI1AMCHGSXbQB9Q4oeEBrPvfZbXN4vOQGGRp8i+4TQx3XJ9T2D3oTm
         477xLpYpwDgJx3Pyzzx/xD90nJF4zlnmtkXwsz4cJvQ4G6ml7UbZFO99AHpiWFl0MwQ8
         4wkaK672RWXvMHCZBn5v7EVK+sxGrXtAbuIBFdQXrkRVsnLWw6A9dgT3ye6VOcruVWYL
         /6hdtFePArhHlPcLnXacfGhGqR96sMYdIhzXbgo/cljTHvRo67nrZC3ak3y99t++51eW
         AmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QMhndAdtiDl6QVFwKn0jdgPxeijswHWcwE0ZEgDVZg=;
        b=Q3PfmWITs0rtrWRwWkym5r+x+6vvHkEWzpeX1awnZ7kq2jKoMxmfOYdcKLiOU/gmV3
         DFZL6hVWCpeH0vH6KXvfzkuAm46a0byYIRekWwmVS8gUwEUNI2XHchw1q1+vFcRS8RpA
         HYoQWFAlvVc6yMj3jLJkeAG76lObj8TWOnnNJbjRqB36yguYXdVpO6HEK7vNp5hoAb8G
         C1yTlDeOhrwM0eHMjdFKxpaTmctlTn0HWRaZfbdK9cnak+JpA9VdAY0z78E9sub0bCav
         9TDAjZqqnf5prcCGmHuwWaWCdk7VVxJG7y2Lf18VrC7+wEOet1JH/Mkxf1EDpdT337S+
         uEEw==
X-Gm-Message-State: AOAM531tBvEViRI0NIQbLZVBYhYFsYCxuU1qNYCcnpMoJo+tyY+hbE1w
        Q95PTgF8HZ/WvIF6coPLr2yUNQ==
X-Google-Smtp-Source: ABdhPJy7zjPzI4FA2qe3aIxXI6RwrfJZmOHByXJ2FDFBUWb5etab7m/wTr4VkMQAD/VYr6mljuLa6w==
X-Received: by 2002:a17:902:eb14:: with SMTP id l20mr5952790plb.6.1596683323762;
        Wed, 05 Aug 2020 20:08:43 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e9sm5480439pfh.151.2020.08.05.20.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:43 -0700 (PDT)
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
Subject: [PATCH RESEND v1 10/11] perf arm-spe: Fill address info for memory samples
Date:   Thu,  6 Aug 2020 11:07:26 +0800
Message-Id: <20200806030727.30267-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Arm SPE backend decoder has passed virtual and physical
addresses info through packet, these addresses info can be filled into
the synthesize samples, finally the address info can be used for memory
profiling.

To support memory related samples, this patch divides into two functions
for generating samples:
  - arm_spe__synth_mem_sample() is for synthesizing memory accessing and
    TLB related samples;
  - arm_spe__synth_branch_sample() is to synthesize branch samples which
    is mainly for branch miss prediction.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 52 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index c2cf5058648f..74308a72b000 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -235,7 +235,6 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
 	sample->pid = speq->pid;
 	sample->tid = speq->tid;
-	sample->addr = record->to_ip;
 	sample->period = 1;
 	sample->cpu = speq->cpu;
 
@@ -259,18 +258,37 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
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
@@ -283,15 +301,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
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
@@ -299,15 +315,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
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
@@ -315,31 +329,27 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
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
2.17.1

