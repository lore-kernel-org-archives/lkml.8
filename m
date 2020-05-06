Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A75C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187B420CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778885;
	bh=dEwj4BLtmw/xOXg61wIrK2OssFKv+7yJBHNRM+E5rgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cD5UhG29iIc6ouQ4PqnfwRS8Xyvkiu1WS65pvX85YjNxh9IEqHa7aormZXjTQu1o4
	 jStkkmg9aLbzhmLAba6Yzs62XjVe9J6xZ98BLMoH11nzHVy6APNVUQyVINhU7H6/y1
	 PbWFrT+LK6jk08van99yr4yOiFuoyukoB609jA8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgEFP2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgEFP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F8F20A8B;
        Wed,  6 May 2020 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778835;
        bh=dEwj4BLtmw/xOXg61wIrK2OssFKv+7yJBHNRM+E5rgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHsaDj+eT19ORFZwAe9kk9EQB3Hh8Uzu2qF1joHd7Op6qs6WqIsPiWbBylCus2GwK
         mElDYA7U1J3Cesi+cCZ2k9ZlHmUAI3CwcDqBOQ3bCeeNQmtnhXPTvi7hOg3k6GK7HN
         dg+6I35OlCIha1inDxOxYtksJF6YMpzIrWkP/pRg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 82/91] perf trace: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:25 -0300
Message-Id: <20200506152234.21977-83-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 54 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 31575713ad0b..a46efb907bd4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -366,9 +366,7 @@ static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
 	return NULL;
 }
 
-static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
-					  struct tp_field *field,
-					  const char *name)
+static int evsel__init_tp_uint_field(struct evsel *evsel, struct tp_field *field, const char *name)
 {
 	struct tep_format_field *format_field = evsel__field(evsel, name);
 
@@ -380,11 +378,9 @@ static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 
 #define perf_evsel__init_sc_tp_uint_field(evsel, name) \
 	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
-	   perf_evsel__init_tp_uint_field(evsel, &sc->name, #name); })
+	   evsel__init_tp_uint_field(evsel, &sc->name, #name); })
 
-static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
-					 struct tp_field *field,
-					 const char *name)
+static int evsel__init_tp_ptr_field(struct evsel *evsel, struct tp_field *field, const char *name)
 {
 	struct tep_format_field *format_field = evsel__field(evsel, name);
 
@@ -396,7 +392,7 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 
 #define perf_evsel__init_sc_tp_ptr_field(evsel, name) \
 	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
-	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
+	   evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
 static void evsel__delete_priv(struct evsel *evsel)
 {
@@ -404,13 +400,13 @@ static void evsel__delete_priv(struct evsel *evsel)
 	evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct evsel *evsel)
+static int evsel__init_syscall_tp(struct evsel *evsel)
 {
 	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
 	if (sc != NULL) {
-		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
-		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
+		if (evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
+		    evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
 			return -ENOENT;
 		return 0;
 	}
@@ -418,7 +414,7 @@ static int perf_evsel__init_syscall_tp(struct evsel *evsel)
 	return -ENOMEM;
 }
 
-static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
+static int evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
 {
 	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
@@ -436,21 +432,21 @@ static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evs
 	return -ENOMEM;
 }
 
-static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
+static int evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
 {
 	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
 }
 
-static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
+static int evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 {
 	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
 }
 
-static int perf_evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
+static int evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
 	if (evsel__syscall_tp(evsel) != NULL) {
 		if (perf_evsel__init_sc_tp_uint_field(evsel, id))
@@ -474,7 +470,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	if (IS_ERR(evsel))
 		return NULL;
 
-	if (perf_evsel__init_raw_syscall_tp(evsel, handler))
+	if (evsel__init_raw_syscall_tp(evsel, handler))
 		goto out_delete;
 
 	return evsel;
@@ -1801,7 +1797,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
-static int perf_evsel__init_tp_arg_scnprintf(struct evsel *evsel)
+static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 {
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
@@ -3694,7 +3690,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 	return __trace__deliver_event(trace, event->event);
 }
 
-static struct syscall_arg_fmt *perf_evsel__syscall_arg_fmt(struct evsel *evsel, char *arg)
+static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg)
 {
 	struct tep_format_field *field;
 	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
@@ -3749,7 +3745,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 			scnprintf(arg, sizeof(arg), "%.*s", left_size, left);
 
-			fmt = perf_evsel__syscall_arg_fmt(evsel, arg);
+			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg);
 			if (fmt == NULL) {
 				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
 				       arg, evsel->name, evsel->filter);
@@ -4178,7 +4174,7 @@ static int trace__replay(struct trace *trace)
 							     "syscalls:sys_enter");
 
 	if (evsel &&
-	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
+	    (evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
 	    perf_evsel__init_sc_tp_ptr_field(evsel, args))) {
 		pr_err("Error during initialize raw_syscalls:sys_enter event\n");
 		goto out;
@@ -4190,7 +4186,7 @@ static int trace__replay(struct trace *trace)
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "syscalls:sys_exit");
 	if (evsel &&
-	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
+	    (evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
 	    perf_evsel__init_sc_tp_uint_field(evsel, ret))) {
 		pr_err("Error during initialize raw_syscalls:sys_exit event\n");
 		goto out;
@@ -4470,11 +4466,11 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 			continue;
 
 		if (strcmp(evsel->tp_format->system, "syscalls")) {
-			perf_evsel__init_tp_arg_scnprintf(evsel);
+			evsel__init_tp_arg_scnprintf(evsel);
 			continue;
 		}
 
-		if (perf_evsel__init_syscall_tp(evsel))
+		if (evsel__init_syscall_tp(evsel))
 			return -1;
 
 		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
@@ -4998,8 +4994,8 @@ int cmd_trace(int argc, const char **argv)
 			if (trace.syscalls.events.augmented->priv == NULL &&
 			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
 				struct evsel *augmented = trace.syscalls.events.augmented;
-				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
-				    perf_evsel__init_augmented_syscall_tp_args(augmented))
+				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
+				    evsel__init_augmented_syscall_tp_args(augmented))
 					goto out;
 				/*
 				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
@@ -5013,8 +5009,8 @@ int cmd_trace(int argc, const char **argv)
 				 * as not to filter it, then we'll handle it just like we would
 				 * for the BPF_OUTPUT one:
 				 */
-				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel) ||
-				    perf_evsel__init_augmented_syscall_tp_args(evsel))
+				if (evsel__init_augmented_syscall_tp(evsel, evsel) ||
+				    evsel__init_augmented_syscall_tp_args(evsel))
 					goto out;
 				evsel->handler = trace__sys_enter;
 			}
@@ -5022,7 +5018,7 @@ int cmd_trace(int argc, const char **argv)
 			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
 				struct syscall_tp *sc;
 init_augmented_syscall_tp:
-				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
+				if (evsel__init_augmented_syscall_tp(evsel, evsel))
 					goto out;
 				sc = __evsel__syscall_tp(evsel);
 				/*
@@ -5046,7 +5042,7 @@ int cmd_trace(int argc, const char **argv)
 				 */
 				if (trace.raw_augmented_syscalls)
 					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
-				perf_evsel__init_augmented_syscall_tp_ret(evsel);
+				evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
 			}
 		}
-- 
2.21.1

