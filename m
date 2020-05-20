Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCF3205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFsBVZVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETH2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgETH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:28:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25335C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e14so1006033ybh.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pg8X3zsQYx36UMQsRQzJQNRzKxV0haL9XJi6KY3pltg=;
        b=IFsBVZVLPNRULbE6YYRGkUm9WJ5b6ZkW+NDQK7kKTrzGDrri4yLsgAxoIcujJbtyn1
         sCqcgKrfPHW+BUF4AR7bN0sYsha93tqft11ntBzTK/LM7LQQ1PPNQdTSe0ZlQ3Ovej/D
         jGuSAP9/b/yGJCG8MtEHWjya9IVzKIBbh5ery1GKshTGhTHeRrLawlWRsgedy09QWwdX
         gVPbNYY6sZdrpRVbeUSn8zgIxBypbgHK71ceT/ZGWi6Xz4wKYJc/Qv6MVQnR183eJcrt
         gb9mcg5iMILoLqc3QUxysv1ilFc18koA4DuV9KRUWjlORirdy6Q9ijku3RKWOA1NH2zA
         jdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pg8X3zsQYx36UMQsRQzJQNRzKxV0haL9XJi6KY3pltg=;
        b=aZ/WBJgrtC2t9auqR3PwYCsyHRQ74k/vfPYYxD7zkdS047HVLW2qH0SID9UHj3imZK
         4Z2a2FlnOjHgx9tdc7LnyrV8sVKPu1ZIwSIylhEPZX3zxmQMVEeC97X8Vj15Fv9O3zei
         GO6Mk6pN6VVba+6MQArsh/3H2aST5rVeYYzLSj/MpwXepibShch8nMEXnOlzSbvJS2Af
         rjra3jJKv48otqobUeoVOUQ1Z9+Eqjv9XK8vn93S+EIE3aezWr1AKFaOM85AZPxTJDiO
         MYb9/phO78Xen6W7eWs6bdpZsktqYFpQzN4ewhsVcZONWqNzfqb/yNDYU2OKH0ov2R/B
         x+/Q==
X-Gm-Message-State: AOAM532vEb53f9aJQVkxsoBkaOvAAqexc4y9sD6o0C23JshssQtdMtlM
        Cep2VM9Qrz65Kn1+gMYCEWMi7RETy+JF
X-Google-Smtp-Source: ABdhPJyyzwNekVBx1x6MqUBBsMhf9BSK8uRhitcUQ2Zfj9uqwbF9oil4MwNf1a97+WAkaMeiHsxsXPoe2WYF
X-Received: by 2002:a25:8012:: with SMTP id m18mr5146740ybk.123.1589959705364;
 Wed, 20 May 2020 00:28:25 -0700 (PDT)
Date:   Wed, 20 May 2020 00:28:09 -0700
In-Reply-To: <20200520072814.128267-1-irogers@google.com>
Message-Id: <20200520072814.128267-3-irogers@google.com>
Mime-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 2/7] perf metricgroup: Always place duration_time last
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

If a metric contains the duration_time event then the event is placed
outside of the metric's group of events. Rather than split the group,
make it so the duration_time is immediately after the group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a16f60da06ab..7a43ee0a2e40 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -410,8 +410,8 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 					       struct expr_parse_ctx *ctx)
 {
 	struct hashmap_entry *cur;
-	size_t bkt, i = 0;
-	bool no_group = false;
+	size_t bkt;
+	bool no_group = true, has_duration = false;
 
 	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
 		pr_debug("found event %s\n", (const char *)cur->key);
@@ -421,20 +421,20 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
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
 			(const char *)cur->key);
 		no_group = false;
-		i++;
 	}
-	if (!no_group)
+	if (!no_group) {
 		strbuf_addf(events, "}:W");
+		if (has_duration)
+			strbuf_addf(events, ",duration_time");
+	} else if (has_duration)
+		strbuf_addf(events, "duration_time");
 }
 
 static void metricgroup__add_metric_non_group(struct strbuf *events,
-- 
2.26.2.761.g0e0b3e54be-goog

