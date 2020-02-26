Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3FC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1C24689
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZX2Qm49B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBZLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:54:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6797 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBZLx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:53:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDjG6rl1z9txVD;
        Wed, 26 Feb 2020 12:53:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZX2Qm49B; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7I8_fAH5jb5p; Wed, 26 Feb 2020 12:53:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDjG5j5tz9txV6;
        Wed, 26 Feb 2020 12:53:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718034; bh=5wrf5K15NKLuOcsJxLWZ4BEl3NP+TA4cDZIMscPwnDM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ZX2Qm49Bqx1Kj6Zn0cKTj5BHa/hXTY6IybrO+i5NFuh2093kGa9NoVgT1M1r6b1cR
         RQQzs94iE/BB6jn+LWfTPujJld7QKmu3d7i6yvb1dP+xkNppfhV75IiaMa/OrKMf0O
         90qxpPbPUjMcOlBNVzk8UhRdrudqZrFnj2JBuSUI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11B948B846;
        Wed, 26 Feb 2020 12:53:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DN958VpjJGRB; Wed, 26 Feb 2020 12:53:55 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCC5F8B776;
        Wed, 26 Feb 2020 12:53:55 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9196F65400; Wed, 26 Feb 2020 11:53:55 +0000 (UTC)
Message-Id: <dc8e20c8c95b7e83add0c6dd48f9470628896c5c.1582717645.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1582717645.git.christophe.leroy@c-s.fr>
References: <cover.1582717645.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/13] powerpc/ptrace: split out VSX related functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 26 Feb 2020 11:53:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CONFIG_VSX functions out of ptrace.c, into
ptrace-vsx.c and ptrace-novsx.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/Makefile       |   4 +
 arch/powerpc/kernel/ptrace/ptrace-decl.h  |  26 ++++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c |  57 +++++++
 arch/powerpc/kernel/ptrace/ptrace-vsx.c   | 151 +++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c       | 175 +---------------------
 5 files changed, 241 insertions(+), 172 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-decl.h
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-novsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-vsx.c

diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
index 02fb28eb3b55..238c27189078 100644
--- a/arch/powerpc/kernel/ptrace/Makefile
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -7,3 +7,7 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y				+= ptrace.o
 obj-$(CONFIG_PPC64)		+= ptrace32.o
+obj-$(CONFIG_VSX)		+= ptrace-vsx.o
+ifneq ($(CONFIG_VSX),y)
+obj-y				+= ptrace-novsx.o
+endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
new file mode 100644
index 000000000000..764df4ee9362
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* ptrace-(no)vsx */
+
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf);
+
+/* ptrace-vsx */
+
+int vsr_active(struct task_struct *target, const struct user_regset *regset);
+int vsr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+int vsr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf);
+
+/* ptrace */
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void flush_tmregs_to_thread(struct task_struct *tsk);
+#else
+static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
+#endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
new file mode 100644
index 000000000000..b2dc4e92d11a
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/regset.h>
+
+#include <asm/switch_to.h>
+
+#include "ptrace-decl.h"
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ */
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
+		     offsetof(struct thread_fp_state, fpr[32]));
+
+	flush_fp_to_thread(target);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.fp_state, 0, -1);
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ */
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
+		     offsetof(struct thread_fp_state, fpr[32]));
+
+	flush_fp_to_thread(target);
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fp_state, 0, -1);
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace-vsx.c b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
new file mode 100644
index 000000000000..d53466d49cc0
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/regset.h>
+
+#include <asm/switch_to.h>
+
+#include "ptrace-decl.h"
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ */
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
+
+	flush_fp_to_thread(target);
+
+	/* copy to local buffer then write that out */
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	buf[32] = target->thread.fp_state.fpscr;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ */
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
+
+	flush_fp_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	buf[32] = target->thread.fp_state.fpscr;
+
+	/* copy to local buffer then write that out */
+	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	if (i)
+		return i;
+
+	for (i = 0; i < 32 ; i++)
+		target->thread.TS_FPR(i) = buf[i];
+	target->thread.fp_state.fpscr = buf[32];
+	return 0;
+}
+
+/*
+ * Currently to set and and get all the vsx state, you need to call
+ * the fp and VMX calls as well.  This only get/sets the lower 32
+ * 128bit VSX registers.
+ */
+
+int vsr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	flush_vsx_to_thread(target);
+	return target->thread.used_vsr ? regset->n : 0;
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	vsx[32];
+ * };
+ */
+int vsr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	u64 buf[32];
+	int ret, i;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_vsx_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  buf, 0, 32 * sizeof(double));
+
+	return ret;
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	vsx[32];
+ * };
+ */
+int vsr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[32];
+	int ret, i;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_vsx_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 buf, 0, 32 * sizeof(double));
+	if (!ret)
+		for (i = 0; i < 32 ; i++)
+			target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 22826c942eae..ead33b74e1f3 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -33,6 +33,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#include "ptrace-decl.h"
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -100,7 +102,7 @@ static const struct pt_regs_offset regoffset_table[] = {
 };
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static void flush_tmregs_to_thread(struct task_struct *tsk)
+void flush_tmregs_to_thread(struct task_struct *tsk)
 {
 	/*
 	 * If task is not current, it will have been flushed already to
@@ -120,8 +122,6 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 		tm_save_sprs(&(tsk->thread));
 	}
 }
-#else
-static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
 #endif
 
 /**
@@ -403,91 +403,6 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	fpr[32];
- *	u64	fpscr;
- * };
- */
-static int fpr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-#ifdef CONFIG_VSX
-	u64 buf[33];
-	int i;
-
-	flush_fp_to_thread(target);
-
-	/* copy to local buffer then write that out */
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_FPR(i);
-	buf[32] = target->thread.fp_state.fpscr;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-#else
-	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32]));
-
-	flush_fp_to_thread(target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.fp_state, 0, -1);
-#endif
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	fpr[32];
- *	u64	fpscr;
- * };
- *
- */
-static int fpr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
-{
-#ifdef CONFIG_VSX
-	u64 buf[33];
-	int i;
-
-	flush_fp_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_FPR(i);
-	buf[32] = target->thread.fp_state.fpscr;
-
-	/* copy to local buffer then write that out */
-	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-	if (i)
-		return i;
-
-	for (i = 0; i < 32 ; i++)
-		target->thread.TS_FPR(i) = buf[i];
-	target->thread.fp_state.fpscr = buf[32];
-	return 0;
-#else
-	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32]));
-
-	flush_fp_to_thread(target);
-
-	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fp_state, 0, -1);
-#endif
-}
-
 #ifdef CONFIG_ALTIVEC
 /*
  * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
@@ -612,90 +527,6 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
-/*
- * Currently to set and and get all the vsx state, you need to call
- * the fp and VMX calls as well.  This only get/sets the lower 32
- * 128bit VSX registers.
- */
-
-static int vsr_active(struct task_struct *target,
-		      const struct user_regset *regset)
-{
-	flush_vsx_to_thread(target);
-	return target->thread.used_vsr ? regset->n : 0;
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last
- * checkpointed value of all FPR registers for the current
- * transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	vsx[32];
- * };
- */
-static int vsr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-	u64 buf[32];
-	int ret, i;
-
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
-	flush_vsx_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  buf, 0, 32 * sizeof(double));
-
-	return ret;
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last
- * checkpointed value of all FPR registers for the current
- * transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	vsx[32];
- * };
- */
-static int vsr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
-{
-	u64 buf[32];
-	int ret,i;
-
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
-	flush_vsx_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 buf, 0, 32 * sizeof(double));
-	if (!ret)
-		for (i = 0; i < 32 ; i++)
-			target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-
-	return ret;
-}
-#endif /* CONFIG_VSX */
-
 #ifdef CONFIG_SPE
 
 /*
-- 
2.25.0

