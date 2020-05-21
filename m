Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA93207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY/uD0ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgEULKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgEULJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:09:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA10C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so4857925ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E0UepZUl50HW0uHDfJhRs9oZIgYHrAECVMB9g20DGiQ=;
        b=oY/uD0lypzzY7RbHryAv7AQdD01jnrfv9h6MiH9bK4YOkm0hW3lIgen04LKNdDC72x
         w7LJtgm8qT6UVw+SLVLkOuF0uyIZif16xVJpCyDCaIaObTJXq2K9UI2wr5zZgFjRkLRq
         k2oIhn/yqo2/4rrLHtcctItkVZVnNB8ZaAl1k2ep3pQydvkgv7tUJW+QNSJsAaYI1UpX
         RQy9F63SQwVrR5NpnRLaW6Dlxvxo+yyBrHOqdYm4sh/qg386CBdA4ivmRa1CN+L4YJCo
         H19L9w/WkrH1tZ1nw2hfX9aFdckc32XIzZRL5gcsno8L//4drV8V5p7Tc+q78ShV1g7M
         Dfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E0UepZUl50HW0uHDfJhRs9oZIgYHrAECVMB9g20DGiQ=;
        b=UrBOj6AaOrE7d5jK3eSiKc3bvowJ0fwUptwt0DoZdDo9rXSebjxnHpB49CuTt/sYha
         JN30mMMmyd9IsiPoco/jPh5hlvqEzl+tXGnGS71Vi/HwJdVRwIpgVl9w3kbxOSfFS+fQ
         qZhwD4RtRZ8crzNbB2SOgDqxMOIaacW4Wb+LBzEEhQzHLFCJm8GtluEfKnrxKAZCjFe/
         sQ3+ErAWqSM1MQAz2iNwsvcgqTkA4xKVQQCQMZ1kDQBM8kBX8hN9VjP9f948zZhI1kbn
         qNX2mg7JhkhLymq4A+4aqgcAgwVmg1UoV+JPzzXhndDLtO6pLD3IEyakU0LkRepbE7qh
         SlfQ==
X-Gm-Message-State: AOAM530R26EM94A8SEJUCW2WWMZyaYxs0gCIqwVQKpN4mZGg/oSzfPpT
        lYyciVQ7tF8ApQOeauFLQQye/OIAUA==
X-Google-Smtp-Source: ABdhPJz6luzhv8RtemG02q/50WcPIBaJ1dHDCBbqgqWhKrmRiYdj/f9zBMjzPI0axa78KQpXYK8ioWqULA==
X-Received: by 2002:a25:41c3:: with SMTP id o186mr14043993yba.48.1590059397203;
 Thu, 21 May 2020 04:09:57 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:46 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-4-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 03/11] kcsan: Support distinguishing volatile accesses
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

In the kernel, volatile is used in various concurrent context, whether
in low-level synchronization primitives or for legacy reasons. If
supported by the compiler, we will assume that aligned volatile accesses
up to sizeof(long long) (matching compiletime_assert_rwonce_type()) are
atomic.

Recent versions Clang [1] (GCC tentative [2]) can instrument volatile
accesses differently. Add the option (required) to enable the
instrumentation, and provide the necessary runtime functions. None of
the updated compilers are widely available yet (Clang 11 will be the
first release to support the feature).

[1] https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be361137efd705e05814
[2] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html

This patch allows removing any explicit checks in primitives such as
READ_ONCE() and WRITE_ONCE().

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Reword Makefile comment.
---
 kernel/kcsan/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.kcsan |  5 ++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index a73a66cf79df..15f67949d11e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -789,6 +789,49 @@ void __tsan_write_range(void *ptr, size_t size)
 }
 EXPORT_SYMBOL(__tsan_write_range);
 
+/*
+ * Use of explicit volatile is generally disallowed [1], however, volatile is
+ * still used in various concurrent context, whether in low-level
+ * synchronization primitives or for legacy reasons.
+ * [1] https://lwn.net/Articles/233479/
+ *
+ * We only consider volatile accesses atomic if they are aligned and would pass
+ * the size-check of compiletime_assert_rwonce_type().
+ */
+#define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
+	void __tsan_volatile_read##size(void *ptr)                             \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
+	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
+		__alias(__tsan_volatile_read##size);                           \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
+	void __tsan_volatile_write##size(void *ptr)                            \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size,                                        \
+			     KCSAN_ACCESS_WRITE |                              \
+				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
+	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
+		__alias(__tsan_volatile_write##size);                          \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
+
+DEFINE_TSAN_VOLATILE_READ_WRITE(1);
+DEFINE_TSAN_VOLATILE_READ_WRITE(2);
+DEFINE_TSAN_VOLATILE_READ_WRITE(4);
+DEFINE_TSAN_VOLATILE_READ_WRITE(8);
+DEFINE_TSAN_VOLATILE_READ_WRITE(16);
+
 /*
  * The below are not required by KCSAN, but can still be emitted by the
  * compiler.
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 20337a7ecf54..75d2942b9437 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -9,7 +9,10 @@ else
 cc-param = --param -$(1)
 endif
 
+# Keep most options here optional, to allow enabling more compilers if absence
+# of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
-	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls)
+	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

