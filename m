Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285DC208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3XhVoaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgEHFhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgEHFgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:36:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B295C05BD0C
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:36:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z11so807308ybk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kf/Nl54LdD1Myd4Q2ihfierbY9Agfscu2MTKHIAamr0=;
        b=s3XhVoaJuVP7bfI29XP+1KV8iq/zlxEkxZpwETde6utnftcO1DZWav49uNhLe9yLot
         +5/BdgyKr/VjJ3NqNKoK+eh6gBwyC3Oa7xXwAXVvKgWiZxGCTrBsX0PWDwuZFt0LALxS
         W88zJ02aK0yyrAQaCPjn2L6BbibphSG3vz7GsueuTLhoYcdhPiz8nEzV/5ntVLYPHUSR
         Wyy7zFsHLy5pXaIkJvbLXXRvpynpq8+VYRCoy8O1Kppx1y2azcHzoMe6RCGLINLMBrbL
         fvGBdGFk+cDjvAo7kCUIID/P2Z5ZFqkjEKrZGP8BBeYhQ4u4+ELHUH0kaMTwORFRbnSK
         SULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kf/Nl54LdD1Myd4Q2ihfierbY9Agfscu2MTKHIAamr0=;
        b=INyImggbXA2PE8IXWHPiSXpUdv4EnO4hrQb8Z5K5pTN7zx6fMnn7AzdYSc+QAaItvW
         5wZgbheFBU5azM6YM4/Szlfq8qUd/3bnzAhnN+aCuopJNfosqzPeWGAJDC9xPYihEFop
         gZBMPXNUxTZofDSQWGC4NTRCNgiqty0S5EGqIDJjoxU35EuKTP7mOYCclJm3jDWJmKnC
         LSvH98WzVJRnt919H1pFD3um1rahmaPVrxJfEtK9Wwg29FKZJVqsivW9fK0jZdB+2VuU
         QcywNrNGBokNzKd8WXnWyT1Ey8AOyxHsZTKs1gvJihj1GpSwCiId3kiNOWVjQP8mM/e9
         WHxw==
X-Gm-Message-State: AGi0PuboMW18kGc/lS5vE81d3bzEI2P3G36G6y9UKc+LHMJIrIzMcVR8
        qEjSUf09smX/A9jOlXol5TYX4gVPrKRH
X-Google-Smtp-Source: APiQypKOjaO6fI6votAtJkqNtpxhTPzscSvTlH8sv81/G65sdjlnWRsXh9hMb8MSR2pcQmAAjFHFfSeqH1EV
X-Received: by 2002:a25:cf50:: with SMTP id f77mr1986942ybg.19.1588916202354;
 Thu, 07 May 2020 22:36:42 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:20 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-6-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 05/14] perf expr: fix memory leaks in bison
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
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a destructor for strings to reclaim memory in the event of errors.
Free the ID given for a lookup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 21e82a1e11a2..3b49b230b111 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -27,6 +27,7 @@
 %token EXPR_PARSE EXPR_OTHER EXPR_ERROR
 %token <num> NUMBER
 %token <str> ID
+%destructor { free ($$); } <str>
 %token MIN MAX IF ELSE SMT_ON
 %left MIN MAX IF
 %left '|'
@@ -94,8 +95,10 @@ if_expr:
 expr:	  NUMBER
 	| ID			{ if (lookup_id(ctx, $1, &$$) < 0) {
 					pr_debug("%s not found\n", $1);
+					free($1);
 					YYABORT;
 				  }
+				  free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-- 
2.26.2.645.ge9eca65c58-goog

