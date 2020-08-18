Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E572C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0910A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/z3sGgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHRONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHROMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930FC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=usfJYrHjoBxFonX6sQP2Y3rxktOMSPitLSs0Bq2ULDs=; b=J/z3sGgmw26VoRwZHJTiHkVuNY
        3cJ2BO1DQWxwvEzefjIhA4dhn5yq2osaoDxlHbg2X741in1Rh5JihKO8q+3snmJxN0CMIcyg3LWyN
        50xdwPmCiS3yNP4NKuZcC/zabBwHIWHmPP+ZhrdbhnKyxllhDNCj2uwfNR9TwvY2R4WIpcYvLWZeo
        +hx+SgSMPT259x4tUoHowTIsHGJDul4d3AdMuWEuLLh8BX62orMnsTheoMSw8UzZ0El8FIXdzUmI/
        +Cs6mk4eOkJP/NH4GSy4l9uQF6/YE993/OqUy6fcyT7gFePpX1+y6xU7ejEehQZtHwQ6zdofOPz1n
        kR4PEijg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LL-0006VI-6c; Tue, 18 Aug 2020 14:12:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3F4730799A;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB76223D42C11; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135805.279421092@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 17/18] tracepoint: Optimize using static_call()
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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
---
 include/linux/tracepoint-defs.h |    5 ++
 include/linux/tracepoint.h      |   86 ++++++++++++++++++++++++++++------------
 include/trace/define_trace.h    |   14 +++---
 kernel/tracepoint.c             |   25 +++++++++--
 4 files changed, 94 insertions(+), 36 deletions(-)

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
@@ -148,6 +151,12 @@ static inline struct tracepoint *tracepo
 
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
@@ -157,12 +166,11 @@ static inline struct tracepoint *tracepo
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
@@ -182,14 +190,11 @@ static inline struct tracepoint *tracepo
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
@@ -205,7 +210,7 @@ static inline struct tracepoint *tracepo
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 1);			\
@@ -227,11 +232,13 @@ static inline struct tracepoint *tracepo
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
@@ -277,21 +284,50 @@ static inline struct tracepoint *tracepo
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
@@ -320,8 +356,8 @@ static inline struct tracepoint *tracepo
 		return false;						\
 	}
 
-#define DEFINE_TRACE_FN(name, reg, unreg)
-#define DEFINE_TRACE(name)
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
+#define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
 
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
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -221,6 +221,20 @@ static void *func_remove(struct tracepoi
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
@@ -251,8 +265,9 @@ static int tracepoint_add_func(struct tr
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
@@ -281,9 +296,11 @@ static int tracepoint_remove_func(struct
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


