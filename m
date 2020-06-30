Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F5E20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9otwvbs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xwgu3AOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgF3Fqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbgF3Fqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED699C061755;
        Mon, 29 Jun 2020 22:46:31 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pgkphRaGEy8Yhqq7odaGRHYOVQX84dVuNSHLC82kuU=;
        b=E9otwvbsP6fkQIQEzrCLtoiSgGeFf4td6kMkZ8W7QaDr3/zwuxbE36rk6GMf+IhaSpz0Km
        8N0+y2u+4FGwt7XZgIvxFlBrYY1rmNeWUlaPxiAdQw0is+7Q5ONMFRg4qvt0u0xbIoPsaZ
        k/Smy86qXZVyaa9F7wj5oEAdfphHd6WpujuJh/S+XKmsZ1YNULvHCnt/XEpacTrjCOZg6m
        HRTxT2hGtSfcZHD3+HdElggf7j6BTDwzDpR1lPfPuTlThTYRbHFQep8zjU4lV4urLp1YmH
        QqKOvkX7NO/LbeAxhPB9kAtvkdzb2w3Dbsj6Fcx/ACRc2ydnkE2Xu5cw841+lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pgkphRaGEy8Yhqq7odaGRHYOVQX84dVuNSHLC82kuU=;
        b=Xwgu3AOumeCzro6vBPT+CXbrO72V/FxDvk0GJo8E3RKV5/d3jWPZxXaVH9cPcuW8jYMeTp
        qxjJYZnEuMDaNwCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v3 19/20] kvm/eventfd: Use sequence counter with associated spinlock
Date:   Tue, 30 Jun 2020 07:44:51 +0200
Message-Id: <20200630054452.3675847-20-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_irqfd.h | 2 +-
 virt/kvm/eventfd.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index dc1da020305b..dac047abdba7 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -42,7 +42,7 @@ struct kvm_kernel_irqfd {
 	wait_queue_entry_t wait;
 	/* Update side is protected by irqfds.lock */
 	struct kvm_kernel_irq_routing_entry irq_entry;
-	seqcount_t irq_entry_sc;
+	seqcount_spinlock_t irq_entry_sc;
 	/* Used for level IRQ fast-path */
 	int gsi;
 	struct work_struct inject;
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index ef7ed916ad4a..d6408bb497dc 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -303,7 +303,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	INIT_LIST_HEAD(&irqfd->list);
 	INIT_WORK(&irqfd->inject, irqfd_inject);
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
-	seqcount_init(&irqfd->irq_entry_sc);
+	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
 
 	f = fdget(args->fd);
 	if (!f.file) {
-- 
2.20.1

