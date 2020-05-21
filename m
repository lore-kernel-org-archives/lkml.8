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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EAEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B19207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry3yF5S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgEUOWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgEUOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so5501096ybt.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lmm+/+h5qLO6fUy4Is9S48RQHv+8MyPjNoPxJUCaU88=;
        b=Ry3yF5S5/LqKUOIQpGNAL925QQehVK9jMWjX8PjHCVoA0XPJgDubp7oFbY/CDc5ThC
         WT+0+uecdaVL9mF34dHUHm62BJaTSsum+nyk/7BRGtaSIo0CfuUst2nRWxDLmPQI89QI
         +EfLiybS+tHYvCsDoFRrWrqcBiBaOxZY8EJgGeUvWdYTvlvj3g2KPPhIeGWj4lC4HOj4
         lS1EU36gsfoCEpfUFIUQa1ABmK44OnOuPq7qricwYQzsXdq73eqRwAVoEg4qfKY1Wszz
         qJvzYI+sBeM+aHoOD9Zfk+rBSEa3mXkekb06m6J8UASfj8D12i0ddnbMSjnmjhXb7rT3
         4iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lmm+/+h5qLO6fUy4Is9S48RQHv+8MyPjNoPxJUCaU88=;
        b=T7X56ecJmf/62ukYyNN+V6jvZ6Ea6LDI3oE98A13lnqfRQu6iJK741dn2deOfa7cZ9
         3jiD+7Zef3UZ3kNos+7DoYeGL+aqw37iypgOb+9X5djZLEmrPARm6a95miF4rbPfROnl
         dZtRQhNnp/1wVvvT16q94/2zx91WMxEOoQexdvlZrcPbKWv8bY1yi7WuhqPBCpFQhX1w
         ipIilopCOYZK1FdENFr6VHyV3cHrC/U/yZQ0g/48xMXQ1+7AXL4+U3y5p8yc0VTbq54Z
         NWyx3hECzZWzgZpXgU5OTQJI1wajTGuvk+Y+1nO5SAfTrDYjquiBslIAXjyaokhUtgsZ
         +t8A==
X-Gm-Message-State: AOAM531GNBr9ASqxBPzKRXHaVEpANO10HD2i4tNLJ5tpHeg24+CtrTwP
        0/6limN0BvqNbARTlL/2xLsfhq6bnw==
X-Google-Smtp-Source: ABdhPJxCbmIqG74ZKiFWtHzlEGlfTFXRBt+iLEI339Mbm7r+Lf9EBVzuxRUJ8/F5xLLcF6uwV4CNs3EzoQ==
X-Received: by 2002:a25:77d0:: with SMTP id s199mr14286095ybc.333.1590070963005;
 Thu, 21 May 2020 07:22:43 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:46 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-11-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 10/11] compiler.h: Move function attributes to compiler_types.h
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

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h       | 29 -----------------------------
 include/linux/compiler_types.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 379a5077e9c6..652aee025c89 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -250,35 +250,6 @@ do {									\
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

