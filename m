Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F04D20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niJrPhDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgCaTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:33:39 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:54091 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:33:38 -0400
Received: by mail-wr1-f73.google.com with SMTP id c8so11518593wru.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qbfJ5ZHXD/KzKrN959jG51gO6gDSc8KmiwmuYQdIsZ8=;
        b=niJrPhDLmNi0q0B92w+BxyASfUD0qeO09c9A36PsjsnSqDX/a6SpIwAHNH+8rodJiy
         mqVmSgArBe2hZN/fUYYmO8jeNuTnq6RLtywMI4k4T6Lvdv5I2XiK9hIS+D2nJJ/jdIg7
         9KxtqmrnFAmBosdLzxYn2viKzwlnXx/8yOInGy0usf6ovKVh6/yKlQwlaIm3fY6QUwyz
         23hGtX1z41K4/BmAlMaXbfnO9czNgfrpflvM6PaL9AQq4LdrZEp93cSM3k0B/pMDyRe+
         AYMZkrBUZXey+/zgDvMX6yrvrpdNUcy4aH9T63kMBzGjYufapyfhvFza35ygCJq1sJ8V
         uATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qbfJ5ZHXD/KzKrN959jG51gO6gDSc8KmiwmuYQdIsZ8=;
        b=GHtnhZBavq/p7MlR5kyeo6r202za0RpkazGHa0tVxHMABJWgHOabqLZt8bY/C+4Pbz
         ob0pWEMQNRMcRYpejt5gXNtCSRkRZBRVUhqNRYpOihp4FdOO2sGOATLRI5l9Q1YNDuXS
         up45jmaGmyPJG4Wn1+x8DDrlpOKbdx90YTZFc9gluy6Aa6Omk3PLqVAez+yBmHnbbvOF
         3yjkFWePGPbK/TZgyvrMAPENwj9kJEs/JZ02WorT8Ue8++aOPUwyv+XcTYMOtyvT7+Le
         etP3/TqUPvNyB8hKrMWtfYwcadBJND0itRHBE8AwKKtM3cMTBX6znFVwAsJ2oHcnpYLV
         sHrg==
X-Gm-Message-State: ANhLgQ2U/Z3W/4EVlVyZuZJw1ompdMzTMVv9pbGE3xBVBZXR2EK6FAdI
        nbSh478a9leVos2gIqGHH4x5JjKfHg==
X-Google-Smtp-Source: ADFU+vshvjFpdPlGKM9ctQkQ2baq9irpXuBM/VHki3fkxx2uhPxbrDk9a4dTdwFp0pVTUmRpuZWB6X+jwg==
X-Received: by 2002:adf:f401:: with SMTP id g1mr21276581wro.140.1585683215086;
 Tue, 31 Mar 2020 12:33:35 -0700 (PDT)
Date:   Tue, 31 Mar 2020 21:32:32 +0200
Message-Id: <20200331193233.15180-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 1/2] kcsan: Move kcsan_{disable,enable}_current() to kcsan-checks.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both affect access checks, and should therefore be in kcsan-checks.h.
This is in preparation to use these in compiler.h.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 16 ++++++++++++++++
 include/linux/kcsan.h        | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 101df7f46d89..ef95ddc49182 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -36,6 +36,20 @@
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
+/**
+ * kcsan_disable_current - disable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_disable_current(void);
+
+/**
+ * kcsan_enable_current - re-enable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_enable_current(void);
+
 /**
  * kcsan_nestable_atomic_begin - begin nestable atomic region
  *
@@ -133,6 +147,8 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
 
+static inline void kcsan_disable_current(void)		{ }
+static inline void kcsan_enable_current(void)		{ }
 static inline void kcsan_nestable_atomic_begin(void)	{ }
 static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 17ae59e4b685..53340d8789f9 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -50,25 +50,9 @@ struct kcsan_ctx {
  */
 void kcsan_init(void);
 
-/**
- * kcsan_disable_current - disable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_disable_current(void);
-
-/**
- * kcsan_enable_current - re-enable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_enable_current(void);
-
 #else /* CONFIG_KCSAN */
 
 static inline void kcsan_init(void)			{ }
-static inline void kcsan_disable_current(void)		{ }
-static inline void kcsan_enable_current(void)		{ }
 
 #endif /* CONFIG_KCSAN */
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

