Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32756C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0366221582
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Koz8yhPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEGIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:14:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E2BC0610D5
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 01:14:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g6so5983964ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=laqIw2e8BtvC1AZBZIJa3w6PXohYXYOFdU6fqXlT6Ys=;
        b=Koz8yhPrUge2qVVcAlXS3xyTi6AXWgzlfI0d/AGJIRthsuF8fw+v2Ec78xvYT1vOlR
         kEr+40q4sqVBX2wHSELJg/ziCcyodqffvKB8cPN3wNTjlV6wa4O2bY/SrAuIct2lInpT
         jK7ZTZQwfp8xM4w1f59/gu1d6VSLBWgPWsuWz7YKC+dPriJw4tMIwIc6XhMjtUe7OZXU
         GtvOIuWm3IX4nSFjVVpokhNFSTVvIpatY3gOP40uSJbWKHDv5/mSbK+j+fDMdFJjpw5W
         YRoGylIfifN6N++4ritkfMUA/OFQaHaOyelTbptoqRdfKQ9CfYVCOlOYx/e9SqoD7/jn
         OgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=laqIw2e8BtvC1AZBZIJa3w6PXohYXYOFdU6fqXlT6Ys=;
        b=jib/VC6qiY1gSyC/0GV5x3HUUjXLe4UpvVB52RLPu3JMuIFdpHuydENYxxdOCvBhpc
         xz5sDQO/tnwVnbS6tQlIYczNM8UmvFyQlWQ7ljZcjOAIJN0s7X4kSC6J3EnIBK1xsD17
         rfUpxKWiDCL/po9J7ZEnyquTx9CTjbWtzdjmpzC0VzYsGErM3HElMn0TFustF74LV8x8
         1ufxEx5VYIgVIWpGOLHl1XyNvM04DIlj9pw3I378BH3gfn3osY14p0XdVqA2eiarX8qu
         kzobb/uf6oyVCJccacJpTrKPekFm5osPJq50xcimW3cyi+t19oaVcAEwW42O64gUiAha
         Umrg==
X-Gm-Message-State: AGi0PuY+w2xMtYO3S4inacLrjq17D7XLYfznA6pK1TDBcn/nCxjtzwT7
        6FRO0qQ56UlnKCS2D7ZYakl0JcWZsIz6
X-Google-Smtp-Source: APiQypLaC9JqxCmf6Bc+54GwEgoHzPXMW94TycpXOg7SlZklfTr4XBRhXJ0pzY3K1F7ZAs3iNOA7yPXtwrAv
X-Received: by 2002:a25:d1c1:: with SMTP id i184mr8537881ybg.165.1588839293414;
 Thu, 07 May 2020 01:14:53 -0700 (PDT)
Date:   Thu,  7 May 2020 01:14:32 -0700
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Message-Id: <20200507081436.49071-4-irogers@google.com>
Mime-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH 3/7] perf metricgroup: free metric_events on error
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

Avoid a simple memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index dcd175c05872..2356dda92a07 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -185,6 +185,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
+			free(metric_events);
 			continue;
 		}
 		for (i = 0; metric_events[i]; i++)
@@ -192,11 +193,13 @@ static int metricgroup__setup_events(struct list_head *groups,
 		me = metricgroup__lookup(metric_events_list, evsel, true);
 		if (!me) {
 			ret = -ENOMEM;
+			free(metric_events);
 			break;
 		}
 		expr = malloc(sizeof(struct metric_expr));
 		if (!expr) {
 			ret = -ENOMEM;
+			free(metric_events);
 			break;
 		}
 		expr->metric_expr = eg->metric_expr;
-- 
2.26.2.526.g744177e7f7-goog

