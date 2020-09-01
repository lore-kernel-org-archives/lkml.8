Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336BBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F31E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hmev6mrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgIAIi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgIAIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B47C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so297615wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMYXU9TL7zgFGEjWywBpuTYQrfrAALWjKCfbRM8tz4U=;
        b=Hmev6mrAeRXwv9TDgymSrwbqP2T7KHCm8aTnLhkvSgPxMmDCmsyzv591Pi7ENETJNI
         OmrrG36C57kBrsz806Jv0SEXlufcKNhc5yJcHYYydX/Us3cTawmFjtZ/VBBM/9IfTDlN
         Uz5j4PlCKOhKhQFZGiwTF2x8xgSzp2IQ0XlxuNoHko/UvyIX1vNGdomKp3PGBtupTIZz
         mY613eumedspLRfL6QtS9DMiu6OI3RWQYZGKeKa9WVHdllAspTEaaVaryqkhdLpVG9/1
         XVCeNSxwxvp0SB6FLdtqnSaemiaY6p6bWgxaVCxk68NGPv7XDGHJRjZqN1/hE6hpRhln
         NHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMYXU9TL7zgFGEjWywBpuTYQrfrAALWjKCfbRM8tz4U=;
        b=HEsJasQGAn0BW1FMV5cdCiMl9wzOFi8o9k4XjygasE1VwHSxbqb0OTgRyvqQuc31rh
         Zlt8rQs9TLY08uOYx8FkmhuE8Z7fGtLCzsC+otFcQVzPbkSHanBX83UZ9vuhqIH11yVX
         L6CxNoz7j3JQc35F3kJ1WWINI7xxu0Z56vOAp5lljK9x0u/v3itRC2Uq3/cf47KFgE8U
         0HZ1Ka7mfvKsi+LU17h4Ld40SACipSHI2ssZeQ5KDRhycpE+MbR93g6hsvT7+A/2x3We
         i/M8DP628bsozw8ZJMlBYPl7qcsQTzaENaXYo3KNGYBZvUXogosTBgzWHKysuuWuU7Ox
         RU7Q==
X-Gm-Message-State: AOAM533klTM+PHDGqmkQJ93qTGiv1cm6NsvdWhb8fJYZN8XOWt5GDYpE
        HpSwmih9ECZ+P7m5n/gpNPlUaw==
X-Google-Smtp-Source: ABdhPJyINPVHbx2F6P9tfTG/mccXmJClITl695E+wu2QobEglQFHRjWVeVu76SUdhMIX0m17vY6Mvg==
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr671638wmj.64.1598949519428;
        Tue, 01 Sep 2020 01:38:39 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:38 -0700 (PDT)
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
Subject: [PATCH v2 06/14] perf mem: Support AUX trace
Date:   Tue,  1 Sep 2020 09:38:07 +0100
Message-Id: <20200901083815.13755-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf memory profiling doesn't support aux trace data so the tool cannot
receive the synthesized samples from hardware tracing data.  On the
Arm64 platform, though it doesn't support PMU events for memory load and
store, but Armv8's SPE is a good candidate for memory profiling, the
hardware tracer can record memory accessing operations with physical
address and virtual address for different cache levels and it also stats
the memory operations for remote access and TLB.

To allow the perf memory tool to support AUX trace, this patches adds
the aux callbacks for session structure.  It passes the predefined
itrace option to ask the AUX trace decoder to generate memory samples.
This patch also invokes the standard API perf_event__process_attr() to
register sample IDs into evlist.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index b9432ee27754..ded416d68d88 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -7,6 +7,7 @@
 #include "perf.h"
 
 #include <subcmd/parse-options.h>
+#include "util/auxtrace.h"
 #include "util/trace-event.h"
 #include "util/tool.h"
 #include "util/session.h"
@@ -252,6 +253,12 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int report_raw_events(struct perf_mem *mem)
 {
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = true,
+		.mem = true,		/* Memory samples */
+		.default_no_sample = true,
+	};
+
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -264,6 +271,8 @@ static int report_raw_events(struct perf_mem *mem)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	session->itrace_synth_opts = &itrace_synth_opts;
+
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
 					       mem->cpu_bitmap);
@@ -397,6 +406,19 @@ parse_mem_ops(const struct option *opt, const char *str, int unset)
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
@@ -408,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
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
2.20.1

