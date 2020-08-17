Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5001D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GriPZrfj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dwl1bGKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgHQTBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgHQPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB43C061342;
        Mon, 17 Aug 2020 08:47:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597679275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfG3NSVBr4paNKgfERRH/ehgelvWsFkUr80BrGwy6Mk=;
        b=GriPZrfjKricvBzBPPikY9JufpHNUhjPnKW95ucWZr0Tq1MAmPl0CfUtulN/6Kw5eoYcoh
        51cphJnSkjFeM9h8RKbBeKkSVMqAUCwyd/ZwvCS/J839eQAxU47rr4/PU3Jk2wceVb5Ude
        c4GUlgHrXikLqtMOb9yycGwhicW2Xb17f0ToyrdJDc6OAlv7GujU8M7HQAU0VPSQpcYgCB
        N6cQXZ4J7ZyPBpdkrKkvPUOkJdDWujAQPm/U9wcghdDxyddFDI2aW7Faa0fCQvyFq77Ynx
        unN5btYEgPUXrvquG2vUjYPm6JGdLyht5XPkKGSUxBd87R81Hj94vA96x0rFVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597679275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfG3NSVBr4paNKgfERRH/ehgelvWsFkUr80BrGwy6Mk=;
        b=Dwl1bGKO6ziVqSvaMG15cK6cRr8FtGdDfzQ8Gl3Ls3Vpf7D+F2hCrgFdkoEhtpj/YWMSyL
        xWMSxnCiWNwu12Ag==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use SERIALIZE in sync_core() when available
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
References: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159767927411.3192.1923111080573965673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bf9c912f9a649776c2d741310486a6984edaac72
Gitweb:        https://git.kernel.org/tip/bf9c912f9a649776c2d741310486a6984edaac72
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Aug 2020 20:28:33 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 17 Aug 2020 17:23:04 +02:00

x86/cpu: Use SERIALIZE in sync_core() when available

The SERIALIZE instruction gives software a way to force the processor to
complete all modifications to flags, registers and memory from previous
instructions and drain all buffered writes to memory before the next
instruction is fetched and executed. Thus, it serves the purpose of
sync_core(). Use it when available.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/include/asm/special_insns.h |  6 ++++++
 arch/x86/include/asm/sync_core.h     | 26 ++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13..5999b0b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,12 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+static inline void serialize(void)
+{
+	/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
+	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index fdb5b35..4631c0f 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -5,6 +5,7 @@
 #include <linux/preempt.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/special_insns.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
@@ -54,14 +55,23 @@ static inline void iret_to_self(void)
 static inline void sync_core(void)
 {
 	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
-	 * because it works on every CPU, at any CPL (so it's compatible
-	 * with paravirtualization), and it never exits to a hypervisor.
-	 * The only down sides are that it's a bit slow (it seems to be
-	 * a bit more than 2x slower than the fastest options) and that
-	 * it unmasks NMIs.  The "push %cs" is needed because, in
-	 * paravirtual environments, __KERNEL_CS may not be a valid CS
-	 * value when we do IRET directly.
+	 * The SERIALIZE instruction is the most straightforward way to
+	 * do this but it not universally available.
+	 */
+	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
+		serialize();
+		return;
+	}
+
+	/*
+	 * For all other processors, there are quite a few ways to do this.
+	 * IRET-to-self is nice because it works on every CPU, at any CPL
+	 * (so it's compatible with paravirtualization), and it never exits
+	 * to a hypervisor. The only down sides are that it's a bit slow
+	 * (it seems to be a bit more than 2x slower than the fastest
+	 * options) and that it unmasks NMIs.  The "push %cs" is needed
+	 * because, in paravirtual environments, __KERNEL_CS may not be a
+	 * valid CS value when we do IRET directly.
 	 *
 	 * In case NMI unmasking or performance ever becomes a problem,
 	 * the next best option appears to be MOV-to-CR2 and an
