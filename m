Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5821973
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0N9gD16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEHFg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgEHFgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:36:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433BC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:36:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185so774723ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8mTjY5Q7uhlsrEjhBpa42c8dBQy8FzN3v/FyAmB9p0U=;
        b=U0N9gD16UqP7ggUJ2BXHcDcYbFnXrHHk2W/wpDJdwshXylLUUsmQ2lXTCxBNvUnXYs
         5uM+y6GVF3wt9WnW6XHGpMyjH1Av492UKkTjrOApESVWEjWjAyb2X2vD+wKPLCTgttlb
         AbRmttl3quYEeXgYE3qHriWaDoHIU4TGYnzp9g3kKImXUUinzNq61VFjgWP3/znke2TZ
         xjO5onI0M6QbZUjnL96Kamm1IqPhIs/dnpDhgpJGQqqB54qSekXLZDQGziHuIpa5qH4H
         MSImdPjv+p3Akv8mvKh8zjTR/NIeijnmkEt+6JvfuM38UuK7rl4TNnjlZXPiX3gl8zld
         L9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8mTjY5Q7uhlsrEjhBpa42c8dBQy8FzN3v/FyAmB9p0U=;
        b=Yv3yQt5FK6sx9ZKj9+C3NU+WtJ6GnmrUExZbGoiedT9BGwGFtIVbnSiyaMDI6Vn8iS
         VLKXT2Qw0nz0d9nLGmgOwMzL+kmhve/L2fenDuNxqMSJ46TXimMAlWGnilMZzTZieK5O
         nZOPTSVOPH0dgMCccIRIGY74QdsaZCb8KLWLeZaMMwyKqougER0utQf0T/ujkl+jOOap
         Zjq8iGPEjsrE4OLCC5nvhuG3U+nAJ4AwaXCWWzNcrlcCSG0zuFqI4Lmd2OQwZ4oqFH6l
         wy64sQFUvWWccdm2CbwfNrUtmE2L0zJppb80zUEbSGa7/8mYHU2CE3aiLZjloa6sXzdI
         8gFg==
X-Gm-Message-State: AGi0Puah0gLXlHS+S93Q7eO1VfGEbeeBjgHgpkUNPitqiaaKlMTaa32D
        arCNRZnnQVLY6KXCboMtLtHgRRMWgJ8m
X-Google-Smtp-Source: APiQypLYnLzFa6KkrtPWiXGpB+HvJwAyS+CNHcM1QUymtxR2ZhxGTAf5vF8Cpv3uBvP/ggheCJMUzudz3fDy
X-Received: by 2002:a25:be81:: with SMTP id i1mr1962944ybk.184.1588916208391;
 Thu, 07 May 2020 22:36:48 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:23 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-9-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 08/14] perf metricgroup: change evlist_used to a bitmap
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a bitmap rather than an array of bools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 37be5a368d6e..4f7e36bc49d9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -95,7 +95,7 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      struct expr_parse_ctx *pctx,
 				      struct evsel **metric_events,
-				      bool *evlist_used)
+				      unsigned long *evlist_used)
 {
 	struct evsel *ev;
 	bool leader_found;
@@ -105,7 +105,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	double *val_ptr;
 
 	evlist__for_each_entry (perf_evlist, ev) {
-		if (evlist_used[j++])
+		if (test_bit(j++, evlist_used))
 			continue;
 		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
 			if (!metric_events[i])
@@ -150,7 +150,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			j++;
 		}
 		ev = metric_events[i];
-		evlist_used[ev->idx] = true;
+		set_bit(ev->idx, evlist_used);
 	}
 
 	return metric_events[0];
@@ -166,13 +166,11 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
-	bool *evlist_used;
+	unsigned long *evlist_used;
 
-	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
-	if (!evlist_used) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
+	if (!evlist_used)
+		return -ENOMEM;
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -210,7 +208,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		list_add(&expr->nd, &me->head);
 	}
 
-	free(evlist_used);
+	bitmap_free(evlist_used);
 
 	return ret;
 }
-- 
2.26.2.645.ge9eca65c58-goog

