Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A22F204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOHIILKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgIBPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgIBNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:32:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1ADC061258
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so4730501wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsR1z1lW3YoQRoLJaVtPJDlZl+DJfNaMXIyuQNTTZFQ=;
        b=SOHIILKknOvaEulupM34Z1YDabecXGHBsZjQGbqpfhzZntgfnFpZPr43kaXKX+z3Wj
         T0v2gqN3NqblM0Ru8R5RyBQycgUMBOV+qv54YdX7BEIFr+Hwz+Un4PE+iPiINohm16Bi
         PqmqDYD1qdRdH2/Ba+HsdOH2RYI+B0rQs2THYL78CpchaZjE8emFVwFi5EBRsfd13var
         rpx3cOUzL9bh8+msNSBB2lBVGhk3ZJ1sgH9qvYci4WcSFvfYXVO3pF9pJ+F1U0RZsMO5
         LxhVzmeTo7Y/juzbx9bkfcT30l55a4LF0f5TfqF09RkM+iZVHN8zEBHP9c8Cwvpj5sIl
         hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsR1z1lW3YoQRoLJaVtPJDlZl+DJfNaMXIyuQNTTZFQ=;
        b=LsHXbOUrZATqYDu0qobZuWGPWJGaQ8XfC7azTY0CF8MgqPeDVrJXIYA/Qd2gTanbHc
         LijqYmJNnrfU7GW9H8AvNpVMoYxoCN3u7XNu0NGmsFS84QVTB39nXVOvRxVm50ANWElW
         CCgaghHmWfhu6eAeER2SXcuKDCTtw32Rb4GSDj3clSOvuwNJjd+FgJmAmieLCkluDbca
         z5BiXrfQPaMzUvU+/Vo2qmlYkV2sAyZsj2cAlWDZx08enViS/T72a09IapVgjDoGUVzh
         gJNs08CLVecK4mJK6QX/pbD1EhpdB+8aUYT/0iKpZTrwjkunTW2HeffTR7zkjOIIkmrT
         eH7w==
X-Gm-Message-State: AOAM530G+rQSi9piM9BmQBvU3QqXhMJqIU2OfIPsAfEhUPQUvRkkh6Qz
        RwOK2HNFzmLFHJtSoDTKfVQrLg==
X-Google-Smtp-Source: ABdhPJxsOepotZsLYvBPAdNQ8SvDtxoduwHk2Q7y/TLzW8wHTRhHqAWwVZEaVzVT4IS+O/AAg04mhg==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr7665393wrm.117.1599052912437;
        Wed, 02 Sep 2020 06:21:52 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:51 -0700 (PDT)
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
Subject: [PATCH v3 5/6] perf tests tsc: Make tsc testing as a common testing
Date:   Wed,  2 Sep 2020 14:21:30 +0100
Message-Id: <20200902132131.36304-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 arch provides the testing for conversion between tsc and perf time,
the testing is located in x86 arch folder.  Move this testing out from
x86 arch folder and place it into the common testing folder, so allows
to execute tsc testing on other architectures (e.g. Arm64).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/x86/include/arch-tests.h           | 1 -
 tools/perf/arch/x86/tests/Build                    | 1 -
 tools/perf/arch/x86/tests/arch-tests.c             | 4 ----
 tools/perf/tests/Build                             | 1 +
 tools/perf/tests/builtin-test.c                    | 4 ++++
 tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c | 0
 tools/perf/tests/tests.h                           | 1 +
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (100%)

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c41c5affe4be..6a54b94f1c25 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -7,7 +7,6 @@ struct test;
 
 /* Tests */
 int test__rdpmc(struct test *test __maybe_unused, int subtest);
-int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
 int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 2997c506550c..36d4f248b51d 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -3,6 +3,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
 perf-y += rdpmc.o
-perf-y += perf-time-to-tsc.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 6763135aec17..bc25d727b4e9 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -8,10 +8,6 @@ struct test arch_tests[] = {
 		.desc = "x86 rdpmc",
 		.func = test__rdpmc,
 	},
-	{
-		.desc = "Convert perf time to TSC",
-		.func = test__perf_time_to_tsc,
-	},
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	{
 		.desc = "DWARF unwind",
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 84352fc49a20..3ae29b2a3d0f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -60,6 +60,7 @@ perf-y += api-io.o
 perf-y += demangle-java-test.o
 perf-y += pfm.o
 perf-y += parse-metric.o
+perf-y += perf-time-to-tsc.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d328caaba45d..67e6a1c6c793 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -341,6 +341,10 @@ static struct test generic_tests[] = {
 		.desc = "Parse and process metrics",
 		.func = test__parse_metric,
 	},
+	{
+		.desc = "Convert perf time to TSC",
+		.func = test__perf_time_to_tsc,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
similarity index 100%
rename from tools/perf/arch/x86/tests/perf-time-to-tsc.c
rename to tools/perf/tests/perf-time-to-tsc.c
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4447a516c689..1633f54d6156 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -122,6 +122,7 @@ int test__pfm(struct test *test, int subtest);
 const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
 int test__parse_metric(struct test *test, int subtest);
+int test__perf_time_to_tsc(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.17.1

