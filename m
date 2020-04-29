Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5149C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F632082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j53Z5Tng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgD2XPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgD2XOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:14:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5281C08ED7D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:14:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h1so5622320ybk.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8gY6v9J8FfbbwZkEG4Nn5uBCpCuSVyf2CJPw0f8f/F4=;
        b=j53Z5TngwbNIBG7fz7dPedULnCpGEsFxHx7XikbU76ZSEueRgzAojZFFZqDeAmBC+8
         DcJH61iPiVLyE1B0LNBnISwQCeqTEkqcqF0ifSQ6wGDvqsR3n/V+zLGxvF/C3I1FVFi8
         WmNP31WrIltq5N9Dc5ax2y2w1tPwfKJBJm1WaQm7pA7nH61PkBGy5HhwBzeWA4kuZUS6
         x1T01Dkt6V26Zq1y+H/NDdU9xI+EpiRsES6lOXasnUkTdtMmb343HWR0t6ugfxQi6vaW
         ihO5uqR22J3cNn/lV0jTqAooYf7Rz7PN44C9nNc/M2wORlDoA0WDrRe65SAdGECFAlGi
         fMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8gY6v9J8FfbbwZkEG4Nn5uBCpCuSVyf2CJPw0f8f/F4=;
        b=VeZki3vnrKqU72YVMHr/z8j70lTfnooycn9Ayv2NLrXKFfEeU+Z4a8dE+bnlxnmCSa
         1rJt6zYzfJSQ9X6jET2kYfMeoyqPpmnDtEWh+RpOdZAi1avZI4paZTlVkHo9x0iyDf1s
         0BZkg5x7yiCAIuAbYLUrdFiQB4FsGkUFZbWCvnu5Z290HclGMWRsSmubMNAVRGMwWRyR
         tUQmKO7lMxEkB7PvZQ/zsvtKIYmUUqPjS34DZ0fg1bhBYRn/b7FnXyaqMb4YC6/gx9jz
         vuOGc/hg4S0cpzcTTLCKS2wEQ1zVmkWWJs5uBPW8AZvStFauz0Z+L/IS5rKQ18Zf33o3
         7Nnw==
X-Gm-Message-State: AGi0PuaflMZqxNGOdAezNLVdjjm/JLxyKo/Xej8PLPNSu38t6e/noF2b
        K5xvJ8TP5JVgDcO1z2DTFHB6MFXX+nV2
X-Google-Smtp-Source: APiQypLWn5UzCICVrx/KvH2GTIhnZrDmbo/WAmtqo8hNyPqvYDquWDMHiJie4pxY1ZcqEleo72Sf+YzyysFR
X-Received: by 2002:a25:d14c:: with SMTP id i73mr1231247ybg.116.1588202093016;
 Wed, 29 Apr 2020 16:14:53 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:14:42 -0700
In-Reply-To: <20200429231443.207201-1-irogers@google.com>
Message-Id: <20200429231443.207201-4-irogers@google.com>
Mime-Version: 1.0
References: <20200429231443.207201-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 3/4] perf pmu: add perf_pmu__find_by_type helper
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
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This is used by libpfm4 during event parsing to locate the pmu for an
event.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d9f89ed18dea..0fb7d438d9ad 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -871,6 +871,17 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, list)
+		if (pmu->type == type)
+			return pmu;
+
+	return NULL;
+}
+
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 {
 	/*
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1edd214b75a5..cb6fbec50313 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.2.303.gf8c07b1a785-goog

