Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC46C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C24204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YboYnhBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIBPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgIBNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:32:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C222C06125C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so5220261wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9dotQ0xE5MsbgSZ9X32aTQe7eTprrtBJ5XMjCQYNj8=;
        b=YboYnhBMkhbL/WFTud0SFF7e3j6vv2slL1U3qKUfCbfSWa6wmH+tXlQr48OdB71stC
         2dCkO3jxwk/a8taij2tPW4sDVLkDZcTN6UGR2r/oe3Qk7AMcoeO+f5yFR3WC/bW0lMHF
         bvbKBpLloCQZyoZLH3TcDBChowtNMT4a5zYqb0poiVGEi+TIWHVEyl2M/BbCtEsOXteY
         E1oqreUuy58VA/AGUuEOpqOHOXDfZWev7cYM3ff5e1YtastGM1nHs+sbgP+zUQg4Y9Tq
         821bSfw07/3y967cm+mN4no8F2ZXTl8GRqyIPLkV8Fdqz9miSYzBrpD5/Qk+i/PoIxuU
         ENbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9dotQ0xE5MsbgSZ9X32aTQe7eTprrtBJ5XMjCQYNj8=;
        b=uZsmIdBlugtQhV6Zj+UKtz3bXR9aYVFPdLZBboiLBdts2ZUtKJjY19bhfewPVJCqB3
         /VcohMeTkYIVDjXcg6UWVG736MZBCbg61GPVfthgCCgce6SlJ2SP+SEKWZsvZL5Iein0
         xBt8oNPaeuJqwUVDi4+N7jV0cid9cOXTJTvJSxzJBj6dEJyKqq4qQwD0Y0GxDB/nz4+z
         FvuA/45gmOzjzEEEAvswGZ358GUx1rEHyIWBTiXdew67Lrcg/+yhzIzave0ac3ktl1GQ
         epKBn7CfV3ZhxTwZjv+GyWxbDPiTLd7nUgL3cCHRWKulpohQM09a2iVtmP91yqETxYzh
         fZXA==
X-Gm-Message-State: AOAM530LJrScqyd/AtzRb2aaaZqdRa8eEb2fU78yH03oibwjbZldjPZw
        vAYmQuWqnh9/PX3BDqtobBft1w==
X-Google-Smtp-Source: ABdhPJx697oUJ83nF7Cd9d2sEP7NkmFkT4q17z2l7fxpvP2GP2N59OiOp7LkGKrv8kh3as20NPiXmg==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr6887080wrs.28.1599052913650;
        Wed, 02 Sep 2020 06:21:53 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:53 -0700 (PDT)
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
Subject: [PATCH v3 6/6] perf tests tsc: Add checking helper is_supported()
Date:   Wed,  2 Sep 2020 14:21:31 +0100
Message-Id: <20200902132131.36304-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far tsc is enabled on x86_64, i386 and Arm64 architectures, add
checking helper to skip this testing for other architectures.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/perf-time-to-tsc.c | 13 +++++++++++++
 tools/perf/tests/tests.h            |  1 +
 3 files changed, 15 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 67e6a1c6c793..4b57ea79d3e7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -344,6 +344,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Convert perf time to TSC",
 		.func = test__perf_time_to_tsc,
+		.is_supported = test__tsc_is_supported,
 	},
 	{
 		.func = NULL,
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 026d32ed078e..41dadd4cd097 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -171,3 +171,16 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evlist__delete(evlist);
 	return err;
 }
+
+bool test__tsc_is_supported(void)
+{
+	/*
+	 * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.
+	 * Just enable the test for x86_64/i386 and Arm64 archs.
+	 */
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
+	return true;
+#else
+	return false;
+#endif
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1633f54d6156..86466a518d8e 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,7 @@ int test__perf_time_to_tsc(struct test *test, int subtest);
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
+bool test__tsc_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-- 
2.17.1

