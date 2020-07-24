Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A5C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B0D2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1TI3qqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYn3jmdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGXIds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGXIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBCFC0619D3;
        Fri, 24 Jul 2020 01:33:44 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I+zOp4ND2YLRFWIvUS7WZ18CUWb+0kpdo++bZaFcPaI=;
        b=S1TI3qqFBrJF0TuXCDs4/W4sEvyThzBRN26pn+jsOscNYTvU/zq7tQqjBi1Seri2vMfBLB
        d2zMdVm4EE+Va/217U6aTEwbitFqxctmrX/BDnj4oZRQwnprOF7AMys94xfjxPf663MZX5
        4mnvepLG1MMc+zPeLfclKUg3fJo/dR6QUyRpBPugeIuSBnLCVcCxB1LfACiyKoPKHAGivX
        1EnQuXCNBRGOG+e+zQZPGizbDLvLdENwxlUo6mbtJgu4H2fN2hQ1eXrjjuUzrcutVuphWe
        d5dsj9hrk9GJVDBpa93Efg7NqZp5IV60xCKpmPE/P/GAREgPPsHe9JDSIVBSQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I+zOp4ND2YLRFWIvUS7WZ18CUWb+0kpdo++bZaFcPaI=;
        b=oYn3jmdByc+zFRD5ePEUNUY2kD3C0Q1Z8RmqL55z6MnNJy3O5YPt27gIm/BFsEZWZeeIlZ
        VDeCXpaoqt5mFUDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,irq: Convert to sched_set_fifo()
Cc:     tglx@linutronix.de,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962195.4006.17896492793064474322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     7a40798c714ff462863352d490b382515daba49e
Gitweb:        https://git.kernel.org/tip/7a40798c714ff462863352d490b382515daba49e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:24 +02:00

sched,irq: Convert to sched_set_fifo()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: tglx@linutronix.de
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq/manage.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7619111..06b6274 100644
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
@@ -1281,13 +1278,12 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
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
