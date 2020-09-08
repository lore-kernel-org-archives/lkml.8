Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA845C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9663921532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599540177;
	bh=4j7jotL5yxs4TqfltYTG1YEt+zKFkr1Q0UyMkIffXvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgZLHtgAycl00OyvdzhKcPvKQhdyqYNj+UFXrUAPxSCdZ61lwIbUysztw1/AhHoxp
	 1H6HQefP3YFywlRMpdeZJPlMp42akgmWKV+ANf/7sNYb1Y4uXH/HU2pI9ShAaO4XXL
	 /Gnk/eJhvC0LcUqahFq3U897Mjmb5KaG0czXhJAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIHEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgIHEmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304FC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c196so4442957pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWwRaOcpZiRwzBRh+MpTLPCX3xdF/W5yfKxu51dW7t0=;
        b=jJCAQFf0i6/XhYQzb4Y5pyzc0bST3YZDy1pOeI7fY/rb3TvOoUWAgFzTvpsEbHIU5n
         Nu6mzJdiRpqWdPhsfBv+nOyFv2KexJBF+1tdeIMEUiuL/aw/6sGMBBtIf6HQ2UrbeBRZ
         XPdyFq1bP1xuEwGdaSt/YFuFk/fmbAQjtjkj+GH0sMmjMUgTiJPKcTei5ViY5ohQ9tc5
         VmSeZG+m6h6sXqFmUklIsmBUM/ALFNTfnkkonj27HNv8iNrTcszufM9MUwBCNEvPD9e1
         S0geZCO1bvWqaaiDwBm/uv/x9nVpqRtVCfIWwPQnUrSIll8iviCT0WlFVcRf9N0M69ZU
         bQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JWwRaOcpZiRwzBRh+MpTLPCX3xdF/W5yfKxu51dW7t0=;
        b=ip9mFiOLaap3claG+XYH0nh72w3gVkU+deQX3arR9fIh2Yt9G2PgjCH/ERkTK8VYmS
         keJ0tdlz7upjweXd+/vdpGxqO2hKS1VbbqKmyErR7XLInFwOA1kHBWMPFMUMIQS7DzqL
         L+y/M9JmhEfbbGol3L+nbbl2q2n1PGV180dtW/bHZfi+nYsVXqRUFIANuntaIiszzWWc
         nEjWo8f/2AkZkbYMPsVEfQXLMF9E+lWju18yflXzTAp3Irft4aKZCFprdq6HkWiCZf7t
         g4Lz0LaEPIkDVZgtjsnTP4ZjPapdJL3ihSqB617d32k7Tknq6GwkVkA42AQDkgHAR0RF
         7gBw==
X-Gm-Message-State: AOAM532m2i4RzEOjerfB7boXNUSAHDDbyBsxnFkLdXUKgjiHxpHH/EiS
        L2SFI1X3YZtPDL6HUicrZSU=
X-Google-Smtp-Source: ABdhPJwIHTZ5NloFDuQnPDMFVzqUxVWssA9lm8UK4cYHFsteOJMNCHOWfP9kLPpjKc+XA8jsDDBYnA==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr21964814plo.193.1599540161201;
        Mon, 07 Sep 2020 21:42:41 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm16777625pfn.109.2020.09.07.21.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:40 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/4] perf stat: Add --multiply-cgroup option
Date:   Tue,  8 Sep 2020 13:42:26 +0900
Message-Id: <20200908044228.61197-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --multiply-cgroup option is a syntax sugar to monitor large number
of cgroups easily.  Current command line requires to list all the
events and cgroups even if users want to monitor same events for each
cgroup.  This patch addresses that usage by copying given events for
each cgroup on user's behalf.

For instance, if they want to monitor 6 events for 200 cgroups each
they should write 1200 event names (with -e) AND 1200 cgroup names
(with -G) on the command line.  But with this change, they can just
specify 6 events and 200 cgroups plus one more option.

A simpler example below: It wants to measure 3 events for 2 cgroups
('a' and 'b').  The result is that total 6 events are counted like
below.

  $ ./perf stat -a -e cpu-clock,cycles,instructions --multiply-cgroup -G a,b sleep 1

   Performance counter stats for 'system wide':

              988.18 msec cpu-clock                 a #    0.987 CPUs utilized
       3,153,761,702      cycles                    a #    3.200 GHz                      (100.00%)
       8,067,769,847      instructions              a #    2.57  insn per cycle           (100.00%)
              982.71 msec cpu-clock                 b #    0.982 CPUs utilized
       3,136,093,298      cycles                    b #    3.182 GHz                      (99.99%)
       8,109,619,327      instructions              b #    2.58  insn per cycle           (99.99%)

         1.001228054 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 20 +++++++++-
 tools/perf/util/cgroup.c  | 78 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  |  2 +
 tools/perf/util/stat.h    |  1 +
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..6724d23ce2e7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1068,6 +1068,16 @@ static int parse_control_option(const struct option *opt,
 	return 0;
 }
 
+static int parse_stat_cgroups(const struct option *opt,
+			      const char *str, int unset)
+{
+	stat_config.cgroups = strdup(str);
+	if (!stat_config.cgroups)
+		return -1;
+
+	return parse_cgroups(opt, str, unset);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1111,7 +1121,9 @@ static struct option stat_options[] = {
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
-		     "monitor event in cgroup name only", parse_cgroups),
+		     "monitor event in cgroup name only", parse_stat_cgroups),
+	OPT_BOOLEAN(0, "multiply-cgroup", &multiply_cgroup,
+		    "multiply the event list by cgroups"),
 	OPT_STRING('o', "output", &output_name, "file", "output file name"),
 	OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
 	OPT_INTEGER(0, "log-fd", &output_fd,
@@ -2248,6 +2260,11 @@ int cmd_stat(int argc, const char **argv)
 	if (add_default_attributes())
 		goto out;
 
+	if (multiply_cgroup && stat_config.cgroups) {
+		if (evlist__multiply_cgroup(evsel_list, stat_config.cgroups) < 0)
+			goto out;
+	}
+
 	target__validate(&target);
 
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
@@ -2412,6 +2429,7 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__delete(evsel_list);
 
+	free(stat_config.cgroups);
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	runtime_stat_delete(&stat_config);
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 050dea9f1e88..4892f9496bc2 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -12,6 +12,7 @@
 #include <api/fs/fs.h>
 
 int nr_cgroups;
+bool multiply_cgroup;
 
 static int open_cgroup(const char *name)
 {
@@ -156,6 +157,10 @@ int parse_cgroups(const struct option *opt, const char *str,
 		return -1;
 	}
 
+	/* delay processing cgroups after it sees all events */
+	if (multiply_cgroup)
+		return 0;
+
 	for (;;) {
 		p = strchr(str, ',');
 		e = p ? p : eos;
@@ -193,6 +198,79 @@ int parse_cgroups(const struct option *opt, const char *str,
 	return 0;
 }
 
+int evlist__multiply_cgroup(struct evlist *evlist, const char *str)
+{
+	struct evlist *orig_list, *tmp_list;
+	struct evsel *pos, *evsel, *leader;
+	struct cgroup *cgrp = NULL;
+	const char *p, *e, *eos = str + strlen(str);
+	int ret = -1;
+
+	if (evlist->core.nr_entries == 0) {
+		fprintf(stderr, "must define events before cgroups\n");
+		return -EINVAL;
+	}
+
+	orig_list = evlist__new();
+	tmp_list = evlist__new();
+	if (orig_list == NULL || tmp_list == NULL) {
+		fprintf(stderr, "memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	/* save original events and init evlist */
+	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
+	evlist->core.nr_entries = 0;
+
+	for (;;) {
+		p = strchr(str, ',');
+		e = p ? p : eos;
+
+		/* allow empty cgroups, i.e., skip */
+		if (e - str) {
+			/* termination added */
+			char *name = strndup(str, e - str);
+			if (!name)
+				break;
+
+			cgrp = cgroup__new(name);
+			free(name);
+			if (cgrp == NULL)
+				break;
+		} else {
+			cgrp = NULL;
+		}
+
+		leader = NULL;
+		evlist__for_each_entry(orig_list, pos) {
+			evsel = evsel__clone(pos);
+			evsel->cgrp = cgroup__get(cgrp);
+
+			if (evsel__is_group_leader(pos))
+				leader = evsel;
+			evsel->leader = leader;
+
+			evlist__add(tmp_list, evsel);
+		}
+		/* cgroup__new() has a refcount, release it here */
+		cgroup__put(cgrp);
+		nr_cgroups++;
+
+		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
+		tmp_list->core.nr_entries = 0;
+
+		if (!p) {
+			ret = 0;
+			break;
+		}
+		str = p+1;
+	}
+	evlist__delete(orig_list);
+	evlist__delete(tmp_list);
+
+	return ret;
+}
+
 static struct cgroup *__cgroup__findnew(struct rb_root *root, uint64_t id,
 					bool create, const char *path)
 {
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index e98d5975fe55..9a842f243dfb 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -17,6 +17,7 @@ struct cgroup {
 };
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
+extern bool multiply_cgroup;  /* create events for each cgroup */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
@@ -24,6 +25,7 @@ void cgroup__put(struct cgroup *cgroup);
 struct evlist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
+int evlist__multiply_cgroup(struct evlist *evlist, const char *cgroups);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f8778cffd941..22f381fe93de 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -135,6 +135,7 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
+	char			*cgroups;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.28.0.526.ge36021eeef-goog

