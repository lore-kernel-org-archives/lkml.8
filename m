Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18F21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eHEq6C4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJSI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIJSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:02:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCCC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:02:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l186so6198923ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6XEeeB5/U/sRKk9s3VgQBr26xp7sU48GNLcGd5eOC+I=;
        b=eHEq6C4empFsuJtM1ELLwJVOD0XHhxgDKg0cORsFd70FuiNlUFOG96V3gZ1Rt0pHHg
         zld9R+q8VHoDvUbAtVcOSl0pyhL6ZLJiGtsdiBxIEPTOe0N4bxMHb0Pu6NEaIknVLUwx
         ucvQJxvCAXciA8j0y2EcGKkNO9FXBcont7lIPA+UgefMxGii7E4u3MpTQL8OY+nmy3P5
         0vlJvSQTkHk8LQsaQ3DQlw76gPbDpLeO8qQH4vKyUb3OjCdicwolR/8Rg9Z+lx/Tpb8b
         E21pGloKSYI92UlSYRNcyYaWUXd7aZ4i9V5pD9/qrurrAj98JZpryACcjL160VPmgkkk
         9BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6XEeeB5/U/sRKk9s3VgQBr26xp7sU48GNLcGd5eOC+I=;
        b=Cd3w6yzrde2swbIldPf6rwC2WfgKaYFIhBZiyEkLKC+TTBSVEW/EBTMs7naXzSWJDm
         s8tT3IazM6z/DdUXhZvkiRmECboBTv6RgBRrhwo4qaFcfazhaVMhCmiIySIUGsm2daQb
         Io16f8P4A/Od85mUEU8QF78n53Mtdv4ox7dN2PqanWI7AC5yzNQPErkqMkpcloQZcju7
         erTgWoKeYGT6fyF2DXoqrokW/BKnJWxirHP4HqObhT360dli7KeTWxU5iU7V9p/Eatio
         +1L25xfIo+xGR1fv+ZvQItSfHNY/xTaJVY5z9eXbjblQnZ6P4Rtu4MjjuAVYDJYT6Fpj
         CS/Q==
X-Gm-Message-State: AOAM532XLiULo+I/+BGPHdKmgYfcUIrrtSnn83Tzd4HbGQ2c34+fCoeS
        nEXDvzohuhrvTXvFnqSD58C+4IGTjZjo
X-Google-Smtp-Source: ABdhPJzXHHJkq0v6387/I4zMMXNG0u1dN+76XDUthmoWZthMcsnNvlbF4wvEZH3emqTLbi31HunBuun85YEV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:fc0d:: with SMTP id
 v13mr14256346ybd.272.1599760955035; Thu, 10 Sep 2020 11:02:35 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:02:31 -0700
Message-Id: <20200910180231.786751-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v3] perf metricgroup: Fix uncore metric expressions
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
and uncore_imc/case_count_write/. These events open 6 events per socket
with pmu names of uncore_imc_[0-5]. The current metric setup code in
find_evsel_group assumes one ID will map to 1 event to be recorded in
metric_events. For events with multiple matches, the first event is
recorded in metric_events (avoiding matching >1 event with the same
name) and the evlist_used updated so that duplicate events aren't
removed when the evlist has unused events removed.

Before this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

             41.14 MiB  uncore_imc/cas_count_read/
     1,002,614,251 ns   duration_time

       1.002614251 seconds time elapsed

After this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
            126.97 MiB  uncore_imc/cas_count_write/
     1,003,019,728 ns   duration_time

v3. cleans up searching for the same event within metric_events to use a
    helper and avoids a redundant search. It uses a continue loop to
    make the search for similarly named events shorter.
v2. avoids iterating over the whole evlist as suggested by
    namhyung@kernel.org. It also fixes the metric_leader computation
    that was broken in the same commits.

Erroneous duplication introduced in:
commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").

Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 75 ++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 662f4e8777d5..7b66452cb9f9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -149,6 +149,18 @@ static void expr_ids__exit(struct expr_ids *ids)
 		free(ids->id[i].id);
 }
 
+static bool contains_event(struct evsel **metric_events, int num_events,
+			const char *event_name)
+{
+	int i;
+
+	for (i = 0; i < num_events; i++) {
+		if (!strcmp(metric_events[i]->name, event_name))
+			return true;
+	}
+	return false;
+}
+
 /**
  * Find a group of events in perf_evlist that correspond to those from a parsed
  * metric expression. Note, as find_evsel_group is called in the same order as
@@ -179,7 +191,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	int i = 0, matched_events = 0, events_to_match;
 	const int idnum = (int)hashmap__size(&pctx->ids);
 
-	/* duration_time is grouped separately. */
+	/*
+	 * duration_time is always grouped separately, when events are grouped
+	 * (ie has_constraint is false) then ignore it in the matching loop and
+	 * add it to metric_events at the end.
+	 */
 	if (!has_constraint &&
 	    hashmap__find(&pctx->ids, "duration_time", (void **)&val_ptr))
 		events_to_match = idnum - 1;
@@ -206,23 +222,20 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				sizeof(struct evsel *) * idnum);
 			current_leader = ev->leader;
 		}
-		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
-			if (has_constraint) {
-				/*
-				 * Events aren't grouped, ensure the same event
-				 * isn't matched from two groups.
-				 */
-				for (i = 0; i < matched_events; i++) {
-					if (!strcmp(ev->name,
-						    metric_events[i]->name)) {
-						break;
-					}
-				}
-				if (i != matched_events)
-					continue;
-			}
+		/*
+		 * Check for duplicate events with the same name. For example,
+		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
+		 * on skylakex. Only the first such event is placed in
+		 * metric_events. If events aren't grouped then this also
+		 * ensures that the same event in different sibling groups
+		 * aren't both added to metric_events.
+		 */
+		if (contains_event(metric_events, matched_events, ev->name))
+			continue;
+		/* Does this event belong to the parse context? */
+		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
 			metric_events[matched_events++] = ev;
-		}
+
 		if (matched_events == events_to_match)
 			break;
 	}
@@ -238,7 +251,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	}
 
 	if (matched_events != idnum) {
-		/* Not whole match */
+		/* Not a whole match */
 		return NULL;
 	}
 
@@ -246,8 +259,32 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 
 	for (i = 0; i < idnum; i++) {
 		ev = metric_events[i];
-		ev->metric_leader = ev;
+		/* Don't free the used events. */
 		set_bit(ev->idx, evlist_used);
+		/*
+		 * The metric leader points to the identically named event in
+		 * metric_events.
+		 */
+		ev->metric_leader = ev;
+		/*
+		 * Mark two events with identical names in the same group (or
+		 * globally) as being in use as uncore events may be duplicated
+		 * for each pmu. Set the metric leader of such events to be the
+		 * event that appears in metric_events.
+		 */
+		evlist__for_each_entry_continue(perf_evlist, ev) {
+			/*
+			 * If events are grouped then the search can terminate
+			 * when then group is left.
+			 */
+			if (!has_constraint &&
+			    ev->leader != metric_events[i]->leader)
+				break;
+			if (!strcmp(metric_events[i]->name, ev->name)) {
+				set_bit(ev->idx, evlist_used);
+				ev->metric_leader = metric_events[i];
+			}
+		}
 	}
 
 	return metric_events[0];
-- 
2.28.0.526.ge36021eeef-goog

