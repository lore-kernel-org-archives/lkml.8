Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFBC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065AF2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022401;
	bh=1yH336cDHg1XCo8mE3CXxWN2Wfs+pS+peIyoC1Fr+ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKPrclUaEJHtw1iaM1DP8yrfKjhV1BL57uEv9wVeQxrGbYVjkEydgULRoqWgHUcdq
	 ilGEzJnCNmwFWrCZ6bmulaOzIAMyANDWcO/+7RsgFdLsZgJ9mMDDSAt8YOfoqjbH5H
	 AWe4ajuvXNSOpg6jp3jAoP5XENwVYsAizaRn2o3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD0VT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:19:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A42206D6;
        Mon, 27 Apr 2020 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022396;
        bh=1yH336cDHg1XCo8mE3CXxWN2Wfs+pS+peIyoC1Fr+ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhT6IedCvpDCVnI1nusfcg4uDzefx5h+JWp4jKnU91QWqYCVarcA1HhEF21DYqEaN
         gvuOMVwqTLeL5qt/Jp/OjidF/+q8aoF9hzXIz7cwDXn8NSC6Id5xVTMArPJITCTIif
         VcZEncB85wgKn3PPSCYECzCYNI7O38EUggDPd9tg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 3/7] perf bpf: Decouple creating the evlist from adding the SB event
Date:   Mon, 27 Apr 2020 18:19:31 -0300
Message-Id: <20200427211935.25789-4-acme@kernel.org>
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

Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
requiring that the evlist be allocated beforehand.

This will allow using the same side band thread and evlist to be used
for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
after they are generated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 17 ++++++++++++++---
 tools/perf/builtin-top.c    | 15 +++++++++++++--
 tools/perf/util/bpf-event.c |  3 +--
 tools/perf/util/bpf-event.h |  7 +++----
 tools/perf/util/evlist.c    | 17 +++--------------
 tools/perf/util/evlist.h    |  2 +-
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2348c4205e59..ed2244847400 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1572,16 +1572,27 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			goto out_child;
 	}
 
+	err = -1;
 	if (!rec->no_buildid
 	    && !perf_header__has_feat(&session->header, HEADER_BUILD_ID)) {
 		pr_err("Couldn't generate buildids. "
 		       "Use --no-buildid to profile anyway.\n");
-		err = -1;
 		goto out_child;
 	}
 
-	if (!opts->no_bpf_event)
-		bpf_event__add_sb_event(&rec->sb_evlist, &session->header.env);
+	if (!opts->no_bpf_event) {
+		rec->sb_evlist = evlist__new();
+
+		if (rec->sb_evlist == NULL) {
+			pr_err("Couldn't create side band evlist.\n.");
+			goto out_child;
+		}
+
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			goto out_child;
+		}
+	}
 
 	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 70e1c732db6a..de24aced7213 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1742,8 +1742,19 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	if (!top.record_opts.no_bpf_event)
-		bpf_event__add_sb_event(&top.sb_evlist, &perf_env);
+	if (!top.record_opts.no_bpf_event) {
+		top.sb_evlist = evlist__new();
+
+		if (top.sb_evlist == NULL) {
+			pr_err("Couldn't create side band evlist.\n.");
+			goto out_delete_evlist;
+		}
+
+		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			goto out_delete_evlist;
+		}
+	}
 
 	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 0cd41a862952..3742511a08d1 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -509,8 +509,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 	return 0;
 }
 
-int bpf_event__add_sb_event(struct evlist **evlist,
-			    struct perf_env *env)
+int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 {
 	struct perf_event_attr attr = {
 		.type	          = PERF_TYPE_SOFTWARE,
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 81fdc88e6c1a..2c7a50509659 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -33,8 +33,7 @@ struct btf_node {
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
-int bpf_event__add_sb_event(struct evlist **evlist,
-				 struct perf_env *env);
+int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
 void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				    struct perf_env *env,
 				    FILE *fp);
@@ -46,8 +45,8 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static inline int bpf_event__add_sb_event(struct evlist **evlist __maybe_unused,
-					  struct perf_env *env __maybe_unused)
+static inline int evlist__add_bpf_sb_event(struct evlist **evlist __maybe_unused,
+					   struct perf_env *env __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 82d9f9bb8975..1d0d36da223b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1704,38 +1704,27 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	return leader;
 }
 
-int perf_evlist__add_sb_event(struct evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data)
 {
 	struct evsel *evsel;
-	bool new_evlist = (*evlist) == NULL;
-
-	if (*evlist == NULL)
-		*evlist = evlist__new();
-	if (*evlist == NULL)
-		return -1;
 
 	if (!attr->sample_id_all) {
 		pr_warning("enabling sample_id_all for all side band events\n");
 		attr->sample_id_all = 1;
 	}
 
-	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
+	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
 	if (!evsel)
 		goto out_err;
 
 	evsel->side_band.cb = cb;
 	evsel->side_band.data = data;
-	evlist__add(*evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
-
 out_err:
-	if (new_evlist) {
-		evlist__delete(*evlist);
-		*evlist = NULL;
-	}
 	return -1;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..0f02408fff3e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -107,7 +107,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
 
 int perf_evlist__add_dummy(struct evlist *evlist);
 
-int perf_evlist__add_sb_event(struct evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
-- 
2.21.1

