Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67787C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1061B21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hM2yYI/h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDtREUXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgIJJiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgIJJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:20 -0400
Date:   Thu, 10 Sep 2020 09:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGqEr272DO0zbhqeem7s2KCQ+3LfEE88fEDMVWlEoTg=;
        b=hM2yYI/hNv/3cQfgAxJHWnDn6Ry6nHfqVxoJDNiCQO73kK7pFvGUYExSKGWZ+sq+r/5g8z
        fRFA37aY8vm+rGEXUZRGreexv2UWi4f3HjIAHOoIlPF5/2qKLmmmV0DBDiMUJxS7BxhfG0
        +OAtdj/RIMvOBcoimt+DOpAOACjSWSabQcATawKu6dxsSs0QBee+yLSIEdi148oIU1Lhcj
        JyhIUsMyh6iNZfH/fQSrenONJ90gUxjuHURUngMNRhOhkeyrsGYrWkBKydGb0rL3qkOkBL
        h3iW59J/bMu7LgjvpIleiZozaHwK4EmfxWbj4IOqTckj8ci6QkbB4OCXoUc7fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGqEr272DO0zbhqeem7s2KCQ+3LfEE88fEDMVWlEoTg=;
        b=iDtREUXtmz9Gds3N8qyGjc0PSGbnFPs/3kxCmKtE+kDERFxPRoTumPoItI8vYeg5DmVkUr
        XVVotZUo0vJd6EDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Adjust #VC IST Stack on entering NMI handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-44-joro@8bytes.org>
References: <20200907131613.12703-44-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973434.20229.7691205060608983396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     315562c9af3d583502b35c4b223a08d95ce69864
Gitweb:        https://git.kernel.org/tip/315562c9af3d583502b35c4b223a08d95ce69864
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/sev-es: Adjust #VC IST Stack on entering NMI handler

When an NMI hits in the #VC handler entry code before it has switched to
another stack, any subsequent #VC exception in the NMI code-path will
overwrite the interrupted #VC handler's stack.

Make sure this doesn't happen by explicitly adjusting the #VC IST entry
in the NMI handler for the time it can cause #VC exceptions.

 [ bp: Touchups, spelling fixes. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-44-joro@8bytes.org
---
 arch/x86/include/asm/sev-es.h | 19 ++++++++++++-
 arch/x86/kernel/nmi.c         |  9 ++++++-
 arch/x86/kernel/sev-es.c      | 53 ++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 9fbeeda..59176e8 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -78,4 +78,23 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern struct static_key_false sev_es_enable_key;
+extern void __sev_es_ist_enter(struct pt_regs *regs);
+extern void __sev_es_ist_exit(void);
+static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_ist_enter(regs);
+}
+static __always_inline void sev_es_ist_exit(void)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_ist_exit();
+}
+#else
+static inline void sev_es_ist_enter(struct pt_regs *regs) { }
+static inline void sev_es_ist_exit(void) { }
+#endif
+
 #endif
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954..4c89c4d 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -33,6 +33,7 @@
 #include <asm/reboot.h>
 #include <asm/cache.h>
 #include <asm/nospec-branch.h>
+#include <asm/sev-es.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
@@ -488,6 +489,12 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	this_cpu_write(nmi_cr2, read_cr2());
 nmi_restart:
 
+	/*
+	 * Needs to happen before DR7 is accessed, because the hypervisor can
+	 * intercept DR7 reads/writes, turning those into #VC exceptions.
+	 */
+	sev_es_ist_enter(regs);
+
 	this_cpu_write(nmi_dr7, local_db_save());
 
 	irq_state = idtentry_enter_nmi(regs);
@@ -501,6 +508,8 @@ nmi_restart:
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
+	sev_es_ist_exit();
+
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));
 	if (this_cpu_dec_return(nmi_state))
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index fae8145..39ebb2d 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -51,6 +51,7 @@ struct sev_es_runtime_data {
 };
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
 static void __init setup_vc_stacks(int cpu)
 {
@@ -73,6 +74,55 @@ static void __init setup_vc_stacks(int cpu)
 	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
 }
 
+static __always_inline bool on_vc_stack(unsigned long sp)
+{
+	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
+}
+
+/*
+ * This function handles the case when an NMI is raised in the #VC exception
+ * handler entry code. In this case, the IST entry for #VC must be adjusted, so
+ * that any subsequent #VC exception will not overwrite the stack contents of the
+ * interrupted #VC handler.
+ *
+ * The IST entry is adjusted unconditionally so that it can be also be
+ * unconditionally adjusted back in sev_es_ist_exit(). Otherwise a nested
+ * sev_es_ist_exit() call may adjust back the IST entry too early.
+ */
+void noinstr __sev_es_ist_enter(struct pt_regs *regs)
+{
+	unsigned long old_ist, new_ist;
+
+	/* Read old IST entry */
+	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	/* Make room on the IST stack */
+	if (on_vc_stack(regs->sp))
+		new_ist = ALIGN_DOWN(regs->sp, 8) - sizeof(old_ist);
+	else
+		new_ist = old_ist - sizeof(old_ist);
+
+	/* Store old IST entry */
+	*(unsigned long *)new_ist = old_ist;
+
+	/* Set new IST entry */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
+}
+
+void noinstr __sev_es_ist_exit(void)
+{
+	unsigned long ist;
+
+	/* Read IST entry */
+	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
+		return;
+
+	/* Read back old IST entry and write it to the TSS */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
+}
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -277,6 +327,9 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_active())
 		return;
 
+	/* Enable SEV-ES special handling */
+	static_branch_enable(&sev_es_enable_key);
+
 	/* Initialize per-cpu GHCB pages */
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
