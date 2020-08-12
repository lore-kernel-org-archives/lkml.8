Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E006C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045272080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHLMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:05:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47507 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgHLMF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:05:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1W5YHQzB09ZS;
        Wed, 12 Aug 2020 14:05:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vqoO8MfIV5UT; Wed, 12 Aug 2020 14:05:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1W4BT9zB09ZQ;
        Wed, 12 Aug 2020 14:05:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 098EB8B7FC;
        Wed, 12 Aug 2020 14:05:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q6e4G13CLk1g; Wed, 12 Aug 2020 14:05:52 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A16788B828;
        Wed, 12 Aug 2020 14:05:52 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 819BB65C34; Wed, 12 Aug 2020 12:05:52 +0000 (UTC)
Message-Id: <3f44870a1aa983cb023702161674c39c41af4c04.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 01/19] powerpc/signal: Move inline functions in
 signal.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:05:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To really be inlined, the functions needs to be defined in the
same C file as the caller, or in an included header.

Move functions from signal .c defined inline in signal.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 3dd4eb83a9c0 ("powerpc: move common register copy functions from signal_32.c to signal.c")
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

