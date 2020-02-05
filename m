Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED292072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqOTXcZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBEUoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:44:22 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:43609 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgBEUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:44:22 -0500
Received: by mail-wr1-f73.google.com with SMTP id u8so2080951wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sqwbag/mHy/vE3+gzAzb/2Oiv0jGf8Mn6Bv8Q3gyQkw=;
        b=IqOTXcZRoF8SEhZUjNCSG+GqZwsIC3sBUUxBHgycS65QviiCIVFm5nA+3zz+fH2rOi
         ncmn3PHofpj4aV10ugF8h1UOD6tE5OM3hbnvaAS7h3MMJiymM14RYwhAnCCkZXoWeZNV
         ZKf5yb9zwrajfIFwL0b76PHaKsxCqmnuWl3P6ubRoUtdby91xM/0LXAkeiuCCBQ7iH4w
         8NpBI+laYP8gQ8sjoBvWpkEf0K8RyU/1h7kb4idrVVsoGlEOsracKLa+nOz+J0PsSzcd
         SiBOGPrQpexvbbq6kjb+GaUx2MJEhYFv/MegGCxXfOoBGShEHwU+/HKV8OY9JM4ESfRt
         H0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sqwbag/mHy/vE3+gzAzb/2Oiv0jGf8Mn6Bv8Q3gyQkw=;
        b=B2aey4ZDFSpD5qD1AmD/wWYSLYpqu6KOoiUp3uY9xCX9dxkmoZJrFQZYeGVYv8ZQho
         j/m4lauVSKyW7oyLDmtg3Od5s533kF7sTGgw3ynlR1kH6ybgJzAQefqc0s9UfibY3TtK
         Bhro/BeeGs9L93H611t2c85biMJHRVD9eP7FwsA//4oQS/0Vm1E0eSj0FQMfbuwmPmQX
         0nIOy0gkat3UpqN5mY1tp3qJ0EEMoT0CYi+PuLRbrYPFIaGsDSPtcahrwKZrNIDcZ3S2
         uPiwz1K+ylFd9t/6fzsVYUKQrDtwus+9uXXtJUlVGF8oH7VyF4CM0/FRYqTqCpsc1kLV
         UmEg==
X-Gm-Message-State: APjAAAWQJs5xC7zrkrs1bxUBdvBsdHQpHoPtI7PKEutnno+9Xt1QVcaO
        jaI7xgynxFd1WEN4vZSV+ZFEbO61lw==
X-Google-Smtp-Source: APXvYqwKzWuL5SA1nUkq74i0CXGJsZNQRrAsvDnm8+zpHgURL+fekhQGL9I4JbrH0xsolumcHK1Lu3YT3g==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr418289wrw.276.1580935458188;
 Wed, 05 Feb 2020 12:44:18 -0800 (PST)
Date:   Wed,  5 Feb 2020 21:43:32 +0100
In-Reply-To: <20200205204333.30953-1-elver@google.com>
Message-Id: <20200205204333.30953-2-elver@google.com>
Mime-Version: 1.0
References: <20200205204333.30953-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 2/3] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
may be used to assert properties of synchronization logic, where
violation cannot be detected as a normal data race.

Examples of the reports that may be generated:

    ==================================================================
    BUG: KCSAN: data-race in test_thread / test_thread

    write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
     test_thread+0x8d/0x111
     debugfs_write.cold+0x32/0x44
     ...

    assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
     test_thread+0xa3/0x111
     debugfs_write.cold+0x32/0x44
     ...
    ==================================================================

    ==================================================================
    BUG: KCSAN: data-race in test_thread / test_thread

    assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
     test_thread+0xb9/0x111
     debugfs_write.cold+0x32/0x44
     ...

    read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
     test_thread+0x77/0x111
     debugfs_write.cold+0x32/0x44
     ...
    ==================================================================

Signed-off-by: Marco Elver <elver@google.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
---

Please let me know if the names make sense, given they do not include a
KCSAN_ prefix.

The names are unique across the kernel. I wouldn't expect another macro
with the same name but different semantics to pop up any time soon. If
there is a dual use to these macros (e.g. another tool that could hook
into it), we could also move it elsewhere (include/linux/compiler.h?).

We can also revisit the original suggestion of WRITE_ONCE_EXCLUSIVE(),
if it is something that'd be used very widely. It'd be straightforward
to add with the help of these macros, but would need to be added to
include/linux/compiler.h.
---
 include/linux/kcsan-checks.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 21b1d1f214ad5..1a7b51e516335 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -96,4 +96,38 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
 #endif
 
+/**
+ * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
+ *
+ * Assert that there are no other threads writing @var; other readers are
+ * allowed. This assertion can be used to specify properties of synchronization
+ * logic, where violation cannot be detected as a normal data race.
+ *
+ * For example, if a per-CPU variable is only meant to be written by a single
+ * CPU, but may be read from other CPUs; in this case, reads and writes must be
+ * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
+ * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
+ * race condition. Using this macro allows specifying this property in the code
+ * and catch such bugs.
+ *
+ * @var variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
+
+/**
+ * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
+ *
+ * Assert that no other thread is accessing @var (no readers nor writers). This
+ * assertion can be used to specify properties of synchronization logic, where
+ * violation cannot be detected as a normal data race.
+ *
+ * For example, if a variable is not read nor written by the current thread, nor
+ * should it be touched by any other threads during the current execution phase.
+ *
+ * @var variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
+
 #endif /* _LINUX_KCSAN_CHECKS_H */
-- 
2.25.0.341.g760bfbb309-goog

