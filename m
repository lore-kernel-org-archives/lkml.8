Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC159C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39ED21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M0uKCWNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBZNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:21:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgBZNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QkkzX/tuVP1Ba8wqck7KvV7FsmKeJNx2lhKIiv2qRmY=; b=M0uKCWNAzqDxteCkykLkwBOgtX
        vrl6ynGXqz4FhQA+m65tf+weg2JzoRAs0/x0/fZ0BLbkiFh4eZP886pxfFwbp6vFUktyGiMIuu2p9
        uHJg/dE69xotoWJyIcSYfqi/6GwPj3naW6Xcl7v+Xe9JUPaPMmJBZ2NopfKB45S8xXkfvZr9+urbD
        osuXOr4SgR7A8erHsdJVQDzTxgFyr7fd7e0SuxNhLhyjmeMF7Db7Y+WrlVPBIo5zzXDQJiFKGX0o+
        gFguD1EoGDZpEUuQTd8/Yr63An1/XYFzW+5D1lO4+CyiWxtTm5/vwtTE0ZETccE7SghPSoHchZtx/
        Nl9OLOrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6wd5-0005Vp-1X; Wed, 26 Feb 2020 13:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A080305EFE;
        Wed, 26 Feb 2020 14:19:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE5902B264904; Wed, 26 Feb 2020 14:21:33 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org
Subject: [PATCH v2] mm: Fix use_mm() vs TLB invalidate
Message-ID: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
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
v2 now with WARN_ON_ONCE

 mmu_context.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/mm/mmu_context.c
===================================================================
--- linux-2.6.orig/mm/mmu_context.c
+++ linux-2.6/mm/mmu_context.c
@@ -24,14 +24,19 @@ void use_mm(struct mm_struct *mm)
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
 
+	WARN_ON(!(tsk->flags & PF_KTHREAD));
+	WARN_ON(tsk->mm != NULL);
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
 
+	WARN_ON(!(tsk->flags & PF_KTHREAD));
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
