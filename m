Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0A320707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lg1OIAs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgFWIjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbgFWIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:39:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75023C061573;
        Tue, 23 Jun 2020 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YNPoha+d8J2Lc5+zyAZdd8COdiF4UhJWzzpElOKIt+Y=; b=lg1OIAs5pOsPBLdq8xFnSRa/75
        QRyillgyOQBJJfElaGLM808BoLX83AFa3hS/WhV7hGjXvx9twNBqTD39QaB8YilZM4bDi11VbcG2z
        Mi+cqF8g9icUSd53Ri5sMMt9KwNLMzOXBsYG0aPzd9PbYB+DoOQHE69JDApSFow2bywCDuH55FWhC
        Rw8syHNrsoCdnJZnPA5H5VGVcDfbiO1sLAL36ESTXlMTkRyqYF5AD/bWu5c28V/brgC9MXfVTb9WC
        uf8DmPZvqAcOm/tQnIvpoPm+ZOZFT8eJAPaL2UODAU4oQXvyFksewGSWI65dOnLoihVp3jNT0uM7t
        iGUrq6zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jneS3-0000fx-Qh; Tue, 23 Jun 2020 08:38:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 952FF307623;
        Tue, 23 Jun 2020 10:38:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE500237095F7; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083721.155449112@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 10:36:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: [PATCH v4 1/8] lockdep: Prepare for NMI IRQ state tracking
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason not to always, accurately, track IRQ state.

This change also makes IRQ state tracking ignore lockdep_off().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3646,7 +3646,16 @@ static void __trace_hardirqs_on_caller(v
  */
 void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs do not (and cannot) track lock dependencies, nothing to do.
+	 */
+	if (unlikely(in_nmi()))
+		return;
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (unlikely(current->hardirqs_enabled)) {
@@ -3692,7 +3701,27 @@ void noinstr lockdep_hardirqs_on(unsigne
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs can happen in the middle of local_irq_{en,dis}able() where the
+	 * tracking state and hardware state are out of sync.
+	 *
+	 * NMIs must save lockdep_hardirqs_enabled() to restore IRQ state from,
+	 * and not rely on hardware state like normal interrupts.
+	 */
+	if (unlikely(in_nmi())) {
+		/*
+		 * Skip:
+		 *  - recursion check, because NMI can hit lockdep;
+		 *  - hardware state check, because above;
+		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
+		 */
+		goto skip_checks;
+	}
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (curr->hardirqs_enabled) {
@@ -3720,6 +3749,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
 			    current->curr_chain_key);
 
+skip_checks:
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
 	curr->hardirq_enable_ip = ip;
@@ -3735,7 +3765,15 @@ void noinstr lockdep_hardirqs_off(unsign
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * Matching lockdep_hardirqs_on(), allow NMIs in the middle of lockdep;
+	 * they will restore the software state. This ensures the software
+	 * state is consistent inside NMIs as well.
+	 */
+	if (unlikely(!in_nmi() && (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)))
 		return;
 
 	/*


