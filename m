Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D43F207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdAR16zY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgFDO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgFDO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:56:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764FC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:56:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i82so3860860qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I7c54UO+jBDB8Mu0xGlRZFnGkQOtoIXkr80oIo5a6yg=;
        b=WdAR16zYbaIpErpsEUjQUxhf/HVJmWp9W2xV9KUpPSOChHzHXHifTJoWwWOYOgQr66
         0tu9vvF0JqyYKkPP+BQVmRzBp26oSZ6f5MBQIGKG9QuJ+2MeZlMY19pWKVIj+DjzY8x+
         IFeOAnr488HRfID5IN9RfVX7CdLbjjQrnAA6c6fCFlYMlZ385fOeMUsizNK0tkN+DBK7
         M3P20DNhi79d33RVXcTSYH8WcEQjbOohH22CnJjNh7PCoeNx0EGyMUlhMdc59XV2JLn9
         1+s2pMv/7JWlvLF+V2r97qS7XXEKlFVPKO7k/2NxgzCW1Gu8GNAKXCbVEp2GmdyG9Ytf
         hksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I7c54UO+jBDB8Mu0xGlRZFnGkQOtoIXkr80oIo5a6yg=;
        b=WJYnH5y9t2LW7o802HIaDiVUdTub/paXHaG+inwWhkL3FWF1NUpRvA7F8v3yC1ntyK
         nSqINW0JP9DgPM3zvyHKxvJbpUbgln7j4/nzwybkRTllFczQFJhwOvtSSzUqljLBVaJj
         yNNQTQk2vj+kL9HRO0fjWm2f1tEptRGqR0xWiSM5ZCm+e1JSmiNMLGY05LuWueKqMgJF
         gQvAHwj5wQllauz6X2Kw9LdLxYqJp52pv2Ti5c8ppf7ymOAhAlazlTTbWWHmc4CHwOgJ
         A+PAkaJA8zpN7t+Ta6ZjvXyua495LeCQlw0gHInD7Zn2GN49nVXeIM2S07vXdEYlhKHd
         1TJg==
X-Gm-Message-State: AOAM5302lHlJSLhJFLzGx04a+ttmroY4PFMHOBWwLWq856okVrByaJeY
        jvMfp/nwjz3iIh0NTKfl0ioq5lY6qA==
X-Google-Smtp-Source: ABdhPJyAh8LeK70LOHp8HEnAZAPVHdn5vz8HSU2QyqdrJk5KJMZ8eiFT3HVtWniKuUOz4CDcEf60hO0/UA==
X-Received: by 2002:ad4:556b:: with SMTP id w11mr5001166qvy.171.1591282605967;
 Thu, 04 Jun 2020 07:56:45 -0700 (PDT)
Date:   Thu,  4 Jun 2020 16:56:34 +0200
Message-Id: <20200604145635.21565-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v2 1/2] kcov, objtool: Make runtime functions noinstr-compatible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, clang-built-linux@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we lack a compiler attribute to add to noinstr that would disable
KCOV, make the KCOV runtime functions return if the caller is in a
noinstr section. We then whitelist __sanitizer_cov_*() functions in
objtool. __sanitizer_cov_*() cannot safely become safe noinstr functions
as-is, as they may fault due to accesses to vmalloc's memory.

Declare write_comp_data() as __always_inline to ensure it is inlined,
and reduce stack usage and remove one extra call from the fast-path.

In future, our compilers may provide an attribute to implement
__no_sanitize_coverage, which can then be added to noinstr, and the
checks added in this patch can be guarded by an #ifdef checking if the
compiler has such an attribute or not.

Signed-off-by: Marco Elver <elver@google.com>
---
Apply after:
https://lkml.kernel.org/r/20200604102241.466509982@infradead.org

v2:
* Rewrite based on Peter's and Andrey's feedback -- v1 worked because we
  got lucky. Let's not rely on luck, as it will be difficult to ensure the
  same conditions remain true in future.

v1: https://lkml.kernel.org/r/20200604095057.259452-1-elver@google.com

Note: There are a set of KCOV patches from Andrey in -next:
https://lkml.kernel.org/r/cover.1585233617.git.andreyknvl@google.com --
Git cleanly merges this patch with those patches, and no merge conflict
is expected.
---
 kernel/kcov.c         | 19 +++++++++++++++++--
 tools/objtool/check.c |  7 +++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 8accc9722a81..3329a0fdb868 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -24,6 +24,7 @@
 #include <linux/refcount.h>
 #include <linux/log2.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
 
@@ -172,6 +173,12 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
 	return ip;
 }
 
+static __always_inline bool in_noinstr_section(unsigned long ip)
+{
+	return (unsigned long)__noinstr_text_start <= ip &&
+	       ip < (unsigned long)__noinstr_text_end;
+}
+
 /*
  * Entry point from instrumented code.
  * This is called once per basic-block/edge.
@@ -180,13 +187,18 @@ void notrace __sanitizer_cov_trace_pc(void)
 {
 	struct task_struct *t;
 	unsigned long *area;
-	unsigned long ip = canonicalize_ip(_RET_IP_);
+	unsigned long ip;
 	unsigned long pos;
 
+	if (unlikely(in_noinstr_section(_RET_IP_)))
+		return;
+
 	t = current;
 	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
 		return;
 
+	ip = canonicalize_ip(_RET_IP_);
+
 	area = t->kcov_area;
 	/* The first 64-bit word is the number of subsequent PCs. */
 	pos = READ_ONCE(area[0]) + 1;
@@ -198,12 +210,15 @@ void notrace __sanitizer_cov_trace_pc(void)
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
-static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
+static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
 	struct task_struct *t;
 	u64 *area;
 	u64 count, start_index, end_pos, max_pos;
 
+	if (unlikely(in_noinstr_section(ip)))
+		return;
+
 	t = current;
 	if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
 		return;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3e214f879ada..cb208959f560 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2213,6 +2213,13 @@ static inline bool noinstr_call_dest(struct symbol *func)
 	if (!strncmp(func->name, "__ubsan_handle_", 15))
 		return true;
 
+	/*
+	 * The __sanitizer_cov_*() calls include a check if the caller is in the
+	 * noinstr section, and simply return if that is the case.
+	 */
+	if (!strncmp(func->name, "__sanitizer_cov_", 16))
+		return true;
+
 	return false;
 }
 
-- 
2.27.0.rc2.251.g90737beb825-goog

