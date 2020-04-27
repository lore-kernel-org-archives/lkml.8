Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34CC81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9002075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD0XZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgD0XZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:25:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:25:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jTD7c-00042r-Ny; Tue, 28 Apr 2020 01:25:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 86B39100FC0; Tue, 28 Apr 2020 01:24:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/idt: Keep spurious entries unset in system_vectors
In-Reply-To: <20200424122535.1212732-1-vkuznets@redhat.com>
References: <20200424122535.1212732-1-vkuznets@redhat.com>
Date:   Tue, 28 Apr 2020 01:24:54 +0200
Message-ID: <87ftcopl4p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> Commit dc20b2d52653 ("x86/idt: Move interrupt gate initialization to IDT
> code") had a side-effect of 'set_bit(i, used_vectors)' for unused entries

That was not a side effect. That was intentional.

> which are being mapped to spurious entries. (user_vectors were later

user_vectors?

> renamed to system_vectors).
>
> Previously, we used to count on system_vectors in arch_show_interrupts()

We used to? Maybe you used to. I did not.

> to not print unexisting entries in /proc/interrupts. E.g. 'Hypervisor
> callback interrupts' should not be printed on bare metal. This is
> currently broken.

That was definitely unintended, but that's a purely cosmetic issue.

> Setting bits in system_vectors for all unused entries also makes
> alloc_intr_gate() fail in case someone decides to do it later. It seems
> this is not currently an issue because all alloc_intr_gate() users are
> calling it early, before we call idt_setup_apic_and_irq_gates() but
> this also seems wrong.

No, that's not wrong. There is absolutely no reason to allocate an
interrupt gate later.

The only thing what's wrong is that alloc_intr_gate() lacks an __init
annotation and a sanity check to reject attempts which come in late
after idt_setup_apic_and_irq_gates() was invoked.

With that addressed we can remove the set_bit() for unused vectors to
cure the /proc/interrupts cosmetics.

Talking about side effects. This also reflects the actual number of
system vectors which are assigned in the debugfs interface as that was
'broken' as well.

Thanks,

        tglx

8<--------------------
 arch/x86/kernel/idt.c            |   20 ++++++++++++++++----
 drivers/xen/events/events_base.c |   24 +++++++++++++++---------
 2 files changed, 31 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -51,6 +51,9 @@ struct idt_data {
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
 
+
+static __initdata bool idt_setup_done;
+
 /*
  * Early traps running on the DEFAULT_STACK because the other interrupt
  * stacks work only after cpu_init().
@@ -318,11 +321,16 @@ void __init idt_setup_apic_and_irq_gates
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
-		set_bit(i, system_vectors);
+		/*
+		 * Don't set the non assigned system vectors in the
+		 * system_vectors bitmap. Otherwise they show up in
+		 * /proc/interrupts.
+		 */
 		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
 #endif
+	idt_setup_done = true;
 }
 
 /**
@@ -352,6 +360,7 @@ void idt_invalidate(void *addr)
 	load_idt(&idt);
 }
 
+/* This goes away once ASYNC_PF is sanitized */
 void __init update_intr_gate(unsigned int n, const void *addr)
 {
 	if (WARN_ON_ONCE(!test_bit(n, system_vectors)))
@@ -359,9 +368,12 @@ void __init update_intr_gate(unsigned in
 	set_intr_gate(n, addr);
 }
 
-void alloc_intr_gate(unsigned int n, const void *addr)
+void __init alloc_intr_gate(unsigned int n, const void *addr)
 {
-	BUG_ON(n < FIRST_SYSTEM_VECTOR);
-	if (!test_and_set_bit(n, system_vectors))
+	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
+		return;
+	if (WARN_ON(idt_setup_done))
+		return;
+	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
 		set_intr_gate(n, addr);
 }
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1639,26 +1639,32 @@ EXPORT_SYMBOL_GPL(xen_set_callback_via);
 /* Vector callbacks are better than PCI interrupts to receive event
  * channel notifications because we can receive vector callbacks on any
  * vcpu and we don't need PCI support or APIC interactions. */
-void xen_callback_vector(void)
+static void xen_callback_vector(void)
 {
-	int rc;
 	uint64_t callback_via;
 
 	if (xen_have_vector_callback) {
 		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
-		rc = xen_set_callback_via(callback_via);
-		if (rc) {
+		if (xen_set_callback_via(callback_via)) {
 			pr_err("Request for Xen HVM callback vector failed\n");
 			xen_have_vector_callback = 0;
-			return;
 		}
-		pr_info_once("Xen HVM callback vector for event delivery is enabled\n");
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
-				xen_hvm_callback_vector);
 	}
 }
+
+static __init void xen_init_callback_vector(void)
+{
+	xen_callback_vector();
+	if (!xen_have_vector_callback)
+		return;
+
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
+	pr_info("Xen HVM callback vector for event delivery is enabled\n");
+}
+
 #else
 void xen_callback_vector(void) {}
+static inline void xen_init_callback_vector(void) {}
 #endif
 
 #undef MODULE_PARAM_PREFIX
@@ -1693,7 +1699,7 @@ void __init xen_init_IRQ(void)
 			pci_xen_initial_domain();
 	}
 	if (xen_feature(XENFEAT_hvm_callback_vector))
-		xen_callback_vector();
+		xen_init_callback_vector();
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
