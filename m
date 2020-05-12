Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B2DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664C820740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvLZcsgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbgELX7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgELX7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:59:23 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86963C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:59:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d19so15311514qkj.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2GqDmhX9YlwDryUmBk9kB8vRTZY2wKrfJUobuEy5dec=;
        b=TvLZcsgrbK465iqLR68FzyqGGKfGy61Aj5tpf2Lko49QcopBuPmIkCKwK6DHwolICX
         PyoiprfjQgg/M2KmJdhT98PanCbE+eGndefT24ddn7vGDwt3IoIJH+n4Q39v62G6NeBj
         t2nMFDGHss9tXKFOnfrzeeSli6+xDMJZ1iVrOBLJRuD+1J4QkRIzMHli+zFejh61+q5k
         0j8lAgzUpe/+Z47BFgsqSKqUlcKu0DRpQ1+J7ywXNofJu5bER+JN21gDo8HYUxE8neJI
         VfWxQkk+PpZTXekgxnzWSvnIBAPi7MSMhKlj0u7y4LIYrC91Zq61SsMJ3lQqsnXqbVfi
         FvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2GqDmhX9YlwDryUmBk9kB8vRTZY2wKrfJUobuEy5dec=;
        b=fx70ssyxqkwowWNOcsYimbV0lJp7emzri6/hJp2fD43qpH6WQouRCiv5x3UMu3hkpq
         In19aIJhINV1J3o1WnW+e9pG8GY0Km/41kJm5J59Z4gGWkrhocGuKCLsesrDnw0g6SZt
         iltFqQnQO8MjkDHBZtW7m/+BnsMLbWxLMSO6+TSoO4K7ZZCIP2U7ogEdOTyJjaMlQI8O
         oWeZGjnU0Odv9qjHZjjDD+dPh22hVyP1XCL2Dgvq3ojTdEtyQraIlTafOThKIx7jssuS
         lq1SgIMVPRnKD9kR5NHqKZSD7TH0YC7ewEJy5/NpHbQyGLnxtW1y+wquNuQ4ZjJh/ddA
         F89g==
X-Gm-Message-State: AGi0PuZIzn6CireZBqKyEB3RwA4e57eDq+5GYKLrv6dXUECwsrouuQfl
        xJwtICQuv9FIIqbYoTHD7xEIzQwbgyfV
X-Google-Smtp-Source: APiQypIqwsqlQgaFDQ7OBgifsBKayD3dwzktGfh4/s7RLkqB9FhBs6v3rxAbeSMUE1YfTv5HmHnogdus1R8j
X-Received: by 2002:a0c:f791:: with SMTP id s17mr23443305qvn.36.1589327962662;
 Tue, 12 May 2020 16:59:22 -0700 (PDT)
Date:   Tue, 12 May 2020 16:59:18 -0700
Message-Id: <20200512235918.10732-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] perf evsel: Fix 2 memory leaks
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocated, perf_pkg_mask and metric_events need freeing.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a2397ca4d57a..654b79c1f4ac 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1266,6 +1266,8 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->per_pkg_mask);
+	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

