Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D87C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E102086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wi8bgarS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgBKQFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:05:52 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:36543 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgBKQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:05:52 -0500
Received: by mail-wr1-f74.google.com with SMTP id t6so7160884wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fPyPj6YXKlNnOn1twoWGjqPJDWM/gm79Q9ZakEnsr3Y=;
        b=Wi8bgarSTrgQE0LHOAgjWN5y+UOmdZAXDCDDqS4Xl//tm/ab2PRuBL+m+ZV4fEuGCT
         LBN+1P+92h5nmEcvgxOxoo0J3risVqx7nriYaWeZrizVUMlibdBHxh2SLWpPcjgA9EFC
         e9AHZRbAygFp3t26xwIPhIV7tPHVIao0eYYBgRG2+5j1UYd+bwZLI0WmgX8vgQuEJd9p
         TLHUNgZ2CtFhMl6JVfeSrIsTZZNJDwVp/UQLzhwFtMxhkg4/f+Kt4I7dqIAPCcs3ivVd
         MxoRdEHczXPfymaT7lQVrgHnryh1BButaQ/AnXMhpC32R9JafHwqwtfqY+IqmK9ALjEy
         7+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fPyPj6YXKlNnOn1twoWGjqPJDWM/gm79Q9ZakEnsr3Y=;
        b=K34xUf9EOocc+2EbPJtLaznotXt33uJseolmYLIrWGNR9tMcsuc3AZO9hoIQSycLc8
         qplVxNE/SsMiAPAIpQqgyfgLXWwctSuI8dVjwVpWdgqvdGLKrH2P2G4nYJz/BhxtFShH
         M9bUUQPUcqKi9bg1NbzxLkK2eZsLMTdBq3h6NpeJpU9ReNrnWSHagQtKFO3NspZzc2Kc
         Bs0ObyP+bM+7iNjhOLsb2BQhKheC/UukMiPE19IFsC4S/jOSn4GJyLEg1FVwTLDWI86L
         fUYT6IznyLE7y3JttT5e58OCJTVGYM2z7bmF+8+DPqvR0Ayicqqf45Dbgf1xLxA2S1hm
         wqrw==
X-Gm-Message-State: APjAAAViANeAewnNp69n13AZF+UGTtN9lCvq5VdTqWiQPhhhkmuA170H
        QOSIt5eCpt8ZRoLKbnb1GslT4cLUcw==
X-Google-Smtp-Source: APXvYqyT2BXQcpEnVTgCOo0D6aB+ikDiUifc71EECv9RsfSJjuuSjwfsCQlvQO+G2Qpm+M6x1B9QQmLXZg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr8979251wrs.309.1581437149565;
 Tue, 11 Feb 2020 08:05:49 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:04:19 +0100
Message-Id: <20200211160423.138870-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 1/5] kcsan: Move interfaces that affects checks to kcsan-checks.h
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

This moves functions that affect state changing the behaviour of
kcsan_check_access() to kcsan-checks.h. Since these are likely used with
kcsan_check_access() it makes more sense to have them in kcsan-checks.h,
to avoid including all of 'include/linux/kcsan.h'.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 48 ++++++++++++++++++++++++++++++++++--
 include/linux/kcsan.h        | 41 ------------------------------
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf6961794e9a1..8675411c8dbcd 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -32,10 +32,54 @@
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
-#else
+/**
+ * kcsan_nestable_atomic_begin - begin nestable atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_nestable_atomic_begin(void);
+
+/**
+ * kcsan_nestable_atomic_end - end nestable atomic region
+ */
+void kcsan_nestable_atomic_end(void);
+
+/**
+ * kcsan_flat_atomic_begin - begin flat atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_flat_atomic_begin(void);
+
+/**
+ * kcsan_flat_atomic_end - end flat atomic region
+ */
+void kcsan_flat_atomic_end(void);
+
+/**
+ * kcsan_atomic_next - consider following accesses as atomic
+ *
+ * Force treating the next n memory accesses for the current context as atomic
+ * operations.
+ *
+ * @n number of following memory accesses to treat as atomic.
+ */
+void kcsan_atomic_next(int n);
+
+#else /* CONFIG_KCSAN */
+
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
-#endif
+
+static inline void kcsan_nestable_atomic_begin(void)	{ }
+static inline void kcsan_nestable_atomic_end(void)	{ }
+static inline void kcsan_flat_atomic_begin(void)	{ }
+static inline void kcsan_flat_atomic_end(void)		{ }
+static inline void kcsan_atomic_next(int n)		{ }
+
+#endif /* CONFIG_KCSAN */
 
 /*
  * kcsan_*: Only calls into the runtime when the particular compilation unit has
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 1019e3a2c6897..7a614ca558f65 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -56,52 +56,11 @@ void kcsan_disable_current(void);
  */
 void kcsan_enable_current(void);
 
-/**
- * kcsan_nestable_atomic_begin - begin nestable atomic region
- *
- * Accesses within the atomic region may appear to race with other accesses but
- * should be considered atomic.
- */
-void kcsan_nestable_atomic_begin(void);
-
-/**
- * kcsan_nestable_atomic_end - end nestable atomic region
- */
-void kcsan_nestable_atomic_end(void);
-
-/**
- * kcsan_flat_atomic_begin - begin flat atomic region
- *
- * Accesses within the atomic region may appear to race with other accesses but
- * should be considered atomic.
- */
-void kcsan_flat_atomic_begin(void);
-
-/**
- * kcsan_flat_atomic_end - end flat atomic region
- */
-void kcsan_flat_atomic_end(void);
-
-/**
- * kcsan_atomic_next - consider following accesses as atomic
- *
- * Force treating the next n memory accesses for the current context as atomic
- * operations.
- *
- * @n number of following memory accesses to treat as atomic.
- */
-void kcsan_atomic_next(int n);
-
 #else /* CONFIG_KCSAN */
 
 static inline void kcsan_init(void)			{ }
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
-static inline void kcsan_nestable_atomic_begin(void)	{ }
-static inline void kcsan_nestable_atomic_end(void)	{ }
-static inline void kcsan_flat_atomic_begin(void)	{ }
-static inline void kcsan_flat_atomic_end(void)		{ }
-static inline void kcsan_atomic_next(int n)		{ }
 
 #endif /* CONFIG_KCSAN */
 
-- 
2.25.0.225.g125e21ebc7-goog

