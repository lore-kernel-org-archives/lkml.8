Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D34720787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrAL1XfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDVL3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E19C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sGPoG9nHkRgcF5sVGoi2OVg1N+i4DA3e12+aG10N4j0=; b=qrAL1XfZyYppT26PTddnkyQscM
        j8LpY/SqA4DAv1M8WxGrD6gsbvfAujKxm9x6Jp02kSoOZZhmKV4UH4dFe+y5lfuYpKu+JmHb8Lcxy
        uC2yA+C7xpYm5CjAOt+1o2Dn3Scqslx+mcZQRhctj8Q/WdYGRfi/zRdvFw/3qjUbElTlShZB5BUGD
        ErtbpLf/eHIvXlASNmbAgYPtSNsboAvptmPb404nqGHSkBuVBcCRxvG0PQ0tpxtNGnDh/aYarZjQO
        oMcXxiPlf+6B5ZcQEVgQu2QTGS6Nky5azwFXe8Umi4WlI1phkXFT0TPRXLCh8IW0wi2jdiabrhzMp
        qLIH6AtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0003bN-JQ; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 562B230797E;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F393A22B9589C; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112832.224090625@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org
Subject: [PATCH 17/23] sched,irq: Convert to sched_set_fifo()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: tglx@linutronix.de
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq/manage.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1271,9 +1271,6 @@ static int
 setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 {
 	struct task_struct *t;
-	struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO/2,
-	};
 
 	if (!secondary) {
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
@@ -1281,13 +1278,12 @@ setup_irq_thread(struct irqaction *new,
 	} else {
 		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
 				   new->name);
-		param.sched_priority -= 1;
 	}
 
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
+	sched_set_fifo(t);
 
 	/*
 	 * We keep the reference to the task struct even if


