Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3DC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C14206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595679623;
	bh=SjbgSq0MtyWTeKrLJoHhHtsIzrGEP4M7ydonpYL6NtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqzK4m5sos8gQT7oU6k1Z+R3YVNKUeOLZ851BLPfhwBayoUiDoe+bjyMlS9ngWOiS
	 36n6wfeFFttRsWPBNgTawXlae4zooqfG+FgeSSdrgDmfGQskNWccA2p16HacEro+rp
	 s9ZUg1rpYn02Ggzw32uXk6FRxMHtuKF9ZKyRhg8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGYMUW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:20:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgGYMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:20:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-6IvaXkHzNJuj31O0Gga7uQ-1; Sat, 25 Jul 2020 08:20:13 -0400
X-MC-Unique: 6IvaXkHzNJuj31O0Gga7uQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3652C100CCC0;
        Sat, 25 Jul 2020 12:20:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DADB05D9DC;
        Sat, 25 Jul 2020 12:20:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf tools: Fix term parsing for raw syntax
Date:   Sat, 25 Jul 2020 14:19:59 +0200
Message-Id: <20200725121959.1181869-2-jolsa@kernel.org>
In-Reply-To: <20200725121959.1181869-1-jolsa@kernel.org>
References: <20200725121959.1181869-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jin Yao reported issue with possible conflict between raw
events and term values in pmu event syntax.

Currently following syntax is resolved as raw event with
0xead value:
  uncore_imc_free_running/read/

instead of using 'read' term from uncore_imc_free_running pmu,
because 'read' is correct raw event syntax with 0xead value.

To solve this issue we do following:
  - check existing terms during rXXXX syntax processing
    and make them priority in case of conflict
  - allow pmu/r0x1234/ syntax to be able to specify conflicting
    raw event (implemented in previous patch)

Also adding automated tests for this and perf_pmu__parse_cleanup
call to parse_events_terms, so the test gets properly cleaned up.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-events.c | 37 ++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.c  | 23 ++++++++++++++++++++
 tools/perf/util/parse-events.h  |  2 ++
 tools/perf/util/parse-events.l  | 19 ++++++++++-------
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5aaddcb0058a..7f9f87a470c3 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -631,6 +631,34 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong val", term->val.num == 1);
 	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "umask"));
 
+	/*
+	 * read
+	 *
+	 * The perf_pmu__test_parse_init injects 'read' term into
+	 * perf_pmu_events_list, so 'read' is evaluated as read term
+	 * and not as raw event with 'ead' hex value.
+	 */
+	term = list_entry(term->list.next, struct parse_events_term, list);
+	TEST_ASSERT_VAL("wrong type term",
+			term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
+	TEST_ASSERT_VAL("wrong type val",
+			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+	TEST_ASSERT_VAL("wrong val", term->val.num == 1);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "read"));
+
+	/*
+	 * r0xead
+	 *
+	 * To be still able to pass 'ead' value with 'r' syntax,
+	 * we added support to parse 'r0xHEX' event.
+	 */
+	term = list_entry(term->list.next, struct parse_events_term, list);
+	TEST_ASSERT_VAL("wrong type term",
+			term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG);
+	TEST_ASSERT_VAL("wrong type val",
+			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+	TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
+	TEST_ASSERT_VAL("wrong config", !term->config);
 	return 0;
 }
 
@@ -1781,7 +1809,7 @@ struct terms_test {
 
 static struct terms_test test__terms[] = {
 	[0] = {
-		.str   = "config=10,config1,config2=3,umask=1",
+		.str   = "config=10,config1,config2=3,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
 	},
 };
@@ -1841,6 +1869,13 @@ static int test_term(struct terms_test *t)
 
 	INIT_LIST_HEAD(&terms);
 
+	/*
+	 * The perf_pmu__test_parse_init prepares perf_pmu_events_list
+	 * which gets freed in parse_events_terms.
+	 */
+	if (perf_pmu__test_parse_init())
+		return -1;
+
 	ret = parse_events_terms(&terms, t->str);
 	if (ret) {
 		pr_debug("failed to parse terms '%s', err %d\n",
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e88e4c7a2a9a..254f02a7fb0d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2019,6 +2019,27 @@ static void perf_pmu__parse_init(void)
 	perf_pmu__parse_cleanup();
 }
 
+int perf_pmu__test_parse_init(void)
+{
+	struct perf_pmu_event_symbol *list;
+
+	list = malloc(sizeof(*list) * 1);
+	if (!list)
+		return -ENOMEM;
+
+	list->type   = PMU_EVENT_SYMBOL;
+	list->symbol = strdup("read");
+
+	if (!list->symbol) {
+		free(list);
+		return -ENOMEM;
+	}
+
+	perf_pmu_events_list = list;
+	perf_pmu_events_list_num = 1;
+	return 0;
+}
+
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name)
 {
@@ -2080,6 +2101,8 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	int ret;
 
 	ret = parse_events__scanner(str, &parse_state);
+	perf_pmu__parse_cleanup();
+
 	if (!ret) {
 		list_splice(parse_state.terms, terms);
 		zfree(&parse_state.terms);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f0010095fc8c..00cde7d2e30c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -261,4 +261,6 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 }
 #endif /* HAVE_LIBELF_SUPPORT */
 
+int perf_pmu__test_parse_init(void);
+
 #endif /* __PERF_PARSE_EVENTS_H */
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 44c85fea5d00..3ca5fd2829ca 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -41,14 +41,6 @@ static int value(yyscan_t scanner, int base)
 	return __value(yylval, text, base, PE_VALUE);
 }
 
-static int raw(yyscan_t scanner)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	return __value(yylval, text + 1, 16, PE_RAW);
-}
-
 static int str(yyscan_t scanner, int token)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
@@ -72,6 +64,17 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
+static int raw(yyscan_t scanner)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	if (perf_pmu__parse_check(text) == PMU_EVENT_SYMBOL)
+		return str(scanner, PE_NAME);
+
+	return __value(yylval, text + 1, 16, PE_RAW);
+}
+
 static bool isbpf_suffix(char *text)
 {
 	int len = strlen(text);
-- 
2.25.4

