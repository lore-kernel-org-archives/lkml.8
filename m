Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C489C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000572084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK1m+ecJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEGOKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgEGOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51054C05BD0B
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p31so7309588qte.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O3s1th6kwHV7OYn1BOC0SkexVvWRfaB4W2WMHJ3+QAE=;
        b=CK1m+ecJfjS+4WckyJ+MIAJmu9NSdTFzbnEvuTlhNhN2suAzSw1T5RCN8pFKx7qCp4
         n8nnqkhcZQAmfewVBnzZ6SAJQ+TjfCy93ePBEh5Frx6f707haJ1ZrHUlcr7n6906D2DN
         ojqiStE90Xd10Qio2tmn6XzaetPKq7lCzsFLSnIsfHSjm5vbOBl9vWzRWTiiM+ZvHAFN
         hC1/0b5t+keN9XBkOOOUKcIjiW4lsqVd0R1fMzlrlrGhAN0EIoQW7WWxeueiYqiI5D9N
         wAc4DchPEq05tJn/O4RH4yGj03qsYJkUcITNMNLGCEhgB8FQeT8TYfOhk24A/N4h+t8x
         7k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O3s1th6kwHV7OYn1BOC0SkexVvWRfaB4W2WMHJ3+QAE=;
        b=E8BUKeuHzjFI3M9qPgbFpeKdZn0eI2pM/1sA3IUwT9kiwcptldtgTh7icT0uCbJdIB
         hlw/PbwAZQisps3sEcEchwTOtfqsYbNXRqlaS4nAIKcJEz1D7JUSu8DrebIvXqaS/iXy
         7jfYrfPszdrpblmhWzMEOKRn2GvUR8xiuV6WsNs/N+l8SjQvXRcg/h/FyX6+h1DpoGh5
         kVKERJRC4Wk+h1duMKCfQ+7Q9eq0VTokbz1bwDN0cZgIom8B0C4IGdrdbY/k3bmKunU8
         ozJB4Z4Jw33Luswyu5Rpuy5hSF0TxLSuRQGe6FO9LB8WtCAUqc00BQsvSwndrboHOBPv
         voJQ==
X-Gm-Message-State: AGi0PuYuwUgDSqHPH3A4Gry/2ZFa9WlvcCFZ3H6C0Kd8PgVl93Os1+IB
        FPfp+uw5227WDuGc0FKsQy+whnAFxoGe
X-Google-Smtp-Source: APiQypIHBeiQoZpM97RY/NesSn20dHYkSwzLM+BOs1oCir4+ihIeJWG35Y9jkK+FwGLI1ItCDPmH/CkTnit7
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr14045295qvb.122.1588860533355;
 Thu, 07 May 2020 07:08:53 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:11 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-16-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 15/23] perf expr: fix memory leaks in bison
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
2.26.2.526.g744177e7f7-goog

