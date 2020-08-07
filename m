Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5BFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A9A2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5cF70/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHGHQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:16:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so481744pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=556/nqlePYZWBkAMwQbIJix7Bhlob1GBVvm8WL0qp+4=;
        b=O5cF70/el26zG5aNlKIFz3vqTV8m01oR5hzLW6GizfWXCEWUFnHFfKEbZj8Z4kijG1
         gmNkeh/A3DBUysqXZLW0O2l8g9FC8cik5TX9LWZZHyNUrCSY7w+ItBNFg0La+Q+GeQcl
         sZclwBxIw3bE/OwbxNp3o8SnjfJLCUOBHh+Inl07SlkrAGkSNSlzDMgI+0tclEJ3E0Pt
         dyagUKTF7WSPYi4pDNJ1tdumRFGcAODDmQGV++cs8rKbFwexdKEqjvbem/NQx8hzVZ+u
         Y0UkqObpjwLVYu2go4YurHcs6cM+sCaIUKKZ9VBIlwI12w0wjduSbGhVElZ+e8kxQJsT
         dw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=556/nqlePYZWBkAMwQbIJix7Bhlob1GBVvm8WL0qp+4=;
        b=ldWpyvXDCon9Zq6OS51qc/Rv5nfa1dKOLXCeFUVyVPn7E8IiMMSm+odTA2XIdiTwOK
         apqtDXv4ZO4G/zXnrcjt8RQ9KBqFgO6+C2WDi3nKvZ0nMM2OPLum0EVfJseK94aNnMyM
         JeG8nizZb4rVm2qqZLRX+c8Zzb1Iu7u2aPD1Nrj0D7mZudIong6DkTvRF1hP1uN6vRxp
         NIdpY9gagogzivEBV7HVoYcSZDQxwU5c5Ycnm6bwKi8CxA2QYREkoHz0aAzhOpqwZ6RY
         b/xSn3WQGb7DEIqdTAhKhwvk2VK7yGYJrpQEF88ePeAwnyu4etJv97LkVx4nvj5LDCiq
         /nyg==
X-Gm-Message-State: AOAM533aDuKua6knVrhN3hmhrWvqlBn8mHKMaK2gkDHXY4Zs93oSxgg9
        iClFCfiK4QNB0slAmbuOcF0DjQ==
X-Google-Smtp-Source: ABdhPJyNnQdY8evKlB8D01W4yEwcejbI7oiamJeHiqmIHVJl2qF8SuEVSzJYIcEz4iPols5IAb2zCQ==
X-Received: by 2002:aa7:9904:: with SMTP id z4mr11739740pff.32.1596784616467;
        Fri, 07 Aug 2020 00:16:56 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id c15sm10837967pfo.115.2020.08.07.00.16.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 00:16:55 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] perf arm-spe: Enable timestamp with arch timer counter
Date:   Fri,  7 Aug 2020 15:16:20 +0800
Message-Id: <20200807071620.11907-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807071620.11907-1-leo.yan@linaro.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the arch timer's counter is used for SPE tracing data, and now
it's ready to use arch timer for sample's timestamp in Perf tool, this
patch is to enable timestamp by convert the arch timer counter value to
the time.

After enabling timestamp for Arm SPE with this patch, we can see the
timestamp with 'time' field:

  $ perf script -F,+time
    dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 17 +++++++++++++++++
 tools/perf/util/arm-spe.c            | 16 ++++++++++++++--
 tools/perf/util/arm-spe.h            |  5 +++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index e3593063b3d1..a7cbd5fdb30e 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -11,6 +11,7 @@
 #include <linux/zalloc.h>
 #include <time.h>
 
+#include "../../../util/arm_arch_timer.h"
 #include "../../../util/cpumap.h"
 #include "../../../util/event.h"
 #include "../../../util/evsel.h"
@@ -22,6 +23,7 @@
 #include "../../../util/auxtrace.h"
 #include "../../../util/record.h"
 #include "../../../util/arm-spe.h"
+#include "../../../util/mmap.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -47,6 +49,9 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_event_mmap_page *pc;
+	struct perf_arch_timer_conversion tc = { 0 };
+	int err;
 
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
@@ -54,8 +59,20 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
+	pc = session->evlist->mmap[0].core.base;
+	if (pc) {
+		err = perf_read_arch_timer_conversion(pc, &tc);
+		if (err)
+			return err;
+	}
+
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
 	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_TIME_SHIFT] = tc.time_shift;
+	auxtrace_info->priv[ARM_SPE_TIME_MULT] = tc.time_mult;
+	auxtrace_info->priv[ARM_SPE_TIME_ZERO] = tc.time_zero;
+	auxtrace_info->priv[ARM_SPE_TIME_CYCLES] = tc.time_cycles;
+	auxtrace_info->priv[ARM_SPE_TIME_MASK] = tc.time_mask;
 
 	return 0;
 }
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3882a5360ada..07232664c927 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -16,6 +16,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include "arm_arch_timer.h"
 #include "auxtrace.h"
 #include "color.h"
 #include "debug.h"
@@ -44,6 +45,7 @@ struct arm_spe {
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
+	struct perf_arch_timer_conversion tc;
 
 	u8				timeless_decoding;
 	u8				data_queued;
@@ -229,7 +231,8 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	struct arm_spe_record *record = &speq->decoder->record;
 
 	if (!spe->timeless_decoding)
-		sample->time = speq->timestamp;
+		sample->time = arch_timer_cyc_to_perf_time(speq->timestamp,
+							   &spe->tc);
 
 	sample->ip = record->from_ip;
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
@@ -350,6 +353,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record;
 	int ret;
 
 	if (!spe->kernel_start)
@@ -369,6 +373,9 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		if (ret < 0)
 			continue;
 
+		record = &speq->decoder->record;
+		speq->timestamp = record->timestamp;
+
 		ret = arm_spe_sample(speq);
 		if (ret)
 			return ret;
@@ -585,7 +592,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_arch_timer_cyc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
@@ -934,6 +941,11 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	spe->tc.time_shift = auxtrace_info->priv[ARM_SPE_TIME_SHIFT];
+	spe->tc.time_mult = auxtrace_info->priv[ARM_SPE_TIME_MULT];
+	spe->tc.time_zero = auxtrace_info->priv[ARM_SPE_TIME_ZERO];
+	spe->tc.time_cycles = auxtrace_info->priv[ARM_SPE_TIME_CYCLES];
+	spe->tc.time_mask = auxtrace_info->priv[ARM_SPE_TIME_MASK];
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 	spe->auxtrace.process_event = arm_spe_process_event;
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..8baa32ad179d 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -12,6 +12,11 @@
 enum {
 	ARM_SPE_PMU_TYPE,
 	ARM_SPE_PER_CPU_MMAPS,
+	ARM_SPE_TIME_SHIFT,
+	ARM_SPE_TIME_MULT,
+	ARM_SPE_TIME_ZERO,
+	ARM_SPE_TIME_CYCLES,
+	ARM_SPE_TIME_MASK,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.17.1

