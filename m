Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877922077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgDAKRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgDAKRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:35 -0400
IronPort-SDR: JWDxFCRFKs0bXgFuh/msX7WWfYRJA/O/1CzWSghA2hIalS4bRl3dxEe3mMgyHZuCt3Lh0Gt/6q
 NAjjCItnWI5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:33 -0700
IronPort-SDR: /lK1sDkMDYrtPANgKYelTYuzZ/N6rbe162/l8piq6NlkAD5VW6WPkWjKRGNDhpm9/nEr+sY1PP
 /XPafS5hczDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925473"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 01/16] perf auxtrace: Add ->evsel_is_auxtrace() callback
Date:   Wed,  1 Apr 2020 13:15:58 +0300
Message-Id: <20200401101613.6201-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ->evsel_is_auxtrace() callback to identify if a selected event
is an AUX area event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
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
2.17.1

