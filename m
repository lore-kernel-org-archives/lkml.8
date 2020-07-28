Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD032C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A51E20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4tiQ/JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgG1I6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgG1I5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4BEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8so24019498ybc.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nX/1NZr6qGhnB5fWEWRCVFU3/TmZaNj5LyMINF6iah8=;
        b=C4tiQ/JT4wpELCImOIwKNla4CWq4rVq7GmsYOkdbWLzvQnBGSN4ijrmKf5muLUqYz8
         QmG3Ayk33QBbjyPb8paRmHGAXlk/hn8rTu2TrBDgLGf53y3CBIIn3egYYyyp+RfznFcS
         7w1/DVrHHiSuzQSLMyA19FiSV4WSuMIlXwjMuP7HrY2nnYMhRu/Wa4qxV9Ll8rcKj5YX
         00SJozfC5ObsHV1GrOM2Nz0HnrTvx0sFZVhLI2JSDo1ZBaZ/EiEvQRhdJXW2zIfhGPbG
         ZK3CalcCoZpL09BOij3aGTD+Kg+X1MnMthWMyx6FOQjinVuoC35As1iBvJqRZ5zVk561
         Jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nX/1NZr6qGhnB5fWEWRCVFU3/TmZaNj5LyMINF6iah8=;
        b=SNM2kJQojkTvoqU60Bsat2ymHgMasxvJee/Bp658lCdZlenwuM1W6vAvhUvvE3qt7+
         uw52mGwUrY0COWOErl2t1Na/r6cL3hZ52r6K7pHxGk46Hsy6tT3DE5yssk0Z21IxDDLL
         C1qsQofEYNUCWdVTVTMDq0dUYzFcGiqcvvT5cQ9K8Jy/PDUJDgd8+KMpdlY1VvoaZ23r
         1utPQl38yLjLiVWqkI4wprn5DJsliJWdtDwE+xDY+2VGAi2+Z6/pr1IecrOBpIMeIN0s
         rSB31LQHKseyQ6JRN/6/KkGpI9A2Nj0NXHmJ8vfcxG891Bn6UtHP1M1E3gznWUwy1Kde
         k0vg==
X-Gm-Message-State: AOAM532PCuR+HdU7NG4/zXHhh51V23/ZIHzJKm0/j0QioDXUtVBN2ZF4
        PDy7cIt4HwLrS+vOSgj6bBG2oLEOwZD+
X-Google-Smtp-Source: ABdhPJx8NSGF6mLTqzK5ekC5JPY7ACRycIrYng7z5LWrxFWN5dAz7vMCOxEpNCM7jbecgVk7PHTKckyA7kiD
X-Received: by 2002:a25:d745:: with SMTP id o66mr19987184ybg.116.1595926660128;
 Tue, 28 Jul 2020 01:57:40 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:31 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-3-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 2/5] perf record: Prevent override of attr->sample_period
 for libpfm4 events
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
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Before:
$ perf record -c 10000 --pfm-events=cycles:period=77777

Would yield a cycles event with period=10000, instead of 77777.

This was due to an ordering issue between libpfm4 parsing
the event string and perf record initializing the event.

This patch fixes the problem by preventing override for
events with attr->sample_period != 0 by the time
perf_evsel__config() is invoked. This seems to have been the
intent of the author.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 811f538f7d77..8afc24e2ec52 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -976,8 +976,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * We default some events to have a default interval. But keep
 	 * it a weak assumption overridable by the user.
 	 */
-	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
-				     opts->user_interval != ULLONG_MAX)) {
+	if (!attr->sample_period) {
 		if (opts->freq) {
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
-- 
2.28.0.163.g6104cc2f0b6-goog

