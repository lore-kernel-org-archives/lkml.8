Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E4C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0221744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxTio0Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAMPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:18:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37854 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAMPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:18:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so4854871pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8mTqANxv5DHSW2L9Rb94kZJyHHKwSNLneAjemBS510=;
        b=mxTio0Y7CRyOEVA5QUx8Zmc+d9pNPUYeqHPZoahnw+cqEMz4oQ3qDsQEyF0Ij/7kDp
         IgJqVAMLKqsfx+JKU+EV9qk8cm/M9jBJyTVwgDdFT53RgpMxJReg6FXyoztl7afd0EsL
         VBiucLJxb3ypOgYzaXGrxUuzZcPtH04UpOHzfKWUnJonBN2owFIasHl7O2+eG5sOBLaj
         yW7bhcF0WN/JTbGBZytFNCpx9LBUjB6YnIreLH4MmZ02lBF+UsfE+g9s/eZlvyGyw0jI
         TdKJ2Sm8C+Mil73jor6INuX6VWbt3TpqrStwVYveyfuTRBHMbYwvaxXLpzBvEOD4zgwE
         L+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8mTqANxv5DHSW2L9Rb94kZJyHHKwSNLneAjemBS510=;
        b=mRjuJpcZ4HnPvMyJbmiMhsZ/HfQhdoIn1elOAbFfIn2SiJEJOWF+W9XzJY/YbH6ZnO
         IRhYAcaabFxICaFoht1PCvMExswS8M+Wt/V8fVTtDNCt5CefoPJujXsSulsGScoYQIDR
         iNGLvLOMXA9jO9g6LatVanGISc2XYiG1L6/+2mORCNdC8RhHWVIDVOMDeaYQZjZi43eW
         O3id1YVpxDjTFkUn2ZM7Vpp+6zzADBWqZwjqD9khQqvLNWmoQSXhmG7SCsuUc4NsXeE1
         ga45LjadrwA8jQVEstBCVFpDSNiU139tsgkWpZSAwr5ROLynPZm/fUoqcvgwE2gSQTzp
         OVVQ==
X-Gm-Message-State: APjAAAVAACGdt30uUlHXoKdM71oPQorVLHXIbUiGyfLvW2Xg7bjeMVl+
        2hr2hT9tH/39S0Soo2cbc3kOqw==
X-Google-Smtp-Source: APXvYqwDfc0YRYN28OgL6fIvpz43tf0oXRiK76qKO5DOWbG7gHtvSrm8Sum5l4RoRoBSw82CPBvKIw==
X-Received: by 2002:a63:646:: with SMTP id 67mr21302788pgg.150.1578928715832;
        Mon, 13 Jan 2020 07:18:35 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id w8sm13844307pfn.186.2020.01.13.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:18:35 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 2/2] perf parse: Copy string to perf_evsel_config_term
Date:   Mon, 13 Jan 2020 23:18:06 +0800
Message-Id: <20200113151806.17854-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113151806.17854-1-leo.yan@linaro.org>
References: <20200113151806.17854-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf with CoreSight fails to record trace data with command:

  perf record -e cs_etm/@tmc_etr0/u --per-thread ls
  failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
  directory)/perf/

This failure is root caused with the commit 1dc925568f01 ("perf
parse: Add a deep delete for parse event terms").

The log shows, cs_etm fails to parse the sink attribution; cs_etm event
relies on the event configuration to pass sink name, but the event
specific configuration data cannot be passed properly with flow:

  get_config_terms()
    ADD_CONFIG_TERM(DRV_CFG, term->val.str);
      __t->val.str = term->val.str;
        `> __t->val.str is assigned to term->val.str;

  parse_events_terms__purge()
    parse_events_term__delete()
      zfree(&term->val.str);
        `> term->val.str is freed and assigned to NULL pointer;

  cs_etm_set_sink_attr()
    sink = __t->val.str;
      `> sink string has been freed.

To fix this issue, in the function get_config_terms(), this patch
changes to use strdup() for allocation a new duplicate string rather
than directly assignment string pointer.

This patch addes a new field 'free_str' in the data structure
perf_evsel_config_term; 'free_str' is set to true when the union is used
as a string pointer; thus it can tell perf_evsel__free_config_terms() to
free the string.

Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evsel.c        | 2 ++
 tools/perf/util/evsel_config.h | 1 +
 tools/perf/util/parse-events.c | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 549abd43816f..6fe9e28180e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
 		list_del_init(&term->list);
+		if (term->free_str)
+			free(term->val.str);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index b4a65201e4f7..e026ab67b008 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -32,6 +32,7 @@ enum evsel_term_type {
 struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
+	bool		      free_str;
 	union {
 		u64	      period;
 		u64	      freq;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 64b394519a4c..cc36c1f2e7eb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1240,7 +1240,12 @@ do {								\
 #define ADD_CONFIG_TERM_STR(__type, __val)			\
 do {								\
 	ADD_CONFIG_TERM(__type);				\
-	__t->val.str = __val;					\
+	__t->val.str = strdup(__val);				\
+	if (!__t->val.str) {					\
+		zfree(&__t);					\
+		return -ENOMEM;					\
+	}							\
+	__t->free_str = true;					\
 } while (0)
 
 	struct parse_events_term *term;
-- 
2.17.1

