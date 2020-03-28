Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B5C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F4620723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgC1LAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55531 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC1LAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C3-0003cU-G8; Sat, 28 Mar 2020 11:59:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 174471C0483;
        Sat, 28 Mar 2020 11:59:59 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:58 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: kill get_user_{try,catch,ex}
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319874.28353.518154111372597104.tip-bot2@tip-bot2>
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

Commit-ID:     77f3c6166ddc7567455b244074b3ebb63862b56f
Gitweb:        https://git.kernel.org/tip/77f3c6166ddc7567455b244074b3ebb63862b56f
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 13:26:51 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:35:35 -04:00

x86: kill get_user_{try,catch,ex}

no users left

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/uaccess.h | 54 +---------------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1cfa33b..4dc5acc 100644
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
 
