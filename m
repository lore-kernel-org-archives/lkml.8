Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14FC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01682068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEBxUmUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgGVPda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbgGVPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB5C0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TYbpJTNKNHnKd/yC/27nJi3RjVc3yF+nkyY7wdu/D64=; b=YEBxUmUCw7u36YESQYB2QhsKr/
        DCsUOAeicoyGf17EbheplnEMXQutgvwBKCVtX5+ZAZdL3JINDnPLjX2KDxe1eakWfhm/GdY7ZK1VC
        ltNnyYBeRdIE640HVTJ6NrHdIoJatiaR1NhWfcTUPF+qw5tH5eMJyRN2Ek2iQiI3MUyO+MpqjEJA6
        /c+nY+yKjO5ElLj51eb9zwaSe4Y9ip0BBJ6EwA6Mv02XTjMEBYCTngSbEomeZA3rWkhD0F4ibKUG9
        ZCVvYD9o4QUPJKaX+2oEyooMcD/YrdCpb6sp8sIq33Zph5y+x3LvtSHK+yja9hNY3MzXE8pm2ucv0
        z4fD5z6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjv-0007rb-Gk; Wed, 22 Jul 2020 15:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E89B930768E;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E263200D4173; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722153017.379439644@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 6/9] irq_work: Provide irq_work_queue_remote_static()
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the same horrible semantics provided by
smp_call_function_single_async(), doing so allows skiping a bunch of
atomic ops.

API wise this is horrible crap as it relies on external serialization.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |    1 +
 kernel/irq_work.c        |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -68,6 +68,7 @@ static inline bool irq_work_needs_cpu(vo
 
 #ifdef CONFIG_SMP
 extern int irq_work_queue_remote(int cpu, struct irq_work *work);
+extern int irq_work_queue_remote_static(int cpu, struct irq_work *work);
 extern void irq_work_single(void *arg);
 #endif
 
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -63,6 +63,9 @@ void irq_work_single(void *arg)
 	work->func(work);
 	lockdep_irq_work_exit(flags);
 
+	if (!(flags & IRQ_WORK_BUSY))
+		return;
+
 	/*
 	 * Clear the BUSY bit, if set, and return to the free state if no-one
 	 * else claimed it meanwhile.
@@ -108,6 +111,22 @@ int irq_work_queue_remote(int cpu, struc
 
 	return 0;
 }
+
+int irq_work_queue_remote_static(int cpu, struct irq_work *work)
+{
+	/*
+	 * Ensures preemption is disabled in the caller.
+	 */
+	WARN_ON_ONCE(cpu == smp_processor_id());
+
+	if (atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING)
+		return -EBUSY;
+
+	atomic_set(&work->node.a_flags, IRQ_WORK_PENDING);
+	__smp_call_single_queue(cpu, &work->node.llist);
+
+	return 0;
+}
 
 #endif /* CONFIG_SMP */
 


