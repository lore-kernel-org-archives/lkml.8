Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2011C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9086218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383739;
	bh=30CZ9PEAJfchmXoSIp9QKjRwAYs/rClC7yLCk+RuL7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6gHHvaoTZz0k0S9xoBKQRzWWWnU2WXGwWsUFh+Y/g5EQlTEfHGhH7H/pYP4hoViv
	 QJJjwsC0bRQcOwk9q5gaamHoP19ssRr+jW2xawg9B6W0ZVEfe2eNo4qpZ6ph1Cv83V
	 8Z8OmnSeOQYFbh9rdxcTTTgEvw7KDV+amW3EhB0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgDTLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgDTLze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE5421927;
        Mon, 20 Apr 2020 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383734;
        bh=30CZ9PEAJfchmXoSIp9QKjRwAYs/rClC7yLCk+RuL7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llAJTnPG+Xut6XAg4tje4gYplX0A58DKTI70+K5tucPNmwyWuqx2uhd4QBLroUgxL
         lfH24EIgVko9aKI154qthybxomKNbVE28KnqIrK+dBJHrQzdVr+S/7LFKrrHWNU2DF
         L5wsSnO6orxRT6x3H57kYp9A7JcS1nHuyfbrImxg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/60] perf auxtrace: Add ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:41 -0300
Message-Id: <20200420115316.18781-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
index 3571ce72ca28..2c4ad6838766 100644
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
index e58ef160b599..db65aae5c2ea 100644
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
@@ -749,6 +754,13 @@ void auxtrace_index__free(struct list_head *head __maybe_unused)
 {
 }
 
+static inline
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+				 struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
 static inline
 int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 {
-- 
2.21.1

