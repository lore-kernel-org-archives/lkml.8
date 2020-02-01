Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7EC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970DB2070C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBAIsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:48:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgBAIsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:48:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ixoRr-0003ea-93; Sat, 01 Feb 2020 09:48:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2ADC1C1DF9;
        Sat,  1 Feb 2020 09:48:14 +0100 (CET)
Date:   Sat, 01 Feb 2020 08:48:14 -0000
From:   "tip-bot2 for Dexuan Cui" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/hyperv: Suspend/resume the hypercall page for
 hibernation
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578350559-130275-1-git-send-email-decui@microsoft.com>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Message-ID: <158054689467.396.9318913619625622500.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     05bd330a7fd8875c423fc07d8ddcad73c10e556e
Gitweb:        https://git.kernel.org/tip/05bd330a7fd8875c423fc07d8ddcad73c10e556e
Author:        Dexuan Cui <decui@microsoft.com>
AuthorDate:    Mon, 06 Jan 2020 14:42:39 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Feb 2020 09:41:16 +01:00

x86/hyperv: Suspend/resume the hypercall page for hibernation

For hibernation the hypercall page must be disabled before the hibernation
image is created so that subsequent hypercall operations fail safely. On
resume the hypercall page has to be restored and reenabled to ensure proper
operation of the resumed kernel.

Implement the necessary suspend/resume callbacks.

[ tglx: Decrypted changelog ]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1578350559-130275-1-git-send-email-decui@microsoft.com

---
 arch/x86/hyperv/hv_init.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index caaf4dc..b0da532 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -21,11 +21,15 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
+/* Storage to save the hypercall page temporarily for hibernation */
+static void *hv_hypercall_pg_saved;
+
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
 
@@ -246,6 +250,48 @@ static int __init hv_pci_init(void)
 	return 1;
 }
 
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/*
+	 * Reset the hypercall page as it is going to be invalidated
+	 * accross hibernation. Setting hv_hypercall_pg to NULL ensures
+	 * that any subsequent hypercall operation fails safely instead of
+	 * crashing due to an access of an invalid page. The hypercall page
+	 * pointer is restored on resume.
+	 */
+	hv_hypercall_pg_saved = hv_hypercall_pg;
+	hv_hypercall_pg = NULL;
+
+	/* Disable the hypercall page in the hypervisor */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	return 0;
+}
+
+static void hv_resume(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Re-enable the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 1;
+	hypercall_msr.guest_physical_address =
+		vmalloc_to_pfn(hv_hypercall_pg_saved);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	hv_hypercall_pg = hv_hypercall_pg_saved;
+	hv_hypercall_pg_saved = NULL;
+}
+
+static struct syscore_ops hv_syscore_ops = {
+	.suspend	= hv_suspend,
+	.resume		= hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -330,6 +376,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
 
 remove_cpuhp_state:
@@ -349,6 +397,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
