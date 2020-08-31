Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4204C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47D4208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897901;
	bh=Ab8QYwI6/ALUDbI9X3koay2u1a9suSWcIabBhFDEc5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkspZnWtXwG3mJ07g91OBnTaJj9QvsUW00bjODxS4GSr0MjwbdWXoYmXf9wAJHLq9
	 VRNTaMIAzz11RsjxVbioEW66TunIqAjYBsFAcsnmMBN+bjX3FaZiSpBiG8dppusig3
	 zYBkoH+tuJOxwjVvapPKzU5gaR+RtdGYGVb0VUMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgHaSSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgHaSSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F822071B;
        Mon, 31 Aug 2020 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897886;
        bh=Ab8QYwI6/ALUDbI9X3koay2u1a9suSWcIabBhFDEc5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8pU6DyKJt35KSHktLYvDCbMNKs3PZlOuhYSkKZ4ToxuxZKayB2+clIefr463Eb+r
         +t8X4rq5efjt6OH0nWehSeO+uDlTnfGzhckp5+3s8qKxMJz7yKmt3MF+40DLg/uTXI
         9X1kVETm9gyqOEAkoimfTTiUO3CSlszVyy4yY8/k=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 01/19] kcsan: Add support for atomic builtins
Date:   Mon, 31 Aug 2020 11:17:47 -0700
Message-Id: <20200831181805.1833-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9147ff6..682d9fd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -879,3 +879,113 @@ void __tsan_init(void)
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
2.9.5

