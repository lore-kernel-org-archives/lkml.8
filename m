Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D52078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6qhOBpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgCXWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:08:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38260 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:08:38 -0400
Received: by mail-pf1-f202.google.com with SMTP id f14so340395pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VnIQr3MBxwNyixFgi8P0Qi6KFxgZe3JgL+pz4Qnuelg=;
        b=H6qhOBpIaCqmAfrwiudXsn51RgS46CZ3ql0StNelb36ygCFpUuwdW6xIMrhvCVO7Yb
         Hcxl/D7yuzy9s4NQD8muz5HuI3/SyG+oIZ6aD42C0a1AOG3Y45dF5cdpUU3rHbgEEgod
         HQsRIeJ85c0vta+vto632L4dAefjgRhxHdp0K3Cx8ufYJDTPbH0yHIQ64aChjvvzevfW
         t0LU8vgeVLyq9yR8/KkjXex1t3ann2zPA65+LWpa30YaKunHPjVxbulhp7MYLghPnIiQ
         k1LQ7o5JSxKSjAI3NVQyTcr2yn8mcgWJ6wgZinXRmZebwPV5T7/9vsPHtaqjQZrZaqvS
         2ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VnIQr3MBxwNyixFgi8P0Qi6KFxgZe3JgL+pz4Qnuelg=;
        b=k9UoGmfQzWdTdeUQ2BLA/l6n6kEEqkWjSDwDSEWFwhhpYXbGXpYpJc7SRghRJKqzy/
         XVSBaCMJ1cuLXGfCutsFQTQlYozhKFNcWYy3SEYbEQQpBRGtKqHT0YiY8tcvVBTt1m8E
         T83KCfhdcYsXqgDVpbDhnOe+CKBFQ+QE1/l08t0++6kojPiXKAz5CSCIHP6Z9xxtFsPA
         eUuKcy2H9cIpZwmZUTBP8JkWMsptzhzxklt0UbCtuS0vTjO8lJx0w9qeFqQVMOLNcpTw
         BLAPlf+bqWFpw76g6LcxiKxsyuDHGj39fEmHhetM4N7XBY4/yICOUXHLpI69CcnEO3Ci
         kFCg==
X-Gm-Message-State: ANhLgQ0hJyjbbOvYCgAQQhW+lncyf3iKZqCV0Fs9grccrzdi8FZwau2I
        U3Xv4Uar/qIWGO1HFCz9fpdD8Z67ZgXk/Wc2EVM=
X-Google-Smtp-Source: ADFU+vuJkS/dbhJwq40eXWK/Cpfkjxfw7E2yOZ6lr1x1oukykz2w9NRmfbYucwUJbVc4kDvtCkjonP3BqbMwMqATwDo=
X-Received: by 2002:a63:36cd:: with SMTP id d196mr29685923pga.280.1585087714533;
 Tue, 24 Mar 2020 15:08:34 -0700 (PDT)
Date:   Tue, 24 Mar 2020 15:08:25 -0700
Message-Id: <20200324220830.110002-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] x86: signal: move save_altstack_ex out of generic headers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Brian Gerst <brgerst@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations (clang+KASAN), sas_ss_reset() may emit calls to
memset().  This is a problem for SMAP protections on x86, which should
try to minimize calls to any function not already on short whitelist, in
order to prevent leaking AC flags or being used as a gadget.

Linus noted that save_altstack_ex() only has two callsites, in the
arch-specific arch/x86/kernel/signal.c, and shouldn't be defined in arch
independent headers. Move the definitions there, make them static
functions, then split the reset logic out, and move it outside of the
put_user_try/put_user_catch SMAP guards. This does less work with the
SMAP guards down.

Link: https://github.com/ClangBuiltLinux/linux/issues/876
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <clang-built-linux@googlegroups.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Notes to reviewers:
* The macro was maybe nicer since the compat_ versions have different
  type signatures.
* There's still some duplication, and the code could be DRY'er. Thoughts
  on whether to:
  a) move these to arch/x86/include/asm/sigframe.h as static inline
     functions.
  b) move these to a new header as static inline function.
  c) keep them as functions, but non-static, in their own new
     translation unit.
  d) patch is fine as it.
  e) other.


 arch/x86/ia32/ia32_signal.c | 18 +++++++++++++++++-
 arch/x86/kernel/signal.c    | 35 ++++++++++++++++++++++++++++++++---
 include/linux/compat.h      |  9 ---------
 include/linux/signal.h      | 10 ----------
 4 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a3aefe9b9401..dadcc30d1138 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -325,6 +325,21 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	return 0;
 }
 
+static void compat_save_altstack_unsafe(compat_stack_t *uss, unsigned long sp)
+{
+	compat_stack_t __user *__uss = uss;
+	struct task_struct *t = current;
+	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp);
+	put_user_ex(t->sas_ss_flags, &__uss->ss_flags);
+	put_user_ex(t->sas_ss_size, &__uss->ss_size);
+}
+
+static void reset_altstack(void)
+{
+	if (current->sas_ss_flags & SS_AUTODISARM)
+		sas_ss_reset(current);
+}
+
 int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs)
 {
@@ -362,7 +377,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
 		put_user_ex(0, &frame->uc.uc_link);
-		compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+		compat_save_altstack_unsafe(&frame->uc.uc_stack, regs->sp);
 
 		if (ksig->ka.sa.sa_flags & SA_RESTORER)
 			restorer = ksig->ka.sa.sa_restorer;
@@ -377,6 +392,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		 */
 		put_user_ex(*((u64 *)&code), (u64 __user *)frame->retcode);
 	} put_user_catch(err);
+	reset_altstack();
 
 	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
 	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573851a3..03ea56ee86ec 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -213,6 +213,32 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	return err;
 }
 
+#ifdef CONFIG_X86_X32_ABI
+static void compat_save_altstack_unsafe(compat_stack_t *uss, unsigned long sp)
+{
+	compat_stack_t __user *__uss = uss;
+	struct task_struct *t = current;
+	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp);
+	put_user_ex(t->sas_ss_flags, &__uss->ss_flags);
+	put_user_ex(t->sas_ss_size, &__uss->ss_size);
+}
+#endif
+
+static void save_altstack_unsafe(stack_t *uss, unsigned long sp)
+{
+	struct task_struct *t = current;
+	stack_t __user *__uss = uss;
+	put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp);
+	put_user_ex(t->sas_ss_flags, &__uss->ss_flags);
+	put_user_ex(t->sas_ss_size, &__uss->ss_size);
+}
+
+static void reset_altstack(void)
+{
+	if (current->sas_ss_flags & SS_AUTODISARM)
+		sas_ss_reset(current);
+}
+
 /*
  * Set up a signal frame.
  */
@@ -394,7 +420,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
 		put_user_ex(0, &frame->uc.uc_link);
-		save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+		save_altstack_unsafe(&frame->uc.uc_stack, regs->sp);
 
 		/* Set up to return from userspace.  */
 		restorer = current->mm->context.vdso +
@@ -412,6 +438,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		 */
 		put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
 	} put_user_catch(err);
+	reset_altstack();
 	
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
@@ -475,7 +502,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		/* Create the ucontext.  */
 		put_user_ex(uc_flags, &frame->uc.uc_flags);
 		put_user_ex(0, &frame->uc.uc_link);
-		save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+		save_altstack_unsafe(&frame->uc.uc_stack, regs->sp);
 
 		/* Set up to return from userspace.  If provided, use a stub
 		   already in userspace.  */
@@ -487,6 +514,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 			err |= -EFAULT;
 		}
 	} put_user_catch(err);
+	reset_altstack();
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
@@ -560,7 +588,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 		/* Create the ucontext.  */
 		put_user_ex(uc_flags, &frame->uc.uc_flags);
 		put_user_ex(0, &frame->uc.uc_link);
-		compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+		compat_save_altstack_unsafe(&frame->uc.uc_stack, regs->sp);
 		put_user_ex(0, &frame->uc.uc__pad0);
 
 		if (ksig->ka.sa.sa_flags & SA_RESTORER) {
@@ -572,6 +600,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 		}
 		put_user_ex(restorer, (unsigned long __user *)&frame->pretcode);
 	} put_user_catch(err);
+	reset_altstack();
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				regs, set->sig[0]);
diff --git a/include/linux/compat.h b/include/linux/compat.h
index df2475be134a..083a771decb8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -454,15 +454,6 @@ extern void __user *compat_alloc_user_space(unsigned long len);
 
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
-#define compat_save_altstack_ex(uss, sp) do { \
-	compat_stack_t __user *__uss = uss; \
-	struct task_struct *t = current; \
-	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp); \
-	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
-	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
-} while (0);
 
 /*
  * These syscall function prototypes are kept in the same order as
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 1a5f88316b08..1732114989f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -444,16 +444,6 @@ void signals_init(void);
 int restore_altstack(const stack_t __user *);
 int __save_altstack(stack_t __user *, unsigned long);
 
-#define save_altstack_ex(uss, sp) do { \
-	stack_t __user *__uss = uss; \
-	struct task_struct *t = current; \
-	put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
-	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
-	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
-} while (0);
-
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
-- 
2.25.1.696.g5e7596f4ac-goog

