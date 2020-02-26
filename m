Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDDC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5A24689
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cwr47Kfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBZLyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:54:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7417 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgBZLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:54:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDjJ6blLz9txVF;
        Wed, 26 Feb 2020 12:53:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cwr47Kfg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mFW_VrsgF66z; Wed, 26 Feb 2020 12:53:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDjJ5bFhz9txV6;
        Wed, 26 Feb 2020 12:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718036; bh=uf9kHFohIIPyVydQkYJqQZCBFiY/xz5h8N0infTzpjI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Cwr47KfgLC9TjHqgh0JCBvhURTolFNiq7slgeZyUMuY2B+NxuspYHUzpKvdenfjcq
         elAxUm7o9Qi4e/2aK4jfOmBs/GfJ2rTfyaYVyVCFt65n8fuXiNqb4PdKQFExaGdUEU
         kgLZCgs1vijMbC8ig1fMqt33OpWfiJoX++Rt+sO4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 124CF8B846;
        Wed, 26 Feb 2020 12:53:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7LiuAwP5A4_m; Wed, 26 Feb 2020 12:53:57 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5FC08B776;
        Wed, 26 Feb 2020 12:53:57 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9EBAE65400; Wed, 26 Feb 2020 11:53:57 +0000 (UTC)
Message-Id: <7bb197e10ad59fb840cd5f6e0d654aa19923246a.1582717645.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1582717645.git.christophe.leroy@c-s.fr>
References: <cover.1582717645.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 07/13] powerpc/ptrace: split out SPE related functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 26 Feb 2020 11:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CONFIG_SPE functions out of ptrace.c, into
ptrace-spe.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/Makefile      |  1 +
 arch/powerpc/kernel/ptrace/ptrace-decl.h |  9 ++++
 arch/powerpc/kernel/ptrace/ptrace-spe.c  | 66 ++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c      | 66 ------------------------
 4 files changed, 76 insertions(+), 66 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-spe.c

diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
index 522e6fd0b5b8..f87eadf6e072 100644
--- a/arch/powerpc/kernel/ptrace/Makefile
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -12,3 +12,4 @@ ifneq ($(CONFIG_VSX),y)
 obj-y				+= ptrace-novsx.o
 endif
 obj-$(CONFIG_ALTIVEC)		+= ptrace-altivec.o
+obj-$(CONFIG_SPE)		+= ptrace-spe.o
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index 0f9282cb52fc..8a362f97f1d6 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -26,6 +26,15 @@ int vr_set(struct task_struct *target, const struct user_regset *regset,
 	   unsigned int pos, unsigned int count,
 	   const void *kbuf, const void __user *ubuf);
 
+/* ptrace-spe */
+
+int evr_active(struct task_struct *target, const struct user_regset *regset);
+int evr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+int evr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf);
+
 /* ptrace */
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
diff --git a/arch/powerpc/kernel/ptrace/ptrace-spe.c b/arch/powerpc/kernel/ptrace/ptrace-spe.c
new file mode 100644
index 000000000000..c2e1a15c4343
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-spe.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/regset.h>
+
+#include <asm/switch_to.h>
+
+/*
+ * For get_evrregs/set_evrregs functions 'data' has the following layout:
+ *
+ * struct {
+ *   u32 evr[32];
+ *   u64 acc;
+ *   u32 spefscr;
+ * }
+ */
+
+int evr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	flush_spe_to_thread(target);
+	return target->thread.used_spe ? regset->n : 0;
+}
+
+int evr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	flush_spe_to_thread(target);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.evr,
+				  0, sizeof(target->thread.evr));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
+		     offsetof(struct thread_struct, spefscr));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.acc,
+					  sizeof(target->thread.evr), -1);
+
+	return ret;
+}
+
+int evr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	flush_spe_to_thread(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.evr,
+				 0, sizeof(target->thread.evr));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
+		     offsetof(struct thread_struct, spefscr));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.acc,
+					 sizeof(target->thread.evr), -1);
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index c383325db4a6..ca2b4d804992 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -403,72 +403,6 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
-#ifdef CONFIG_SPE
-
-/*
- * For get_evrregs/set_evrregs functions 'data' has the following layout:
- *
- * struct {
- *   u32 evr[32];
- *   u64 acc;
- *   u32 spefscr;
- * }
- */
-
-static int evr_active(struct task_struct *target,
-		      const struct user_regset *regset)
-{
-	flush_spe_to_thread(target);
-	return target->thread.used_spe ? regset->n : 0;
-}
-
-static int evr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-	int ret;
-
-	flush_spe_to_thread(target);
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.evr,
-				  0, sizeof(target->thread.evr));
-
-	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
-		     offsetof(struct thread_struct, spefscr));
-
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.acc,
-					  sizeof(target->thread.evr), -1);
-
-	return ret;
-}
-
-static int evr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
-{
-	int ret;
-
-	flush_spe_to_thread(target);
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &target->thread.evr,
-				 0, sizeof(target->thread.evr));
-
-	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
-		     offsetof(struct thread_struct, spefscr));
-
-	if (!ret)
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					 &target->thread.acc,
-					 sizeof(target->thread.evr), -1);
-
-	return ret;
-}
-#endif /* CONFIG_SPE */
-
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 /**
  * tm_cgpr_active - get active number of registers in CGPR
-- 
2.25.0

