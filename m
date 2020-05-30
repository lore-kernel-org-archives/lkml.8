Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8CD2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDiMO4OH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgE3IUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3IUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:20:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52914C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v1so5875356ybo.23
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ULNDcMU2cPOuKjungjzNkW5is5uzXicsHUJwDCdcrQ0=;
        b=oDiMO4OHlhHtX3cEYbV0VwadSP4yGmNf4HsbHS3LR2awH1AKRJNKO4dIA0yxwLZH9h
         i5cWdpkdULms3BTyRXs+eaLYjOEeKRcM2r6CxpRjLGFrLt0ClSQWMj+t52+XpiSdEYE9
         hZYE3YcxHsoYPJjrxeWU1Qb1rOW2oUsuxuSv0rrXCzag+hj9gX1ToasQSIWFyj/kAwLp
         0cqHfRBUAmpakDPvgM7OaKxwyEEjTagRnEMHVXAOqGEoruNBKhxsFzcOFfnpyC8ENLK2
         G4Q9XWil/FgJ9By/Q+qX9hhRpAxD+QdYP/TaKK1BvaQB/WARqwF7KepRTJCfZfa5FopY
         7/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ULNDcMU2cPOuKjungjzNkW5is5uzXicsHUJwDCdcrQ0=;
        b=tY+3gvpcgHUJoqufofX4851Ngn4QoF6Qj2dmv4+dWJ/PfiigKujrrk5oLSgWy/adtW
         gYyEfE/FZXn1GbrqX3ywPCJMzoSMoGGj8Jh4AvsaukVabiYeQ7DVqi4lJtVs73IV9hDd
         W7Nave7JSodwoYJ+ZKwookJ20AogR9DsKYbL+nCMFfAI7RuPheG/e+kHfgOP4mtEQWsV
         x/ZnyDSRBKR9UeeP3R7Wpuxbyj2pDu+4kTU9AtYfZYB04fIr1VZVit06hn/K+wG64Va9
         mxu0ThFq+2qAVbSDSjgkBIvzpRRYZX+7HMfCA3YU7xNJaLMDi4bxKT/HB2LB+/bTdVjD
         Ng7g==
X-Gm-Message-State: AOAM531/p8GvM1A7pF2ABay2lnDj/Og6xr5He2VHszitXDTPbQoMtkHb
        667cQ/heQ0qT951fAnB3ooCwTjeCTAZc
X-Google-Smtp-Source: ABdhPJzQBzLQbWP/c4aT3uyK6bwS0+e/RrfnFmqrZpD6+dZog08w4njiDtVp9qMX98jOogjsPk3VXewxJxwP
X-Received: by 2002:a25:80d0:: with SMTP id c16mr19278304ybm.98.1590826839536;
 Sat, 30 May 2020 01:20:39 -0700 (PDT)
Date:   Sat, 30 May 2020 01:20:14 -0700
In-Reply-To: <20200530082015.39162-1-irogers@google.com>
Message-Id: <20200530082015.39162-3-irogers@google.com>
Mime-Version: 1.0
References: <20200530082015.39162-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH 2/3] perf tests: Don't tail call optimize in unwind test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tail call optimization can unexpectedly make the stack smaller and
cause the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dwarf-unwind.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 779ce280a0e9..2a0dac81f44c 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -94,7 +94,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	return strcmp((const char *) symbol, funcs[idx]);
 }
 
-noinline int test_dwarf_unwind__thread(struct thread *thread)
+__no_tail_call noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
@@ -125,7 +125,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 
 static int global_unwind_retval = -INT_MAX;
 
-noinline int test_dwarf_unwind__compare(void *p1, void *p2)
+__no_tail_call noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 {
 	/* Any possible value should be 'thread' */
 	struct thread *thread = *(struct thread **)p1;
@@ -144,7 +144,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 	return p1 - p2;
 }
 
-noinline int test_dwarf_unwind__krava_3(struct thread *thread)
+__no_tail_call noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 {
 	struct thread *array[2] = {thread, thread};
 	void *fp = &bsearch;
@@ -163,12 +163,12 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 	return global_unwind_retval;
 }
 
-noinline int test_dwarf_unwind__krava_2(struct thread *thread)
+__no_tail_call noinline int test_dwarf_unwind__krava_2(struct thread *thread)
 {
 	return test_dwarf_unwind__krava_3(thread);
 }
 
-noinline int test_dwarf_unwind__krava_1(struct thread *thread)
+__no_tail_call noinline int test_dwarf_unwind__krava_1(struct thread *thread)
 {
 	return test_dwarf_unwind__krava_2(thread);
 }
-- 
2.27.0.rc2.251.g90737beb825-goog

