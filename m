Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D43C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D795C207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipz3LQxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBULLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:11:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgBULLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SVjfyIXphMvz+0mMh2uVsdtbFsbq7Vh0uLErS6TwfLs=; b=ipz3LQxmil6VBbX0LjxdZNhiF5
        v38HWarRPxD1CofLKUZxD5lS3+lDbjcq+GC7UOmOoTt0W+PnyGRuqbU6nxV2xXuDG40IbX8Co1cLx
        zwdL/d2zAE3KhbmLhTIWsiIQaK+srz4oJx+CGOprfIdPdAUoNTOIXuoDzwI3C9FoNQMSZNbTZyEVK
        Z7e21zLAxB8xvWOQRfqxWwbQG2idydm3HZcNHz0sDibMYuvrwJ8jTU2YnHIpkW1luU+6T21L503gs
        pcpeL5VoNB+1PydwXZtam8v9BD4VF8b06qhSCWlcMaBHQj/jxUfqUr9vQsXQTqCkiip/SPrNNvJTJ
        Lb/b8tRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j56Dc-00032d-IN; Fri, 21 Feb 2020 11:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A7730220B;
        Fri, 21 Feb 2020 12:09:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A735620254E68; Fri, 21 Feb 2020 12:11:38 +0100 (CET)
Date:   Fri, 21 Feb 2020 12:11:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org
Subject: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
Message-ID: <20200221111138.GX14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For SMP systems using IPI based TLB invalidation, looking at
current->active_mm is entirely reasonable. This then presents the
following race condition:


  CPU0			CPU1

  flush_tlb_mm(mm)	use_mm(mm)
    <send-IPI>
			  tsk->active_mm = mm;
			  <IPI>
			    if (tsk->active_mm == mm)
			      // flush TLBs
			  </IPI>
			  switch_mm(old_mm,mm,tsk);


Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
because the IPI lands before we actually switched.

Avoid this by disabling IRQs across changing ->active_mm and
switch_mm().

[ There are all sorts of reasons this might be harmless for various
architecture specific reasons, but best not leave the door open at
all. ]

Cc: stable@kernel.org
Reported-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Index: linux-2.6/mm/mmu_context.c
===================================================================
--- linux-2.6.orig/mm/mmu_context.c
+++ linux-2.6/mm/mmu_context.c
@@ -24,14 +24,19 @@ void use_mm(struct mm_struct *mm)
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
 
+	BUG_ON(!(tsk->flags & PF_KTHREAD));
+	BUG_ON(tsk->mm != NULL);
+
 	task_lock(tsk);
+	local_irq_disable();
 	active_mm = tsk->active_mm;
 	if (active_mm != mm) {
 		mmgrab(mm);
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
-	switch_mm(active_mm, mm, tsk);
+	switch_mm_irqs_off(active_mm, mm, tsk);
+	local_irq_enable();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
@@ -54,11 +59,15 @@ void unuse_mm(struct mm_struct *mm)
 {
 	struct task_struct *tsk = current;
 
+	BUG_ON(!(tsk->flags & PF_KTHREAD));
+
 	task_lock(tsk);
 	sync_mm_rss(mm);
+	local_irq_disable();
 	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
+	local_irq_enable();
 	task_unlock(tsk);
 }
 EXPORT_SYMBOL_GPL(unuse_mm);
