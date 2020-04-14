Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C00C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112232076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBJvjQZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503516AbgDNSLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503481AbgDNSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:11:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160BC0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p12so563500qvm.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=ZBJvjQZ7S0H7g7dGFOCFUEHvsaRcW9EiWMXBZ2djyZfTOihoQcg+OCkWR5O9DVKrLP
         7NOBkGjPs2OgzNHER/gXrnr2mU4MSkH0UZfjq+EKsykmrHo87H4VRLNAq//Ige5b8zuv
         RRBArhBoOTQRZykqIvq2ECJKsEIF/s2vK3hU+oDK+tncfAH1007l9mOg5gHlCVr6Kt9o
         2+ixDpZydTNpJ/uvIFmw6ETeWO9KZC0w7gaQIPYg8pcRcLesNw/MCqpOtcaIqGZvDEyI
         t293S67vHrq58vdb41c2eN1Y9/BQ4rv6cKFzNSQJMRv/exAN0bbLJTWDM4hL6ku7n6fc
         qJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=c++1KOY3NpQlFH3KLELVJ1QUcWHhzcS0zdl9z+TqdNjGjRyCfaTzBBZMQiRRvYY18x
         EeO+OofEPgDyhXYXV8+7DX8pCToMNcX2RTEYHP6KbXXVrB/GBi1Ez2PT7BfvJ5rOnAz1
         VcRkicpeFwgNi/1IoDYaG/Yc8go9BXbYtpKNFDYek2lvvkFPUwspzo7v4yjcKerjVCQt
         4E+YtquRCCLBn80pbfm17dvpO6zHq+uuz+1ZDoai4dewMUu45Jeh/dDcHoShK5ivjF6f
         xwCo8130TcNBiS7Q0Vi8NVyFBBQVlvnuR5UDW3OLIkJzW6Evij4qZ96w7H+j9zLlf0kB
         0KNw==
X-Gm-Message-State: AGi0PubCuBCb2wOTrpmVP4C9Q1yIKsNdarIDAP55AAv0LMriyiwgImcM
        OB9zKl0fzO2dBuQuXY7PxYp7er66iRq2
X-Google-Smtp-Source: APiQypL7lljiWPR9gDt9kyZti8EWxbZqDY0GWqpVMgq3xEKyNJazIUclxhN3genl9KEXl5Vgs1UG+EYue0iV
X-Received: by 2002:a0c:fd8c:: with SMTP id p12mr1256220qvr.163.1586887866597;
 Tue, 14 Apr 2020 11:11:06 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:10:53 -0700
In-Reply-To: <20200414181054.22435-1-irogers@google.com>
Message-Id: <20200414181054.22435-4-irogers@google.com>
Mime-Version: 1.0
References: <20200414181054.22435-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 3/4] perf pmu: add perf_pmu__find_by_type helper
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
index ef6a63f3d386..5e918ca740c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -869,6 +869,17 @@ static struct perf_pmu *pmu_find(const char *name)
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
index 5fb3f16828df..de3b868d912c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -65,6 +65,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.0.110.g2183baf09c-goog

