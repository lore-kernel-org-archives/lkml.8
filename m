Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C93C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BF7208C3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCHXXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:23:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCHXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:50 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Ga-00033N-NS; Mon, 09 Mar 2020 00:23:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2AC2610408A;
        Mon,  9 Mar 2020 00:23:28 +0100 (CET)
Message-Id: <20200308222609.017810037@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:00 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 01/13] context_tracking: Ensure that the critical path cannot be instrumented
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

context tracking lacks a few protection mechanisms against instrumentation:

 - While the core functions are marked NOKPROBE they lack protection
   against function tracing which is required as the function entry/exit
   points can be utilized by BPF.

 - static functions invoked from the protected functions need to be marked
   as well as they can be instrumented otherwise.

 - using plain inline allows the compiler to emit traceable and probable
   functions.

Fix this by adding the missing notrace/NOKPROBE annotations and converting
the plain inlines to __always_inline.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/context_tracking.h       |   14 +++++++-------
 include/linux/context_tracking_state.h |    6 +++---
 kernel/context_tracking.c              |    9 +++++----
 3 files changed, 15 insertions(+), 14 deletions(-)

--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -20,32 +20,32 @@ extern void context_tracking_exit(enum c
 extern void context_tracking_user_enter(void);
 extern void context_tracking_user_exit(void);
 
-static inline void user_enter(void)
+static __always_inline void user_enter(void)
 {
 	if (context_tracking_enabled())
 		context_tracking_enter(CONTEXT_USER);
 
 }
-static inline void user_exit(void)
+static __always_inline void user_exit(void)
 {
 	if (context_tracking_enabled())
 		context_tracking_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
-static inline void user_enter_irqoff(void)
+static __always_inline void user_enter_irqoff(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_USER);
 
 }
-static inline void user_exit_irqoff(void)
+static __always_inline void user_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_USER);
 }
 
-static inline enum ctx_state exception_enter(void)
+static __always_inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
@@ -59,7 +59,7 @@ static inline enum ctx_state exception_e
 	return prev_ctx;
 }
 
-static inline void exception_exit(enum ctx_state prev_ctx)
+static __always_inline void exception_exit(enum ctx_state prev_ctx)
 {
 	if (context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
@@ -75,7 +75,7 @@ static inline void exception_exit(enum c
  * is enabled.  If context tracking is disabled, returns
  * CONTEXT_DISABLED.  This should be used primarily for debugging.
  */
-static inline enum ctx_state ct_state(void)
+static __always_inline enum ctx_state ct_state(void)
 {
 	return context_tracking_enabled() ?
 		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -26,12 +26,12 @@ struct context_tracking {
 extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
-static inline bool context_tracking_enabled(void)
+static __always_inline bool context_tracking_enabled(void)
 {
 	return static_branch_unlikely(&context_tracking_key);
 }
 
-static inline bool context_tracking_enabled_cpu(int cpu)
+static __always_inline bool context_tracking_enabled_cpu(int cpu)
 {
 	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
 }
@@ -41,7 +41,7 @@ static inline bool context_tracking_enab
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
-static inline bool context_tracking_in_user(void)
+static __always_inline bool context_tracking_in_user(void)
 {
 	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
 }
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(context_tracking_key);
 DEFINE_PER_CPU(struct context_tracking, context_tracking);
 EXPORT_SYMBOL_GPL(context_tracking);
 
-static bool context_tracking_recursion_enter(void)
+static notrace bool context_tracking_recursion_enter(void)
 {
 	int recursion;
 
@@ -44,8 +44,9 @@ static bool context_tracking_recursion_e
 
 	return false;
 }
+NOKPROBE_SYMBOL(context_tracking_recursion_enter);
 
-static void context_tracking_recursion_exit(void)
+static __always_inline void context_tracking_recursion_exit(void)
 {
 	__this_cpu_dec(context_tracking.recursion);
 }
@@ -59,7 +60,7 @@ static void context_tracking_recursion_e
  * instructions to execute won't use any RCU read side critical section
  * because this function sets RCU in extended quiescent state.
  */
-void __context_tracking_enter(enum ctx_state state)
+void notrace __context_tracking_enter(enum ctx_state state)
 {
 	/* Kernel threads aren't supposed to go to userspace */
 	WARN_ON_ONCE(!current->mm);
@@ -142,7 +143,7 @@ NOKPROBE_SYMBOL(context_tracking_user_en
  * This call supports re-entrancy. This way it can be called from any exception
  * handler without needing to know if we came from userspace or not.
  */
-void __context_tracking_exit(enum ctx_state state)
+void notrace __context_tracking_exit(enum ctx_state state)
 {
 	if (!context_tracking_recursion_enter())
 		return;

