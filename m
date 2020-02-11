Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A71C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AE32051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBKMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:01:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBKMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:01:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1UEZ-0006en-Q5; Tue, 11 Feb 2020 13:01:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 70E101C2016;
        Tue, 11 Feb 2020 13:01:43 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:01:43 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] arm/patch: Fix !MMU compile
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158142250314.411.6705592121382625135.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7a7a8f549ddd18126dfa3dedbe42d877614c7995
Gitweb:        https://git.kernel.org/tip/7a7a8f549ddd18126dfa3dedbe42d877614c7995
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2020 12:57:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 12:56:27 +01:00

arm/patch: Fix !MMU compile

Now that patch.o is unconditionally selected for ftrace, it can also
get compiled for !MMU kernels. These (obviously) lack
{set,clear}_fixmap() support.

Also remove the superfluous __acquire/__release nonsense.

Fixes: 42e51f187f86 ("arm/ftrace: Use __patch_text()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/kernel/patch.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index d0a05a3..e9e828b 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -16,10 +16,10 @@ struct patch {
 	unsigned int insn;
 };
 
+#ifdef CONFIG_MMU
 static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
-	__acquires(&patch_lock)
 {
 	unsigned int uintaddr = (uintptr_t) addr;
 	bool module = !core_kernel_text(uintaddr);
@@ -34,8 +34,6 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 
 	if (flags)
 		raw_spin_lock_irqsave(&patch_lock, *flags);
-	else
-		__acquire(&patch_lock);
 
 	set_fixmap(fixmap, page_to_phys(page));
 
@@ -43,15 +41,19 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 }
 
 static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
-	__releases(&patch_lock)
 {
 	clear_fixmap(fixmap);
 
 	if (flags)
 		raw_spin_unlock_irqrestore(&patch_lock, *flags);
-	else
-		__release(&patch_lock);
 }
+#else
+static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
+{
+	return addr;
+}
+static void __kprobes patch_unmap(int fixmap, unsigned long *flags) { }
+#endif
 
 void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 {
@@ -64,8 +66,6 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 
 	if (remap)
 		waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
-	else
-		__acquire(&patch_lock);
 
 	if (thumb2 && __opcode_is_thumb16(insn)) {
 		*(u16 *)waddr = __opcode_to_mem_thumb16(insn);
@@ -102,8 +102,7 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 	if (waddr != addr) {
 		flush_kernel_vmap_range(waddr, twopage ? size / 2 : size);
 		patch_unmap(FIX_TEXT_POKE0, &flags);
-	} else
-		__release(&patch_lock);
+	}
 
 	flush_icache_range((uintptr_t)(addr),
 			   (uintptr_t)(addr) + size);
