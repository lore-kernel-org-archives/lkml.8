Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99A246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898504;
	bh=uML8ZskUBMFCZ5RLaVNUAmEeKkTZGjRYfta84Wl3xi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfjkNu1Urllh+bOYO6qr2kjPXUMUxQqnr/EC38QI63rFcTQBu1Mks6xAj10s6Tg0u
	 313oLjqeN9Ln+AF7TIQlB2EA5kVO7vHTZ6zZp7YHT2Uiyaw6r9gWrzu/Za5BirS5Il
	 /9Pbz4I9ptGbsxyiW2I8ApQGR1MIKQseK5cJvRN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgB1OBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgB1OBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:19 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47478246B8;
        Fri, 28 Feb 2020 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898478;
        bh=uML8ZskUBMFCZ5RLaVNUAmEeKkTZGjRYfta84Wl3xi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFB7M155hX1ifft+4ewm89mxa65+u+yg/HNpF1zh1uMggmri0a3Tpcacabczwt8Wn
         4pUxlOLtf6EaL1BWZ0gIvj/gUGKQhLDDV821t3BMsClVzxCyqKiTKyE/VVQJekAAHA
         wu+i/jSa65ndfN6OV5lsC4TlNUl9W1yRgeu2CBHs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/15] perf annotate: Remove privsize from symbol__annotate() args
Date:   Fri, 28 Feb 2020 11:00:11 -0300
Message-Id: <20200228140014.1236-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

privsize is passed as 0 from all the symbol__annotate() callers.
Remove it from argument list.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c     | 2 +-
 tools/perf/ui/gtk/annotate.c | 2 +-
 tools/perf/util/annotate.c   | 7 ++++---
 tools/perf/util/annotate.h   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index cc26aeab6a66..f6dd1a63f159 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 22cc240f7371..35f9641bf670 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
+	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3b79da595db6..a76309fcf381 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2149,9 +2149,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		     struct annotation_options *options, struct arch **parch)
 {
+	size_t privsize = 0;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
@@ -2790,7 +2791,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
+	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -3070,7 +3071,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, 0, options, parch);
+	err = symbol__annotate(ms, evsel, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8e54184b43dc..7bc60988e478 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -350,7 +350,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
-		     struct evsel *evsel, size_t privsize,
+		     struct evsel *evsel,
 		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
-- 
2.21.1

