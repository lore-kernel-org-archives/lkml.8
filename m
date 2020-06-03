Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9920674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVH/fv2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgFCLnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgFCLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B29C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qNhYv2Y/S8hWOcHSxiTZb5nzE+u9vWtPn8+l4Z+FKJU=; b=KVH/fv2Rc7RkLQNfJ8GmBYq0gg
        lsVwqJnVkpOnDc4HXE3VU7LSY8dMvImrTGZoCf3qf748BDQ2I6ZGmh2Gq8NsbDHEWf6zmbAqJo5YK
        w5HIQubMCyNESBYw5KyHHaMWxQmDmimsC2dpVyU4CJkuCZ5alV5haeFcPlwMRsDp4JhmThJhSo4Y2
        Is9IgBf7pvhmXzzU2R0PjEiszmpGI9KOBaL6a2kectSPxBn05RBn5A4uXcaB9/KBmeqlpa0Kjw6Eo
        P5OT0hLD5BHosYPQ5/8R3Hh6p0L+u7uIxtI5bN3cPsCHhaGaI6q1aPNPNwcZkCriBWGOsCoONZk6+
        bDyDABhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRms-0005oh-Uh; Wed, 03 Jun 2020 11:42:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE803306CDC;
        Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AEE09209DB0C8; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.012171668@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 4/9] x86/entry: __always_inline irqflags for noinstr
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x65: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x5d: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x35: call to arch_local_irq_save() leaves .noinstr.text section
vmlinux.o: warning: objtool: check_preemption_disabled()+0x31: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: check_preemption_disabled()+0x33: call to arch_irqs_disabled_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x2f: call to native_irq_disable() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irqflags.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -17,7 +17,7 @@
 
 /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
 extern inline unsigned long native_save_fl(void);
-extern inline unsigned long native_save_fl(void)
+extern __always_inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
 
@@ -44,12 +44,12 @@ extern inline void native_restore_fl(uns
 		     :"memory", "cc");
 }
 
-static inline void native_irq_disable(void)
+static __always_inline void native_irq_disable(void)
 {
 	asm volatile("cli": : :"memory");
 }
 
-static inline void native_irq_enable(void)
+static __always_inline void native_irq_enable(void)
 {
 	asm volatile("sti": : :"memory");
 }
@@ -74,22 +74,22 @@ static inline __cpuidle void native_halt
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return native_save_fl();
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long flags)
+static __always_inline void arch_local_irq_restore(unsigned long flags)
 {
 	native_restore_fl(flags);
 }
 
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
 	native_irq_disable();
 }
 
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
 	native_irq_enable();
 }
@@ -115,7 +115,7 @@ static inline __cpuidle void halt(void)
 /*
  * For spinlocks, etc:
  */
-static inline notrace unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags = arch_local_save_flags();
 	arch_local_irq_disable();
@@ -159,12 +159,12 @@ static inline notrace unsigned long arch
 #endif /* CONFIG_PARAVIRT_XXL */
 
 #ifndef __ASSEMBLY__
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static __always_inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & X86_EFLAGS_IF);
 }
 
-static inline int arch_irqs_disabled(void)
+static __always_inline int arch_irqs_disabled(void)
 {
 	unsigned long flags = arch_local_save_flags();
 


