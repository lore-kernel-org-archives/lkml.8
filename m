Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255FBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CDC2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTdP/zoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407253AbgE1U06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:26:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407016AbgE1U0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UxjfvjgRuchdbQ1Ws3uYJW3D/1z0lF3If9pdqFqKFgU=; b=KTdP/zoV0Gr5w4fObWyACUelOZ
        ju0hCNKdW6KWZYbFQzhCjeu5caSu9zf/AC1wyEy/MDgIWQfGxACCJVB+kAzaMZuyn+gtFGHe8+0/j
        ABz7oRhEluZ/b6X5DjXkAa5FdDCvhfvBt3Q9ioQB36+xiKv9Omq34nB1kHAeiYQpsRm8BbyMMlRiR
        p5I4SxS6gnNmv8By8nRis1tlZLEwtWglJl3COdWIRF3W0rCvLiL1bfXY3a2+pOizvOm55udCHQAqY
        RCEKCebd6aXpqM7vbxPa1ZETa2Ry3CNptUhBxSkHeCYYo70Qj+c0G1sfN1lpogh+kh3l7c8sz0LQn
        2PGvBwLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4m-0003gZ-Sz; Thu, 28 May 2020 20:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E25723012C3;
        Thu, 28 May 2020 22:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CE5C0203B84BB; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528202328.418625592@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org
Subject: [PATCH 1/6] x86/entry: Introduce local_db_{save,restore}()
References: <20200528201937.038455891@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow other exceptions than #DB to disable breakpoints,
provide a common helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/debugreg.h |   25 +++++++++++++++++++++++++
 arch/x86/kernel/traps.c         |   18 ++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -113,6 +113,31 @@ static inline void debug_stack_usage_inc
 static inline void debug_stack_usage_dec(void) { }
 #endif /* X86_64 */
 
+static __always_inline void local_db_save(unsigned long *dr7)
+{
+	get_debugreg(*dr7, 7);
+	if (*dr7)
+		set_debugreg(0, 7);
+	/*
+	 * Ensure the compiler doesn't lower the above statements into
+	 * the critical section; disabling breakpoints late would not
+	 * be good.
+	 */
+	barrier();
+}
+
+static __always_inline void local_db_restore(unsigned long dr7)
+{
+	/*
+	 * Ensure the compiler doesn't raise this statement into
+	 * the critical section; enabling breakpoints early would
+	 * not be good.
+	 */
+	barrier();
+	if (dr7)
+		set_debugreg(dr7, 7);
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern void set_dr_addr_mask(unsigned long mask, int dr);
 #else
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -727,15 +727,7 @@ static __always_inline void debug_enter(
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
 	 */
-	get_debugreg(*dr7, 7);
-	set_debugreg(0, 7);
-
-	/*
-	 * Ensure the compiler doesn't lower the above statements into
-	 * the critical section; disabling breakpoints late would not
-	 * be good.
-	 */
-	barrier();
+	local_db_save(dr7);
 
 	/*
 	 * The Intel SDM says:
@@ -756,13 +748,7 @@ static __always_inline void debug_enter(
 
 static __always_inline void debug_exit(unsigned long dr7)
 {
-	/*
-	 * Ensure the compiler doesn't raise this statement into
-	 * the critical section; enabling breakpoints early would
-	 * not be good.
-	 */
-	barrier();
-	set_debugreg(dr7, 7);
+	local_db_restore(dr7);
 }
 
 /*


