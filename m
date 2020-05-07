Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBE22084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="biQh+rIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgEGOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgEGOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B013C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g17so7164287ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WNLwvCLfBBjUXdSm9htdY2ZIrU9tK5abqhIDyW74dxc=;
        b=biQh+rIPaJjiWmCdpodETgccn4Y8n5FVL+Mpr1MGuwevY0+0SykmjiYjnIyHYQMSBY
         IR4+qgSztOBizqP2lGvsdWjUQzlUnfjxI9lZ8cNpebFxnizLjDTBQQ8NfHsAa93Htouv
         mrQ8GovuR/j5bV1vGV8e9R1zTUZmDbrcjuldLL2/J3s++NkilCKmBluMxqXG2cIbRqEU
         dAq/VoetqTDUKRgLyWw/0o6+WAtaMsG+6YWBCiJvb2V9KMeq3j6eLqL7LV45hnvhutcN
         j1/j0E36THBQDBgTLTFMupBXqIgInb0pLME/AOQ3nEmGnsF+BJe4lZ5MxcqCuUH015zI
         grMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WNLwvCLfBBjUXdSm9htdY2ZIrU9tK5abqhIDyW74dxc=;
        b=poVHdEzRTsZShjUuFOpLrVIKqJeL/w9LDFkTP7lPvkIAzjA9tN5bV2Q+vG1cXsqKRd
         8RqFz07imphNnwbFCbqJ54WwoYhu2PEySoZvW4is4tZuDC19iO9uaJtHCCu+xHWavGrm
         r0MCMBmJp59g3LFceCIPo9kD1JtZjf8+xh8FFe92lG0vPwJEj2VkJf9e5lOyTfKw3qYv
         Im2i/cqHwJqYVoTm0K36Xyn9w4leCsWI7U2bCti+Tv5Z58flCmTn+M1jD8PEi8KRGtB8
         gudEV76iLMmXoCjCtts7EsO6PXS08cVKA3DcQ9d07KdtRybX9KYQlnfuXPBjI82nGZSS
         dlBQ==
X-Gm-Message-State: AGi0PubaNaeEP0NUmgkjaliJanePfg8eA0TIQhfSO4Dq/+lIPaYqHEC/
        d7nwwJqi+8xcjzjJjwZRCIlj3XEhzgG7
X-Google-Smtp-Source: APiQypK7cb30cBnYwkBB+E9mLL262GSv1zCyE6oU2nAP4RqCHtNPorpKhkR4Mmq+RPtTBEFQtMYEM/rnQiQh
X-Received: by 2002:a25:b951:: with SMTP id s17mr23122292ybm.205.1588860535288;
 Thu, 07 May 2020 07:08:55 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:12 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-17-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 16/23] perf evsel: fix 2 memory leaks
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

If allocated, perf_pkg_mask and metric_events need freeing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f3e60c45d59a..d5c28e583986 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1268,6 +1268,8 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->per_pkg_mask);
+	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
 
-- 
2.26.2.526.g744177e7f7-goog

