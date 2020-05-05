Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBCAC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0CB2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KrQ3Qv5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgEEOgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729698AbgEEOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:36:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:36:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h1so2394010qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xLqVtWplZKsLIJdprvnT5ADfeKVT4pCnW1acw8qUeXY=;
        b=KrQ3Qv5s+EiIpNV+/8EDkHhdMdh6db6Oqm5UekNng3/rjuE4X2NmmVHkgJjVzo4WD+
         20sh5L2mMWwN+lTWsrBuU1N07Yp1pi+zN8FtaxSBqZWKviabJk6HLMFyYQpspmKgOcf8
         RxHtRJX5rM3mCSObpEozIUZjOhoDer40tzz3HO9pUI8p82BNQWbqNf8MX6cGDjubvXYa
         mXLFBnPwNSlyG0MNyzIHhg99lIuuoDPqgQOcKVpb4SVbbL8m1UFK4opJukodhyfl7HbZ
         A1CdGQJQTe5WYzbBtzTifeT5Vh8lY4zLo0n6n8kRvyxYbmzfz6ubNAYy1H8azgPphRR1
         NN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xLqVtWplZKsLIJdprvnT5ADfeKVT4pCnW1acw8qUeXY=;
        b=dOzUazsFucBrOZWFxV+IwwrKlSXAJHNvuQ09UkrGSmdebTseSoGHlSNuuSc17A6Wyu
         Mi38l0QsYJ2paD7OBFGvNsSaMsTEAfWlH6TuTa5gSokh926iRhr0HWpZb5g/1Ayq4Zdn
         Cerz73T+B9Hm8mjdawzmHFWO5LgtmjBI/9ri/82HN2bg5F8oVuP2ibix1feUnYQwZJ+7
         uBoyydGbb4PoiGqCa2uRcpZqB4rpYVrUbdVdycP1esQ1hCLlqGEOVYQBLNspB3AGOa22
         Wq6bb3KLJB1IYzH6ZtQnu4ErJinn5GCp6CjXJG/PC6SZVq76xubpsUiJZliqo7x77OJA
         GCDQ==
X-Gm-Message-State: AGi0PubKeD21EZzBnbTMrJ+P+kNfRnMO1NztmYAfu3JJJ1JJEL4Cabbs
        d0RW5WkrHSvDTWSFv5Ux3l8bvWo3DWAV
X-Google-Smtp-Source: APiQypIg5n1Py8vFsd8f4tbvam9ovtUcumM2lvtSdsGDHBQ1I+7c3JGuR2EfERRbuSy63jCu/fgedm3EwM4n
X-Received: by 2002:a0c:f90c:: with SMTP id v12mr3037715qvn.21.1588689396441;
 Tue, 05 May 2020 07:36:36 -0700 (PDT)
Date:   Tue,  5 May 2020 07:36:25 -0700
In-Reply-To: <20200505143625.147832-1-irogers@google.com>
Message-Id: <20200505143625.147832-4-irogers@google.com>
Mime-Version: 1.0
References: <20200505143625.147832-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v3 3/3] lib kallsyms: move hex2u64 out of header
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hex2u64 is a helper that's out of place in kallsyms.h as not being kallsyms
related. Move from kallsyms.h to the only user.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/kallsyms.c | 13 -------------
 tools/lib/symbol/kallsyms.h |  2 --
 tools/perf/util/symbol.c    | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 1f2f519a4e3f..e335ac2b9e19 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -17,19 +17,6 @@ bool kallsyms__is_function(char symbol_type)
 	return symbol_type == 'T' || symbol_type == 'W';
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
-{
-	char *p;
-
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
-}
-
 static void read_to_eol(struct io *io)
 {
 	int ch;
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..72ab9870454b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,8 +18,6 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
-int hex2u64(const char *ptr, u64 *long_val);
-
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8f4300492dc7..381da6b39f89 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -566,6 +566,20 @@ void dso__sort_by_name(struct dso *dso)
 	return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+static int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
+
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
 					 u64 start, u64 size))
-- 
2.26.2.526.g744177e7f7-goog

