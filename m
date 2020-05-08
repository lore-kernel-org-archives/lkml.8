Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C209624994
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEHNFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730444AbgEHNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15CC05BD43;
        Fri,  8 May 2020 06:05:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gc-0007R0-6L; Fri, 08 May 2020 15:05:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D80A21C0838;
        Fri,  8 May 2020 15:04:53 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__config*() to evsel__config*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309375.8414.12372751634790248776.tip-bot2@tip-bot2>
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

Commit-ID:     6ec17b4e2592a328b08e888d107e31cfd69d6abb
Gitweb:        https://git.kernel.org/tip/6ec17b4e2592a328b08e888d107e31cfd69d6abb
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:57:01 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__config*() to evsel__config*()

As they are all 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  |  8 +++----
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/util/evsel.c                     | 22 +++++++++-----------
 tools/perf/util/evsel.h                     | 10 +++------
 tools/perf/util/evsel_config.h              |  2 +-
 tools/perf/util/record.c                    |  9 +++-----
 6 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 01d5420..f2e8325 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3124,8 +3124,8 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	if (perf_evsel__init_sc_tp_uint_field(sys_exit, ret))
 		goto out_delete_sys_exit;
 
-	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
-	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
+	evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
+	evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
 
 	evlist__add(evlist, sys_enter);
 	evlist__add(evlist, sys_exit);
@@ -3849,7 +3849,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_maj = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
-		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
+		evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
 		evlist__add(evlist, pgfault_maj);
 	}
 
@@ -3857,7 +3857,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_min = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MIN);
 		if (pgfault_min == NULL)
 			goto out_error_mem;
-		perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
+		evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
 		evlist__add(evlist, pgfault_min);
 	}
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index c6b2d7a..a77492b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -60,7 +60,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evsel__config(evsel, &opts, NULL);
+	evsel__config(evsel, &opts, NULL);
 
 	perf_thread_map__set_pid(evlist->core.threads, 0, getpid());
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 11e7547..f88cf79 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -686,9 +686,8 @@ int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-static void __perf_evsel__config_callchain(struct evsel *evsel,
-					   struct record_opts *opts,
-					   struct callchain_param *param)
+static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+				      struct callchain_param *param)
 {
 	bool function = perf_evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -746,12 +745,11 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 	}
 }
 
-void perf_evsel__config_callchain(struct evsel *evsel,
-				  struct record_opts *opts,
-				  struct callchain_param *param)
+void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+			     struct callchain_param *param)
 {
 	if (param->enabled)
-		return __perf_evsel__config_callchain(evsel, opts, param);
+		return __evsel__config_callchain(evsel, opts, param);
 }
 
 static void
@@ -832,7 +830,7 @@ static void apply_config_terms(struct evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_INHERIT:
 			/*
 			 * attr->inherit should has already been set by
-			 * perf_evsel__config. If user explicitly set
+			 * evsel__config. If user explicitly set
 			 * inherit using config terms, override global
 			 * opt->no_inherit setting.
 			 */
@@ -901,7 +899,7 @@ static void apply_config_terms(struct evsel *evsel,
 				perf_evsel__set_sample_bit(evsel, DATA_SRC);
 				evsel->core.attr.mmap_data = track;
 			}
-			perf_evsel__config_callchain(evsel, opts, &param);
+			evsel__config_callchain(evsel, opts, &param);
 		}
 	}
 }
@@ -953,8 +951,8 @@ struct perf_evsel_config_term *__perf_evsel__get_config_term(struct evsel *evsel
  *     enable/disable events specifically, as there's no
  *     initial traced exec call.
  */
-void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
-			struct callchain_param *callchain)
+void evsel__config(struct evsel *evsel, struct record_opts *opts,
+		   struct callchain_param *callchain)
 {
 	struct evsel *leader = evsel->leader;
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -1027,7 +1025,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel->core.attr.exclude_callchain_user = 1;
 
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
-		perf_evsel__config_callchain(evsel, opts, callchain);
+		evsel__config_callchain(evsel, opts, callchain);
 
 	if (opts->sample_intr_regs) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2facb16..617cb3f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -188,12 +188,10 @@ void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
 
-void perf_evsel__config(struct evsel *evsel,
-			struct record_opts *opts,
-			struct callchain_param *callchain);
-void perf_evsel__config_callchain(struct evsel *evsel,
-				  struct record_opts *opts,
-				  struct callchain_param *callchain);
+void evsel__config(struct evsel *evsel, struct record_opts *opts,
+		   struct callchain_param *callchain);
+void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+			     struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
 void perf_evsel__calc_id_pos(struct evsel *evsel);
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index e026ab6..f893891 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -7,7 +7,7 @@
 
 /*
  * The 'struct perf_evsel_config_term' is used to pass event
- * specific configuration data to perf_evsel__config routine.
+ * specific configuration data to evsel__config routine.
  * It is allocated within event parsing and attached to
  * perf_evsel::config_terms list head.
 */
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 97e2c0c..18ce2cd 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -15,7 +15,7 @@
 #include "../perf-sys.h"
 
 /*
- * perf_evsel__config_leader_sampling() uses special rules for leader sampling.
+ * evsel__config_leader_sampling() uses special rules for leader sampling.
  * However, if the leader is an AUX area event, then assume the event to sample
  * is the next event.
  */
@@ -34,8 +34,7 @@ static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
 	return leader;
 }
 
-static void perf_evsel__config_leader_sampling(struct evsel *evsel,
-					       struct evlist *evlist)
+static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
@@ -93,14 +92,14 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 	use_comm_exec = perf_can_comm_exec();
 
 	evlist__for_each_entry(evlist, evsel) {
-		perf_evsel__config(evsel, opts, callchain);
+		evsel__config(evsel, opts, callchain);
 		if (evsel->tracking && use_comm_exec)
 			evsel->core.attr.comm_exec = 1;
 	}
 
 	/* Configure leader sampling here now that the sample type is known */
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__config_leader_sampling(evsel, evlist);
+		evsel__config_leader_sampling(evsel, evlist);
 
 	if (opts->full_auxtrace) {
 		/*
