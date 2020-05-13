Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A9DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8692C20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slK4LHj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgEMADZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMADZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:03:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0EEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:03:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so17508326ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E4DgmjxmPaW4DT6II9yNjLvDj+WP8wxPWzW8I99qhiQ=;
        b=slK4LHj48R8pGlRTD2JiiSK0HzzqpEofMiWPhBVcr82mVqgbr4sB4H+1fAqMuZ46g+
         rvnvQf2lddMdVWXQP/3UTm7KsnP02CC/Qc7zf9cY0BPh3LoLuLxuFC7WtHBJHnk6mhis
         SVzTln/278ZvlJ9ew/DnQjn/aOvY92z7Kz77vu0HqU4bjYoiwcBa7etyfzUoNGhp5vUG
         ZAyxEbGkNWqFoifdnPhNoplJ+43s7Y8p30XEALgx7Sj4K0BSw+io+wX+OxPzlGg6NcXc
         XmsFXp8Z6RxU8SqsvL3Kwn9WLVdFbkSNB51D2U2GGUz7cpn7nR/Fw4ZVpPokCaiE5I1F
         z3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E4DgmjxmPaW4DT6II9yNjLvDj+WP8wxPWzW8I99qhiQ=;
        b=GBNyLPl9vC/kdVFDz/AVUp+G51EEZ+JZwO0bv4jc0Am3K8G7b4vq93JMIsr7VwDfOQ
         KQRef62yqrPo5T6SF0Paq7K5Xe0IlRNJw/gFIXSjHTAG1RtD3KzxhRHHEXcCjfCnbItk
         8SAmkhcbOitIRtx6JWxm/SzLHRcInKssd9GPTEf9q55iI3gMRILuSVats0tFSC5SCTGM
         TL7TMAizMvKNuVdRpta6VWCtQeKfcbh0E5gRa+3wJoEiumLj7bwWTqvWf2Adv8+ImoNP
         4Q2aSoluntWiDQT3iR11iO6BPLZP/pnTgPlU5LebAC+IEM6gD6F8sIJ5xm4vujiRQIYC
         TdQg==
X-Gm-Message-State: AGi0PubvDYubZXSVS2SaRkPszp7FBrXF0q5Ag0Loc9TDTFpGPxKlsDnN
        +OJqJaZt3zwB4/fS9WAPCRlpD5NXXz1Y
X-Google-Smtp-Source: APiQypKF5i+is7i9ZOVgBJ7JAV19pNquFCAEO2MKfazz19cc1QAEqqn+ZPfdbGh7iP3XfL5ALiuDfYPcgb9p
X-Received: by 2002:a25:bb07:: with SMTP id z7mr37501626ybg.278.1589328204300;
 Tue, 12 May 2020 17:03:24 -0700 (PDT)
Date:   Tue, 12 May 2020 17:03:18 -0700
Message-Id: <20200513000318.15166-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] perf expr: Fix memory leaks in metric bison
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a destructor for strings to reclaim memory in the event of errors.
Free the ID given for a lookup, it was previously strdup-ed in the lex
code.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

