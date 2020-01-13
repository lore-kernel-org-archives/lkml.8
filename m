Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712DCC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3995A21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wjzz2n96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAMPS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:18:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47031 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAMPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:18:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so4829447pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B3v9KtfRVLcMP3bzkZxOovc2P22Cupcw5q1+cH+SLAo=;
        b=Wjzz2n96sKJS1QC6z2trsjWbqW8PtL1kdpLv29GTElHUmKRDRyGEnpAh4gzC29It1t
         b1MxQds4441JbXh27ZDchdiDpIclEJU9tMbdK7ahg18suf8VbABcOJeqP2gtUbNkziVL
         1JPbEM7jlfYN3arsgDlDSFF2ISibIaqN6/hZQktR+wT74OjZDyX991hgUMU+nP6QChyi
         c7EaI7jwMaLmRNSWRnpPr/dGzEIE/aCoTXlwQ7SnIHYHrIXFxlAb40VJ5MNzsjwGaMks
         QGqFH3VH/n1O1V2CHr3CTSxxXg8YEQ/OE+cc3C6nKALmgrbTFPG1PWTFYLxC7akKCJmt
         ikAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B3v9KtfRVLcMP3bzkZxOovc2P22Cupcw5q1+cH+SLAo=;
        b=T6s4JIvDFfQ0KZWTpvEXkdUXV0qIehe9lko3D2cmNiC0IdTkYxcnDfNmnlspPMmm7o
         yWEW0R5i6WDSRXaaLerwgdPA43q1PIm0oltO78t4LF/2klrJ/ZkJacqnAVQ4Ij2VNMqT
         VZajnJf/Ga4H7MXCvQ7w/IYNOveALx2zSAHV02a3BJi30Wn1Hjr6SxA2lv+KN8NS4Qf1
         LrlRVPEibigrbzcdKht+YPk4EDiaBkQ+iesrxxgLE8rZAWZfev+9AN0LS42yAt3puP85
         Prw9lpJ0RkTFqIy5IAe4+3ZG6FwCnnOpqkYPEQfT8KdJYnjmTmgfS6zN7QyjpiuXxlo5
         6diQ==
X-Gm-Message-State: APjAAAUsd0RkjSuX7dKL1B3H+rRrNIGmfXd9Z8BPoW0Ghj+d2vTvohos
        /MhmTuq3uF6XHjaLEN/y65iPfQ==
X-Google-Smtp-Source: APXvYqwyXUT3hWWx8NEhGL0PgApe2Pfhim+F10Cwc4bTEuGWAQvD6gYxsKyMrh8J7VDr2uOL45pbjA==
X-Received: by 2002:a63:9e12:: with SMTP id s18mr21041025pgd.380.1578928707867;
        Mon, 13 Jan 2020 07:18:27 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id w8sm13844307pfn.186.2020.01.13.07.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:18:27 -0800 (PST)
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
Subject: [PATCH v5 1/2] perf parse: Refactor struct perf_evsel_config_term
Date:   Mon, 13 Jan 2020 23:18:05 +0800
Message-Id: <20200113151806.17854-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct perf_evsel_config_term::val is a union which contains
fields 'callgraph', 'drv_cfg' and 'branch' as string pointers.  This
leads to the complex code logic for handling every type's string
separately, and it's hard to release string as a general way.

This patch refactors the structure to add a common field 'str' in the
'val' union as string pointer and remove the other three fields
'callgraph', 'drv_cfg' and 'branch'.  Without passing field name, the
patch simplifies the string handling with macro ADD_CONFIG_TERM_STR()
for string pointer assignment.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c |  2 +-
 tools/perf/util/evsel.c           |  6 ++--
 tools/perf/util/evsel_config.h    |  4 +--
 tools/perf/util/parse-events.c    | 53 ++++++++++++++++++-------------
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ede040cf82ad..2898cfdf8fe1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -226,7 +226,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		sink = term->val.drv_cfg;
+		sink = term->val.str;
 		snprintf(path, PATH_MAX, "sinks/%s", sink);
 
 		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..549abd43816f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -808,12 +808,12 @@ static void apply_config_terms(struct evsel *evsel,
 				perf_evsel__reset_sample_bit(evsel, TIME);
 			break;
 		case PERF_EVSEL__CONFIG_TERM_CALLGRAPH:
-			callgraph_buf = term->val.callgraph;
+			callgraph_buf = term->val.str;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_BRANCH:
-			if (term->val.branch && strcmp(term->val.branch, "no")) {
+			if (term->val.str && strcmp(term->val.str, "no")) {
 				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
-				parse_branch_str(term->val.branch,
+				parse_branch_str(term->val.str,
 						 &attr->branch_sample_type);
 			} else
 				perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 1f8d2fe0b66e..b4a65201e4f7 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -36,18 +36,16 @@ struct perf_evsel_config_term {
 		u64	      period;
 		u64	      freq;
 		bool	      time;
-		char	      *callgraph;
-		char	      *drv_cfg;
 		u64	      stack_user;
 		int	      max_stack;
 		bool	      inherit;
 		bool	      overwrite;
-		char	      *branch;
 		unsigned long max_events;
 		bool	      percore;
 		bool	      aux_output;
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
+		char	      *str;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ed7c008b9c8b..64b394519a4c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1219,8 +1219,7 @@ static int config_attr(struct perf_event_attr *attr,
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused)
 {
-#define ADD_CONFIG_TERM(__type, __name, __val)			\
-do {								\
+#define ADD_CONFIG_TERM(__type)					\
 	struct perf_evsel_config_term *__t;			\
 								\
 	__t = zalloc(sizeof(*__t));				\
@@ -1229,9 +1228,19 @@ do {								\
 								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->val.__name = __val;				\
 	__t->weak	= term->weak;				\
-	list_add_tail(&__t->list, head_terms);			\
+	list_add_tail(&__t->list, head_terms)
+
+#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
+do {								\
+	ADD_CONFIG_TERM(__type);				\
+	__t->val.__name = __val;				\
+} while (0)
+
+#define ADD_CONFIG_TERM_STR(__type, __val)			\
+do {								\
+	ADD_CONFIG_TERM(__type);				\
+	__t->val.str = __val;					\
 } while (0)
 
 	struct parse_events_term *term;
@@ -1239,53 +1248,53 @@ do {								\
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM(TIME, time, term->val.num);
+			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
+			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
+			ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
+			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
-			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
-			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
+			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events, term->val.num);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
-			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 0 : 1);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
+			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
-			ADD_CONFIG_TERM(PERCORE, percore,
-					term->val.num ? true : false);
+			ADD_CONFIG_TERM_VAL(PERCORE, percore,
+					    term->val.num ? true : false);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
-			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
+			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
 			break;
 		default:
 			break;
@@ -1322,7 +1331,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
 
 #undef ADD_CONFIG_TERM
 	return 0;
-- 
2.17.1

