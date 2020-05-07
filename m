Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58C820CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588845074;
	bh=TGIxpS1LinEbb5t9ldAwJgUFNFzGnm2VJ+9sF7EG9xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0yobSrZk4f8mhhnNiv6f2h9rrpW/SV3H6inVbmDSPYLctKZ3+sIMNqLmw8GLE2/yI
	 Y78xp99hwe8OXR9LoiPAlBqwwVyaj9Mhk8PkD57ggBziTxE/QQ6ITGeEufUfCwstdh
	 7S578J3/fRDBnqv/IiJpO7U9IkSKfU7BK8MTJGMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEGJvN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:51:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgEGJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:51:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-hJDBiqwANdixxF7KGMlaSg-1; Thu, 07 May 2020 05:51:04 -0400
X-MC-Unique: hJDBiqwANdixxF7KGMlaSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BED7801503;
        Thu,  7 May 2020 09:51:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B64100164D;
        Thu,  7 May 2020 09:51:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 4/5] perf tools: Setup callchain properly in pipe mode
Date:   Thu,  7 May 2020 11:50:23 +0200
Message-Id: <20200507095024.2789147-5-jolsa@kernel.org>
In-Reply-To: <20200507095024.2789147-1-jolsa@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 3
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callchains are automatically initialized by checking
on event's sample_type. For pipe mode we need to put
this check into attr event code.

Moving the callchains setup code into callchain_param_setup
function and calling it from attr event process code.

This enables pipe output having callchains, like:

  # perf record -g -e 'raw_syscalls:sys_enter' true | perf script
  # perf record -g -e 'raw_syscalls:sys_enter' true | perf report

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 33 ++++++++++++++++++++++-----------
 tools/perf/builtin-script.c | 14 ++++++++++++--
 tools/perf/util/callchain.c | 14 ++++++++++++++
 tools/perf/util/callchain.h |  1 +
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ba63390246c2..5b7c6db4c930 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -402,16 +402,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
-		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER)) {
-			callchain_param.record_mode = CALLCHAIN_DWARF;
-			dwarf_callchain_users = true;
-		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
-			callchain_param.record_mode = CALLCHAIN_LBR;
-		else
-			callchain_param.record_mode = CALLCHAIN_FP;
-	}
+	callchain_param_setup(sample_type);
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -1090,6 +1081,26 @@ parse_percent_limit(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int process_attr(struct perf_tool *tool __maybe_unused,
+			union perf_event *event,
+			struct evlist **pevlist)
+{
+	u64 sample_type;
+	int err;
+
+	err = perf_event__process_attr(tool, event, pevlist);
+	if (err)
+		return err;
+
+	/*
+	 * Check if we need to enable callchains based
+	 * on events sample_type.
+	 */
+	sample_type = perf_evlist__combined_sample_type(*pevlist);
+	callchain_param_setup(sample_type);
+	return 0;
+}
+
 int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
@@ -1120,7 +1131,7 @@ int cmd_report(int argc, const char **argv)
 			.fork		 = perf_event__process_fork,
 			.lost		 = perf_event__process_lost,
 			.read		 = process_read_event,
-			.attr		 = perf_event__process_attr,
+			.attr		 = process_attr,
 			.tracing_data	 = perf_event__process_tracing_data,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 56d7bcd12671..5c4a580c048a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2085,6 +2085,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct evlist *evlist;
 	struct evsel *evsel, *pos;
+	u64 sample_type;
 	int err;
 	static struct evsel_script *es;
 
@@ -2119,10 +2120,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 
 	set_print_ip_opts(&evsel->core.attr);
 
-	if (evsel->core.attr.sample_type)
+	if (evsel->core.attr.sample_type) {
 		err = perf_evsel__check_attr(evsel, scr->session);
+		if (err)
+			return err;
+	}
 
-	return err;
+	/*
+	 * Check if we need to enable callchains based
+	 * on events sample_type.
+	 */
+	sample_type = perf_evlist__combined_sample_type(evlist);
+	callchain_param_setup(sample_type);
+	return 0;
 }
 
 static int print_event_with_time(struct perf_tool *tool,
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 818aa4efd386..2775b752f2fa 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1599,3 +1599,17 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 	for (node = cursor->first; node != NULL; node = node->next)
 		map__zput(node->ms.map);
 }
+
+void callchain_param_setup(u64 sample_type)
+{
+	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
+		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		    (sample_type & PERF_SAMPLE_STACK_USER)) {
+			callchain_param.record_mode = CALLCHAIN_DWARF;
+			dwarf_callchain_users = true;
+		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			callchain_param.record_mode = CALLCHAIN_LBR;
+		else
+			callchain_param.record_mode = CALLCHAIN_FP;
+	}
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 8f668ee29f25..fe36a9e5ccd1 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -297,4 +297,5 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
+void callchain_param_setup(u64 sample_type);
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.25.4

