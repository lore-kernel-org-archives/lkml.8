Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0022C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6823207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBA9I9Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgEOPEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgEOPEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:04:09 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD70C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 65so2838777qva.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B+kcPzRw4VpBcmlaWaCawRXGVLL4Q9ilUa578zhnNe4=;
        b=MBA9I9Ds9sphzYE8O9qX+xEotZ3z2JLG9hSnM9Ck8y/jo3U1qvWKrCFsfyJakOFlcI
         G8bF+Q2ujxXznoqqQG0jnINq1Ua0OSBOEFbqR5BeLACrRDIL/f3LwfWTDhRLk36EvFpw
         3VTgfYdjYmfx2kltdHtUxILzFn5ow4bLWYiQRJJ4H1kkfXwD9EKPH79PVkrWDGQIPUGW
         j7IYRYBmidGrD5WK67mwK8WRYWYw1M9iPgeWbHfsQTffmxhfOyhN4yn3Oxj4Ddqtfeu7
         JrKyfmjXDH3MvLb3CbWu+MBfoZrtdUVmS3xQVfUmPF7bP+whVFdChbSi30e0+qLOPWk7
         qu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B+kcPzRw4VpBcmlaWaCawRXGVLL4Q9ilUa578zhnNe4=;
        b=cKA/lcfPcmeFYPkNCf9+359Ph2L4sWPnFbehRpLb5B7/yX9NtDMT6wsagt0dJqtiyF
         9uvUWUJ2gOUQEz+mFS/I4VUITB9ziff7oLfYcrkI+Pj5XnAtkvB7v61Ds5wHtqCw+8Kh
         jJoPgZlXxAFW2/s1FfpuZYPbChpMRFmxGeTOhsXyd67CboVKLyUwDjxYqE3d1YpTG3se
         FdVCWDG2AbVXoPqi4OFk2j3lbWU9Ic67IpUw8QWs3W0Zz3mbD/5qlnRyKk6ooDf6K/n9
         6Jxa4WGHAyle7S59CnLW/FQX++SeYqJNANG9x1Px8FRWmKxadt5876gA8ygFnEggnzTx
         ldCA==
X-Gm-Message-State: AOAM530vWgfe4+fgJMSC1N1KHf2CT8nGBhszj7rylKuzyyNBGQt6fR1d
        oqlFYX7ICVHGO75cuOAIHXSnlhmw0w==
X-Google-Smtp-Source: ABdhPJwF8qkWMSzla5rBX1lIIVgJAA6R72kSA8uwKkZvNTTBIrVD8kUQDFMHmV6vDg8uqiPTbHzp4M0l2Q==
X-Received: by 2002:a05:6214:164:: with SMTP id y4mr3698355qvs.249.1589555047207;
 Fri, 15 May 2020 08:04:07 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:37 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-10-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 09/10] compiler.h: Move function attributes to compiler_types.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
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
index fce56402c082..a7b01e750dd3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -259,35 +259,6 @@ do {									\
 	__WRITE_ONCE_SCALAR(x, val);					\
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

