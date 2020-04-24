Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A3AC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5623120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGqU76OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgDXPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:47:41 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD9C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:47:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id p31so11473432qte.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=grccW3g/q/18tgku44K89kuFTrJMvGmwGZNHR1ZbIyw=;
        b=WGqU76OYUqlKFL6FK6YSWyheHaWO+ApKchnRKd6FWif3TsB7Agc3qGdwWucWZwS9Uv
         VHEcBukxl+6E08o8K4dsPTas2B/5TjYyS4JUL5YRRYnPt/R1Fl/kndoMFLkdVQgx7nCB
         HcHnB9GQ++ODt5gC+MxdLh5DdaWlHfhcmNv2AhoVo1FY7dNc7NHKzKEBEEA6csLgWuCU
         +PjabbT3382pqVJOFaWpP7cak+xd7gloIni/diYLtVqsmyvClvaL/aUvzPJ1LEIEClFw
         4o6mdktIk5lGL07YiKQiQoFzZUL9JYTEgfGOt8xyExARiYQmJ7N2rCMudSf76pujuxAE
         jJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=grccW3g/q/18tgku44K89kuFTrJMvGmwGZNHR1ZbIyw=;
        b=hl1mO9UNVVd6feF5lQABjzb6w0k2fPqU8NNAyjqSeuG6WDYHZfXsVmNDD3bXo93yDK
         Awh9P49mJ81J1ImMgeKA3V93walhhELLYVEldbJ071uJpDDUcqpxiXmadWDwtmoMl4iu
         qTt5CoOG+tbZanSPcLFo672dMssENj0TdTM1y7oz8EBPJptgYCVpO4Sl5CiUMwQBrRMn
         B316vXYMfa3ruAwqSt7ZYZhBqf0dPwheGuPvj7e0bXNvQY+10SQQ8sFdyZgBheCuxt4K
         VAz4GEENhEBnnsm9SCwppvuIB28TB2Uk7yiq5tXqqcOcVCsQx0/+6b0GrC51VN6X8SuF
         IATg==
X-Gm-Message-State: AGi0PuZeJ9deNQKFx7/xIWf+wxWb2AMQaVfzW9rMcSHRsrZDXKPrHFGj
        1I+lyEgo5OUjg7MDpcFjyV4zybGbsQ==
X-Google-Smtp-Source: APiQypKE5P/DsYHiEa5v2f8uA0bvj6/C7GzyBGD0UsrunWoiC8H9/wr2Xo+D6+cRX4Mqq9SossAhb+oMLw==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr9294100qke.175.1587743259356;
 Fri, 24 Apr 2020 08:47:39 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:47:29 +0200
Message-Id: <20200424154730.190041-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/2] kcsan: Add __kcsan_{enable,disable}_current() variants
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, will@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __kcsan_{enable,disable}_current() variants only call into KCSAN if
KCSAN is enabled for the current compilation unit. Note: This is
typically not what we want, as we usually want to ensure that even calls
into other functions still have KCSAN disabled.

These variants may safely be used in header files that are shared
between regular kernel code and code that does not link the KCSAN
runtime.

Signed-off-by: Marco Elver <elver@google.com>
---
This is to help with the new READ_ONCE()/WRITE_ONCE():
https://lkml.kernel.org/r/20200424134238.GE21141@willie-the-truck

These should be using __kcsan_disable_current() and
__kcsan_enable_current(), instead of the non-'__' variants.
---
 include/linux/kcsan-checks.h | 17 ++++++++++++++---
 kernel/kcsan/core.c          |  7 +++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index ef95ddc49182..7b0b9c44f5f3 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -49,6 +49,7 @@ void kcsan_disable_current(void);
  * Supports nesting.
  */
 void kcsan_enable_current(void);
+void kcsan_enable_current_nowarn(void); /* Safe in uaccess regions. */
 
 /**
  * kcsan_nestable_atomic_begin - begin nestable atomic region
@@ -149,6 +150,7 @@ static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
+static inline void kcsan_enable_current_nowarn(void)	{ }
 static inline void kcsan_nestable_atomic_begin(void)	{ }
 static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
@@ -165,15 +167,24 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
 
 #endif /* CONFIG_KCSAN */
 
+#ifdef __SANITIZE_THREAD__
 /*
- * kcsan_*: Only calls into the runtime when the particular compilation unit has
- * KCSAN instrumentation enabled. May be used in header files.
+ * Only calls into the runtime when the particular compilation unit has KCSAN
+ * instrumentation enabled. May be used in header files.
  */
-#ifdef __SANITIZE_THREAD__
 #define kcsan_check_access __kcsan_check_access
+
+/*
+ * Only use these to disable KCSAN for accesses in the current compilation unit;
+ * calls into libraries may still perform KCSAN checks.
+ */
+#define __kcsan_disable_current kcsan_disable_current
+#define __kcsan_enable_current kcsan_enable_current_nowarn
 #else
 static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 				      int type) { }
+static inline void __kcsan_enable_current(void)  { }
+static inline void __kcsan_disable_current(void) { }
 #endif
 
 /**
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 40919943617b..0a0f018cb154 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -625,6 +625,13 @@ void kcsan_enable_current(void)
 }
 EXPORT_SYMBOL(kcsan_enable_current);
 
+void kcsan_enable_current_nowarn(void)
+{
+	if (get_ctx()->disable_count-- == 0)
+		kcsan_disable_current();
+}
+EXPORT_SYMBOL(kcsan_enable_current_nowarn);
+
 void kcsan_nestable_atomic_begin(void)
 {
 	/*
-- 
2.26.2.303.gf8c07b1a785-goog

