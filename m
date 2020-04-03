Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABCCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A7E206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+cOTbRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgDCXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:16:29 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:52006 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgDCXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:16:28 -0400
Received: by mail-pj1-f73.google.com with SMTP id q10so8023041pja.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=luXTGhq6OQLi5VsHgIyxUs88AaI8Ib2h5O78LnnQDP0=;
        b=T+cOTbRAfMTwp8LeIgu8wZuUjspP7qaifcwkc46gd7Np9Pzh4Z+VBxfY0wRvhtQqc+
         K/RJIy15f+wz9LVPRNbvXG3p5J28QhmrlR/QY9XZS7BIJPbCmbNtLjm2eESC+PUUZxTb
         SU7n7DYv5tREfboE4XahyeJSBp9LxolThXCNF/9olHEtbXlIg5/0CB+1EVKf33P+9CyJ
         TaVaOCVcz8d0KzF75dnmYdYAJgV2JMvGdj/6IthSO+/VhnJBuNpiSH8xzGZrj8fga1Xr
         um/2rBVW1QItp5NJ53P310NqOON1aIwmYyL0Nx0/vVwX+LjBeolgXuqEKUMuc1zrKIw/
         nfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luXTGhq6OQLi5VsHgIyxUs88AaI8Ib2h5O78LnnQDP0=;
        b=J+LBOlU7Wt+rsyQw+7OfMpokClQCWQYqIcDNQ80ZkPDQJGSQu1bWlAmFFgEwrKtmhB
         cyI0HeOHmzz88lGnzaLNYz8vBU8n9fB83KkNeK+JtVscGhBBKunAGlkfxYe1kUEIbsv8
         XKnktd4BtUd8pcJGIAVyTyvX/S5Sqn0RN4m8JgH6vucaM76y+97BlZKhklxnbWY8Um9w
         AEdQUAay2goYDG2C/yWRwDLi/9l4Wl857ss/RjYz7Jq57qpSwQ2J+9AVvh9gW6y67yDW
         q6daeyNkug0JPLX0poxNLDUZmxL6Sec1GBMW1RbacewsaRMyZO9hpFz4hAuYqpzXdMXC
         J54A==
X-Gm-Message-State: AGi0PuaqFtFV5orLXC7chjOFKpDtaUTP8Zp9AWNCNF94Pkvo60c83rlg
        zCXg051qOjLQlXyI8bxZVvTm7EZK/oFOzDzubFs=
X-Google-Smtp-Source: APiQypITPz8jjP0H68cy1r2v0nHwRcZw90VxWHxiIZzpbekgGTUn5elg/JVRllp+dZjhLYiGxgVbF/Vkk4KDJyNdXpI=
X-Received: by 2002:a17:90a:2226:: with SMTP id c35mr12984311pje.2.1585955785901;
 Fri, 03 Apr 2020 16:16:25 -0700 (PDT)
Date:   Fri,  3 Apr 2020 16:16:06 -0700
In-Reply-To: <20200324220830.110002-1-ndesaulniers@google.com>
Message-Id: <20200403231611.81444-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200324220830.110002-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v2] x86: signal: move save_altstack_ex out of generic headers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
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

Linus noted that unsafe_save_altstack() only has callsites in the
arch-specific arch/x86/kernel/signal.c, and shouldn't be defined in arch
independent headers.

Split the logic of unsafe_save_altstack() into two, and move the definitions
to arch/x86/include/asm/sigframe.h.  This does less work with the SMAP
guards down.

Link: https://github.com/ClangBuiltLinux/linux/issues/876
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <clang-built-linux@googlegroups.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Rebased on top of
  commit 39f16c1c0f14 ("x86: get rid of put_user_try in {ia32,x32}_setup_rt_frame()")
* went back to macros instead of static inline functions I had in v1.
Note:
Technically, this is a functional change that does more work if we jump
to Efault before calling {__compat|unsafe}_save_altstack, though the
hope is that that is an exceptional case.

 arch/x86/ia32/ia32_signal.c     |  2 ++
 arch/x86/include/asm/sigframe.h | 13 +++++++++++++
 arch/x86/kernel/signal.c        |  4 ++++
 include/linux/compat.h          |  2 --
 include/linux/signal.h          | 10 ----------
 5 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index f9d8804144d0..e18f6d9dc393 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -349,6 +349,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
 	unsafe_put_user(*(__u64 *)set, (__u64 *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
+	reset_altstack();
 
 	if (__copy_siginfo_to_user32(&frame->info, &ksig->info, false))
 		return -EFAULT;
@@ -371,5 +372,6 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	return 0;
 Efault:
 	user_access_end();
+	reset_altstack();
 	return -EFAULT;
 }
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 84eab2724875..67c317b8585d 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,4 +85,17 @@ struct rt_sigframe_x32 {
 
 #endif /* CONFIG_X86_64 */
 
+#define unsafe_save_altstack(uss, sp, label) do { \
+	stack_t __user *__uss = uss; \
+	struct task_struct *t = current; \
+	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
+	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
+	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
+} while (0);
+
+#define reset_altstack() do { \
+	if (current->sas_ss_flags & SS_AUTODISARM) \
+		sas_ss_reset(current); \
+} while (0);
+
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83b74fb38c8f..1e9a900929b3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -416,6 +416,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	return 0;
 Efault:
 	user_access_end();
+	reset_altstack();
 	return -EFAULT;
 }
 #else /* !CONFIG_X86_32 */
@@ -507,6 +508,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 
 Efault:
 	user_access_end();
+	reset_altstack();
 	return -EFAULT;
 }
 #endif /* CONFIG_X86_32 */
@@ -541,6 +543,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
 	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
+	reset_altstack();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		if (__copy_siginfo_to_user32(&frame->info, &ksig->info, true))
@@ -567,6 +570,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 #ifdef CONFIG_X86_X32_ABI
 Efault:
 	user_access_end();
+	reset_altstack();
 	return -EFAULT;
 #endif
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0480ba4db592..f614967374f5 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -461,8 +461,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 			&__uss->ss_sp, label); \
 	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
 } while (0);
 
 /*
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 05bacd2ab135..1732114989f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -444,16 +444,6 @@ void signals_init(void);
 int restore_altstack(const stack_t __user *);
 int __save_altstack(stack_t __user *, unsigned long);
 
-#define unsafe_save_altstack(uss, sp, label) do { \
-	stack_t __user *__uss = uss; \
-	struct task_struct *t = current; \
-	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
-	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
-	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
-} while (0);
-
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
-- 
2.26.0.292.g33ef6b2f38-goog

