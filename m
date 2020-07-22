Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F15C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210A52068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zaV+teOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgGVPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732942AbgGVPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A686C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tx4qoiH3PUHFWV8+AgjV+uBCV7VzasfH+zR58zkiQYE=; b=zaV+teOtuhACm+rJ1S15JKxAsL
        U4Bi+pJ28ifqWFQdjntYTFOQ7FvplV3AJ35T3XHDu4RJkscKGlhS51WO2LG/UUyfMNzy5LSatu+dD
        7Dl8qEAiBQoow3ro1LW60fP5b0HUh/ZklpQubvF7nJZl44Xriou2FX9xDpl5UyWyMexlM4V8PBLJu
        A1zqj+L7P4CRWWfTwCoYPuiHWNnvYmltYs/SEhFxRAONU+nsfYz6gVM93sOPaRLsJjBpQdVu4ylYu
        DjcF7g9UFd3bC9hCkROSxuZWITWnlp2Fs9EWfo3ToBbWLDuByVbqak3+ywkFlxlIdxTnyY30MPUTO
        zhJiVxjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjv-0007rZ-GA; Wed, 22 Jul 2020 15:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9039B306FFE;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 446D5200D4172; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722153017.164499573@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 3/9] irq_work: Optimize irq_work_single()
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trade one atomic op for a full memory barrier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irqflags.h |    8 ++++----
 kernel/irq_work.c        |   29 +++++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -88,14 +88,14 @@ do {						\
 		  current->irq_config = 0;			\
 	  } while (0)
 
-# define lockdep_irq_work_enter(__work)					\
+# define lockdep_irq_work_enter(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 1;			\
 	  } while (0)
-# define lockdep_irq_work_exit(__work)					\
+# define lockdep_irq_work_exit(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 0;			\
 	  } while (0)
 
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -34,7 +34,7 @@ static bool irq_work_claim(struct irq_wo
 	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
-	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
+	 * The pairing smp_mb() in irq_work_single() makes sure
 	 * everything we did before is visible.
 	 */
 	if (oflags & IRQ_WORK_PENDING)
@@ -136,22 +136,27 @@ void irq_work_single(void *arg)
 	int flags;
 
 	/*
-	 * Clear the PENDING bit, after this point the @work
-	 * can be re-used.
-	 * Make it immediately visible so that other CPUs trying
-	 * to claim that work don't rely on us to handle their data
-	 * while we are in the middle of the func.
+	 * Clear the PENDING bit, after this point the @work can be re-used.
+	 * The PENDING bit acts as a lock, and we own it, so we can clear it
+	 * without atomic ops.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
+	flags = atomic_read(&work->node.a_flags);
+	flags &= ~IRQ_WORK_PENDING;
+	atomic_set(&work->node.a_flags, flags);
+
+	/*
+	 * See irq_work_claim().
+	 */
+	smp_mb();
 
-	lockdep_irq_work_enter(work);
+	lockdep_irq_work_enter(flags);
 	work->func(work);
-	lockdep_irq_work_exit(work);
+	lockdep_irq_work_exit(flags);
+
 	/*
-	 * Clear the BUSY bit and return to the free state if
-	 * no-one else claimed it meanwhile.
+	 * Clear the BUSY bit, if set, and return to the free state if no-one
+	 * else claimed it meanwhile.
 	 */
-	flags &= ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 


