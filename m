Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ECC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF402082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC0C26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:28:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47836 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHeje-003hGI-93; Fri, 27 Mar 2020 02:28:38 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 8/8] x86: get rid of user_atomic_cmpxchg_inatomic()
Date:   Fri, 27 Mar 2020 02:28:36 +0000
Message-Id: <20200327022836.881203-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Only one user left; the thing had been made polymorphic back in 2013
for the sake of MPX.  No point keeping it now that MPX is gone.
Convert futex_atomic_cmpxchg_inatomic() to user_access_{begin,end}()
while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h   | 20 ++++++++-
 arch/x86/include/asm/uaccess.h | 93 ------------------------------------------
 2 files changed, 19 insertions(+), 94 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index d5d36f408ad0..537f58280174 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -90,7 +90,25 @@ static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *o
 static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 						u32 oldval, u32 newval)
 {
-	return user_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval);
+	int ret = 0;
+
+	if (!user_access_begin(uaddr, sizeof(u32)))
+		return -EFAULT;
+	asm volatile("\n"
+		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
+		"2:\n"
+		"\t.section .fixup, \"ax\"\n"
+		"3:\tmov     %3, %0\n"
+		"\tjmp     2b\n"
+		"\t.previous\n"
+		_ASM_EXTABLE_UA(1b, 3b)
+		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "memory"
+	);
+	user_access_end();
+	*uval = oldval;
+	return ret;
 }
 
 #endif
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d11662f753d2..c8247a84244b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -453,99 +453,6 @@ extern __must_check long strnlen_user(const char __user *str, long n);
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
-extern void __cmpxchg_wrong_size(void)
-	__compiletime_error("Bad argument size for cmpxchg");
-
-#define __user_atomic_cmpxchg_inatomic(uval, ptr, old, new, size)	\
-({									\
-	int __ret = 0;							\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__uaccess_begin_nospec();					\
-	switch (size) {							\
-	case 1:								\
-	{								\
-		asm volatile("\n"					\
-			"1:\t" LOCK_PREFIX "cmpxchgb %4, %2\n"		\
-			"2:\n"						\
-			"\t.section .fixup, \"ax\"\n"			\
-			"3:\tmov     %3, %0\n"				\
-			"\tjmp     2b\n"				\
-			"\t.previous\n"					\
-			_ASM_EXTABLE_UA(1b, 3b)				\
-			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
-			: "i" (-EFAULT), "q" (__new), "1" (__old)	\
-			: "memory"					\
-		);							\
-		break;							\
-	}								\
-	case 2:								\
-	{								\
-		asm volatile("\n"					\
-			"1:\t" LOCK_PREFIX "cmpxchgw %4, %2\n"		\
-			"2:\n"						\
-			"\t.section .fixup, \"ax\"\n"			\
-			"3:\tmov     %3, %0\n"				\
-			"\tjmp     2b\n"				\
-			"\t.previous\n"					\
-			_ASM_EXTABLE_UA(1b, 3b)				\
-			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
-			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
-			: "memory"					\
-		);							\
-		break;							\
-	}								\
-	case 4:								\
-	{								\
-		asm volatile("\n"					\
-			"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"		\
-			"2:\n"						\
-			"\t.section .fixup, \"ax\"\n"			\
-			"3:\tmov     %3, %0\n"				\
-			"\tjmp     2b\n"				\
-			"\t.previous\n"					\
-			_ASM_EXTABLE_UA(1b, 3b)				\
-			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
-			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
-			: "memory"					\
-		);							\
-		break;							\
-	}								\
-	case 8:								\
-	{								\
-		if (!IS_ENABLED(CONFIG_X86_64))				\
-			__cmpxchg_wrong_size();				\
-									\
-		asm volatile("\n"					\
-			"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"		\
-			"2:\n"						\
-			"\t.section .fixup, \"ax\"\n"			\
-			"3:\tmov     %3, %0\n"				\
-			"\tjmp     2b\n"				\
-			"\t.previous\n"					\
-			_ASM_EXTABLE_UA(1b, 3b)				\
-			: "+r" (__ret), "=a" (__old), "+m" (*(ptr))	\
-			: "i" (-EFAULT), "r" (__new), "1" (__old)	\
-			: "memory"					\
-		);							\
-		break;							\
-	}								\
-	default:							\
-		__cmpxchg_wrong_size();					\
-	}								\
-	__uaccess_end();						\
-	*(uval) = __old;						\
-	__ret;								\
-})
-
-#define user_atomic_cmpxchg_inatomic(uval, ptr, old, new)		\
-({									\
-	access_ok((ptr), sizeof(*(ptr))) ?		\
-		__user_atomic_cmpxchg_inatomic((uval), (ptr),		\
-				(old), (new), sizeof(*(ptr))) :		\
-		-EFAULT;						\
-})
-
 /*
  * movsl can be slow when source and dest are not both 8-byte aligned
  */
-- 
2.11.0

