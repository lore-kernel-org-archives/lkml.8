Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD6E2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qftf80dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgEGOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgEGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:09:07 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7265C05BD15
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:09:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y31so6859615qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=qftf80dqY2OXb3xONvddbfejzztaLTIjQEIwPKcM6ty5NoFp+S0rNSk4kKOzA7ZEYy
         iWsbeqBvLRmjyugkJ6q/uTvgAPpyhStAcT+/iKqo4IIkfWCvQG9cPYB/o6Hny2LiMhRS
         XKgiUYWbcGhqKNs8rwh7NrOxVx52tGj8ZiHE5rlHy7vi6Xw22t3hLYi/xW5htypWnahh
         +rrJDNYr3peJ3FkroPEHttaLXJJ4P9FEnNFMIk8Edr78k6xohiY+Oz/cGsO+8YX4e39y
         OFvcdnfqEGMqf8sT8dQahr0FzrEKxal+eqWfJvT807dcBZwOl+AS1TxYf8fJ/lPkJNqf
         UCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sCS1jCtEUZLDql23q/lHeTg7GUDYj0iuw701FY6e4C0=;
        b=H8heABEQoCqh1iIi87lV+Aof5CfQPGGMujl7+pjLGcGllJhrQeWHX6GFfmF8sdzJUG
         poisQmFt9my/DWhqmq4eZhQQabs/nneOl8J49sBdwRRVfcZs75rBjjLrYKCnwbOXgJBt
         v3drKhjgYTFVRzrzSuyNMuVYy5cjFE3FIGSIKy30+rdVXxqyhWyvGSbwWXcKrKwtoSn6
         atynMtY2mtmcgp7d0RatPCG5aFyLcF8IfxARoUEYbMjRVTGR364VDHib1RM+LTvB7lDJ
         hvlC77V0q37GtGQhCYERFBCsnW1tB4fqMhpv1dr935Ul2b74zrtorEbMJi8427gSCus/
         RCNg==
X-Gm-Message-State: AGi0PuZZc78aPSx60QfwRYXhhJy/jS3lCY2Qc6RlK5jd7aaUW03slvcZ
        +p3Wwm37VZLso4J4Q6Vlmbh78337/QvA
X-Google-Smtp-Source: APiQypIVs1B8xC7PMmjnevHbOmOMRAmBnKmkx6u4qCCQevmlbcqOwlqULz1G9bUo7lrQ3XUBv0tl1j46ihsA
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr13819775qvl.34.1588860543022;
 Thu, 07 May 2020 07:09:03 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:16 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-21-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 20/23] perf metricgroup: always place duration_time last
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

If a metric contains the duration_time event then the event is placed
outside of the metric's group of events. Rather than split the group,
make it so the duration_time is immediately after the group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2356dda92a07..48d0143b4b0c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -421,8 +421,8 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 					       struct expr_parse_ctx *ctx)
 {
 	struct hashmap_entry *cur;
-	size_t bkt, i = 0;
-	bool no_group = false;
+	size_t bkt;
+	bool no_group = true, has_duration = false;
 
 	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
 		pr_debug("found event %s\n", (const char*)cur->key);
@@ -432,20 +432,20 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		 * group.
 		 */
 		if (!strcmp(cur->key, "duration_time")) {
-			if (i > 0)
-				strbuf_addf(events, "}:W,");
-			strbuf_addf(events, "duration_time");
-			no_group = true;
+			has_duration = true;
 			continue;
 		}
 		strbuf_addf(events, "%s%s",
-			i == 0 || no_group ? "{" : ",",
+			no_group ? "{" : ",",
 			(const char*)cur->key);
 		no_group = false;
-		i++;
 	}
-	if (!no_group)
-		strbuf_addf(events, "}:W");
+	if (!no_group) {
+                strbuf_addf(events, "}:W");
+		if (has_duration)
+			strbuf_addf(events, ",duration_time");
+	} else if (has_duration)
+		strbuf_addf(events, "duration_time");
 }
 
 static void metricgroup__add_metric_non_group(struct strbuf *events,
-- 
2.26.2.526.g744177e7f7-goog

