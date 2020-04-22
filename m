Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68039C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E9B217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgDVMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728718AbgDVMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2272C03C1A8;
        Wed, 22 Apr 2020 05:17:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJo-0007sf-Hz; Wed, 22 Apr 2020 14:17:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B4E71C0450;
        Wed, 22 Apr 2020 14:17:27 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:26 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add ->evsel_is_auxtrace() callback
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-2-adrian.hunter@intel.com>
References: <20200401101613.6201-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784695.28353.4504990292045831376.tip-bot2@tip-bot2>
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

Commit-ID:     853f37d75c44c305f750d8c4a34d83f03b610fce
Gitweb:        https://git.kernel.org/tip/853f37d75c44c305f750d8c4a34d83f03b610fce
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:15:58 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf auxtrace: Add ->evsel_is_auxtrace() callback

Add ->evsel_is_auxtrace() callback to identify if a selected event
is an AUX area event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c |  9 +++++++++
 tools/perf/util/auxtrace.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3571ce7..2c4ad68 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2577,3 +2577,12 @@ void auxtrace__free(struct perf_session *session)
 
 	return session->auxtrace->free(session);
 }
+
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
+				 struct evsel *evsel)
+{
+	if (!session->auxtrace || !session->auxtrace->evsel_is_auxtrace)
+		return false;
+
+	return session->auxtrace->evsel_is_auxtrace(session, evsel);
+}
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e58ef16..db65aae 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -21,6 +21,7 @@
 union perf_event;
 struct perf_session;
 struct evlist;
+struct evsel;
 struct perf_tool;
 struct mmap;
 struct perf_sample;
@@ -166,6 +167,8 @@ struct auxtrace {
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
 	void (*free)(struct perf_session *session);
+	bool (*evsel_is_auxtrace)(struct perf_session *session,
+				  struct evsel *evsel);
 };
 
 /**
@@ -584,6 +587,8 @@ void auxtrace__dump_auxtrace_sample(struct perf_session *session,
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
+				 struct evsel *evsel);
 
 #define ITRACE_HELP \
 "				i:	    		synthesize instructions events\n"		\
@@ -750,6 +755,13 @@ void auxtrace_index__free(struct list_head *head __maybe_unused)
 }
 
 static inline
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+				 struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+static inline
 int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 {
 	return 0;
