Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E84D2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmyoV4Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgEVOza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbgEVOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:55:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03BC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so1844910wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkTz4sTk7s012DbHMp3X0LwsnQSwOjg9lEMirTJ/PWk=;
        b=CmyoV4DakSUdEOfu7cjPJzdTIPnJ6TKlRfsXiilcn49CqPDcUOzFGX9DBib2tD3/pm
         QApEtLdvp6Fa4KNTp/oT0fEOwbQWtU5CZ3x2SCCeUD/WspsDejdt5xibpZ3dKW+8N9vd
         wpMgNvOZId9/GA5XVtZF4Lq5us4bbMV8sDPJ0/XlIQLKxCHSnelKR8n1Ie62Om5LxWUl
         EQYUU91KChW8wkfIxjdDK6WH+98E07MH6kLCa43YRIb/FcPg4qpXBzBKU46RZRSX/jmR
         1g6SynQVCCRNNQZhm8gmkXSfMar3NbaV1LuIrwazVbgceNf5GLdXyLQ2URJ4NKjQlMdB
         t4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkTz4sTk7s012DbHMp3X0LwsnQSwOjg9lEMirTJ/PWk=;
        b=AYHmIh0qK4ui/TFtklMBS+EfINQ1+XhJQ3E7Sj3pKv/prYNNylz140DlWxjFER/Csr
         MXBNDmo+n9m9wfzPd/2oUIKO0pBefSi72kYSWX9Pk8E2xp9Vwc9deAyHmo2Pnwfny9Ep
         X05QvarfH0MOf6XYdSbs4x4XoSRFIqLwJW3zX02xuRIE9/nzNz18zlkYUwEnFG61no0F
         FrIAo0kUrchpHSdS/iPSMpcwb3+xUTyb9w6j/GcNGU+qUMm5xPAxKrwdbDz/GS5IB9jG
         m8VcHJaDP+lpyS5Bm7eoVfb4ZfVyVFeucvsCyN/6CXFtL1PN04eBHveJTgOWwkSIseQr
         gIvQ==
X-Gm-Message-State: AOAM533xUwgNuuqquGhIGG+WVETn40r+B4+A+rneu6S6+v0+zNF6GWCG
        9V9iJPHJ5T1DQZEQ1rDOhMqtY6UzqdU=
X-Google-Smtp-Source: ABdhPJxQXqSFq49qzrvg5dJHfbQcmZrcW5ufJyiYOXZjrM7OJFBvSL22Ako9KERokDxGdIZxZR7/nA==
X-Received: by 2002:a1c:25c3:: with SMTP id l186mr13757890wml.103.1590159316931;
        Fri, 22 May 2020 07:55:16 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i21sm9746911wml.5.2020.05.22.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:16 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [RFC PATCH 2/2] locking/spinlock/debug: Add checks for kgdb trap safety
Date:   Fri, 22 May 2020 15:55:10 +0100
Message-Id: <20200522145510.2109799-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522145510.2109799-1-daniel.thompson@linaro.org>
References: <20200522145510.2109799-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general it is not safe to call spin_lock() whilst executing in the
kgdb trap handler. The trap can be entered from all sorts of execution
context (NMI, IRQ, irqs disabled, etc) and the kgdb/kdb needs to be
as resillient as possible.

Currently it is difficult to spot mistakes in the kgdb/kdb logic
(especially so for kdb because it uses more kernel features than
pure-kgdb). Let's provide a means to bring attention to deadlock
risks in the debug code.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h            | 16 ++++++++++++++++
 kernel/locking/spinlock_debug.c |  4 ++++
 lib/Kconfig.kgdb                | 11 +++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb1fd78..de30ce8078cf 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -332,4 +332,20 @@ extern void kgdb_panic(const char *msg);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 #endif /* ! CONFIG_KGDB */
+
+#ifdef CONFIG_KGDB_DEBUG_SPINLOCK
+/**
+ * check_kgdb_context_before() - Check whether to issue a spinlock warning
+ *
+ * Currently this only reports when the master processor violates the
+ * locking rules (because we are using the in_dbg_master() macro since
+ * we are confident that will avoid false positives).
+ *
+ * Return: True if we are executing in the debug trap
+ */
+static inline int check_kgdb_context_before(void) { return in_dbg_master(); }
+#else
+static inline int check_kgdb_context_before(void) { return 0; }
+#endif
+
 #endif /* _KGDB_H_ */
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index b9d93087ee66..b49789e0fed8 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -12,6 +12,7 @@
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/kgdb.h>
 
 void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 			  struct lock_class_key *key, short inner)
@@ -84,6 +85,7 @@ debug_spin_lock_before(raw_spinlock_t *lock)
 	SPIN_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
 	SPIN_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
+	SPIN_BUG_ON(check_kgdb_context_before(), lock, "in debug trap");
 }
 
 static inline void debug_spin_lock_after(raw_spinlock_t *lock)
@@ -174,6 +176,7 @@ int do_raw_read_trylock(rwlock_t *lock)
 void do_raw_read_unlock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	RWLOCK_BUG_ON(check_kgdb_context_before(), lock, "in debug trap");
 	arch_read_unlock(&lock->raw_lock);
 }
 
@@ -183,6 +186,7 @@ static inline void debug_write_lock_before(rwlock_t *lock)
 	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
 	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
 							lock, "cpu recursion");
+	RWLOCK_BUG_ON(check_kgdb_context_before(), lock, "in debug trap");
 }
 
 static inline void debug_write_lock_after(rwlock_t *lock)
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 933680b59e2d..4d57900d6c53 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -29,6 +29,17 @@ config KGDB_SERIAL_CONSOLE
 	  Share a serial console with kgdb. Sysrq-g must be used
 	  to break in initially.
 
+config KGDB_DEBUG_SPINLOCK
+	bool "KGDB: Check for spin lock usage when system is halted"
+	select DEBUG_SPINLOCK
+	default n
+	help
+	  Say Y here to catch spin lock waiting when we are running
+	  in the kgdb trap handler and report it. When the trap handler
+	  is executing all other system activity is halted and spin lock
+	  contention will lead to deadlock. This makes any spin lock wait
+	  from this execution context risky.
+
 config KGDB_TESTS
 	bool "KGDB: internal test suite"
 	default n
-- 
2.25.4

