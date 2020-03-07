Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C0C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C532073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKbOA4bB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:31:36 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53722 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:31:35 -0500
Received: by mail-pl1-f202.google.com with SMTP id 2so2741528plb.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 23:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nvst3AaP56nlItqXpc0+4F52f+TlnZkB8BIILlWHxto=;
        b=jKbOA4bB1Ir9nELIHowpTynl98yX6B0mVQXHRh6uiZFvUUCQznNVW7WnOYdMIEqAwv
         CtyNzm9GgNbFhN6+sEZUEseb3mx7kjvyL0QH8mkv+kX70AaMFfXs5y5lTXUX/BBxpRXB
         fW/Ht8ykjk5bFbdjuBLf3bNGSzRrsG8sCqLtt3lKjF6jLwtNeS7pcT9DO9kAMOwaqx8Q
         n7G+TZ+XGSgaqWTloRPdur88HBdUPDnavwUOr7y24oxEZxXfonmeeE+oSPhDBQ0zF2yu
         9g9yLa4XnX0jUxqwSvMiCjgGsSh+pxCOVARd/02xSIr5VqkmAMkCW7f/uCkXwR8LsyNe
         qCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nvst3AaP56nlItqXpc0+4F52f+TlnZkB8BIILlWHxto=;
        b=iPsTAKBfRHxH5F49hffOXrYS3EnbdRebEp+mb0wUlxwUhvvU5w/MLnrOaReTAkIYzr
         0DJhEccT7L1EYmaALJ6SjtYZSM37tQeGNfV8g4JbqvEkgA+J/jNE2IPRLKoZC8VHZqWa
         OvzQgE+VqeIllvHZZdOfuYyAxfhpe1jMOFXxviHBejZKoNwCWBT0Tr3EPmyqjwOgadra
         4VhmMWEeWjOukybtfLgSTzjjzFj5lVAxqSuIhk+pRcHR40hiTNn5C1Hjd5KmBV+nGSNH
         FGSokL03hsRqoeo5Ww7eSNbKZjljv3d/tME6/BJLblplJnCprWztwfIeXZ5SZLMe+cZa
         1NEQ==
X-Gm-Message-State: ANhLgQ2XQ/mGGJcPQPyAAIuoNlNgNdBRMywbIWxrNp6mxyEbmeGBjwIA
        lV8e04u6yJF4WGS+RMwMaw5Aor1Z3Dj8
X-Google-Smtp-Source: ADFU+vsw8x7MWXyDf4IxfrrvBCRczJ7ClsSFvxk8cp71B5CIbfdBnN/K8cUuZ3t7y3wgsPOQB+rbX1y/UhpF
X-Received: by 2002:a17:90b:1989:: with SMTP id mv9mr7699891pjb.72.1583566293905;
 Fri, 06 Mar 2020 23:31:33 -0800 (PST)
Date:   Fri,  6 Mar 2020 23:31:21 -0800
Message-Id: <20200307073121.203816-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 1/1] perf/tool: fix read in event parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADD_CONFIG_TERM accesses term->weak, however, in get_config_chgs this
value is accessed outside of the list_for_each_entry and references
invalid memory. Add an argument for ADD_CONFIG_TERM for weak and set it
to false in the get_config_chgs case.
This bug was cause by clang's address sanitizer and libfuzzer. It can be
reproduced with a command line of:
  perf stat -a -e i/bs,tsc,L2/o

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.25.1.481.gfbce0eb801-goog

