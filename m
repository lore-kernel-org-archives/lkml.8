Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4EC10F29
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E1720838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCHKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:14:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56474 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgCHKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx5-0004nu-Pt; Sun, 08 Mar 2020 11:14:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7920C1C2213;
        Sun,  8 Mar 2020 11:14:30 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/vector: Force interupt handler invocation to
 irq context
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130623.684591280@linutronix.de>
References: <20200306130623.684591280@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366247018.28353.7207469649673075604.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     008f1d60fe25810d4554916744b0975d76601b64
Gitweb:        https://git.kernel.org/tip/008f1d60fe25810d4554916744b0975d76601b64
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:06:40 +01:00

x86/apic/vector: Force interupt handler invocation to irq context

Sathyanarayanan reported that the PCI-E AER error injection mechanism
can result in a NULL pointer dereference in apic_ack_edge():

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
 RIP: 0010:apic_ack_edge+0x1e/0x40
 Call Trace:
   handle_edge_irq+0x7d/0x1e0
   generic_handle_irq+0x27/0x30
   aer_inject_write+0x53a/0x720

It crashes in irq_complete_move() which dereferences get_irq_regs() which
is obviously NULL when this is called from non interrupt context.

Of course the pointer could be checked, but that just papers over the real
issue. Invoking the low level interrupt handling mechanism from random code
can wreckage the fragile interrupt affinity mechanism of x86 as interrupts
can only be moved in interrupt context or with special care when a CPU goes
offline and the move has to be enforced.

In the best case this triggers the warning in the MSI affinity setter, but
if the call happens on the correct CPU it just corrupts state and might
prevent further interrupt delivery for the affected device.

Mark the APIC interrupts as unsuitable for being invoked in random contexts.

This prevents the AER injection from proliferating the wreckage, but that's
less broken than the current state of affairs and more correct than just
papering over the problem by sprinkling random checks all over the place
and silently corrupting state.

Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de

---
 arch/x86/kernel/apic/vector.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b..6f6d98d 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -557,6 +557,12 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
 		/*
+		 * Prevent that any of these interrupts is invoked in
+		 * non interrupt context via e.g. generic_handle_irq()
+		 * as that can corrupt the affinity move state.
+		 */
+		irqd_set_handle_enforce_irqctx(irqd);
+		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
 		 * required for check_timer() to work correctly as it might
