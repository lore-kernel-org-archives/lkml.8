Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB76206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unGvG35L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaIsotXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIAL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFHR+ta88NnmCU84iaUrVoWbZ58Nhek/uundEV0X+mo=;
        b=unGvG35LKmS4904Uj2hBMbcx06qxVoPUZzCaYDceBlvfIjjUTcWucB0DhFJWhRombewBW5
        ++sZBdNeXTctV+Y9r2h0XzfsIWSoub1BtV9YeiAXmgSgBmyPcqP7j7MHOFRNInd5d4nJYV
        SA6UkK8pEXJVJR86tjlHIWVsJW0BjFXFp6YugIsU2MgurW8rxwNgN3+mtdqIbiQxB33eev
        Gkleok8J0VTh0q9QgbxLc91XqTCMATiJV29FHEpjigtVrfx8+J+0NRp7KDq90lVXn7by+h
        TyAEc2g1ylXyKuP1DPCRDnXx2CC3iQYEu+bYURqG+VxU9SJwdw0csb2zDQh/SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFHR+ta88NnmCU84iaUrVoWbZ58Nhek/uundEV0X+mo=;
        b=YaIsotXcdyRvfVMXRg0s0US3HkjIoVGFanKI9S42QrIcBhTzEDHycOWlVvQZM1HRbF7A62
        n8L/tL+9GeP1CwCg==
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] tracepoint: Optimize using static_call()
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.279421092@infradead.org>
References: <20200818135805.279421092@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088242.20229.6639521579536854409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     d25e37d89dd2f41d7acae0429039d2f0ae8b4a07
Gitweb:        https://git.kernel.org/tip/d25e37d89dd2f41d7acae0429039d2f0ae8b4a07
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:06 +02:00

tracepoint: Optimize using static_call()

Currently the tracepoint site will iterate a vector and issue indirect
calls to however many handlers are registered (ie. the vector is
long).

Using static_call() it is possible to optimize this for the common
case of only having a single handler registered. In this case the
static_call() can directly call this handler. Otherwise, if the vector
is longer than 1, call a function that iterates the whole vector like
the current code.

[peterz: updated to new interface]

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135805.279421092@infradead.org
---
 include/linux/tracepoint-defs.h |  5 ++-
 include/linux/tracepoint.h      | 86 ++++++++++++++++++++++----------
 include/trace/define_trace.h    | 14 ++---
 kernel/tracepoint.c             | 25 +++++++--
 4 files changed, 94 insertions(+), 36 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index b29950a..de97450 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -11,6 +11,8 @@
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 
+struct static_call_key;
+
 struct trace_print_flags {
 	unsigned long		mask;
 	const char		*name;
@@ -30,6 +32,9 @@ struct tracepoint_func {
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
+	struct static_call_key *static_call_key;
+	void *static_call_tramp;
+	void *iterator;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 598fec9..3722a10 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -19,6 +19,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/static_call.h>
 
 struct module;
 struct tracepoint;
@@ -92,7 +93,9 @@ extern int syscall_regfunc(void);
 extern void syscall_unregfunc(void);
 #endif /* CONFIG_HAVE_SYSCALL_TRACEPOINTS */
 
+#ifndef PARAMS
 #define PARAMS(args...) args
+#endif
 
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
@@ -148,6 +151,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #ifdef TRACEPOINTS_ENABLED
 
+#ifdef CONFIG_HAVE_STATIC_CALL
+#define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
+#else
+#define __DO_TRACE_CALL(name)	__tracepoint_iter_##name
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 /*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
@@ -157,12 +166,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * has a "void" prototype, then it is invalid to declare a function
  * as "(void *, void)".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(name, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
-		void *it_func;						\
-		void *__data;						\
 		int __maybe_unused __idx = 0;				\
+		void *__data;						\
 									\
 		if (!(cond))						\
 			return;						\
@@ -182,14 +190,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
-		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
-									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
 		if (it_func_ptr) {					\
-			do {						\
-				it_func = (it_func_ptr)->func;		\
-				__data = (it_func_ptr)->data;		\
-				((void(*)(proto))(it_func))(args);	\
-			} while ((++it_func_ptr)->func);		\
+			__data = (it_func_ptr)->data;			\
+			__DO_TRACE_CALL(name)(args);			\
 		}							\
 									\
 		if (rcuidle) {						\
@@ -205,7 +210,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 1);			\
@@ -227,11 +232,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	extern int __tracepoint_iter_##name(data_proto);		\
+	DECLARE_STATIC_CALL(tp_func_##name, __tracepoint_iter_##name); \
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
@@ -277,21 +284,50 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
-	static const char __tpstrtab_##name[]				 \
-	__section(__tracepoints_strings) = #name;			 \
-	struct tracepoint __tracepoint_##name __used			 \
-	__section(__tracepoints) =					 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	__TRACEPOINT_ENTRY(name);
+#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
+	static const char __tpstrtab_##_name[]				\
+	__section(__tracepoints_strings) = #_name;			\
+	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
+	int __tracepoint_iter_##_name(void *__data, proto);		\
+	struct tracepoint __tracepoint_##_name	__used			\
+	__section(__tracepoints) = {					\
+		.name = __tpstrtab_##_name,				\
+		.key = STATIC_KEY_INIT_FALSE,				\
+		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
+		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
+		.iterator = &__tracepoint_iter_##_name,			\
+		.regfunc = _reg,					\
+		.unregfunc = _unreg,					\
+		.funcs = NULL };					\
+	__TRACEPOINT_ENTRY(_name);					\
+	int __tracepoint_iter_##_name(void *__data, proto)		\
+	{								\
+		struct tracepoint_func *it_func_ptr;			\
+		void *it_func;						\
+									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
+		do {							\
+			it_func = (it_func_ptr)->func;			\
+			__data = (it_func_ptr)->data;			\
+			((void(*)(void *, proto))(it_func))(__data, args); \
+		} while ((++it_func_ptr)->func);			\
+		return 0;						\
+	}								\
+	DEFINE_STATIC_CALL(tp_func_##_name, __tracepoint_iter_##_name);
 
-#define DEFINE_TRACE(name)						\
-	DEFINE_TRACE_FN(name, NULL, NULL);
+#define DEFINE_TRACE(name, proto, args)		\
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
-	EXPORT_SYMBOL_GPL(__tracepoint_##name)
+	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
+	EXPORT_SYMBOL_GPL(__tracepoint_iter_##name);			\
+	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
-	EXPORT_SYMBOL(__tracepoint_##name)
+	EXPORT_SYMBOL(__tracepoint_##name);				\
+	EXPORT_SYMBOL(__tracepoint_iter_##name);			\
+	EXPORT_STATIC_CALL(tp_func_##name)
+
 
 #else /* !TRACEPOINTS_ENABLED */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
@@ -320,8 +356,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return false;						\
 	}
 
-#define DEFINE_TRACE_FN(name, reg, unreg)
-#define DEFINE_TRACE(name)
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
+#define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
 
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index bd75f97..0072393 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -25,7 +25,7 @@
 
 #undef TRACE_EVENT
 #define TRACE_EVENT(name, proto, args, tstruct, assign, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_CONDITION
 #define TRACE_EVENT_CONDITION(name, proto, args, cond, tstruct, assign, print) \
@@ -39,12 +39,12 @@
 #undef TRACE_EVENT_FN
 #define TRACE_EVENT_FN(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_NOP
 #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
@@ -54,15 +54,15 @@
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_FN
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg) \
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_CONDITION
 #define DEFINE_EVENT_CONDITION(template, name, proto, args, cond) \
@@ -70,7 +70,7 @@
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8e05ed2..e92f3fb 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -221,6 +221,20 @@ static void *func_remove(struct tracepoint_func **funcs,
 	return old;
 }
 
+static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs)
+{
+	void *func = tp->iterator;
+
+	/* Synthetic events do not have static call sites */
+	if (!tp->static_call_key)
+		return;
+
+	if (!tp_funcs[1].func)
+		func = tp_funcs[0].func;
+
+	__static_call_update(tp->static_call_key, tp->static_call_tramp, func);
+}
+
 /*
  * Add the probe function to a tracepoint.
  */
@@ -251,8 +265,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	if (!static_key_enabled(&tp->key))
-		static_key_slow_inc(&tp->key);
+	tracepoint_update_call(tp, tp_funcs);
+	static_key_enable(&tp->key);
+
 	release_probes(old);
 	return 0;
 }
@@ -281,9 +296,11 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		if (tp->unregfunc && static_key_enabled(&tp->key))
 			tp->unregfunc();
 
-		if (static_key_enabled(&tp->key))
-			static_key_slow_dec(&tp->key);
+		static_key_disable(&tp->key);
+	} else {
+		tracepoint_update_call(tp, tp_funcs);
 	}
+
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	release_probes(old);
 	return 0;
