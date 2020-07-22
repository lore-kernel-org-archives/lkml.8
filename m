Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B84C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A67C2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrfQWa46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgGVPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbgGVPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186AC0619DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cPtIt79cO+vEy8blfqLRr3/op8c1wR5WOmTjOqKQcuQ=; b=qrfQWa46RNs2V7Yc67xhAJqPNj
        9M6iND9QkjP3hJM0PS7cwvMQ6hpV4N00fDTd09FptHIuC9uCxzTXum0B54Gv24qPSfPHu+Vo+TSnQ
        7jk5EfuZgfbo1WMag5EhoiE98VvJp9B4eJIj91G4lVqjQUEdOA+Uez8juTl5tjcAaRiw5fEISMhQr
        /qGKLLdBtUUyzoaivr95IuIfr1lTrZjepj25LZjz8FSwHWNJ5ite7jDZs+43sdg8iQHopZtx0YP3x
        S620YltE9IJbVhGuQo6E81bQ50IIo2gxZ2+/6oLFJ62Akdo02osUWocPXvAr0uAPw21BqT+4pldYV
        cincR1OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjy-0007t6-J6; Wed, 22 Jul 2020 15:33:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63490303A02;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 565CA200D4176; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722153017.521229636@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 8/9] smp: Make smp_call_function_single_async() safer
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make smp_call_function_single_async() a safer and more convenient
interface by using an atomic op for setting CSD_FLAG_LOCK. This allows
safe concurrent use of this function as would be expected by the
-EBUSY return value.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/smp.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -297,6 +297,13 @@ static void flush_smp_call_function_queu
 				void *info = csd->info;
 
 				csd_unlock(csd);
+				/*
+				 * Ensures any LOAD of func() will be after
+				 * the above UNLOCK, this guarantees that
+				 * func() will observe any state prior
+				 * to _async() returning -EBUSY.
+				 */
+				smp_mb();
 				func(info);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -397,16 +404,18 @@ EXPORT_SYMBOL(smp_call_function_single);
  * can thus be done from contexts with disabled interrupts.
  *
  * The caller passes his own pre-allocated data structure
- * (ie: embedded in an object) and is responsible for synchronizing it
- * such that the IPIs performed on the @csd are strictly serialized.
+ * and is responsible for it's life-time, it must not be re-used
+ * until csd->node.u_flags == 0.
  *
  * If the function is called with one csd which has not yet been
  * processed by previous call to smp_call_function_single_async(), the
  * function will return immediately with -EBUSY showing that the csd
  * object is still in progress.
  *
- * NOTE: Be careful, there is unfortunately no current debugging facility to
- * validate the correctness of this serialization.
+ * When -EBUSY is returned, any invocation of csd->func() is guaranteed to see
+ * the state prior to this call.
+ *
+ * Also, consider using irq_work_queue_remote() if at all possible.
  */
 int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
@@ -414,13 +423,16 @@ int smp_call_function_single_async(int c
 
 	preempt_disable();
 
-	if (csd->node.u_flags & CSD_FLAG_LOCK) {
+	/*
+	 * We still need RELEASE like semantics, even when the cmpxchg() fails.
+	 * Pairs with the smp_mb() in flush_smp_call_function_queue().
+	 */
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&csd->node.u_flags, 0, CSD_FLAG_LOCK) != 0) {
 		err = -EBUSY;
 		goto out;
 	}
-
-	csd->node.u_flags = CSD_FLAG_LOCK;
-	smp_wmb();
+	/* ctrl-dep orders later stores */
 
 	err = generic_exec_single(cpu, csd);
 


