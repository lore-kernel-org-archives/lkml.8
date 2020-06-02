Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CFA206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098669;
	bh=Lxmwor+KAE+F6H+sAca6pvyYQl4LUw0cRmkRF9w2s38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YivRp4XdxTtrNGTzgpFEi044/JUsBPiZ2SNmekAFzqFL5GWbmM+hnDGxn1v7UpQo+
	 P5dxAMbVOOxofYzgdqNVz29/5nSLg+tyU1cYhUQq5mWihkv+CeSifFMWBoYbV8Ydjq
	 dhAgsMH0UI7pYjvktn4GXb/G54WlHfRIlvaRjgL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgFBLvJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58087 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbgFBLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-904prpegM2WX3sTIDkCdog-1; Tue, 02 Jun 2020 07:51:03 -0400
X-MC-Unique: 904prpegM2WX3sTIDkCdog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2BD780B713;
        Tue,  2 Jun 2020 11:51:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7F310013D7;
        Tue,  2 Jun 2020 11:50:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/13] perf tools: Add fake pmu support
Date:   Tue,  2 Jun 2020 13:50:43 +0200
Message-Id: <20200602115055.1168446-2-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the way to create pmu event without the actual
PMU being in place. This way we can test metrics defined
for any processors.

The interface is to define fake_pmu in struct parse_events_state
data. It will be used only in tests via special interface
function added in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 14 +++++++++---
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.l |  8 +++++--
 tools/perf/util/parse-events.y | 41 ++++++++++++++++++++++++++++++++--
 4 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3decbb203846..d521b38fa677 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1429,6 +1429,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 bool auto_merge_stats,
 			 bool use_alias)
 {
+	bool is_fake = parse_state->fake_pmu;
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct perf_pmu *pmu;
@@ -1450,7 +1451,14 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		fprintf(stderr, "' that may result in non-fatal errors\n");
 	}
 
-	pmu = perf_pmu__find(name);
+	if (is_fake) {
+		static struct perf_pmu fake_pmu = { };
+
+		pmu = &fake_pmu;
+	} else {
+		pmu = perf_pmu__find(name);
+	}
+
 	if (!pmu) {
 		char *err_str;
 
@@ -1483,7 +1491,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		}
 	}
 
-	if (perf_pmu__check_alias(pmu, head_config, &info))
+	if (!is_fake && perf_pmu__check_alias(pmu, head_config, &info))
 		return -EINVAL;
 
 	if (verbose > 1) {
@@ -1516,7 +1524,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
 		return -ENOMEM;
 
-	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+	if (!is_fake && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		struct evsel_config_term *pos, *tmp;
 
 		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1fe23a2f9b36..9d6846bea6ab 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -127,9 +127,10 @@ struct parse_events_state {
 	int			   idx;
 	int			   nr_groups;
 	struct parse_events_error *error;
-	struct evlist	  *evlist;
+	struct evlist		  *evlist;
 	struct list_head	  *terms;
 	int			   stoken;
+	bool			   fake_pmu;
 };
 
 void parse_events__handle_error(struct parse_events_error *err, int idx,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 002802e17059..56912c9641f5 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -129,12 +129,16 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int pmu_str_check(yyscan_t scanner)
+static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_state)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
 	yylval->str = strdup(text);
+
+	if (parse_state->fake_pmu)
+		return PE_PMU_EVENT_FAKE;
+
 	switch (perf_pmu__parse_check(text)) {
 		case PMU_EVENT_SYMBOL_PREFIX:
 			return PE_PMU_EVENT_PRE;
@@ -376,7 +380,7 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
 {bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
 {bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
-{name}			{ return pmu_str_check(yyscanner); }
+{name}			{ return pmu_str_check(yyscanner, _parse_state); }
 {name_tag}		{ return str(yyscanner, PE_NAME); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c4ca932d092d..30f623692cf1 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -69,7 +69,7 @@ static void inc_group_count(struct list_head *list,
 %token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
+%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %type <num> PE_VALUE
@@ -87,7 +87,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
+%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
 %destructor { free ($$); } <str>
 %type <term> event_term
@@ -356,6 +356,43 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 		YYABORT;
 	$$ = list;
 }
+|
+PE_PMU_EVENT_FAKE sep_dc
+{
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	if (!list)
+		YYABORT;
+
+	err = parse_events_add_pmu(_parse_state, list, $1, NULL, false, false);
+	free($1);
+	if (err < 0) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_PMU_EVENT_FAKE opt_pmu_config
+{
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	if (!list)
+		YYABORT;
+
+	err = parse_events_add_pmu(_parse_state, list, $1, $2, false, false);
+	free($1);
+	parse_events_terms__delete($2);
+	if (err < 0) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.25.4

