Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B96120767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BG6dftwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEOWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgEOWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:17:42 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A123C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:17:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z5so4039726qtz.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WCzTCCGLOmnXKTfycmI4FwJUOkiifCaukEuyzWz74RE=;
        b=BG6dftwFF8ZH5yTvZvbKc2IJYlA6INCsvT+QzwW+cFz0r2DBOqgRfiH/kp5XTfYe47
         1JJHyrf5ZdSlIZaIJh8MuG3yUNinsdLul0pRDxl6CmayDFj/VMEZN+GqfNWdXxNKJ5Fu
         NrzKdyyMbG86pk1CZuM2HB7VNM9ywiRJ5oM3NXvOYzCy9oIAgb9KDN7rgj9q9skZ1nsH
         YElDQKEfG/k4S8CORnCJV7Q3VewS7q+wtq96Ox9Dq6G51fDpAeFIQmt3EZHeiVIi1Esu
         mFB33Abbnt6diuNImH+RwJxovTuW544YjxxGFquakl/Sm2i1vDd21g7P72GmlXgBJOd7
         qt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WCzTCCGLOmnXKTfycmI4FwJUOkiifCaukEuyzWz74RE=;
        b=U9gy9Fza0ckyvcE2HbBKuy35ff9hI2aPWANhUCXsxdyLslkHEYcIBDj75cWwnxxVLQ
         aK2jEHk/1hdrDi5pRUDR53+O+/VRuDpvWOPofZSY5rdQ42bsdrypMxS8JsNgaXgrTmdA
         +AXRVXlV9qWYoYtWFonZmAesgAKIp/rsi2oQdDhkxbpQ+rKd4IN0quuI2QDCwQMoF9+W
         nZHuTo9Y4CFqLX7qt9ROLCuTMnslKtRqU1KB1b21yUmNhBoIHGiAhkvPxJEtitqyTYQq
         aamHF9mhmdbdTGIlrYwzezU/GAgoTztU9I84vzIQQXQwDDmshBrvD3ROVuxou8cnRagz
         g1og==
X-Gm-Message-State: AOAM533fMa0B/lHHa44Z8aV4lSyDW8wj3hiE56FTDGSkOMACKxgP/vRg
        o+L0quQbqDBTOHeSzSmqnzlGyUv7971q
X-Google-Smtp-Source: ABdhPJzBqKBJJo83Ab/EA4hliZGmCNRhlzF7+LSl1/6H/hVOkVHxQlYeN5jI3zTx0nbbJvFLskdY4DNlu4mw
X-Received: by 2002:a0c:ec44:: with SMTP id n4mr5623243qvq.237.1589581061558;
 Fri, 15 May 2020 15:17:41 -0700 (PDT)
Date:   Fri, 15 May 2020 15:17:27 -0700
In-Reply-To: <20200515221732.44078-1-irogers@google.com>
Message-Id: <20200515221732.44078-3-irogers@google.com>
Mime-Version: 1.0
References: <20200515221732.44078-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v3 2/7] libbpf hashmap: Remove unused #include
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #include of libbpf_internal.h that is unused.
Discussed in this thread:
https://lore.kernel.org/lkml/CAEf4BzZRmiEds_8R8g4vaAeWvJzPb4xYLnpF0X2VNY8oTzkphQ@mail.gmail.com/

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..e823b35e7371 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -15,7 +15,6 @@
 #else
 #include <bits/reg.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.761.g0e0b3e54be-goog

