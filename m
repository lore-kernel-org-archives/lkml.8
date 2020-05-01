Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A5C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732D320857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9ORGGdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgEAWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgEAWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:13:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C23C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:13:28 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n22so12800559qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g+hv77hHTrU5+PV+DL7gk1Le0mH/lrU16qU7b7daeG8=;
        b=u9ORGGdc4Zodd8PCte9qaExvR/YZwCFPynhwuVTJyq8FC8UkhkTeB0stM06i3+W8NU
         npCAYJLJi2eBozGXIyW4ana0QQafDAw90AbSNugE8RouUDUZrM3Rq4aDbXNIhsBGRIbc
         aX2ePsulz3E/itUDhMyQO3lwQMXbu+lUnvBrePW7NAfN8cnxPNFAdPwGDE/9S5DruE53
         AVz2ojTM5xU6Nz71INylA2ESTp00VHOfeysYI8zXOp81nLnZetoAx3dT/RDyGHlP6LXh
         EYVzT3Po6tQaKBNBpL+u+t/ck98s5aweTS2isWbl9h6xjGTyKkfPHFGoDZd3rnVkrOXm
         ghgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g+hv77hHTrU5+PV+DL7gk1Le0mH/lrU16qU7b7daeG8=;
        b=NlWF4sTbu6Zhp2BPxxXIyBxQIGsTjVtIWTY1bNqxqovp45YEh2NFeg5NpiSkUH85lt
         THbI/ruj5jla4bZiniCnLnzlO4cPmekBpkrE1Z41XzdQ7Hn9IiNeibaMRxGQyXTO4+oL
         kUgxtt1tgn9DRupiMtaaS3DBxq/wVfI/jY3/6Eu8Hal2I5jDRFJodMlr4reoELI/ReUH
         e36ie8O5swvlQzPtKKxI2Qr5VcN/0rxYDTDW5y1nXb5CnXZ2IwK7A4131NPMvFLPyTS2
         4JBZBosjbp3YQuxwvmnnI1JdBGnQW1uycLRnlq2euhf7crJ77ZYKJT1pT2quoi1t/kjH
         Qf/A==
X-Gm-Message-State: AGi0Pua7GyafECgZtQpZX5AaWIP0oPdwTCj5dLctw/Hqt9QXXDJasfHR
        ByMFg6wh7vC3xv4m+E6WjljLWjc5X90q
X-Google-Smtp-Source: APiQypKtD2E1Hn1zPd8RS8SWux38STp84q5oCkbp/5c6tb8W+pmk8zQsMGMW07ZrgUI5vdcgw+gU5Qo9msy7
X-Received: by 2002:a0c:ec8f:: with SMTP id u15mr6263062qvo.102.1588371207873;
 Fri, 01 May 2020 15:13:27 -0700 (PDT)
Date:   Fri,  1 May 2020 15:13:15 -0700
In-Reply-To: <20200501221315.54715-1-irogers@google.com>
Message-Id: <20200501221315.54715-4-irogers@google.com>
Mime-Version: 1.0
References: <20200501221315.54715-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 3/3] lib kallsyms: move hex2u64 out of header
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
 tools/lib/symbol/kallsyms.h |  2 --
 tools/perf/util/symbol.c    | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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

