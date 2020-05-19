Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FD2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70E72087D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgESUAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEST7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF15C08C5C3;
        Tue, 19 May 2020 12:59:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OE-0000Ee-BH; Tue, 19 May 2020 21:59:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A33961C0837;
        Tue, 19 May 2020 21:58:47 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] context_tracking: Make guest_enter/exit() .noinstr ready
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134341.672545766@linutronix.de>
References: <20200505134341.672545766@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832753.17951.748859244105491427.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     af1e56b78534c38bb0e0c712ca70e59f816b74e9
Gitweb:        https://git.kernel.org/tip/af1e56b78534c38bb0e0c712ca70e59f816b74e9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 19 Mar 2020 14:53:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:21 +02:00

context_tracking: Make guest_enter/exit() .noinstr ready

Force inlining of the helpers and mark the instrumentable parts
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134341.672545766@linutronix.de


---
 include/linux/context_tracking.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 8150f5a..8cac62e 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -101,12 +101,14 @@ static inline void context_tracking_init(void) { }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 /* must be called with irqs disabled */
-static inline void guest_enter_irqoff(void)
+static __always_inline void guest_enter_irqoff(void)
 {
+	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
 		current->flags |= PF_VCPU;
+	instrumentation_end();
 
 	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_GUEST);
@@ -118,39 +120,48 @@ static inline void guest_enter_irqoff(void)
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_enabled_this_cpu())
+	if (!context_tracking_enabled_this_cpu()) {
+		instrumentation_begin();
 		rcu_virt_note_context_switch(smp_processor_id());
+		instrumentation_end();
+	}
 }
 
-static inline void guest_exit_irqoff(void)
+static __always_inline void guest_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
+	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
+	instrumentation_end();
 }
 
 #else
-static inline void guest_enter_irqoff(void)
+static __always_inline void guest_enter_irqoff(void)
 {
 	/*
 	 * This is running in ioctl context so its safe
 	 * to assume that it's the stime pending cputime
 	 * to flush.
 	 */
+	instrumentation_begin();
 	vtime_account_kernel(current);
 	current->flags |= PF_VCPU;
 	rcu_virt_note_context_switch(smp_processor_id());
+	instrumentation_end();
 }
 
-static inline void guest_exit_irqoff(void)
+static __always_inline void guest_exit_irqoff(void)
 {
+	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
 	vtime_account_kernel(current);
 	current->flags &= ~PF_VCPU;
+	instrumentation_end();
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
