Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C207C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DF92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTxflTDq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDWesScZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgG0MqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgG0MqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A15C0619D2;
        Mon, 27 Jul 2020 05:46:21 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncbRjmcaca/NWD1XtdMB7q/SnurjyzrtHTNxgnMGAbk=;
        b=YTxflTDqcrq4BxFLn4XV6Agotgeu5W6BSEaN5uKOcrUgGzcpEpZZ21gLmOOk8aJ7IqoX36
        b5W1NJRAzasy6+F0OUAg10kC1z3w0RsrOKHMNNfb0E3rsq0ldfijNqxt+RUt4Ik4C5N3BM
        PM0Qho7BCmMFVYIVHBECMdL9zrkWF9qszoHooWUNA659ULFSNMlDE/G7J0XsDf0Bmg3kUH
        jQ9qfKk1nBqjTybXls+405ANjgbBOG216SvowPivYa4ky3YPa4lmC/URr6zCjxp4feGrTF
        O26HKuaN9k3ZcXC+2nv+ibAVLytUCPb1zvWzd+W/N+hEvjcnATE4uSuB90gfhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncbRjmcaca/NWD1XtdMB7q/SnurjyzrtHTNxgnMGAbk=;
        b=RDWesScZTLi6kLlkNxA+qRHNqwxGPQDlOkN0OiE9sj1karnicEiRvKP3jaCqFMNY/foUEM
        witIAYiCmC1muBBw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Refactor sync_core() for readability
Cc:     Tony Luck <tony.luck@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727043132.15082-4-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159585397612.4006.5992564516237216042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f69ca629d89d65737537e05308ac531f7bb07d5c
Gitweb:        https://git.kernel.org/tip/f69ca629d89d65737537e05308ac531f7bb07d5c
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Sun, 26 Jul 2020 21:31:31 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:42:06 +02:00

x86/cpu: Refactor sync_core() for readability

Instead of having #ifdef/#endif blocks inside sync_core() for X86_64 and
X86_32, implement the new function iret_to_self() with two versions.

In this manner, avoid having to use even more more #ifdef/#endif blocks
when adding support for SERIALIZE in sync_core().

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727043132.15082-4-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/include/asm/special_insns.h |  1 +-
 arch/x86/include/asm/sync_core.h     | 56 +++++++++++++++------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index eb8e781..59a3e13 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,7 +234,6 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 9c5573f..fdb5b35 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -6,6 +6,37 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
+#ifdef CONFIG_X86_32
+static inline void iret_to_self(void)
+{
+	asm volatile (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $1f\n\t"
+		"iret\n\t"
+		"1:"
+		: ASM_CALL_CONSTRAINT : : "memory");
+}
+#else
+static inline void iret_to_self(void)
+{
+	unsigned int tmp;
+
+	asm volatile (
+		"mov %%ss, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq %%rsp\n\t"
+		"addq $8, (%%rsp)\n\t"
+		"pushfq\n\t"
+		"mov %%cs, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq $1f\n\t"
+		"iretq\n\t"
+		"1:"
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+}
+#endif /* CONFIG_X86_32 */
+
 /*
  * This function forces the icache and prefetched instruction stream to
  * catch up with reality in two very specific cases:
@@ -44,30 +75,7 @@ static inline void sync_core(void)
 	 * Like all of Linux's memory ordering operations, this is a
 	 * compiler barrier as well.
 	 */
-#ifdef CONFIG_X86_32
-	asm volatile (
-		"pushfl\n\t"
-		"pushl %%cs\n\t"
-		"pushl $1f\n\t"
-		"iret\n\t"
-		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
-#else
-	unsigned int tmp;
-
-	asm volatile (
-		"mov %%ss, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq %%rsp\n\t"
-		"addq $8, (%%rsp)\n\t"
-		"pushfq\n\t"
-		"mov %%cs, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq $1f\n\t"
-		"iretq\n\t"
-		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-#endif
+	iret_to_self();
 }
 
 /*
