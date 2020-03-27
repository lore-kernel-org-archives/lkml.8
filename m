Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDDC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864792082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgC0CcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48056 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgC0CcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSu-PG; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 22/22] kill uaccess_try()
Date:   Fri, 27 Mar 2020 02:32:05 +0000
Message-Id: <20200327023205.881896-22-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
References: <20200327023007.GS23230@ZenIV.linux.org.uk>
 <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

finally

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/x86/exception-tables.rst |  6 ----
 arch/x86/include/asm/asm.h             |  6 ----
 arch/x86/include/asm/processor.h       |  1 -
 arch/x86/include/asm/uaccess.h         | 65 ----------------------------------
 arch/x86/mm/extable.c                  | 12 -------
 5 files changed, 90 deletions(-)

diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
index ed6d4b0cf62c..514f51829da7 100644
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
index cd339b88d5d4..0f63585edf5f 100644
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
index 09705ccc393c..19718fcfdd6a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -541,7 +541,6 @@ struct thread_struct {
 	mm_segment_t		addr_limit;
 
 	unsigned int		sig_on_uaccess_err:1;
-	unsigned int		uaccess_err:1;	/* uaccess failed */
 
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 4dc5accdd826..d11662f753d2 100644
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
index 30bb0bd3b1b8..b991aa4bdfae 100644
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
-- 
2.11.0

