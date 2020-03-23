Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6ABC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23C92072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCWSj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:39:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46696 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxt-00135d-9u; Mon, 23 Mar 2020 18:38:21 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 08/22] x86: kill get_user_{try,catch,ex}
Date:   Mon, 23 Mar 2020 18:38:05 +0000
Message-Id: <20200323183819.250124-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no users left

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/uaccess.h | 54 ------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1cfa33b94a1a..4dc5accdd826 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -335,12 +335,9 @@ do {									\
 		       "i" (errret), "0" (retval));			\
 })
 
-#define __get_user_asm_ex_u64(x, ptr)			(x) = __get_user_bad()
 #else
 #define __get_user_asm_u64(x, ptr, retval, errret) \
 	 __get_user_asm(x, ptr, retval, "q", "", "=r", errret)
-#define __get_user_asm_ex_u64(x, ptr) \
-	 __get_user_asm_ex(x, ptr, "q", "", "=r")
 #endif
 
 #define __get_user_size(x, ptr, size, retval, errret)			\
@@ -378,41 +375,6 @@ do {									\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
-/*
- * This doesn't do __uaccess_begin/end - the exception handling
- * around it must do that.
- */
-#define __get_user_size_ex(x, ptr, size)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__get_user_asm_ex(x, ptr, "b", "b", "=q");		\
-		break;							\
-	case 2:								\
-		__get_user_asm_ex(x, ptr, "w", "w", "=r");		\
-		break;							\
-	case 4:								\
-		__get_user_asm_ex(x, ptr, "l", "k", "=r");		\
-		break;							\
-	case 8:								\
-		__get_user_asm_ex_u64(x, ptr);				\
-		break;							\
-	default:							\
-		(x) = __get_user_bad();					\
-	}								\
-} while (0)
-
-#define __get_user_asm_ex(x, addr, itype, rtype, ltype)			\
-	asm volatile("1:	mov"itype" %1,%"rtype"0\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-                     "3:xor"itype" %"rtype"0,%"rtype"0\n"		\
-		     "  jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_EX(1b, 3b)				\
-		     : ltype(x) : "m" (__m(addr)))
-
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	__label__ __pu_label;					\
@@ -540,22 +502,6 @@ struct __large_struct { unsigned long buf[100]; };
 #define __put_user(x, ptr)						\
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-/*
- * {get|put}_user_try and catch
- *
- * get_user_try {
- *	get_user_ex(...);
- * } get_user_catch(err)
- */
-#define get_user_try		uaccess_try_nospec
-#define get_user_catch(err)	uaccess_catch(err)
-
-#define get_user_ex(x, ptr)	do {					\
-	unsigned long __gue_val;					\
-	__get_user_size_ex((__gue_val), (ptr), (sizeof(*(ptr))));	\
-	(x) = (__force __typeof__(*(ptr)))__gue_val;			\
-} while (0)
-
 #define put_user_try		uaccess_try
 #define put_user_catch(err)	uaccess_catch(err)
 
-- 
2.11.0

