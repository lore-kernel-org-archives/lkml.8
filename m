Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8460320723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgC1LAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55582 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgC1LAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9CA-0003ex-QI; Sat, 28 Mar 2020 12:00:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D4D201C04CE;
        Sat, 28 Mar 2020 12:00:00 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:00:00 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: get rid of small constant size cases in
 raw_copy_{to,from}_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539320051.28353.7961284449453218037.tip-bot2@tip-bot2>
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

Commit-ID:     4b842e4e25b12951fa10dedb4bc16bc47e3b850c
Gitweb:        https://git.kernel.org/tip/4b842e4e25b12951fa10dedb4bc16bc47e3b850c
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 11:46:30 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 15:53:25 -04:00

x86: get rid of small constant size cases in raw_copy_{to,from}_user()

Very few call sites where that would be triggered remain, and none
of those is anywhere near hot enough to bother.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/uaccess.h    |  12 +---
 arch/x86/include/asm/uaccess_32.h |  27 +-------
 arch/x86/include/asm/uaccess_64.h | 108 +-----------------------------
 3 files changed, 2 insertions(+), 145 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ab8eab4..1cfa33b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -378,18 +378,6 @@ do {									\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
-#define __get_user_asm_nozero(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile("\n"						\
-		     "1:	mov"itype" %2,%"rtype"1\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %3,%0\n"				\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
-		     : "=r" (err), ltype(x)				\
-		     : "m" (__m(addr)), "i" (errret), "0" (err))
-
 /*
  * This doesn't do __uaccess_begin/end - the exception handling
  * around it must do that.
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index ba2dc19..388a406 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -23,33 +23,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 static __always_inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (__builtin_constant_p(n)) {
-		unsigned long ret;
-
-		switch (n) {
-		case 1:
-			ret = 0;
-			__uaccess_begin_nospec();
-			__get_user_asm_nozero(*(u8 *)to, from, ret,
-					      "b", "b", "=q", 1);
-			__uaccess_end();
-			return ret;
-		case 2:
-			ret = 0;
-			__uaccess_begin_nospec();
-			__get_user_asm_nozero(*(u16 *)to, from, ret,
-					      "w", "w", "=r", 2);
-			__uaccess_end();
-			return ret;
-		case 4:
-			ret = 0;
-			__uaccess_begin_nospec();
-			__get_user_asm_nozero(*(u32 *)to, from, ret,
-					      "l", "k", "=r", 4);
-			__uaccess_end();
-			return ret;
-		}
-	}
 	return __copy_user_ll(to, (__force const void *)from, n);
 }
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 5cd1caa..bc10e3d 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -65,117 +65,13 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
-	int ret = 0;
-
-	if (!__builtin_constant_p(size))
-		return copy_user_generic(dst, (__force void *)src, size);
-	switch (size) {
-	case 1:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u8 *)dst, (u8 __user *)src,
-			      ret, "b", "b", "=q", 1);
-		__uaccess_end();
-		return ret;
-	case 2:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u16 *)dst, (u16 __user *)src,
-			      ret, "w", "w", "=r", 2);
-		__uaccess_end();
-		return ret;
-	case 4:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u32 *)dst, (u32 __user *)src,
-			      ret, "l", "k", "=r", 4);
-		__uaccess_end();
-		return ret;
-	case 8:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			      ret, "q", "", "=r", 8);
-		__uaccess_end();
-		return ret;
-	case 10:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			       ret, "q", "", "=r", 10);
-		if (likely(!ret))
-			__get_user_asm_nozero(*(u16 *)(8 + (char *)dst),
-				       (u16 __user *)(8 + (char __user *)src),
-				       ret, "w", "w", "=r", 2);
-		__uaccess_end();
-		return ret;
-	case 16:
-		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			       ret, "q", "", "=r", 16);
-		if (likely(!ret))
-			__get_user_asm_nozero(*(u64 *)(8 + (char *)dst),
-				       (u64 __user *)(8 + (char __user *)src),
-				       ret, "q", "", "=r", 8);
-		__uaccess_end();
-		return ret;
-	default:
-		return copy_user_generic(dst, (__force void *)src, size);
-	}
+	return copy_user_generic(dst, (__force void *)src, size);
 }
 
 static __always_inline __must_check unsigned long
 raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 {
-	int ret = 0;
-
-	if (!__builtin_constant_p(size))
-		return copy_user_generic((__force void *)dst, src, size);
-	switch (size) {
-	case 1:
-		__uaccess_begin();
-		__put_user_asm(*(u8 *)src, (u8 __user *)dst,
-			      ret, "b", "b", "iq", 1);
-		__uaccess_end();
-		return ret;
-	case 2:
-		__uaccess_begin();
-		__put_user_asm(*(u16 *)src, (u16 __user *)dst,
-			      ret, "w", "w", "ir", 2);
-		__uaccess_end();
-		return ret;
-	case 4:
-		__uaccess_begin();
-		__put_user_asm(*(u32 *)src, (u32 __user *)dst,
-			      ret, "l", "k", "ir", 4);
-		__uaccess_end();
-		return ret;
-	case 8:
-		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			      ret, "q", "", "er", 8);
-		__uaccess_end();
-		return ret;
-	case 10:
-		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			       ret, "q", "", "er", 10);
-		if (likely(!ret)) {
-			asm("":::"memory");
-			__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
-				       ret, "w", "w", "ir", 2);
-		}
-		__uaccess_end();
-		return ret;
-	case 16:
-		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			       ret, "q", "", "er", 16);
-		if (likely(!ret)) {
-			asm("":::"memory");
-			__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
-				       ret, "q", "", "er", 8);
-		}
-		__uaccess_end();
-		return ret;
-	default:
-		return copy_user_generic((__force void *)dst, src, size);
-	}
+	return copy_user_generic((__force void *)dst, src, size);
 }
 
 static __always_inline __must_check
