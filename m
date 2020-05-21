Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6076020721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mALz/ryu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEULKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgEULKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA245C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h129so4866090ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SvajioAcxE9ANa2I2vNqdu1VYDhOobctmex3U6Yh/nk=;
        b=mALz/ryuWQvX4o5MErFi6iist6T1VROIzyxDcJ4LXQ/RplTvSAJj+TBbsCIkrQVcDi
         3vtW6yE4ekL/VwJYiBih4wCfvVEb5Z5xEhF3NoFyqW8w6rsSKfVMdqxgEFa/6gHGhcO4
         6tV20p5qt82DEqkExXWY9isgJithc/NWtKnxxypptE/jR057eglE10hz6GQgqB4CfbOi
         e3IcUo0cvdpFC+sHVnEOmyDPDC2XuLZ+VwlANvtt6JbKqCZSHbY+rAxe/rrMJT7tSCmX
         tWqeNFfghJwRcRWy8uzzVz1fknlm/POXY/lqfYcpg5aBBLsJI13pn9VVUG3zBkjsizZQ
         eaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SvajioAcxE9ANa2I2vNqdu1VYDhOobctmex3U6Yh/nk=;
        b=tR2hpreObeM9+FjA5lt2DQuKfOTOVIuOg2CIAZ6c3saL461MvrqoEQF0L4bGkpakWh
         9f6i1wUaPR7s/L0GXa9XxbIZ4i6jlPGdIsEzZcug9INfMOFGR6/s+LPTEPXU50IKfVPt
         0xYDFEa7+OjCg8GvwPgmZmi5OPN88qk2BZ+PyjuPmk+v5EUZnG6VtDdrbsEWovAN6Qf3
         WEMrHsFZbr3dopjjwcBd/b4xyKXm2rqdpoYEJiTjagx3K6Z0iLMR4XWkOgrIfHUArvwn
         B6R7w95kfodc+0zbqlIQUF6OQnPXhRRj1GLRe083Mwb/1CWHL2Af7BBbOWw+/0GK55pq
         F6nw==
X-Gm-Message-State: AOAM533Xb6N9zxKUjuDqBEY8qMLpB9ftW55LmU1topg2mLwsBnM9Mjd+
        eYkBllaZqcCgA6IO5ZFAWSiz8KGVhw==
X-Google-Smtp-Source: ABdhPJzziwhXpk6ydHCL2TP+zaQ/m5V6tDnnRZFKTyV4cU1DfwnR3a1yHfCX4wbJcywEuoNEyTrxt5WzMg==
X-Received: by 2002:a25:f20f:: with SMTP id i15mr14499554ybe.72.1590059413041;
 Thu, 21 May 2020 04:10:13 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:53 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-11-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 10/11] compiler.h: Move function attributes to compiler_types.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup and move the KASAN and KCSAN related function attributes to
compiler_types.h, where the rest of the same kind live.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h       | 29 -----------------------------
 include/linux/compiler_types.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1f9bd9f35368..8d3d03f9d562 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -249,35 +249,6 @@ do {									\
 	__WRITE_ONCE(x, val);						\
 } while (0)
 
-#ifdef CONFIG_KASAN
-/*
- * We can't declare function 'inline' because __no_sanitize_address conflicts
- * with inlining. Attempt to inline it may cause a build failure.
- *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
- * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
- */
-# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
-# define __no_sanitize_or_inline __no_kasan_or_inline
-#else
-# define __no_kasan_or_inline __always_inline
-#endif
-
-#define __no_kcsan __no_sanitize_thread
-#ifdef __SANITIZE_THREAD__
-/*
- * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled.
- */
-# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
-# define __no_sanitize_or_inline __no_kcsan_or_inline
-#else
-# define __no_kcsan_or_inline __always_inline
-#endif
-
-#ifndef __no_sanitize_or_inline
-#define __no_sanitize_or_inline __always_inline
-#endif
-
 static __no_sanitize_or_inline
 unsigned long __read_once_word_nocheck(const void *addr)
 {
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6ed0612bc143..b190a12e7089 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -167,6 +167,35 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+#ifdef CONFIG_KASAN
+/*
+ * We can't declare function 'inline' because __no_sanitize_address conflicts
+ * with inlining. Attempt to inline it may cause a build failure.
+ *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
+ */
+# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
+# define __no_sanitize_or_inline __no_kasan_or_inline
+#else
+# define __no_kasan_or_inline __always_inline
+#endif
+
+#define __no_kcsan __no_sanitize_thread
+#ifdef __SANITIZE_THREAD__
+/*
+ * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
+ * compilation units where instrumentation is disabled.
+ */
+# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
+# define __no_sanitize_or_inline __no_kcsan_or_inline
+#else
+# define __no_kcsan_or_inline __always_inline
+#endif
+
+#ifndef __no_sanitize_or_inline
+#define __no_sanitize_or_inline __always_inline
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
2.26.2.761.g0e0b3e54be-goog

