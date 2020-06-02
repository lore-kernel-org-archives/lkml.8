Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D74C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE3D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ih+cI902"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBSoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:44:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C612C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:44:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c17so12676114ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+FgmqyrmNJ7X96y+2DvYBXfBfS1ICd8c/t7BA8+xtfg=;
        b=Ih+cI902kz5t7uJJLppal8ZALLognsWXdA/nGcB832ZjevEAps41Xf85EJ4lQNNRLx
         aSGv2kdW1RsgrQjdkPU3eduEGsRlR5zkHjhZlZDfJUyQLWxNkK9Eh/vW8KjGC1aVZJDo
         ql9STNz0KE/H8twNAY5tBzkzuDJBn+D5j2iqgXqabsHArIU7VY9DzabDO1c7SbWUVl9y
         hmy55hmuk+lZ28VQD3nqH257Y/KSiztMn44marRqh2WRS7RIaCmI5+xITgMFowGWoLVW
         da3BLSGuBNRQpJDFeNibBC39Ahsk9w8BpzDT3KXdVQFsHLrBoTkNohyKQXwcFZSrxMbr
         vlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+FgmqyrmNJ7X96y+2DvYBXfBfS1ICd8c/t7BA8+xtfg=;
        b=nkMbKtQOgzPSxAcX52BHEtydtuRHcBuTPruPPDW146iqnmy89D6lM4M1VqIwgyVoRk
         Lt1BhQjYUtI5/EMDh+FNvjVevQPofxtF+YqvfniLo4zt7ZxBc3ygtPJebrxLS/VbcpR4
         7KZxgLEYzRz9dtNy+bYoDI7dKgQvzyoqxyqnmoJvmqrBBp8eTeRfwm0piBnwzWba931C
         2InUYF2KAnsEGmP90/W9nLGrYiNR8E1s6MeAdfBuQDl/hh0lzeztPOQcIfNOjxp7vad4
         A+J9RbvMSfUzFnj1Qngq+BnE697wnHJ5PYldpLjDAv9WTRxz06yYPducwvgRGRiTt0uR
         r0zA==
X-Gm-Message-State: AOAM533dWSclgiZl0nmYOyyCcJPihQcOtr3+kwBwH/MvBXxW84QSyF0v
        K1rn/uAQcQl2o3fKi2lvD+UJd/ARNw==
X-Google-Smtp-Source: ABdhPJxTGJ1XQLHd2+EEvNjyAaPtRMcsUsLoO9yo/L63wiRqdrs27dDPUe+5EmyUWohMnOSuciizckbctQ==
X-Received: by 2002:a25:bdc8:: with SMTP id g8mr42893731ybk.122.1591123455849;
 Tue, 02 Jun 2020 11:44:15 -0700 (PDT)
Date:   Tue,  2 Jun 2020 20:44:09 +0200
In-Reply-To: <20200602184409.22142-1-elver@google.com>
Message-Id: <20200602184409.22142-2-elver@google.com>
Mime-Version: 1.0
References: <20200602184409.22142-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH -tip 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the portable definitions for __no_sanitize_address, and
__no_sanitize_undefined, and subsequently changes noinstr to use the
attributes to disable instrumentation via KASAN or UBSAN.

Link: https://lore.kernel.org/lkml/000000000000d2474c05a6c938fe@google.com/
Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---

Note: __no_sanitize_coverage (for KCOV) isn't possible right now,
because neither GCC nor Clang support such an attribute. This means
going and changing the compilers again (for Clang it's fine, for GCC,
it'll take a while).

However, it looks like that KCOV_INSTRUMENT := n is currently in all the
right places. Short-term, this should be reasonable.
---
 include/linux/compiler-clang.h | 8 ++++++++
 include/linux/compiler-gcc.h   | 6 ++++++
 include/linux/compiler_types.h | 3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 2cb42d8bdedc..c0e4b193b311 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -33,6 +33,14 @@
 #define __no_sanitize_thread
 #endif
 
+#if __has_feature(undefined_behavior_sanitizer)
+/* GCC does not have __SANITIZE_UNDEFINED__ */
+#define __no_sanitize_undefined \
+		__attribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7dd4e0349ef3..1c74464c80c6 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -150,6 +150,12 @@
 #define __no_sanitize_thread
 #endif
 
+#if __has_attribute(__no_sanitize_undefined__)
+#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#else
+#define __no_sanitize_undefined
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 02becd21d456..89b8c1ae18a1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -198,7 +198,8 @@ struct ftrace_likely_data {
 
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
+	noinline notrace __attribute((__section__(".noinstr.text")))	\
+	__no_kcsan __no_sanitize_address __no_sanitize_undefined
 
 #endif /* __KERNEL__ */
 
-- 
2.27.0.rc2.251.g90737beb825-goog

