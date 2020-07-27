Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0A12075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+fTHaAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgG0G7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0G7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:59:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDAC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:59:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so19648941ybc.15
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9/YSwprGE0WZwSWfXLYVy6V0Ah3OoUpnPGrBV/LRITA=;
        b=m+fTHaAj0JPw3ABBmUnN46A5mmPLHkTVVyZ8suMxXp+vWgocvuwn2YhFNGm88lQUDF
         0Ipw8hhTQmjl6srPRoA77U8pFkle0oyTVg9q7efUVULis+4aPAbpcNJYLgXjR9pGks2K
         0yFv71jR8JqgC1y6376PhYUd0wsXPulqQ2fYvCwRvvx2kEDQ4bGhIi38ppg63XRYKsli
         OJhjdpysVbe0efevbEozHhMUjOoKKqsfe9ptDyWa9vwKUoCod/akcOxXjLKP3GmfnlNp
         F82cjKtzMvkUKQvUWJk48FIhA3xTcb0HP6tKvdZlrtDtw2WZeBIBXmTLt5yDgVbYCM8A
         abNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9/YSwprGE0WZwSWfXLYVy6V0Ah3OoUpnPGrBV/LRITA=;
        b=JtQp+fXM/WPuiSyF9K4W0ASjVPdDAZ0TYaIujw7rYwnoXQOkWoZiuhMotN0zV28Rkv
         lLD4d0s95Rjbr+62NPf5/CpP1kbTfM2uG+grNy1MzSJ2OH7iTWfC5dAZp5pv12KUy0cA
         3378UvWtsxCeSn9Gzt32T7tGDvz6H3rKeJI/nB6NS78TWSy4SQeBjp7SQh8MOh5yDBxb
         YRMhxev8kCQVFYMC49ui5+LP0RgUzzLpecUQc3P03VWHeWgZPLGzxTbQYASF/A2KEiCj
         smn3nk/xpaJVfWbzAd88YgiSyCGkBwEsGy5SLj98Ewp3qVfeMwZZOEhD90NpIdJszSGP
         vJ8g==
X-Gm-Message-State: AOAM532lMc3X8kUjAwEiCiTbw5hqGp2iiyeTxnGzjgLbKtndOLXtWpKL
        /bXfDhhydoem1Do5HDQpntVrpu2FEcO8
X-Google-Smtp-Source: ABdhPJz7ZE9JX1xcuL6ggGjeX4GY2EfS6ZQVKaFpFeKXbWp8rV2g56PwdJo+OYTDl/0xDoD2QJjN04vRVhCC
X-Received: by 2002:a5b:14a:: with SMTP id c10mr32329689ybp.493.1595833191601;
 Sun, 26 Jul 2020 23:59:51 -0700 (PDT)
Date:   Sun, 26 Jul 2020 23:59:48 -0700
Message-Id: <20200727065948.12201-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] perf record: Set PERF_RECORD_SAMPLE if attr->freq is set.
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        David Sharp <dhsharp@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sharp <dhsharp@google.com>

evsel__config() would only set PERF_RECORD_SAMPLE if it set attr->freq
from perf record options. When it is set by libpfm events, it would not
get set. This changes evsel__config to see if attr->freq is set outside of
whether or not it changes attr->freq itself.

Signed-off-by: David Sharp <dhsharp@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef802f6d40c1..811f538f7d77 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -979,13 +979,18 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
 				     opts->user_interval != ULLONG_MAX)) {
 		if (opts->freq) {
-			evsel__set_sample_bit(evsel, PERIOD);
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
 		} else {
 			attr->sample_period = opts->default_interval;
 		}
 	}
+	/*
+	 * If attr->freq was set (here or earlier), ask for period
+	 * to be sampled.
+	 */
+	if (attr->freq)
+		evsel__set_sample_bit(evsel, PERIOD);
 
 	if (opts->no_samples)
 		attr->sample_freq = 0;
-- 
2.28.0.rc0.142.g3c755180ce-goog

