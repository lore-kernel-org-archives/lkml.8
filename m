Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01597C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DCB208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytqZ4y29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgIBNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63671C06124F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so5212803wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTMUwLGNRNQB4ie8SSya+jnVAbwSw8hpqt0lrhaUPZU=;
        b=ytqZ4y29xTnSd7/M8QIfrLrv+ntI+urbxFwppfojEpqWHImU071sJu9kbIIfp2y1Jy
         4+KUCuv9tQmAG4PVtbUUxIqD5p3em/2bkFX349NK0N5gq83Dwbyg/4IxqFtMYCjsxV35
         VfOl48VEHJIvfPHAGw/VpM7DM+1ybRDH1aHZN6BGyrMx5yTijqWPB/K7R2gbbLywc6xL
         YuvDSui2me5MQrMhNRdUY+QF+R5v5C0aWucAf7PBVoNRSa4kgmlOmZrhxmNpg7/xJMlM
         H/Ay2RbRY4H7xd0HKEhRr8otlmXH/sgcKqSRsnKqFbVkLiG3DPRUPETFSLkKulcneinH
         s7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTMUwLGNRNQB4ie8SSya+jnVAbwSw8hpqt0lrhaUPZU=;
        b=P388Gq/0rwcQnObS2pzwaGf3dbB5aITqNj7hCfIMeWiwGyI/PpGtQdPs7QpS2WpRPZ
         njx9zXpAB8BOhu18QWJNpDRvvzHaHAE//xExG5Nf3kyQsrG6gj2N04z0p/ACtxdwqe2b
         Nf2utZwZYzK7dx3nUNOMxsxRoOGAwfJAwJWvMFlr7Cx54j/2H71U2TxHIMeUJN2rAClF
         r9sRnAzhU14zj4mT3QoqQr3RDKsb+1Pve+x6LG/TyBTD2volIdp39XFssLc8vlJZARdw
         0gHqRK1rdlwTRvBh2dzH+3o2wtDTRcZVCxSYtPW1nOs9yjLrL5eVlATbiI4B21GiI30x
         ZqWg==
X-Gm-Message-State: AOAM530frOxZ4m0cb9ojJVqAwmP+GUtK+T7NT8E9dvXWEA9ieNfWnAW+
        s2jwoCUXcM56PbdHVaYBrEqNvA==
X-Google-Smtp-Source: ABdhPJynIUHdhvQpdCfDpFCjzUD2VnFzN/yfu1ibZGD8WSzgabVRPQs6/dACjMzv0GQWC/jlUmC8/w==
X-Received: by 2002:adf:eecb:: with SMTP id a11mr1201605wrp.356.1599052910032;
        Wed, 02 Sep 2020 06:21:50 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/6] perf tsc: Calculate timestamp with cap_user_time_short
Date:   Wed,  2 Sep 2020 14:21:28 +0100
Message-Id: <20200902132131.36304-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf mmap'ed buffer contains the flag 'cap_user_time_short' and two
extra fields 'time_cycles' and 'time_mask', perf tool needs to know
them for handling the counter wrapping case.

This patch is to reads out the relevant parameters from the head of the
first mmap'ed page and stores into the structure 'perf_tsc_conversion',
if the flag 'cap_user_time_short' has been set, it will firstly
calibrate cycle value for timestamp calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/tsc.c | 12 +++++++++---
 tools/perf/util/tsc.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 9e3f04ddddf8..c0ca40204649 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -28,6 +28,10 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 {
 	u64 quot, rem;
 
+	if (tc->cap_user_time_short)
+		cyc = tc->time_cycles +
+			((cyc - tc->time_cycles) & tc->time_mask);
+
 	quot = cyc >> tc->time_shift;
 	rem  = cyc & (((u64)1 << tc->time_shift) - 1);
 	return tc->time_zero + quot * tc->time_mult +
@@ -37,7 +41,6 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 			     struct perf_tsc_conversion *tc)
 {
-	bool cap_user_time_zero;
 	u32 seq;
 	int i = 0;
 
@@ -47,7 +50,10 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		tc->time_mult = pc->time_mult;
 		tc->time_shift = pc->time_shift;
 		tc->time_zero = pc->time_zero;
-		cap_user_time_zero = pc->cap_user_time_zero;
+		tc->time_cycles = pc->time_cycles;
+		tc->time_mask = pc->time_mask;
+		tc->cap_user_time_zero = pc->cap_user_time_zero;
+		tc->cap_user_time_short	= pc->cap_user_time_short;
 		rmb();
 		if (pc->lock == seq && !(seq & 1))
 			break;
@@ -57,7 +63,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		}
 	}
 
-	if (!cap_user_time_zero)
+	if (!tc->cap_user_time_zero)
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 3c5a632ee57c..72a15419f3b3 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -8,6 +8,11 @@ struct perf_tsc_conversion {
 	u16 time_shift;
 	u32 time_mult;
 	u64 time_zero;
+	u64 time_cycles;
+	u64 time_mask;
+
+	bool cap_user_time_zero;
+	bool cap_user_time_short;
 };
 
 struct perf_event_mmap_page;
-- 
2.17.1

