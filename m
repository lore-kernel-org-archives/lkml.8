Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2DB206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZPDpwuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgIAIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgIAIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D993C061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k15so513606wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6ETLd9bglqQpiac4Zb6z2Bmq6IptWFaePDp0F0oRHw=;
        b=RZPDpwuuKedWB6h8a/uSbCCoLu0kxGmEAPkM0FticaRUfJpyXEkQbRvNXFKO53GFTt
         fYPGobjfTXmmRTmgQ595FxVc4FPpIRNaiR5aAvsJuCvr9BEn76ZqMYJeraC+28I6Cc8q
         T89maoq+rewEofygXL0/9vm1MKJgj244rbdxMvCoGfSw6R2e+T7ahiFf8o7BMKDOa70C
         5KXJPwn9MXMdnfZiVhsoYiT1xshzyDqbqld8QFxCbup28w5Gby1VizwUBKs/kOKLjJAL
         N5Vk20AkrbgCKJQA6wI4IkmeQ8Ml83Wu5mLSHDYKgdyTdDZ7OUQkiXxfAXW9jJIPjiYf
         Qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6ETLd9bglqQpiac4Zb6z2Bmq6IptWFaePDp0F0oRHw=;
        b=Q5eZSxBBlEAcGdoKRGYMQeisBTc8+Hhfqy66qGm6UaniXK+6Ncq2KJxBV8+BLaGYa3
         OgNhskuWpoeEle/lyDqWg89gWPD+D9AuvHfSAKZ4S7EB49PZpvPI2eLbk0/PVwArTykE
         Xm7LgNl8hLp1KHImjx3a4RUA5FBQo8enXgTa4DhT5opn1BAQvIWSBZDujQF5biRWPojx
         IA5QVD5h7y9ZpN9gNIbgCmJ1Lr3WapV32Nh4ASCzhSgq4bYYmqZezWLnm6EuCCkEP4hl
         sXyVvvEefiNpFhn9Q6TqmwfoVLeRdktKGS3xRlWTWVC6pJKkQh+B2cKsACb54sDAVXzU
         EvAA==
X-Gm-Message-State: AOAM530+M0/GN3pqjq5gWO2dWdeXVqj1pM/Qz6oVVrWJ5hyQa1oN3UAA
        /AVuX3lFKihUqPEblU2IEQW5Sw==
X-Google-Smtp-Source: ABdhPJzziQDCBVc7U7h2gz2c/fdXSLSHngZVg2NODT88W0TjPcG1Xj18d4EERKU7qIK4r0rSaCpgPg==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr653991wrr.234.1598949526674;
        Tue, 01 Sep 2020 01:38:46 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:46 -0700 (PDT)
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
Subject: [PATCH v2 12/14] perf arm-spe: Synthesize memory event
Date:   Tue,  1 Sep 2020 09:38:13 +0100
Message-Id: <20200901083815.13755-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to synthesize memory event, it generates memory events for
all memory levels.  The memory event can delivery two benefits for SPE:

- The first benefit is the memory event can give out global view for
  memory accessing, rather than using scatter mode to organize events
  (such as L1 cache, last level cache, remote accessing, etc) which can
  only display a single memory type, memory events contain all memory
  accessing so it's easier to review the memory behaviour cross
  different memory levels;

- The second benefit is the samples generation might introduce big
  overhead and need to wait for long time for Perf reporting, we can
  specify itrace option '--itrace=M' to filter out other events and only
  output memory events, this can significantly reduce the overhead
  caused by generating samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 44e73e0ff4e7..7f44ef8c89f1 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -55,6 +55,7 @@ struct arm_spe {
 	u8				sample_tlb;
 	u8				sample_branch;
 	u8				sample_remote_access;
+	u8				sample_memory;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -64,6 +65,7 @@ struct arm_spe {
 	u64				tlb_access_id;
 	u64				branch_miss_id;
 	u64				remote_access_id;
+	u64				memory_id;
 
 	u64				kernel_start;
 
@@ -296,6 +298,19 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
+static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
+{
+	int mem_type = ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS |
+		       ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS |
+		       ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS |
+		       ARM_SPE_REMOTE_ACCESS;
+
+	if (type & mem_type)
+		return true;
+
+	return false;
+}
+
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -357,6 +372,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
+	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
+		err = arm_spe__synth_mem_sample(speq, spe->memory_id);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -924,6 +945,18 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 	}
 
+	if (spe->synth_opts.mem) {
+		spe->sample_memory = true;
+
+		/* Remote access */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->memory_id = id;
+		arm_spe_set_event_name(evlist, id, "memory");
+		id += 1;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

