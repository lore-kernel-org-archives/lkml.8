Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE2220782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QC8bEzwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGCNks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:40:47 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF73C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 06:40:46 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id i10so31552264wrn.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ls5EQRkUxBZzP7EqUh1IKI2XSD94zleYx8ufPET2dw8=;
        b=QC8bEzwgWYyccfeOKyfq0/UYYEp93ZxZUOAiCO8YzRcyfA7lAnkrsVlew9+moU4MUG
         DRDuXkCWla9vIaEJM3cvP237L651k/4hOV7IA9Jnh0mfEtb6gJmtwes/S2tn7UYkxeX6
         a5a4LiHhgo2yaFtlDPTvAV4ShhZ5OH/8MOZcHKSMjq3celIQHtn88022nkpy0uWnqtm9
         Wd8s5msxoBlY6XDBITplJoG520KVNOtyBJReU2/jx3IjWjpSPfXdyFjVuvMxp8zbiGVo
         xf5tFrp+Lm079l47jdaV/s4a5AqD7dGSXAY4Pc5qlLsnU0Z+Kx9mVqSCHzdKRUu1YU81
         Kogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ls5EQRkUxBZzP7EqUh1IKI2XSD94zleYx8ufPET2dw8=;
        b=NVV1BXdApatqJf+g/Sy5Zj2WqtTlZv9ZeaAS34MW7rTVuak22G2y8L/zqJL/ubmu2A
         aIMCKaAMKHhLwDDRNftY9CIzfjl8e46BXkxCYS97jc1tB1SpZXjAwL9VXy227qK1nA/w
         p+WsJntB32+I96ncH6yZZSLWXxZPQe1NBsn/hDTxAz+faFfP0UCsgwEAzE8a0IK3bGkv
         9nnzAaIwMRqtfSgcAFdjr3il0KSf+mEQncJbpQ5h0CraT+qiwFP3UMAUmqz9fWRIkgtk
         bPYj+ERczOtbgJPqGeAHlpwh3xAMOzBLSb/IzzMgUhWFunZvIreaAe2mZCROqAzJfrw3
         mOhg==
X-Gm-Message-State: AOAM533hD782IyrjvkXClDfqDbiWz+KMc8XnUqQAm3dSJdRacrLQhgvX
        wY7OiVMGjO7M2MZ7NCPERYeVdZm3eA==
X-Google-Smtp-Source: ABdhPJzQRn6zHi1Z9vLMAq4p2396wY3gPl6nh8x8/wacERQCIkGGGDaBzXhNJgylDDwcvlwNXQoHSrWWlA==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr38298704wmk.126.1593783645449;
 Fri, 03 Jul 2020 06:40:45 -0700 (PDT)
Date:   Fri,  3 Jul 2020 15:40:29 +0200
Message-Id: <20200703134031.3298135-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 1/3] kcsan: Add support for atomic builtins
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures (currently e.g. s390 partially) implement atomics
using the compiler's atomic builtins (__atomic_*, __sync_*). To support
enabling KCSAN on such architectures in future, or support experimental
use of these builtins, implement support for them.

We should also avoid breaking KCSAN kernels due to use (accidental or
otherwise) of atomic builtins in drivers, as has happened in the past:
https://lkml.kernel.org/r/5231d2c0-41d9-6721-e15f-a7eedf3ce69e@infradead.org

The instrumentation is subtly different from regular reads/writes: TSAN
instrumentation replaces the use of atomic builtins with a call into the
runtime, and the runtime's job is to also execute the desired atomic
operation. We rely on the __atomic_* compiler builtins, available with
all KCSAN-supported compilers, to implement each TSAN atomic
instrumentation function.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d803765603fb..6843169da759 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -856,3 +856,113 @@ void __tsan_init(void)
 {
 }
 EXPORT_SYMBOL(__tsan_init);
+
+/*
+ * Instrumentation for atomic builtins (__atomic_*, __sync_*).
+ *
+ * Normal kernel code _should not_ be using them directly, but some
+ * architectures may implement some or all atomics using the compilers'
+ * builtins.
+ *
+ * Note: If an architecture decides to fully implement atomics using the
+ * builtins, because they are implicitly instrumented by KCSAN (and KASAN,
+ * etc.), implementing the ARCH_ATOMIC interface (to get instrumentation via
+ * atomic-instrumented) is no longer necessary.
+ *
+ * TSAN instrumentation replaces atomic accesses with calls to any of the below
+ * functions, whose job is to also execute the operation itself.
+ */
+
+#define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
+	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
+	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		return __atomic_load_n(ptr, memorder);                                             \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
+	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
+	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		__atomic_store_n(ptr, v, memorder);                                                \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
+
+#define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
+	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
+	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		return __atomic_##op##suffix(ptr, v, memorder);                                    \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
+
+/*
+ * Note: CAS operations are always classified as write, even in case they
+ * fail. We cannot perform check_access() after a write, as it might lead to
+ * false positives, in cases such as:
+ *
+ *	T0: __atomic_compare_exchange_n(&p->flag, &old, 1, ...)
+ *
+ *	T1: if (__atomic_load_n(&p->flag, ...)) {
+ *		modify *p;
+ *		p->flag = 0;
+ *	    }
+ *
+ * The only downside is that, if there are 3 threads, with one CAS that
+ * succeeds, another CAS that fails, and an unmarked racing operation, we may
+ * point at the wrong CAS as the source of the race. However, if we assume that
+ * all CAS can succeed in some other execution, the data race is still valid.
+ */
+#define DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strength, weak)                                           \
+	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
+							      u##bits val, int mo, int fail_mo);   \
+	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
+							      u##bits val, int mo, int fail_mo)    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
+
+#define DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)                                                       \
+	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
+							   int mo, int fail_mo);                   \
+	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
+							   int mo, int fail_mo)                    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
+		return exp;                                                                        \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_val)
+
+#define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
+	DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
+	DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits, );                                                  \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits, );                                                \
+	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
+	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
+	DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
+
+DEFINE_TSAN_ATOMIC_OPS(8);
+DEFINE_TSAN_ATOMIC_OPS(16);
+DEFINE_TSAN_ATOMIC_OPS(32);
+DEFINE_TSAN_ATOMIC_OPS(64);
+
+void __tsan_atomic_thread_fence(int memorder);
+void __tsan_atomic_thread_fence(int memorder)
+{
+	__atomic_thread_fence(memorder);
+}
+EXPORT_SYMBOL(__tsan_atomic_thread_fence);
+
+void __tsan_atomic_signal_fence(int memorder);
+void __tsan_atomic_signal_fence(int memorder) { }
+EXPORT_SYMBOL(__tsan_atomic_signal_fence);
-- 
2.27.0.212.ge8ba1cc988-goog

