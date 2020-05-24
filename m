Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD23C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2F120776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360165;
	bh=YvthoGIsnbxv7y6P6dvXj0HFYo5wbZ2Yl2ZNYPD7PA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P5L4KVasytfCU/JKWU+zj62BrqCvuynNk8fORnmMdImbGLdWr1vUpsRt6DaLSkjh9
	 T7vE7qLeBoudPIviZWo2ElU8iEstVWEITAFaaw/vdX86XnTAXFoAPae+pN4fl45ogo
	 pJpByEcx70KQHRRIlCFN1F5rxeVjI+Gbaq9nHzvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbgEXWmo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:42:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46370 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387850AbgEXWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-RMqsU2sTO66M6GJ_uTm6Zg-1; Sun, 24 May 2020 18:42:36 -0400
X-MC-Unique: RMqsU2sTO66M6GJ_uTm6Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51EEA107ACCD;
        Sun, 24 May 2020 22:42:34 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06E7E5D788;
        Sun, 24 May 2020 22:42:31 +0000 (UTC)
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
Subject: [PATCH 03/14] perf tools: Add struct parse_events_state pointer to scanner
Date:   Mon, 25 May 2020 00:42:08 +0200
Message-Id: <20200524224219.234847-4-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to pass more data to the scanner so let's
start with having it to take pointer to struct
parse_events_state object instead of just start
token.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 15 +++++++++------
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  8 ++++----
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e0ccf027d214..27b8e49d690e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -26,7 +26,7 @@
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
 #include "parse-events-bison.h"
-#define YY_EXTRA_TYPE int
+#define YY_EXTRA_TYPE void*
 #include "parse-events-flex.h"
 #include "pmu.h"
 #include "thread_map.h"
@@ -2027,13 +2027,14 @@ perf_pmu__parse_check(const char *name)
 	return r ? r->type : PMU_EVENT_SYMBOL_ERR;
 }
 
-static int parse_events__scanner(const char *str, void *parse_state, int start_token)
+static int parse_events__scanner(const char *str,
+				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
 	void *scanner;
 	int ret;
 
-	ret = parse_events_lex_init_extra(start_token, &scanner);
+	ret = parse_events_lex_init_extra(parse_state, &scanner);
 	if (ret)
 		return ret;
 
@@ -2057,11 +2058,12 @@ static int parse_events__scanner(const char *str, void *parse_state, int start_t
 int parse_events_terms(struct list_head *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
-		.terms = NULL,
+		.terms  = NULL,
+		.stoken = PE_START_TERMS,
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state, PE_START_TERMS);
+	ret = parse_events__scanner(str, &parse_state);
 	if (!ret) {
 		list_splice(parse_state.terms, terms);
 		zfree(&parse_state.terms);
@@ -2080,10 +2082,11 @@ int parse_events(struct evlist *evlist, const char *str,
 		.idx    = evlist->core.nr_entries,
 		.error  = err,
 		.evlist = evlist,
+		.stoken = PE_START_EVENTS,
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
+	ret = parse_events__scanner(str, &parse_state);
 	perf_pmu__parse_cleanup();
 
 	if (!ret && list_empty(&parse_state.list)) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 6ead9661238c..d60510e0609f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -128,6 +128,7 @@ struct parse_events_state {
 	struct parse_events_error *error;
 	struct evlist	  *evlist;
 	struct list_head	  *terms;
+	int			   stoken;
 };
 
 void parse_events__handle_error(struct parse_events_error *err, int idx,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 394132254447..002802e17059 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -209,10 +209,10 @@ modifier_bp	[rwx]{1,3}
 %%
 
 %{
-	{
-		int start_token;
+	struct parse_events_state *_parse_state = parse_events_get_extra(yyscanner);
 
-		start_token = parse_events_get_extra(yyscanner);
+	{
+		int start_token = _parse_state->stoken;
 
 		if (start_token == PE_START_TERMS)
 			BEGIN(config);
@@ -220,7 +220,7 @@ modifier_bp	[rwx]{1,3}
 			BEGIN(event);
 
 		if (start_token) {
-			parse_events_set_extra(NULL, yyscanner);
+			_parse_state->stoken = 0;
 			/*
 			 * The flex parser does not init locations variable
 			 * via the scan_string interface, so we need do the
-- 
2.25.4

