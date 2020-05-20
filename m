Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30761C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B11A205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olaQa8CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgETH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgETH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:28:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC68C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t10so2725386qvz.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2tRmly8/qGDtTekbgn2lo5YJiPgOHSr53socGYeFTI4=;
        b=olaQa8CE1BsKbe+yaSv7WAep0ye3gnRfXCsSa19Bmm9FUmeEOseb8R8cXKoS3SldFK
         8VGdjr0mSAs0JsCJgVkRP2AFgZua25Qx9hEk8RF0Wiob7F+tPI0L0aL96Uu772POuqA+
         uwhxtvPF34zKhY15RrV/FHEn4T5bcwmUmWu16dvM1QSfxbOGhmqQmZukZDGWxJpo53G5
         G6H5vckludUETauA9rAV3B3Cob8YTvhDQLxldYXK7TeXsJRgm2yJ/eC+k89X7AjYOiQ0
         5CDUIHT9/XLTKPU+jCg1JC0nJ2x3nuGUbYMU00wLPFJHnHnfRpX/JdMP8KGKxd/4uWUE
         Gveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2tRmly8/qGDtTekbgn2lo5YJiPgOHSr53socGYeFTI4=;
        b=JysGWv4SKvATFJEJwdiWgPDTDSFKHcOL2csGYekmZYmLYlvOA9YJt43lz6gini9JHZ
         prpUwCF9P9LQclczqGsPfSG4Q5EgKUK4fDV5rsJF69eqlM6yDf/9Bs2NrV+ifJtXdxbs
         BdqinD8ZHmRM79n40V8KheZXYltU/g9qxEqLO4r0hxFX1QyBgPSERfJ8eP+0y2GUWGEK
         GlaguzMwp3GRBDx7p2kUZv6QBfjMkVyF/0oZtkF7twDUj6QhOUuSNCPxOWRiNA5dImAM
         Ihb8NmfHQhXEmwc2q8YE/EvHEAf4k87hIm7u9j0VaJKdM4WWBsJxl5NXjgUa26sAppIO
         EZxg==
X-Gm-Message-State: AOAM532UE3DQnvB59FGJ3r4n4uOrP7PJ43utjQerQa1yhXa+C7yoJuss
        lVWefhRSL/FK2pj5J2xNMqpfKm7uAVGj
X-Google-Smtp-Source: ABdhPJyza8+/G6GYTHs1Y7nBujR1GXXlFW4JKXm7exIG6wNQZEBwDZgk05NesOSemj3kuy22h4aviOPWTLL2
X-Received: by 2002:ad4:57cb:: with SMTP id y11mr3521842qvx.26.1589959717451;
 Wed, 20 May 2020 00:28:37 -0700 (PDT)
Date:   Wed, 20 May 2020 00:28:14 -0700
In-Reply-To: <20200520072814.128267-1-irogers@google.com>
Message-Id: <20200520072814.128267-8-irogers@google.com>
Mime-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 7/7] perf metricgroup: Remove unnecessary ',' from events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
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

Remove unnecessary commas from events before they are parsed. This
avoids ',' being echoed by parse-events.l.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 432ae2e4c7b1..570285132cf6 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -501,9 +501,14 @@ static void metricgroup__add_metric_non_group(struct strbuf *events,
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
+	bool first = true;
 
-	hashmap__for_each_entry((&ctx->ids), cur, bkt)
-		strbuf_addf(events, ",%s", (const char *)cur->key);
+	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+		if (!first)
+			strbuf_addf(events, ",");
+		strbuf_addf(events, "%s", (const char *)cur->key);
+		first = false;
+	}
 }
 
 static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
@@ -637,8 +642,10 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 	if (!ret) {
+		bool first = true;
+
 		list_for_each_entry(eg, group_list, nd) {
-			if (events->len > 0)
+			if (events->len > 0 && !first)
 				strbuf_addf(events, ",");
 
 			if (eg->has_constraint) {
@@ -648,6 +655,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				metricgroup__add_metric_weak_group(events,
 								   &eg->pctx);
 			}
+			first = false;
 		}
 	}
 	return ret;
-- 
2.26.2.761.g0e0b3e54be-goog

