Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA03C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFFC20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFduoW3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIBNiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIBNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAFC061251
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so5212880wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSOVJj4da1tYC6z/DHA41bMoIW3TylIOsXwZcMYjIwM=;
        b=gFduoW3yWObBgEKzxn3Z98f2OHzIpuzy/oUxUN4Z5K8IwH/FjXe9XZ0GFIQ6F8jI4u
         jG08pozKjMFLwx4cec6VzRs5D4+XyzlwGRHTeKdKzY7gkVOjbPThA9a0C15Igyp5ri0l
         0a/qsxhIghzi3w4Asl70J0iUW4VnrDw66mfyK1NcE/adu7e8d9lZVWis3tnAy7KacGh9
         tspwVr+b97tmgYFjkP99ZsBveLgiMMyLpmbIGu+nDMVsdHtlfz0UmvCjqojO3JSzZ/ju
         uED/XIMpIaujR+kRgBY0m3tGV0ybncuhrceCqjfQ13EQsJxTtVAt3XAEpS0reFUvzQ2J
         a4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSOVJj4da1tYC6z/DHA41bMoIW3TylIOsXwZcMYjIwM=;
        b=nXje0quAHf07fIscuft5cNN3FN7RsOZcpZf8pFvtK/52INVTEYzOB65pnWBAIizraa
         bq9mSEpGCEjHjv4q6Umdsd5jJsXSljYxLB3lWGaPeBvfFJgm01Hmm28jF9cEQyfg3ndg
         dp8JciifhO+czxGzixbqHoWEz1spqtxhJAWm6Fqy3HIEAHGssqGucpJqKUnWamRN67gz
         vAQ6ieFRkmLfftWI516xuRe6Rzo8TcC3FPY1iHP8G9pjnue/8R0Cg4Z01rRXppTxXMv9
         HrMZuwr8sWRY2QcYchK/RMrh4SvA762tMaJqEGr9zhCLFdPCinaPbS9Z8c9AQqMIMJwE
         KiKw==
X-Gm-Message-State: AOAM532wUQVERz+nrlZoYFA/zAnKa0oJ82PKmPYL5m6+JKbgFeZ3y7pr
        Q7fQFc2ljD11oUBiyrp2IvagOQ==
X-Google-Smtp-Source: ABdhPJylGZZUlpKClRfA+I+/xa7UCYOOb9J3x+3cVAv81W73u6GycRURo7OcMoEn58TUKQFSaJZdkw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr7121515wrx.244.1599052911227;
        Wed, 02 Sep 2020 06:21:51 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:50 -0700 (PDT)
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
Subject: [PATCH v3 4/6] perf tsc: Support cap_user_time_short for event TIME_CONV
Date:   Wed,  2 Sep 2020 14:21:29 +0100
Message-Id: <20200902132131.36304-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesized event TIME_CONV doesn't contain the complete parameters
for counters, this will lead to wrong conversion between counter cycles
and timestamp.

This patch extends event TIME_CONV to record flags 'cap_user_time_zero'
which is used to indicate the counter parameters are valid or not, if
not will directly return 0 for timestamp calculation.  And record the
flag 'cap_user_time_short' and its relevant fields 'time_cycles' and
'time_mask' for cycle calibration.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/perf/include/perf/event.h |  4 ++++
 tools/perf/util/jitdump.c           | 14 +++++++++-----
 tools/perf/util/tsc.c               |  4 ++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 842028858d66..a6dbba6b9073 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -324,6 +324,10 @@ struct perf_record_time_conv {
 	__u64			 time_shift;
 	__u64			 time_mult;
 	__u64			 time_zero;
+	__u64			 time_cycles;
+	__u64			 time_mask;
+	bool			 cap_user_time_zero;
+	bool			 cap_user_time_short;
 };
 
 struct perf_record_header_feature {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 0804308ef285..055bab7a92b3 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -374,11 +374,15 @@ static uint64_t convert_timestamp(struct jit_buf_desc *jd, uint64_t timestamp)
 	if (!jd->use_arch_timestamp)
 		return timestamp;
 
-	tc.time_shift = jd->session->time_conv.time_shift;
-	tc.time_mult  = jd->session->time_conv.time_mult;
-	tc.time_zero  = jd->session->time_conv.time_zero;
-
-	if (!tc.time_mult)
+	tc.time_shift	       = jd->session->time_conv.time_shift;
+	tc.time_mult	       = jd->session->time_conv.time_mult;
+	tc.time_zero	       = jd->session->time_conv.time_zero;
+	tc.time_cycles	       = jd->session->time_conv.time_cycles;
+	tc.time_mask	       = jd->session->time_conv.time_mask;
+	tc.cap_user_time_zero  = jd->session->time_conv.cap_user_time_zero;
+	tc.cap_user_time_short = jd->session->time_conv.cap_user_time_short;
+
+	if (!tc.cap_user_time_zero)
 		return 0;
 
 	return tsc_to_perf_time(timestamp, &tc);
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index c0ca40204649..62b4c75c966c 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -98,6 +98,10 @@ int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
 	event.time_conv.time_mult  = tc.time_mult;
 	event.time_conv.time_shift = tc.time_shift;
 	event.time_conv.time_zero  = tc.time_zero;
+	event.time_conv.time_cycles = tc.time_cycles;
+	event.time_conv.time_mask = tc.time_mask;
+	event.time_conv.cap_user_time_zero = tc.cap_user_time_zero;
+	event.time_conv.cap_user_time_short = tc.cap_user_time_short;
 
 	return process(tool, &event, NULL, machine);
 }
-- 
2.17.1

