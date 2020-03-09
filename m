Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D33C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046B921655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780036;
	bh=Y6ql1chUrNII42WXzUr57V5ihL4kwrUzDas0fH4bOts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1fQnEG82fM+8OmuhKlnyeKK/f9oe+mjdVJ9NMqQd4kYz8a0kHF2YqjxTRAgILBEoG
	 pc3+TULzHtmczd92tC0zdVk8jKvV0pRW1S0BjQhwd1jLZdxa5Gg8uvWEGhE0o5eHHl
	 SgXTLMZjoj4OP3rZ+DLdKmsadDb0qo3CzQ3VNxGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCISxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgCISxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:53:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207FB222C3;
        Mon,  9 Mar 2020 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780031;
        bh=Y6ql1chUrNII42WXzUr57V5ihL4kwrUzDas0fH4bOts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUJjk4XDSGGpjQuOulR8iJt73rpLJhwqmDAX92agFAV/2OE/YHGMEz/nto8YJ0KHd
         Vk9b72CWOMMD9r8z1X2U2mewTy4KGmeNew/1j1Ch/K82UuP1OIs7OTPt67MpjsAjVy
         IMaVNaAyiC16tjEv4WFoY214qmfO+QgbjoreNI/w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf parse-events: Fix reading of invalid memory in event parsing
Date:   Mon,  9 Mar 2020 15:53:21 -0300
Message-Id: <20200309185323.22583-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

ADD_CONFIG_TERM accesses term->weak, however, in get_config_chgs this
value is accessed outside of the list_for_each_entry and references
invalid memory. Add an argument for ADD_CONFIG_TERM for weak and set it
to false in the get_config_chgs case.

This bug was cause by clang's address sanitizer and libfuzzer. It can be
reproduced with a command line of:

  perf stat -a -e i/bs,tsc,L2/o

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200307073121.203816-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a14995835d85..a7dc0b096974 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1213,7 +1213,7 @@ static int config_attr(struct perf_event_attr *attr,
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused)
 {
-#define ADD_CONFIG_TERM(__type)					\
+#define ADD_CONFIG_TERM(__type, __weak)				\
 	struct perf_evsel_config_term *__t;			\
 								\
 	__t = zalloc(sizeof(*__t));				\
@@ -1222,18 +1222,18 @@ static int get_config_terms(struct list_head *head_config,
 								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->weak	= term->weak;				\
+	__t->weak	= __weak;				\
 	list_add_tail(&__t->list, head_terms)
 
-#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
+#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)	\
 do {								\
-	ADD_CONFIG_TERM(__type);				\
+	ADD_CONFIG_TERM(__type, __weak);			\
 	__t->val.__name = __val;				\
 } while (0)
 
-#define ADD_CONFIG_TERM_STR(__type, __val)			\
+#define ADD_CONFIG_TERM_STR(__type, __val, __weak)		\
 do {								\
-	ADD_CONFIG_TERM(__type);				\
+	ADD_CONFIG_TERM(__type, __weak);			\
 	__t->val.str = strdup(__val);				\
 	if (!__t->val.str) {					\
 		zfree(&__t);					\
@@ -1247,62 +1247,62 @@ do {								\
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
+			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
+			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
+			ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
 			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
 			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
 			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 0 : 1);
+					    term->val.num ? 0 : 1, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
 			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 0 : 1);
+					    term->val.num ? 0 : 1, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
+			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 			ADD_CONFIG_TERM_VAL(PERCORE, percore,
-					    term->val.num ? true : false);
+					    term->val.num ? true : false, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		default:
 			break;
@@ -1339,7 +1339,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
 
 #undef ADD_CONFIG_TERM
 	return 0;
-- 
2.21.1

