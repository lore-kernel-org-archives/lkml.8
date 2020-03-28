Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B892082E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1LGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55608 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgC1LGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9I9-0003tC-Bv; Sat, 28 Mar 2020 12:06:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E54F31C03A9;
        Sat, 28 Mar 2020 12:06:16 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:16 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86: get rid of user_atomic_cmpxchg_inatomic()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357644.28353.7584105025874912236.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f5544ba712afd1b01dd856c7eecfb5d30beaf920
Gitweb:        https://git.kernel.org/tip/f5544ba712afd1b01dd856c7eecfb5d30beaf920
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Thu, 19 Mar 2020 22:23:48 -04:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:55 -04:00

x86: get rid of user_atomic_cmpxchg_inatomic()

Only one user left; the thing had been made polymorphic back in 2013
for the sake of MPX.  No point keeping it now that MPX is gone.
Convert futex_atomic_cmpxchg_inatomic() to user_access_{begin,end}()
while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h   | 20 ++++++-
 arch/x86/include/asm/uaccess.h | 93 +---------------------------------
 2 files changed, 19 insertions(+), 94 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 5ff7626..f9c0011 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -90,7 +90,25 @@ Efault:
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
index 61d93f0..ea6fc64 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -584,99 +584,6 @@ extern __must_check long strnlen_user(const char __user *str, long n);
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
