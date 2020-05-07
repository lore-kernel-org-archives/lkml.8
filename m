Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B30C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53ACE20753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7wRbdfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgEGIO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbgEGIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:14:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556FDC061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 01:14:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so6055745ybj.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=U7wRbdfzR+TPabVXRkSFeJE9tthG2dbucEQJlAe7mIkrJqQjNyRHem0kHXtghq8bnr
         D5W15KCkFJS8JPclkWuahr8m2Or7W3s1CRJK6fwG+ha+JsvVJK6oHhAhhaQ+53kgckBX
         jo0+hIoMrvB++vfIC/LRimiKx41T5K6kdLlQi0AWa4ykCIJCFJGXa2NhsIC7LoB8wikT
         jx/5iUJ6bIJ/75C1HiSa2uzwXOvqkOW/tLz/fSHRtA0uk/PJ/11XwFNOGH3bgv3gXs3n
         B+2rSOwVUo+gQoTo/Rh8zPvAp6P9EVr9PTU9s/+KCG4AAgfUVIvxV30NhAkerMPUB5+/
         02Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4jAiujVPIH0XWZpTZgSL+DGkUTq2TxINaqAiEYunye0=;
        b=WzpuGnehyXLFoAXlopRIAhUPIzXWPjKmWqAuRvPIEKOZ/2o0LvKc2Zp67xoCVSdsC/
         gjyFxmqXETvXcai4DJU3fRx831fdLWG8AA6BhuzjSvr9oMFhTP71CUrHMN+/QFQH6R87
         5BxZUxOtpoKYwZIHL8x5zka8rlloD/vOIQ9bItygbeKSHurHcaWak1FCt8F7U4U2Gz4E
         SnZv8REbHRjEUrxsRHd8DeGlUDOppVpXhA9xzxPje9pxkVwIxA9XK/FB83TcTj+bK8oq
         9xdMzXF4iB3BURALwPJ8Wx0CeVfqjaUcmwzwWY6opUgSPRAh1fsarlU7X0ObYJ/6DpgA
         cxAQ==
X-Gm-Message-State: AGi0PuZBPyE3Xj2c6evXY8ZRWFy/4VYa6UmE1EduNunNpSA1kATjl3UC
        IYTm7alj5CpSC8SI4FGDruwRRtq7g3Rj
X-Google-Smtp-Source: APiQypKwLkD+uB2It9ZWT/f91/xVIyTeXDlbilbCRc/Jf9xhtrEOmeGyY8IG713wAfAF70bC8hWyMwFCX2YI
X-Received: by 2002:a25:6f56:: with SMTP id k83mr20697937ybc.248.1588839291471;
 Thu, 07 May 2020 01:14:51 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:31 -0700
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Message-Id: <20200507081436.49071-3-irogers@google.com>
Mime-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 2/7] perf metricgroup: change evlist_used to a bitmap
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
index 2f92dbc05226..dcd175c05872 100644
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
 		if (hashmap__find(&pctx->ids, ev->name, (void**)&val_ptr)) {
 			if (!metric_events[i])
@@ -149,7 +149,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			j++;
 		}
 		ev = metric_events[i];
-		evlist_used[ev->idx] = true;
+		set_bit(ev->idx, evlist_used);
 	}
 
 	return metric_events[0];
@@ -165,13 +165,11 @@ static int metricgroup__setup_events(struct list_head *groups,
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
@@ -209,7 +207,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		list_add(&expr->nd, &me->head);
 	}
 
-	free(evlist_used);
+	bitmap_free(evlist_used);
 
 	return ret;
 }
-- 
2.26.2.526.g744177e7f7-goog

