Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF337C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEC920723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgC1LGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgC1LGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IA-0003tS-9U; Sat, 28 Mar 2020 12:06:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D983E1C03A9;
        Sat, 28 Mar 2020 12:06:17 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:17 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86: don't reload after cmpxchg in
 unsafe_atomic_op2() loop
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357755.28353.1367590741418303273.tip-bot2@tip-bot2>
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

Commit-ID:     8aef36dacb3a932cb77da8bb7eb21a154babd0b8
Gitweb:        https://git.kernel.org/tip/8aef36dacb3a932cb77da8bb7eb21a154babd0b8
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Thu, 26 Mar 2020 17:34:40 -04:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:54 -04:00

x86: don't reload after cmpxchg in unsafe_atomic_op2() loop

lock cmpxchg leaves the current value in eax; no need to reload it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 53c07ab..5ff7626 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -34,17 +34,17 @@ do {								\
 do {								\
 	int oldval = 0, ret, tem;				\
 	asm volatile("1:\tmovl	%2, %0\n"			\
-		     "\tmovl\t%0, %3\n"				\
+		     "2:\tmovl\t%0, %3\n"			\
 		     "\t" insn "\n"				\
-		     "2:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
-		     "\tjnz\t1b\n"				\
-		     "3:\n"					\
+		     "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
+		     "\tjnz\t2b\n"				\
+		     "4:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
-		     "4:\tmov\t%5, %1\n"			\
-		     "\tjmp\t3b\n"				\
+		     "5:\tmov\t%5, %1\n"			\
+		     "\tjmp\t4b\n"				\
 		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 4b)			\
-		     _ASM_EXTABLE_UA(2b, 4b)			\
+		     _ASM_EXTABLE_UA(1b, 5b)			\
+		     _ASM_EXTABLE_UA(3b, 5b)			\
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
