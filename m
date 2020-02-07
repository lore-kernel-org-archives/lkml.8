Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B1EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB0C217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OfluTCbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBGU5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:57:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41026 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgBGU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:57:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id l19so437372qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HN45H+ids+NCISymh2yr5TaGOkbSeu3kPfZfuoJYhiE=;
        b=OfluTCbQxU2UiZewf9sKzFEe0wl4kJczwr4+6O5grSXP6BWolUzLfdS/1FDvMbwQR/
         /93uAKd/ORgMIeB0BaD9x6qmSfbDBYDZmIq1M/38b+os8KV8M6WZPsetiTtbf7UePxGC
         AX4rNZmGOXuzE48Fp0N65arYv44wQhAGvXuFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HN45H+ids+NCISymh2yr5TaGOkbSeu3kPfZfuoJYhiE=;
        b=RwABo8P8gzZYxseHqtuK8Oi9W4cac0oE7AhFvOYk7SNoSjZrSYTCEzJ+w1iil7ItXC
         MIgoj3lC8N0wKih2rQGbvjNxVTZapdwHWBd1DDyUzfCVM7TVsFQYytTNNkVGjdd4VdMj
         R9nnjY64Vk3oRFBueBgqAcI9xp0yDNs4f2oww0hjkhUojrPOOM5wzpwnZOY3Ru3bEPsW
         n+q+DHgEUBctq8zdGGcexeSIVyoDxwXm3EbZqiitzfUHEfWVB8nLGCxek2Qy2cwN8w6q
         kvyn38shwZadFvTjcFp1UMoGT5Ooln+UCkG5GxO1CV6jjNpIgEdTZCEN6BHz9XoXZwYC
         YhMg==
X-Gm-Message-State: APjAAAUXhDAXPwmmFwdNuppZg6QzMaKA9u0juP4iqKWZPEgKyTky6zoz
        Yu7zbjzQfl7YEQIC9pNksctn88kkkCk=
X-Google-Smtp-Source: APXvYqw4muYEToLsLXQ4KN9P+X2B7pWR3w+BImuMb/7RPlgI45XwTrLrUC2CUHYZ0zeLTmQGjtrpYg==
X-Received: by 2002:aed:3384:: with SMTP id v4mr278936qtd.58.1581109029448;
        Fri, 07 Feb 2020 12:57:09 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 136sm1887431qkn.109.2020.02.07.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:57:09 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC 3/3] Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
Date:   Fri,  7 Feb 2020 15:56:56 -0500
Message-Id: <20200207205656.61938-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207205656.61938-1-joel@joelfernandes.org>
References: <20200207205656.61938-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e6753f23d961d601dbae50a2fc2a3975c9715b14.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 40 ++++++++------------------------------
 kernel/tracepoint.c        | 10 +---------
 2 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index ab1f13b7f7d2c..b2b13cf03e092 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -13,7 +13,6 @@
  */
 
 #include <linux/smp.h>
-#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -32,8 +31,6 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
-extern struct srcu_struct tracepoint_srcu;
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -76,16 +73,10 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
  */
-#ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
-	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
-#else
-static inline void tracepoint_synchronize_unregister(void)
-{ }
-#endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 extern int syscall_regfunc(void);
@@ -159,31 +150,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
-		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
-									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
-									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
-									\
-		/*							\
-		 * For rcuidle callers, use srcu since sched-rcu	\
-		 * doesn't work from the idle path.			\
-		 */							\
-		if (rcuidle)						\
-			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
-									\
-		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
-									\
+		if (rcucheck)						\
+			rcu_irq_enter_irqson();				\
+		rcu_read_lock_sched_notrace();				\
+		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -191,11 +169,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
-									\
-		if (rcuidle)						\
-			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
-									\
-		preempt_enable_notrace();				\
+		rcu_read_unlock_sched_notrace();			\
+		if (rcucheck)						\
+			rcu_irq_exit_irqson();				\
 	} while (0)
 
 #ifndef MODULE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956eaff8a9c..df956fc23ca57 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -18,9 +18,6 @@
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
-DEFINE_SRCU(tracepoint_srcu);
-EXPORT_SYMBOL_GPL(tracepoint_srcu);
-
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -60,14 +57,9 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void srcu_free_old_probes(struct rcu_head *head)
-{
-	kfree(container_of(head, struct tp_probes, rcu));
-}
-
 static void rcu_free_old_probes(struct rcu_head *head)
 {
-	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+	kfree(container_of(head, struct tp_probes, rcu));
 }
 
 static __init int release_early_probes(void)
-- 
2.25.0.341.g760bfbb309-goog

