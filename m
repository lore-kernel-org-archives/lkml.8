Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802A420679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="idCvMhTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgEVUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbgEVUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:50:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77307C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nJ/ki0NGSa1gL1hmSLbJ87X8HrWKXY+hthWtCDB5YPo=; b=idCvMhTApPfRhcWPcV0AgaC3cb
        jlM9IQC4w00I3KscaUDyPr1hgAJMxQ4LktAWP0WQO2Vb10DfidQSDQTsYmv6iY0Mv/Zpl/w92qlvp
        VMV2VHXUYEncpO2d6xtIZ33zVHhBy+OqjG1Gz7FZgwF7/97DacFyzA9hUPZM8G/Cq8L8Ytv5dVZcW
        yxwuipe3IivmnoNV1TSzoRvUBmrPMDMstPVeQCjS7jOP2ZZ4yU1lsWyA/Ztdc+IYhHNGbdx+yYtw7
        OoWynBAmznZi162zKOmG2dva2GCLmAFiASCoViS2wdOVE3hlboBVvBNTvhms3wNQCuYOk/hX5EGIi
        QICJtF3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcEcA-0000lP-Pr; Fri, 22 May 2020 20:49:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE37A30604B;
        Fri, 22 May 2020 22:49:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE42021462C59; Fri, 22 May 2020 22:49:56 +0200 (CEST)
Message-ID: <20200522204943.236748823@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 May 2020 22:47:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH 1/4] x86/entry: Introduce local_db_{rave,restore}()
References: <20200522204738.645043059@infradead.org>
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
 arch/x86/include/asm/debugreg.h |   23 +++++++++++++++++++++++
 arch/x86/kernel/traps.c         |   18 ++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -113,6 +113,29 @@ static inline void debug_stack_usage_inc
 static inline void debug_stack_usage_dec(void) { }
 #endif /* X86_64 */
 
+static __always_inline void local_db_save(unsigned long *dr7)
+{
+	get_debugreg(*dr7, 7);
+	set_debugreg(0, 7);
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
+	set_debugreg(dr7, 7);
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


