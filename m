Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE5C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4905420857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVbDpsLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436919AbgDPQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730035AbgDPQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:21:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE485C0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:21:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e18so3431281pfl.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a6tQ7DnVmCoPtEQQNpyDptK3byF4qMP4x4cRpQx2XV4=;
        b=AVbDpsLbKtAaOU3yTQ6Jkn38wfxP3SvLchMNOvt7HyyL0QwFZNGqVKoVyLKjt64kGs
         xvsh/ec3XhwSbr/TYnKAw/3EEAX+t7qo6T8+MJ8Ll3dAzCOYHzCYANNSGso/eDiRS9Ss
         TwXciuCd155RVkf14SrqLqp5b1JMcN15Pjj01mS+v2KVoLYkaqIbhd7LZiK4zyVVwE0i
         Q2v23jJUpr1rVLNbAZh2otJz6lnKISqB1yeokKz4ZCu/G34JqABEXnsw0oGT3EyP+KXi
         8B9f8n91EoUnn4jpPfhrK7RYaSMSWO0kyNJe15rOBs6fJJK0X8fifF6bz85UfbQpDz/m
         ij0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a6tQ7DnVmCoPtEQQNpyDptK3byF4qMP4x4cRpQx2XV4=;
        b=mTofJd2gLRnN9l+8mFoWODBjZMALV4216BibbmKGrki7Ig90bv2z73gowiE4YbXhb2
         KTVmf9Vkniwy1m3KHpP/On6dOE3IBtxCY7GFvVp0JUvbHrPVSdFJihHa6jrwn9QxG1un
         DEw1Pg9WfzWYLshS0x0fPn2fmaxZYBlX8bGsNuHyOU4WyGmQBbp2htWGplEniBiB2XIb
         F6o6WsCdBiyIdCqgHP2PBtW2syrX81wv/owqx7po6WBa8khxZYMgcmwSlJv0S1EgALmT
         64ikzsDUBN8oBoCOp2F1QCfJDJXy1Du49GjfB5wuD6qskOvNdBvY3WcAORXAAagLsIwV
         3+RQ==
X-Gm-Message-State: AGi0PubxP0dnhvnl5JHnKQcC5xss23g2cFSmsBbDUYzXCUp2uWSqjPez
        xMH6c8znySpBZDRR6DfifygDnXMT1mNy
X-Google-Smtp-Source: APiQypI/5T+C0TPvvOpusz5KPtkgU0R8dP8dM8GPvH2VRKVG1DKmMcsjfxZ4wvFE7gi8YomJ59uyV4oQeOg8
X-Received: by 2002:a17:90b:23c8:: with SMTP id md8mr5869465pjb.172.1587054070393;
 Thu, 16 Apr 2020 09:21:10 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:20:57 -0700
In-Reply-To: <20200416162058.201954-1-irogers@google.com>
Message-Id: <20200416162058.201954-4-irogers@google.com>
Mime-Version: 1.0
References: <20200416162058.201954-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v10 3/4] perf pmu: add perf_pmu__find_by_type helper
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
2.26.1.301.g55bc3eb7cb9-goog

