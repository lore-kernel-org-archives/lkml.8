Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3912C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36A9221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596818936;
	bh=Fg3Aw0IDcexSj+nRhIX1U3XSgab99WBZOgFlAsu4IIM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hnkVVTt2XuZ+t1WHdcDCjw1eU0KBKNF/lcefUKTltwu07APsw8n0UdYResSOXyiLk
	 0spko+3gatbKOgRradjYtUzYR0gCGA3E58la28xG1Vgt3Xo0mGXpc7pc3+JjAOj91D
	 i+Jc13slfxzMVHifuEzE3c534Lkt6AdgJofl5PGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHGQsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:48:51 -0400
Received: from C02YQ0RWLVCF.internal.digitalocean.com (c-73-181-34-237.hsd1.co.comcast.net [73.181.34.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D14D221E2;
        Fri,  7 Aug 2020 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596818930;
        bh=Fg3Aw0IDcexSj+nRhIX1U3XSgab99WBZOgFlAsu4IIM=;
        h=From:To:Cc:Subject:Date:From;
        b=sc5e5teQfZZ/8vtM7WWGhTGSYRb41w5uS/rIbs5W1ScQZD2vQmzwzp4nS9genHrdD
         XXp1EzJfxa8zKK4LfLbzXf/to2h94CMXvYMavHs2IXD1gac5pHWCT9X1bElhFjoL/o
         Q1AMr+zi2/A9TigcD/Fz1M24cSOMwIZhJfauDZq8=
From:   David Ahern <dsahern@kernel.org>
To:     acme@kernel.org
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
Date:   Fri,  7 Aug 2020 10:48:44 -0600
Message-Id: <20200807164844.44870-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fbd705a0c618 ("sched: Introduce the 'trace_sched_waking' tracepoint")
added sched_waking tracepoint which should be preferred over sched_wakeup
when analyzing scheduling delays.

Update 'perf sched record' to collect sched_waking events if it exists
and fallback to sched_wakeup if it does not. Similarly, update timehist
command to skip sched_wakeup events if the session includes
sched_waking (ie., sched_waking is preferred over sched_wakeup).

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/perf/builtin-sched.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 459e4229945e..0c7d599fa555 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2398,6 +2398,15 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 	printf("\n");
 }
 
+static int timehist_sched_wakeup_ignore(struct perf_tool *tool __maybe_unused,
+					union perf_event *event __maybe_unused,
+					struct evsel *evsel __maybe_unused,
+					struct perf_sample *sample __maybe_unused,
+					struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
 static int timehist_sched_wakeup_event(struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
 				       struct evsel *evsel,
@@ -2958,9 +2967,10 @@ static int timehist_check_attr(struct perf_sched *sched,
 
 static int perf_sched__timehist(struct perf_sched *sched)
 {
-	const struct evsel_str_handler handlers[] = {
+	struct evsel_str_handler handlers[] = {
 		{ "sched:sched_switch",       timehist_sched_switch_event, },
 		{ "sched:sched_wakeup",	      timehist_sched_wakeup_event, },
+		{ "sched:sched_waking",       timehist_sched_wakeup_event, },
 		{ "sched:sched_wakeup_new",   timehist_sched_wakeup_event, },
 	};
 	const struct evsel_str_handler migrate_handlers[] = {
@@ -3018,6 +3028,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	setup_pager();
 
+	/* prefer sched_waking if it is captured */
+	if (perf_evlist__find_tracepoint_by_name(session->evlist,
+						  "sched:sched_waking"))
+		handlers[1].handler = timehist_sched_wakeup_ignore;
+
 	/* setup per-evsel handlers */
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out;
@@ -3330,12 +3345,16 @@ static int __cmd_record(int argc, const char **argv)
 		"-e", "sched:sched_stat_iowait",
 		"-e", "sched:sched_stat_runtime",
 		"-e", "sched:sched_process_fork",
-		"-e", "sched:sched_wakeup",
 		"-e", "sched:sched_wakeup_new",
 		"-e", "sched:sched_migrate_task",
 	};
+	struct tep_event *waking_event;
 
-	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+	/*
+	 * +2 for either "-e", "sched:sched_wakeup" or
+	 * "-e", "sched:sched_waking"
+	 */
+	rec_argc = ARRAY_SIZE(record_args) + 2 + argc - 1;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 
 	if (rec_argv == NULL)
@@ -3344,6 +3363,13 @@ static int __cmd_record(int argc, const char **argv)
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = strdup(record_args[i]);
 
+	rec_argv[i++] = "-e";
+	waking_event = trace_event__tp_format("sched", "sched_waking");
+	if (!IS_ERR(waking_event))
+		rec_argv[i++] = strdup("sched:sched_waking");
+	else
+		rec_argv[i++] = strdup("sched:sched_wakeup");
+
 	for (j = 1; j < (unsigned int)argc; j++, i++)
 		rec_argv[i] = argv[j];
 
-- 
2.17.1

