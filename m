Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EFA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHRRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:19:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgHRRTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhH6c2Pz9vCxm;
        Tue, 18 Aug 2020 19:19:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ob_gp16UB6xB; Tue, 18 Aug 2020 19:19:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhH5Yrkz9vCxg;
        Tue, 18 Aug 2020 19:19:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D3A58B7EC;
        Tue, 18 Aug 2020 19:19:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NIlQY05V3jyF; Tue, 18 Aug 2020 19:19:13 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E4938B7D7;
        Tue, 18 Aug 2020 19:19:13 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1EE6065CF4; Tue, 18 Aug 2020 17:19:13 +0000 (UTC)
Message-Id: <35b1bd44a1a66f5bcf9b457a1c480ac8d5ef50b2.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 01/25] powerpc/signal: Move inline functions in signal.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To really be inlined, the functions need to be defined in the
same C file as the caller, or in an included header.

Move functions defined inline from signal .c in signal.h

Fixes: 3dd4eb83a9c0 ("powerpc: move common register copy functions from signal_32.c to signal.c")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.c | 30 --------------------------
 arch/powerpc/kernel/signal.h | 41 +++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index d15a98c758b8..3b56db02b762 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -133,36 +133,6 @@ unsigned long copy_ckvsx_from_user(struct task_struct *task,
 	return 0;
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-#else
-inline unsigned long copy_fpr_to_user(void __user *to,
-				      struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.fp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_fpr_from_user(struct task_struct *task,
-					void __user *from)
-{
-	return __copy_from_user(task->thread.fp_state.fpr, from,
-			      ELF_NFPREG * sizeof(double));
-}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-inline unsigned long copy_ckfpr_to_user(void __user *to,
-					 struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.ckfp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
-						 void __user *from)
-{
-	return __copy_from_user(task->thread.ckfp_state.fpr, from,
-				ELF_NFPREG * sizeof(double));
-}
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #endif
 
 /* Log an error when sending an unhandled signal to a process. Controlled
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index d396efca4068..4626d39cc0f0 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -19,14 +19,6 @@ extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			      struct task_struct *tsk);
 
-extern unsigned long copy_fpr_to_user(void __user *to,
-				      struct task_struct *task);
-extern unsigned long copy_ckfpr_to_user(void __user *to,
-					       struct task_struct *task);
-extern unsigned long copy_fpr_from_user(struct task_struct *task,
-					void __user *from);
-extern unsigned long copy_ckfpr_from_user(struct task_struct *task,
-						 void __user *from);
 extern unsigned long get_tm_stackpointer(struct task_struct *tsk);
 
 #ifdef CONFIG_VSX
@@ -38,6 +30,39 @@ extern unsigned long copy_vsx_from_user(struct task_struct *task,
 					void __user *from);
 extern unsigned long copy_ckvsx_from_user(struct task_struct *task,
 						 void __user *from);
+unsigned long copy_fpr_to_user(void __user *to, struct task_struct *task);
+unsigned long copy_ckfpr_to_user(void __user *to, struct task_struct *task);
+unsigned long copy_fpr_from_user(struct task_struct *task, void __user *from);
+unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
+#else
+static inline unsigned long
+copy_fpr_to_user(void __user *to, struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.fp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+static inline unsigned long
+copy_fpr_from_user(struct task_struct *task, void __user *from)
+{
+	return __copy_from_user(task->thread.fp_state.fpr, from,
+			      ELF_NFPREG * sizeof(double));
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+inline unsigned long copy_ckfpr_to_user(void __user *to, struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.ckfp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+static inline unsigned long
+copy_ckfpr_from_user(struct task_struct *task, void __user *from)
+{
+	return __copy_from_user(task->thread.ckfp_state.fpr, from,
+				ELF_NFPREG * sizeof(double));
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #endif
 
 #ifdef CONFIG_PPC64
-- 
2.25.0

