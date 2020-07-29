Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9EB22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pk0yGCMa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhSYbYzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgG2OfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:35:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgG2Odb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:31 -0400
Date:   Wed, 29 Jul 2020 14:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfEec54oaiWxDKtGoCTQPjFnBswneSzn0ldCkFiuN8Y=;
        b=pk0yGCMa2/MiPKAjiKr8+h76fIdBReea1gbd6uxsa91KOsd9Wf/56YYLXdaaUTAtatcxQ/
        Iu88KRS11KyQKrb7E4C7TXZ7H288TKrFT4TAmf0OURQZ6Rjs4/URKy/huoFNfwmyek04om
        vKsT/D7WrnskXn3PFh1mlN1/izpvvzPHgXamcq7cwT7tIYpIf2+uVd1I240xOXH/UG6SvM
        qktQ+b3bwHxm+yGJOCs+AW7qvBbfF0QYii1YNJ59gkeHLu13gnemYXjKS0E6JajJGgAqno
        W7ojUsbIpNCDQjg9UaTPlYX5N3nAF+4vYjb2XlJlAkFIh8gHST7ZfJlR2TyPXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfEec54oaiWxDKtGoCTQPjFnBswneSzn0ldCkFiuN8Y=;
        b=rhSYbYzzgTmnUBPFIsQi6v1VDbSPoQy8qGcnbY4LSTSd2oDsDuj1o6KeqjCIFNLaeLbV49
        1KpaRuhFzdpMNHCQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kvm/eventfd: Use sequence counter with associated
 spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-24-a.darwish@linutronix.de>
References: <20200720155530.1173732-24-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603320780.4006.2176719373366704021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5c73b9a2b1b4ecc809a914aa64970157b3d8c936
Gitweb:        https://git.kernel.org/tip/5c73b9a2b1b4ecc809a914aa64970157b3d8c936
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:29 +02:00

kvm/eventfd: Use sequence counter with associated spinlock

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/20200720155530.1173732-24-a.darwish@linutronix.de
---
 include/linux/kvm_irqfd.h | 2 +-
 virt/kvm/eventfd.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index dc1da02..dac047a 100644
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
index ef7ed91..d6408bb 100644
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
