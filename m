Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72EC2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgFCRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgFCRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C16C08C5C2;
        Wed,  3 Jun 2020 10:50:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX5-0005yE-HD; Wed, 03 Jun 2020 19:50:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23D671C032F;
        Wed,  3 Jun 2020 19:50:31 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:30 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: __always_inline arch_atomic_* for noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.070166551@infradead.org>
References: <20200603114052.070166551@infradead.org>
MIME-Version: 1.0
Message-ID: <159120663098.17951.4504058893590117947.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c74809a9760f0d0c80ebe4e6ddcc9aebba9d90bc
Gitweb:        https://git.kernel.org/tip/c74809a9760f0d0c80ebe4e6ddcc9aebba9d90bc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:37 +02:00

x86/entry: __always_inline arch_atomic_* for noinstr

vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x33: call to arch_atomic_and.constprop.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.070166551@infradead.org

---
 arch/x86/include/asm/atomic.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index a9ae588..bf35e47 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -205,13 +205,13 @@ static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int n
 }
 #define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
-static inline int arch_atomic_xchg(atomic_t *v, int new)
+static __always_inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	return arch_xchg(&v->counter, new);
 }
 #define arch_atomic_xchg arch_atomic_xchg
 
-static inline void arch_atomic_and(int i, atomic_t *v)
+static __always_inline void arch_atomic_and(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "andl %1,%0"
 			: "+m" (v->counter)
@@ -219,7 +219,7 @@ static inline void arch_atomic_and(int i, atomic_t *v)
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_and(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 
@@ -229,7 +229,7 @@ static inline int arch_atomic_fetch_and(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_and arch_atomic_fetch_and
 
-static inline void arch_atomic_or(int i, atomic_t *v)
+static __always_inline void arch_atomic_or(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "orl %1,%0"
 			: "+m" (v->counter)
@@ -237,7 +237,7 @@ static inline void arch_atomic_or(int i, atomic_t *v)
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_or(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 
@@ -247,7 +247,7 @@ static inline int arch_atomic_fetch_or(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_or arch_atomic_fetch_or
 
-static inline void arch_atomic_xor(int i, atomic_t *v)
+static __always_inline void arch_atomic_xor(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "xorl %1,%0"
 			: "+m" (v->counter)
@@ -255,7 +255,7 @@ static inline void arch_atomic_xor(int i, atomic_t *v)
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 
