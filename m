Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17304C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92B62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022408;
	bh=TYfXDaeHNcm78wixT5OI7IEg+NXkcTTt0KgLIsIVHkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hb59Rfpt38v5OMoBrZHvXYJmCyqn+qkilSIOsF3D7WAspDmfRCLB5nEBxcEgmzwTp
	 8Z9+Kg4D6AP/aGXu4p2BevVySGsJlAYhOpUoYdZSuvTdq+P6BhzBL9N0suqJX2eKRE
	 fqRrbeYFJkynLdRdYZzqsFOzmw0/3dhWllLit5Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgD0VUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:20:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E07D2082E;
        Mon, 27 Apr 2020 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022403;
        bh=TYfXDaeHNcm78wixT5OI7IEg+NXkcTTt0KgLIsIVHkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cy98FKq9/HE6IrAzHuJEYCp3x0bGJVMIEJY0Jlz1ce5N8l4taeCiXneFhTK4CWonj
         VFhpbWs8YbwU1neFYIZ0ZiBix7B794eEWUYvrWYKkoAQAJVHXRfitgjmrYCikejwk4
         YOqhon1I90BAzY+oX6WzfvntFR5SfpToDf1Xv0Ns=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5/7] perf parse-events: Add parse_events_option() variant that creates evlist
Date:   Mon, 27 Apr 2020 18:19:33 -0300
Message-Id: <20200427211935.25789-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For the upcoming --switch-output-event option we want to create the side
band event, populate it with the specified events and then, if it is
present multiple times, go on adding to it, then, if the BPF tracking is
required, use the first event to set its attr.bpf_event to get those
PERF_RECORD_BPF_EVENT metadata events too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 23 +++++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 10107747b361..5795f3a8f71c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2190,6 +2190,29 @@ int parse_events_option(const struct option *opt, const char *str,
 	return ret;
 }
 
+int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset)
+{
+	struct evlist **evlistp = opt->value;
+	int ret;
+
+	if (*evlistp == NULL) {
+		*evlistp = evlist__new();
+
+		if (*evlistp == NULL) {
+			fprintf(stderr, "Not enough memory to create evlist\n");
+			return -1;
+		}
+	}
+
+	ret = parse_events_option(opt, str, unset);
+	if (ret) {
+		evlist__delete(*evlistp);
+		*evlistp = NULL;
+	}
+
+	return ret;
+}
+
 static int
 foreach_evsel_in_last_glob(struct evlist *evlist,
 			   int (*func)(struct evsel *evsel,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 27596cbd0ba0..6ead9661238c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -31,6 +31,7 @@ bool have_tracepoints(struct list_head *evlist);
 const char *event_type(int type);
 
 int parse_events_option(const struct option *opt, const char *str, int unset);
+int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 int parse_events(struct evlist *evlist, const char *str,
 		 struct parse_events_error *error);
 int parse_events_terms(struct list_head *terms, const char *str);
-- 
2.21.1

