Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF94C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A520737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4fY2fVh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oP+5EMFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGWKnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgGWKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:42 -0400
Date:   Thu, 23 Jul 2020 10:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjRMxxMM9TBa/UfITkjAyJ00bWb8BxFGRi6jwcVsxJ8=;
        b=e4fY2fVh7a+XqFiqztPwF/iU0vDVLBeo0owX7auSh3J6nLWMKhS3mA8XQCJGOG952xhwui
        bfJza2P2bpGoGAhDyK1HTQMudRov8oTTICPhKUXFW7qaf0mO1JmYkBNBRewx60+dyyt9k0
        6ilV+LFIu3KFz7EUv3iR7sGO4pEfW4QYOwLMsZQdNEFnl2YqTpjkDz9FJT9iBEiUMxH8Aa
        hzw5mV9xiVVlb8GydAXxcohSOsfoWqKR7en+g8RgSRZ7/rbHvEzu4+DGCf7bPtSUdju/p4
        UNSlIPJvw/15EOuFhnY5yngPEqUSrZPKsgY/Y7DB+t2MMmJ2T+YzGG74Upm7Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjRMxxMM9TBa/UfITkjAyJ00bWb8BxFGRi6jwcVsxJ8=;
        b=oP+5EMFMQpVPMz9Xzfxcao73BjjVhxYbXJSkBC43zwqdrpSH/3W6LjAwvQsxzsLmTURIIT
        aZ6CjrQqEGlg+UDg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Remove unused PER_CPU() macro
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-11-ndesaulniers@google.com>
References: <20200720204925.3654302-11-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550101949.4006.12408546212089697314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4719ffecbb0659faf1fd39f4b8eb2674f0042890
Gitweb:        https://git.kernel.org/tip/4719ffecbb0659faf1fd39f4b8eb2674f0042890
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:24 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:43 +02:00

x86/percpu: Remove unused PER_CPU() macro

Also remove now unused __percpu_mov_op.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-11-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cf2b9c2..a3c33b7 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,33 +4,15 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
-#define __percpu_mov_op		movq
 #else
 #define __percpu_seg		fs
-#define __percpu_mov_op		movl
 #endif
 
 #ifdef __ASSEMBLY__
 
-/*
- * PER_CPU finds an address of a per-cpu variable.
- *
- * Args:
- *    var - variable name
- *    reg - 32bit register
- *
- * The resulting address is stored in the "reg" argument.
- *
- * Example:
- *    PER_CPU(cpu_gdt_descr, %ebx)
- */
 #ifdef CONFIG_SMP
-#define PER_CPU(var, reg)						\
-	__percpu_mov_op %__percpu_seg:this_cpu_off, reg;		\
-	lea var(reg), reg
 #define PER_CPU_VAR(var)	%__percpu_seg:var
 #else /* ! SMP */
-#define PER_CPU(var, reg)	__percpu_mov_op $var, reg
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
