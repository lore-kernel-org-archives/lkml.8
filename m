Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4CC205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7ndm9MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRLgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgHRL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4EC061345
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tx4qoiH3PUHFWV8+AgjV+uBCV7VzasfH+zR58zkiQYE=; b=O7ndm9MMVR6+8l/JHFpB0qh5mz
        ucZmxwQ6+i2KbGy42XI4B2x9p0kGNuuLiQ1YSAskdjTxiVuYSul59U+ZilN72Cq3BCUFHTkQeZEKW
        gH8JWmrQ8clbg2ENqqczQxbjJwGmZFPTPCWn8H4WpzisS36SWpFyW3SRvSzZikc+RB7ldoj0zUrkG
        QbSKj4n57BWp6NnH2nHcq3nd9ThEcQHVkNHTfcX+YvOcIiDuiP6yguS97nmxv0qDJHrN1+0sutzVj
        eDLxtVQqAGh7wwJxY3Cadd5vUVGKXxya2ERKRdTQ63t032X+j1dBOqPjebLG3wgxQCj5gHpuHalNe
        qKo4SvHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmO-0002AK-5I; Tue, 18 Aug 2020 11:27:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F661301A66;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FB2A200D4C37; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.130676338@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v2 03/10] irq_work: Optimize irq_work_single()
References: <20200818105102.926463950@infradead.org>
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
 


