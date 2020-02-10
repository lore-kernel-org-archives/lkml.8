Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3226C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40B420715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5bI+iOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBJSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:43:32 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:35615 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:43:31 -0500
Received: by mail-wr1-f73.google.com with SMTP id 50so5494875wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QdVP7VsBJw+IixbDmWdM2Gp9NWKsZNR2FStw5cLegFk=;
        b=H5bI+iOBhkjHISdrxSGgdjQRdd7F+P/dxQ+5IGzxVJUok034EzrZnMegEYlIdtkoGn
         Tul56OPNJGaC4SqHNIta9FtzYTH9xaVamX+DWDR9Fye6fnkIiRykVBkc2Lj2MNS82qNH
         +wn/xWSoW9LlopgOhe9iRxeFRuFGQte9+Vzk3Fr/nRXXvvdCBclfpKvLDrnrSxEzBWat
         kl173BTi2ZcIqpTSjRh29W4ICWh0XYuokUeKY6ns4X1AZtpPwZPYRCNJhWhaLazkOuuR
         mlSq4FG+AvBL/LQTjkWi9qe0Z4RrZ61LCBBwblp93rIxJ/xZ5aD4kahKeIdvlNI3pKKY
         6LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QdVP7VsBJw+IixbDmWdM2Gp9NWKsZNR2FStw5cLegFk=;
        b=lBMwlNc2e4mAIuriKDqgjBMjZoYq4W66R63/b7W8q9kEqsAs9y2ly0O/Z+qlovHFfy
         k4MIrVZMrG2nSlzrcLuNQVy71oUvbPPPV5NK3HYt+L32Q2L8b0+9/0QN5g2Xv6fT48HM
         /TixdJieZB6mKOxxSG1ffWi9h3R/1FB581F460m0uEA2dgEtfEp5cxLaqNmiGQBNOQbn
         Dj2fj4rF6oQxhrvWc9kbUbbUvIp19uqpNbBA7isE10kTq0b+f7Fi/lFLBAopBjr0ZQLe
         7No9A/VmWblyARSBiRxUkd8N/9x1lhDqijjwTyZCMXqHmo3ZiqP+EmBP8/BoX/U9GNEG
         zSew==
X-Gm-Message-State: APjAAAVugHIcOI5nHT4kyPBOYBI9oIFih5uRm3UP6i3x1TgYMzhBT54Q
        SwUfJ5C0HYA4QRo65C2ur+I5Is6N4A==
X-Google-Smtp-Source: APXvYqyoQzdcZ2HBNrykFbP5tvsJ6g3cgcrMgM5dFnwuQmVVcBWl1+sUY9+HhbS6XdGt/bWYZqLKWx80Fw==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr3520748wrm.271.1581360209995;
 Mon, 10 Feb 2020 10:43:29 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:43:13 +0100
Message-Id: <20200210184317.233039-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 1/5] kcsan: Move interfaces that affects checks to kcsan-checks.h
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
2.25.0.341.g760bfbb309-goog

