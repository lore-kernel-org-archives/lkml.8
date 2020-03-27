Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84728C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892B2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgC0CcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgC0CcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHemz-003hR3-Ni; Fri, 27 Mar 2020 02:32:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 04/22] x86: get rid of small constant size cases in raw_copy_{to,from}_user()
Date:   Fri, 27 Mar 2020 02:31:47 +0000
Message-Id: <20200327023205.881896-4-viro@ZenIV.linux.org.uk>
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

Very few call sites where that would be triggered remain, and none
of those is anywhere near hot enough to bother.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/uaccess.h    |  12 -----
 arch/x86/include/asm/uaccess_32.h |  27 ----------
 arch/x86/include/asm/uaccess_64.h | 108 +-------------------------------------
 3 files changed, 2 insertions(+), 145 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ab8eab43a8a2..1cfa33b94a1a 100644
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
index ba2dc1930630..388a40660c7b 100644
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
index 5cd1caa8bc65..bc10e3dc64fe 100644
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
-- 
2.11.0

