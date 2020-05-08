Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D339C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3375324999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgEHNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730283AbgEHNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9CC05BD43;
        Fri,  8 May 2020 06:04:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gJ-00077m-Nc; Fri, 08 May 2020 15:04:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 634CA1C0080;
        Fri,  8 May 2020 15:04:42 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:42 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Rename perf_evsel__*() operating on
 'struct evsel *' to evsel__*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308237.8414.4685772292822110544.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     794bca26e537413e3d67e935d7ac4f42d39aeda1
Gitweb:        https://git.kernel.org/tip/794bca26e537413e3d67e935d7ac4f42d39aeda1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:57:20 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf trace: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 54 +++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3157571..a46efb9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -366,9 +366,7 @@ out_delete:
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
@@ -5046,7 +5042,7 @@ init_augmented_syscall_tp:
 				 */
 				if (trace.raw_augmented_syscalls)
 					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
-				perf_evsel__init_augmented_syscall_tp_ret(evsel);
+				evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
 			}
 		}
