Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62314C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520F72068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgFCRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgFCRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68ECC08C5C0;
        Wed,  3 Jun 2020 10:50:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX4-0005xK-D0; Wed, 03 Jun 2020 19:50:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB3D71C032F;
        Wed,  3 Jun 2020 19:50:29 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:29 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: __always_inline CR2 for noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.243227806@infradead.org>
References: <20200603114052.243227806@infradead.org>
MIME-Version: 1.0
Message-ID: <159120662955.17951.16471094480467341445.tip-bot2@tip-bot2>
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

Commit-ID:     8c4d7f8109431652f469b116f2f4fd6526b01a14
Gitweb:        https://git.kernel.org/tip/8c4d7f8109431652f469b116f2f4fd6526b01a14
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:38 +02:00

x86/entry: __always_inline CR2 for noinstr

vmlinux.o: warning: objtool: exc_page_fault()+0x9: call to read_cr2() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_page_fault()+0x24: call to prefetchw() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_page_fault()+0x21: call to kvm_handle_async_pf.isra.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_nmi()+0x1cc: call to write_cr2() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.243227806@infradead.org

---
 arch/x86/include/asm/kvm_para.h      | 2 +-
 arch/x86/include/asm/processor.h     | 2 +-
 arch/x86/include/asm/special_insns.h | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 118e5c2..f53306d 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -141,7 +141,7 @@ static inline void kvm_disable_steal_time(void)
 	return;
 }
 
-static inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
+static __always_inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	return false;
 }
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3eeaaeb..6945b5c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -822,7 +822,7 @@ static inline void prefetch(const void *x)
  * Useful for spinlocks to avoid one state transition in the
  * cache coherency protocol:
  */
-static inline void prefetchw(const void *x)
+static __always_inline void prefetchw(const void *x)
 {
 	alternative_input(BASE_PREFETCH, "prefetchw %P1",
 			  X86_FEATURE_3DNOWPREFETCH,
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 82436cb..eb8e781 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -28,14 +28,14 @@ static inline unsigned long native_read_cr0(void)
 	return val;
 }
 
-static inline unsigned long native_read_cr2(void)
+static __always_inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
 	return val;
 }
 
-static inline void native_write_cr2(unsigned long val)
+static __always_inline void native_write_cr2(unsigned long val)
 {
 	asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
 }
@@ -160,12 +160,12 @@ static inline void write_cr0(unsigned long x)
 	native_write_cr0(x);
 }
 
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
 }
 
-static inline void write_cr2(unsigned long x)
+static __always_inline void write_cr2(unsigned long x)
 {
 	native_write_cr2(x);
 }
