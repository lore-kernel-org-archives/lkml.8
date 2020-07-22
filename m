Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20512077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wJuHu3zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgGVIfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:35:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B9C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QXhlms6z6mxKbNYRQIXcoIbNJvyasfs3bwxG1SAtCHY=; b=wJuHu3zBGTBJWVpH84hmH3QULB
        sF9PokLfw576QGSDpqeNsJnOSiRFKn0szcBhv8AzHEHCYsnTxaUeYScpWhjGH0RVIsvaH/Ov8LU8W
        hcjszoijhfvuv2cZf9KDYvm3Cxoils83GCCe+jnJJkbwrvFTxN/MP30/LFoFCfowzx7ANr3tZlcFr
        mADX8unsGsivvdGlIlYRPMQ+oaSqZ5RjIa8L01bCOa8RZkLc7pUzMK6mJNiJdTKsdpDu2doeZI98R
        rjX28t8UaC5aGNmRJu9Svj0RODMMQPgvnZGeFLAyo7Ylg2gyBRA6mIGX7UfLzYbQnl2jiJGeuHAP3
        0UfBvw9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyADx-0003gp-IC; Wed, 22 Jul 2020 08:35:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34A023060F3;
        Wed, 22 Jul 2020 10:35:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C1D3203DE799; Wed, 22 Jul 2020 10:35:33 +0200 (CEST)
Date:   Wed, 22 Jul 2020 10:35:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org, hch@lst.de, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
Message-ID: <20200722083533.GK10769@hirez.programming.kicks-ass.net>
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
 <20200721140623.4e8ecc6ef5d5ff42115d68fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721140623.4e8ecc6ef5d5ff42115d68fc@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:06:23PM -0700, Andrew Morton wrote:
> On Tue, 21 Jul 2020 17:41:06 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 
> > For SMP systems using IPI based TLB invalidation, looking at
> > current->active_mm is entirely reasonable. This then presents the
> > following race condition:
> > 
> > 
> >   CPU0			CPU1
> > 
> >   flush_tlb_mm(mm)	use_mm(mm)
> >     <send-IPI>
> > 			  tsk->active_mm = mm;
> > 			  <IPI>
> > 			    if (tsk->active_mm == mm)
> > 			      // flush TLBs
> > 			  </IPI>
> > 			  switch_mm(old_mm,mm,tsk);
> > 
> > 
> > Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> > because the IPI lands before we actually switched.
> > 
> > Avoid this by disabling IRQs across changing ->active_mm and
> > switch_mm().
> > 
> > [ There are all sorts of reasons this might be harmless for various
> > architecture specific reasons, but best not leave the door open at
> > all. ]
> 
> Can we give the -stable maintainers (and others) more explanation of
> why they might choose to merge this?

Like so then?

---
Subject: mm: Fix kthread_use_mm() vs TLB invalidate
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 11 Feb 2020 10:25:19 +0100

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

Of the (SMP) architectures that have IPI based TLB invalidate:

  Alpha    - checks active_mm
  ARC      - ASID specific
  IA64     - checks active_mm
  MIPS     - ASID specific flush
  OpenRISC - shoots down world
  PARISC   - shoots down world
  SH       - ASID specific
  SPARC    - ASID specific
  x86      - N/A
  xtensa   - checks active_mm

So at the very least Alpha, IA64 and Xtensa are suspect.

On top of this, for scheduler consistency we need at least preemption
disabled across changing tsk->mm and doing switch_mm(), which is
currently provided by task_lock(), but that's not sufficient for
PREEMPT_RT.

Reported-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 kernel/kthread.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1241,13 +1241,20 @@ void kthread_use_mm(struct mm_struct *mm
 	WARN_ON_ONCE(tsk->mm);
 
 	task_lock(tsk);
+	/*
+	 * Serialize the tsk->mm store and switch_mm() against TLB invalidation
+	 * IPIs. Also make sure we're non-preemptible on PREEMPT_RT to not race
+	 * against the scheduler writing to these variables.
+	 */
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
@@ -1276,9 +1283,11 @@ void kthread_unuse_mm(struct mm_struct *
 
 	task_lock(tsk);
 	sync_mm_rss(mm);
+	local_irq_disable();
 	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
+	local_irq_enable();
 	task_unlock(tsk);
 }
 EXPORT_SYMBOL_GPL(kthread_unuse_mm);
