Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0985C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3F220838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHLMGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30573 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1g6RtZzB09Zc;
        Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RnYOaMbukcmD; Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1g5f6bzB09ZZ;
        Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23CD58B826;
        Wed, 12 Aug 2020 14:06:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CFVyk9b9WH2r; Wed, 12 Aug 2020 14:06:01 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D4B598B7FC;
        Wed, 12 Aug 2020 14:06:00 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B6B7365C34; Wed, 12 Aug 2020 12:06:00 +0000 (UTC)
Message-Id: <80617809ab5d23c6ac4863cc1964cca4bfe49f4f.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 09/19] powerpc/signal: Call get_tm_stackpointer() from
 get_sigframe()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling get_tm_stackpointer() from the caller, call it
directly from get_sigframe(). This avoids a double call and
allows get_tm_stackpointer() to become static and be inlined
into get_sigframe() by GCC.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.c    | 9 ++++++---
 arch/powerpc/kernel/signal.h    | 6 ++----
 arch/powerpc/kernel/signal_32.c | 4 ++--
 arch/powerpc/kernel/signal_64.c | 2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index a295d482adec..5edded5c5d20 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -144,10 +144,13 @@ int show_unhandled_signals = 1;
 /*
  * Allocate space for the signal frame
  */
-void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
-			   size_t frame_size, int is_32)
+static unsigned long get_tm_stackpointer(struct task_struct *tsk);
+
+void __user *get_sigframe(struct ksignal *ksig, struct task_struct *tsk,
+			  size_t frame_size, int is_32)
 {
         unsigned long oldsp, newsp;
+	unsigned long sp = get_tm_stackpointer(tsk);
 
         /* Default to using normal stack */
 	if (is_32)
@@ -304,7 +307,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	user_enter();
 }
 
-unsigned long get_tm_stackpointer(struct task_struct *tsk)
+static unsigned long get_tm_stackpointer(struct task_struct *tsk)
 {
 	/* When in an active transaction that takes a signal, we need to be
 	 * careful with the stack.  It's possible that the stack has moved back
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 6c2a33ab042c..fb98731348c3 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -10,8 +10,8 @@
 #ifndef _POWERPC_ARCH_SIGNAL_H
 #define _POWERPC_ARCH_SIGNAL_H
 
-extern void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
-				  size_t frame_size, int is_32);
+void __user *get_sigframe(struct ksignal *ksig, struct task_struct *tsk,
+			  size_t frame_size, int is_32);
 
 extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 			   struct task_struct *tsk);
@@ -19,8 +19,6 @@ extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			      struct task_struct *tsk);
 
-extern unsigned long get_tm_stackpointer(struct task_struct *tsk);
-
 #ifdef CONFIG_VSX
 extern unsigned long copy_vsx_to_user(void __user *to,
 				      struct task_struct *task);
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 5a838188a181..3356f6aba4ae 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -768,7 +768,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(ksig, tsk, sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (!access_ok(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
@@ -1230,7 +1230,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	BUG_ON(tsk != current);
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 1);
+	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index ec259a0efe24..92d152c1155c 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -824,7 +824,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 	BUG_ON(tsk != current);
 
-	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 0);
+	frame = get_sigframe(ksig, tsk, sizeof(*frame), 0);
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 
-- 
2.25.0

