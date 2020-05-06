Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC95C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0C72068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778835;
	bh=44XUKIVi/6k2wGeb2mPlZ9v42x3xytmKf7KdEkkac/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uel3qHSjJwvtUHn6QakCvOMMdtv1tyy3W/gpSnWin52eLTNTdF/tkQSNEdRVMOWPS
	 saG31hg9ENFF0N+u/8V7eA+eMx0jA4fTnowngOkyQlPwFZCOyegarq2e7f1jJAq1Ej
	 /BtUkxOFbIqiNDNG7Ocfz76uT4N2GhCWX7dABzNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgEFP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgEFP1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE95A2145D;
        Wed,  6 May 2020 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778827;
        bh=44XUKIVi/6k2wGeb2mPlZ9v42x3xytmKf7KdEkkac/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjduP1yFcwY/KHAJcQYYhpVZZ2yoOM1nE1UmaPaxyCwYnWz0e5lmuNvzuVyVBW+4T
         0Ka4GWtfOQXgOuhorwskaPaLsBOlJgETcohhbY4jvKpX71FlTlSsZsjF8ZwzQyC8ng
         UJxRkl2AAyIgYvOVmrAlcpLMz0x30OxphmN5nQeE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 79/91] perf lock: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:22 -0300
Message-Id: <20200506152234.21977-80-acme@kernel.org>
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
 tools/perf/builtin-lock.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5a19dc2f1636..f0a1dbacb46c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -657,32 +657,28 @@ static struct trace_lock_handler report_lock_ops  = {
 
 static struct trace_lock_handler *trace_handler;
 
-static int perf_evsel__process_lock_acquire(struct evsel *evsel,
-					     struct perf_sample *sample)
+static int evsel__process_lock_acquire(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->acquire_event)
 		return trace_handler->acquire_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_acquired(struct evsel *evsel,
-					      struct perf_sample *sample)
+static int evsel__process_lock_acquired(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->acquired_event)
 		return trace_handler->acquired_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_contended(struct evsel *evsel,
-					      struct perf_sample *sample)
+static int evsel__process_lock_contended(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->contended_event)
 		return trace_handler->contended_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_release(struct evsel *evsel,
-					    struct perf_sample *sample)
+static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->release_event)
 		return trace_handler->release_event(evsel, sample);
@@ -849,10 +845,10 @@ static void sort_result(void)
 }
 
 static const struct evsel_str_handler lock_tracepoints[] = {
-	{ "lock:lock_acquire",	 perf_evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
-	{ "lock:lock_acquired",	 perf_evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_contended", perf_evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_release",	 perf_evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
+	{ "lock:lock_acquire",	 evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
+	{ "lock:lock_acquired",	 evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
 static bool force;
-- 
2.21.1

