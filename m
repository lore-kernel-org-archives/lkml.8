Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B91C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DF020716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgC1LBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:01:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1K74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9Bx-0003ZY-BT; Sat, 28 Mar 2020 11:59:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DC6B21C03A9;
        Sat, 28 Mar 2020 11:59:52 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:52 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] kill uaccess_try()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319244.28353.11186344035492827549.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cf122cfba5b1d9daf64009d143f51dfec4b1705a
Gitweb:        https://git.kernel.org/tip/cf122cfba5b1d9daf64009d143f51dfec4b1705a
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 21:10:25 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 15:02:14 -04:00

kill uaccess_try()

finally

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/x86/exception-tables.rst |  6 +--
 arch/x86/include/asm/asm.h             |  6 +--
 arch/x86/include/asm/processor.h       |  1 +-
 arch/x86/include/asm/uaccess.h         | 65 +-------------------------
 arch/x86/mm/extable.c                  | 12 +-----
 5 files changed, 90 deletions(-)

diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
index ed6d4b0..514f518 100644
--- a/Documentation/x86/exception-tables.rst
+++ b/Documentation/x86/exception-tables.rst
@@ -337,10 +337,4 @@ pointer which points to one of:
      entry->insn. It is used to distinguish page faults from machine
      check.
 
-3) ``int ex_handler_ext(const struct exception_table_entry *fixup)``
-     This case is used for uaccess_err ... we need to set a flag
-     in the task structure. Before the handler functions existed this
-     case was handled by adding a large offset to the fixup to tag
-     it as special.
-
 More functions can easily be added.
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cd339b8..0f63585 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,9 +138,6 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_EXTABLE_EX(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
-
 # define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
@@ -166,9 +163,6 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_EXTABLE_EX(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
-
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 #endif
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 09705cc..19718fc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -541,7 +541,6 @@ struct thread_struct {
 	mm_segment_t		addr_limit;
 
 	unsigned int		sig_on_uaccess_err:1;
-	unsigned int		uaccess_err:1;	/* uaccess failed */
 
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 4dc5acc..d11662f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -193,23 +193,12 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 		     : : "A" (x), "r" (addr)			\
 		     : : label)
 
-#define __put_user_asm_ex_u64(x, addr)					\
-	asm volatile("\n"						\
-		     "1:	movl %%eax,0(%1)\n"			\
-		     "2:	movl %%edx,4(%1)\n"			\
-		     "3:"						\
-		     _ASM_EXTABLE_EX(1b, 2b)				\
-		     _ASM_EXTABLE_EX(2b, 3b)				\
-		     : : "A" (x), "r" (addr))
-
 #define __put_user_x8(x, ptr, __ret_pu)				\
 	asm volatile("call __put_user_8" : "=a" (__ret_pu)	\
 		     : "A" ((typeof(*(ptr)))(x)), "c" (ptr) : "ebx")
 #else
 #define __put_user_goto_u64(x, ptr, label) \
 	__put_user_goto(x, ptr, "q", "", "er", label)
-#define __put_user_asm_ex_u64(x, addr)	\
-	__put_user_asm_ex(x, addr, "q", "", "er")
 #define __put_user_x8(x, ptr, __ret_pu) __put_user_x(8, x, ptr, __ret_pu)
 #endif
 
@@ -289,31 +278,6 @@ do {									\
 	}								\
 } while (0)
 
-/*
- * This doesn't do __uaccess_begin/end - the exception handling
- * around it must do that.
- */
-#define __put_user_size_ex(x, ptr, size)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__put_user_asm_ex(x, ptr, "b", "b", "iq");		\
-		break;							\
-	case 2:								\
-		__put_user_asm_ex(x, ptr, "w", "w", "ir");		\
-		break;							\
-	case 4:								\
-		__put_user_asm_ex(x, ptr, "l", "k", "ir");		\
-		break;							\
-	case 8:								\
-		__put_user_asm_ex_u64((__typeof__(*ptr))(x), ptr);	\
-		break;							\
-	default:							\
-		__put_user_bad();					\
-	}								\
-} while (0)
-
 #ifdef CONFIG_X86_32
 #define __get_user_asm_u64(x, ptr, retval, errret)			\
 ({									\
@@ -430,29 +394,6 @@ struct __large_struct { unsigned long buf[100]; };
 	retval = __put_user_failed(x, addr, itype, rtype, ltype, errret);	\
 } while (0)
 
-#define __put_user_asm_ex(x, addr, itype, rtype, ltype)			\
-	asm volatile("1:	mov"itype" %"rtype"0,%1\n"		\
-		     "2:\n"						\
-		     _ASM_EXTABLE_EX(1b, 2b)				\
-		     : : ltype(x), "m" (__m(addr)))
-
-/*
- * uaccess_try and catch
- */
-#define uaccess_try	do {						\
-	current->thread.uaccess_err = 0;				\
-	__uaccess_begin();						\
-	barrier();
-
-#define uaccess_try_nospec do {						\
-	current->thread.uaccess_err = 0;				\
-	__uaccess_begin_nospec();					\
-
-#define uaccess_catch(err)						\
-	__uaccess_end();						\
-	(err) |= (current->thread.uaccess_err ? -EFAULT : 0);		\
-} while (0)
-
 /**
  * __get_user - Get a simple variable from user space, with less checking.
  * @x:   Variable to store result.
@@ -502,12 +443,6 @@ struct __large_struct { unsigned long buf[100]; };
 #define __put_user(x, ptr)						\
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-#define put_user_try		uaccess_try
-#define put_user_catch(err)	uaccess_catch(err)
-
-#define put_user_ex(x, ptr)						\
-	__put_user_size_ex((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
 extern unsigned long
 copy_from_user_nmi(void *to, const void __user *from, unsigned long n);
 extern __must_check long
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 30bb0bd..b991aa4 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -80,18 +80,6 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
-__visible bool ex_handler_ext(const struct exception_table_entry *fixup,
-			      struct pt_regs *regs, int trapnr,
-			      unsigned long error_code,
-			      unsigned long fault_addr)
-{
-	/* Special hack for uaccess_err */
-	current->thread.uaccess_err = 1;
-	regs->ip = ex_fixup_addr(fixup);
-	return true;
-}
-EXPORT_SYMBOL(ex_handler_ext);
-
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
 				       struct pt_regs *regs, int trapnr,
 				       unsigned long error_code,
