Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD58205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgEMTQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390336AbgEMTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:16:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A3C061A0E;
        Wed, 13 May 2020 12:16:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYwrc-0002zJ-Rn; Wed, 13 May 2020 21:16:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 802CD1C0475;
        Wed, 13 May 2020 21:16:20 +0200 (CEST)
Date:   Wed, 13 May 2020 19:16:20 -0000
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/xen: Split HVM vector callback setup and
 interrupt gate allocation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428093824.1451532-2-vkuznets@redhat.com>
References: <20200428093824.1451532-2-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <158939738043.390.5652613957262652373.tip-bot2@tip-bot2>
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

Commit-ID:     fad1940a6a856f59b073e8650e02052ce531154c
Gitweb:        https://git.kernel.org/tip/fad1940a6a856f59b073e8650e02052ce531154c
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Tue, 28 Apr 2020 11:38:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 21:13:54 +02:00

x86/xen: Split HVM vector callback setup and interrupt gate allocation

As a preparatory change for making alloc_intr_gate() __init split
xen_callback_vector() into callback vector setup via hypercall
(xen_setup_callback_vector()) and interrupt gate allocation
(xen_alloc_callback_vector()).

xen_setup_callback_vector() is being called twice: on init and upon
system resume from xen_hvm_post_suspend(). alloc_intr_gate() only
needs to be called once.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200428093824.1451532-2-vkuznets@redhat.com

---
 arch/x86/xen/suspend_hvm.c       |  2 +-
 arch/x86/xen/xen-ops.h           |  2 +-
 drivers/xen/events/events_base.c | 28 +++++++++++++++++-----------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index e666b61..5152afe 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -13,6 +13,6 @@ void xen_hvm_post_suspend(int suspend_cancelled)
 		xen_hvm_init_shared_info();
 		xen_vcpu_restore();
 	}
-	xen_callback_vector();
+	xen_setup_callback_vector();
 	xen_unplug_emulated_devices();
 }
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 45a441c..1cc1568 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -55,7 +55,7 @@ void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
 
-void xen_callback_vector(void);
+void xen_setup_callback_vector(void);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 3a791c8..eb35c3c 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1639,26 +1639,30 @@ EXPORT_SYMBOL_GPL(xen_set_callback_via);
 /* Vector callbacks are better than PCI interrupts to receive event
  * channel notifications because we can receive vector callbacks on any
  * vcpu and we don't need PCI support or APIC interactions. */
-void xen_callback_vector(void)
+void xen_setup_callback_vector(void)
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
+static __init void xen_alloc_callback_vector(void)
+{
+	if (!xen_have_vector_callback)
+		return;
+
+	pr_info("Xen HVM callback vector for event delivery is enabled\n");
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
+}
 #else
-void xen_callback_vector(void) {}
+void xen_setup_callback_vector(void) {}
+static inline void xen_alloc_callback_vector(void) {}
 #endif
 
 #undef MODULE_PARAM_PREFIX
@@ -1692,8 +1696,10 @@ void __init xen_init_IRQ(void)
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
-	if (xen_feature(XENFEAT_hvm_callback_vector))
-		xen_callback_vector();
+	if (xen_feature(XENFEAT_hvm_callback_vector)) {
+		xen_setup_callback_vector();
+		xen_alloc_callback_vector();
+	}
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
