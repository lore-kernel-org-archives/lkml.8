Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02381208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtYtwDCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbgE0Pxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390394AbgE0PwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:52:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E0C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=odP3stPmOZOoMjCjPPJsvRCJXoVaH54qLCzDu3GZ0VI=; b=AtYtwDCspmyCyvnftoNvgyBBz6
        jX3bHZwQQDO2N76RhAv8X6f+8hh7T4uhcYERE885GbwaQwk9owFj5mCQJxvlX5zI+1VEcZ91NRZgR
        YSAT7+nnyKdSGEBOg19/dD1KAps4QQBtLrYbmsjXl2BEdcJYRK3B1oqVDCyV1OCu4MerSy1PJtgW0
        RBVKKEMQ/ICiAnOk1VYfxybBuPcR/fOz6hT3AfUY/EqLuATANuipmF0kRXMhgC1tjf66/B+hd8k1q
        hvJw81QJLQuE6k8L9WVfiOjIHRnitn5qVTjJSh0p1uTiOPFpcK7+dUyO/r7/stSJHRqHYz0rhq4Rn
        Ggxv4GlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdyLQ-0001tv-JO; Wed, 27 May 2020 15:51:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E1883079B8;
        Wed, 27 May 2020 17:51:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0142201479A7; Wed, 27 May 2020 17:51:49 +0200 (CEST)
Message-ID: <20200527155003.407192056@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 May 2020 17:45:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 5/6] lockdep: Prepare for NMI IRQ state tracking
References: <20200527154527.233385756@infradead.org>
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
 kernel/locking/lockdep.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3646,7 +3646,12 @@ static void __trace_hardirqs_on_caller(v
  */
 void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	/*
+	 * Even though NMIs can happen while in lockdep; we only call this
+	 * then the NMI returns to an IRQs enabled context, which guarantees
+	 * we're not in lockdep.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -3682,9 +3687,11 @@ void lockdep_hardirqs_on_prepare(unsigne
 
 	current->hardirq_chain_key = current->curr_chain_key;
 
-	current->lockdep_recursion++;
-	__trace_hardirqs_on_caller();
-	lockdep_recursion_finish();
+	if (!in_nmi()) {
+		current->lockdep_recursion++;
+		__trace_hardirqs_on_caller();
+		lockdep_recursion_finish();
+	}
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
@@ -3692,7 +3699,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
@@ -3735,8 +3742,10 @@ void noinstr lockdep_hardirqs_off(unsign
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
-		return;
+	/*
+	 * Can't test recursion; NMIs can happen while in lockdep.
+	 * Harmless though; all we do is clear hardirqs_enabled.
+	 */
 
 	/*
 	 * So we're supposed to get called after you mask local IRQs, but for


