Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EE1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5D02245C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUp1Ntr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHFDIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHFDIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so16146862pls.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RU78NQx1PS87rKw1B6pRtoGaZl6+eAt/ZvZRlGLVgEU=;
        b=UUp1Ntr5stSqOD9BrxESRW5/j1pJzJPe6g59iG4S2jTKLrakUr1hHb5EeicLQu5q3B
         bXGZI2IloSsZtx6qLMZ7UPf1ZvU1NgwQ/cfHY55I1VCNajOGMc4NDbUwG3FtpC2/I6IL
         WZwPQcpe+32fJf/nywCDJaz7ON2I2fft6iL6HAE0RxJEQ1TOGck0YQFuCetUpJ03gNQX
         m3IfeIfAdMI/Kcv8yu93VXvfPQVh6I+Ym1jR/OQlGEXmGJE0e+Sn9ZBSK4gk6RfJkWyP
         iPwW5hrzjZatbzdBQO75MXWNAPDo5lcRfcjxuLGNiiJ4Xk2VnszDSwP6sl1WM9k4c4tr
         fb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RU78NQx1PS87rKw1B6pRtoGaZl6+eAt/ZvZRlGLVgEU=;
        b=FDkajY4SMME8HrgIaZ38n5xMU5iQMXKrTMTQJ9ZxkHeXAK9osMOx7+8RLwLwFivcky
         RbTL7etiZ9qc6UAXpUt+DQ5abvKhw+AKXqzGbK3d6BJSHyzWt+w5y8Jpey+IGwc0scsq
         9OGhp3AU8aXcOl/fwE6TeNlhTD3W3OfVo6knDqhEat/kiAB0Zi9teOKXjB+7gr03s8HO
         gFYC9uZVO/MUjTD5V6dbucW7Nk94ZW8IsLWFtozsbwYAZwu8HpE77WWoVmdvNK3WKuF4
         ULQGwFy8krUB9R/uvq1Ok8chc/Mdyhr5r3cGJ2iKhTWcLBJTpk+rKEETPZDz0eIADKbc
         8dgA==
X-Gm-Message-State: AOAM532DEkjiG7hFVb58thjcTZTddRiFOjQ5Bime04ka5a4zunKkkia0
        3oZ/LFkWhV7Uj0u6dBM8BzJL/Q==
X-Google-Smtp-Source: ABdhPJzkFPGKsRZx+A9TSV2yvNcsNlwspUJAC6yTNBp8m2LyoHoyEMnmfZSE5z2LZQI/RfGoadIFsw==
X-Received: by 2002:a17:90a:6a0b:: with SMTP id t11mr6468213pjj.154.1596683296320;
        Wed, 05 Aug 2020 20:08:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z77sm6012043pfc.199.2020.08.05.20.08.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:15 -0700 (PDT)
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
Subject: [PATCH RESEND v1 05/11] perf mem: Support AUX trace
Date:   Thu,  6 Aug 2020 11:07:21 +0800
Message-Id: <20200806030727.30267-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf memory profiling doesn't support aux trace data so the tool cannot
receive the synthesized samples from hardware tracing data.  On the
Arm64 platform, though it doesn't support PMU events for memory load and
store, but Armv8's SPE is a good candidate for memory profiling, the
hardware tracer can record memory accessing operations with physical
address and virtual address for different cache level and it also stats
the memory operations for remote access and TLB.

To allow the perf memory tool to support AUX trace, this patches adds
the aux callbacks for session structure.  It passes the predefined synth
options (like llc, flc, remote_access, tlb, etc) so this notifies the
tracing decoder to generate corresponding samples.  This patch also
invokes the standard API perf_event__process_attr() to register sample
IDs into evlist.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index a7204634893c..6c8b5e956a4a 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -7,6 +7,7 @@
 #include "perf.h"
 
 #include <subcmd/parse-options.h>
+#include "util/auxtrace.h"
 #include "util/trace-event.h"
 #include "util/tool.h"
 #include "util/session.h"
@@ -249,6 +250,15 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int report_raw_events(struct perf_mem *mem)
 {
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = true,
+		.flc = true,		/* First level cache samples */
+		.llc = true,		/* Last level cache samples */
+		.tlb = true,		/* TLB samples */
+		.remote_access = true,	/* Remote access samples */
+		.default_no_sample = true,
+	};
+
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -261,6 +271,8 @@ static int report_raw_events(struct perf_mem *mem)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	session->itrace_synth_opts = &itrace_synth_opts;
+
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
 					       mem->cpu_bitmap);
@@ -394,6 +406,19 @@ parse_mem_ops(const struct option *opt, const char *str, int unset)
 	return ret;
 }
 
+static int process_attr(struct perf_tool *tool __maybe_unused,
+			union perf_event *event,
+			struct evlist **pevlist)
+{
+	int err;
+
+	err = perf_event__process_attr(tool, event, pevlist);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
@@ -405,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
 			.comm		= perf_event__process_comm,
 			.lost		= perf_event__process_lost,
 			.fork		= perf_event__process_fork,
+			.attr		= process_attr,
 			.build_id	= perf_event__process_build_id,
 			.namespaces	= perf_event__process_namespaces,
+			.auxtrace_info  = perf_event__process_auxtrace_info,
+			.auxtrace       = perf_event__process_auxtrace,
+			.auxtrace_error = perf_event__process_auxtrace_error,
 			.ordered_events	= true,
 		},
 		.input_name		 = "perf.data",
-- 
2.17.1

