Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6523EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E43205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbgEMTQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390443AbgEMTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:16:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F0C061A0C;
        Wed, 13 May 2020 12:16:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYwrc-0002zE-Hi; Wed, 13 May 2020 21:16:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 247F11C0440;
        Wed, 13 May 2020 21:16:20 +0200 (CEST)
Date:   Wed, 13 May 2020 19:16:20 -0000
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Annotate alloc_intr_gate() with __init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428093824.1451532-3-vkuznets@redhat.com>
References: <20200428093824.1451532-3-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <158939738006.390.4250769933552969485.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4c74d51dab3dd655062a4740af150c1835e19cff
Gitweb:        https://git.kernel.org/tip/4c74d51dab3dd655062a4740af150c1835e19cff
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Tue, 28 Apr 2020 11:38:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 21:13:54 +02:00

x86/idt: Annotate alloc_intr_gate() with __init

There seems to be no reason to allocate interrupt gates after init. Mark
alloc_intr_gate() as __init and add WARN_ON() checks making sure it is
only used before idt_setup_apic_and_irq_gates() finalizes IDT setup and
maps all un-allocated entries to spurious entries.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200428093824.1451532-3-vkuznets@redhat.com

---
 arch/x86/kernel/idt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 98bcb50..0e92051 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -51,6 +51,9 @@ struct idt_data {
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
 
+
+static bool idt_setup_done __initdata;
+
 /*
  * Early traps running on the DEFAULT_STACK because the other interrupt
  * stacks work only after cpu_init().
@@ -323,6 +326,7 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 #endif
+	idt_setup_done = true;
 }
 
 /**
@@ -352,6 +356,7 @@ void idt_invalidate(void *addr)
 	load_idt(&idt);
 }
 
+/* This goes away once ASYNC_PF is sanitized */
 void __init update_intr_gate(unsigned int n, const void *addr)
 {
 	if (WARN_ON_ONCE(!test_bit(n, system_vectors)))
@@ -359,9 +364,14 @@ void __init update_intr_gate(unsigned int n, const void *addr)
 	set_intr_gate(n, addr);
 }
 
-void alloc_intr_gate(unsigned int n, const void *addr)
+void __init alloc_intr_gate(unsigned int n, const void *addr)
 {
-	BUG_ON(n < FIRST_SYSTEM_VECTOR);
-	if (!test_and_set_bit(n, system_vectors))
+	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
+		return;
+
+	if (WARN_ON(idt_setup_done))
+		return;
+
+	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
 		set_intr_gate(n, addr);
 }
