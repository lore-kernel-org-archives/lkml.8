Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC2C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F6F2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v87q1Ys6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7sRFJYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbgGTQbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:31:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgGTP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:24 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pgkphRaGEy8Yhqq7odaGRHYOVQX84dVuNSHLC82kuU=;
        b=v87q1Ys6Tq/CpghmT0FHAuaOzY3Idd5yG0LvZA8Kti/HWmGZMmhlceMkNsg+HGqX+TMsI7
        7g3l5aZWyHHnPTpGDIeznazbC+hoOXyFvF/+3LZa4S8c2/B20Meda6K5SB0RR4W8dtPN5o
        JJNSmeVZTpbaojfg3nh4aGxAA+C0HANRfKMhj0orvLbh2Mfz7TsjyKLptfvCdtkIWKBcX/
        /pLdCaG+NnXavTRUaAh/nNyTEkz1I1nUSTp+vomn4CGfdLXtup60Kya4a9TTJxpUjuO5su
        KIC2dVAs8rbk3qrfSr2jJV97dafZGbxOW4Zsw95a4mG/kwv1gaiYZBhs4T0qsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pgkphRaGEy8Yhqq7odaGRHYOVQX84dVuNSHLC82kuU=;
        b=Q7sRFJYDhBBaDIblOeZZRtKWP+/nZyjoWA5mvhVmVKsu3G7dvS1dZzwfG96QG5334YNxB7
        /i7A60i5BQ2oetAg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 23/24] kvm/eventfd: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:29 +0200
Message-Id: <20200720155530.1173732-24-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
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

