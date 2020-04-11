Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B562C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB652078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDKQEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:04:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:04:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jNIc6-0007Wc-Hq; Sat, 11 Apr 2020 18:04:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 310751C0481;
        Sat, 11 Apr 2020 18:04:10 +0200 (CEST)
Date:   Sat, 11 Apr 2020 16:04:09 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/split_lock: Provide handle_guest_split_lock()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200410115516.978037132@linutronix.de>
References: <20200410115516.978037132@linutronix.de>
MIME-Version: 1.0
Message-ID: <158662104983.28353.13272730251943920504.tip-bot2@tip-bot2>
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

Commit-ID:     d7e94dbdac1a40924626b0efc7ff530c8baf5e4a
Gitweb:        https://git.kernel.org/tip/d7e94dbdac1a40924626b0efc7ff530c8baf5e4a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Apr 2020 13:54:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 11 Apr 2020 16:39:30 +02:00

x86/split_lock: Provide handle_guest_split_lock()

Without at least minimal handling for split lock detection induced #AC,
VMX will just run into the same problem as the VMWare hypervisor, which
was reported by Kenneth.

It will inject the #AC blindly into the guest whether the guest is
prepared or not.

Provide a function for guest mode which acts depending on the host
SLD mode. If mode == sld_warn, treat it like user space, i.e. emit a
warning, disable SLD and mark the task accordingly. Otherwise force
SIGBUS.

 [ bp: Add a !CPU_SUP_INTEL stub for handle_guest_split_lock(). ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/20200410115516.978037132@linutronix.de
Link: https://lkml.kernel.org/r/20200402123258.895628824@linutronix.de
---
 arch/x86/include/asm/cpu.h  |  6 ++++++
 arch/x86/kernel/cpu/intel.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ff6f3ca..dd17c2d 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int sig);
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern bool handle_guest_split_lock(unsigned long ip);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -51,5 +52,10 @@ static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	return false;
 }
+
+static inline bool handle_guest_split_lock(unsigned long ip)
+{
+	return false;
+}
 #endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e97..bf08d45 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -21,6 +21,7 @@
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
+#include <asm/traps.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -1066,13 +1067,10 @@ static void split_lock_init(void)
 	split_lock_verify_msr(sld_state != sld_off);
 }
 
-bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+static void split_lock_warn(unsigned long ip)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
-		return false;
-
 	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-			    current->comm, current->pid, regs->ip);
+			    current->comm, current->pid, ip);
 
 	/*
 	 * Disable the split lock detection for this task so it can make
@@ -1081,6 +1079,31 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	 */
 	sld_update_msr(false);
 	set_tsk_thread_flag(current, TIF_SLD);
+}
+
+bool handle_guest_split_lock(unsigned long ip)
+{
+	if (sld_state == sld_warn) {
+		split_lock_warn(ip);
+		return true;
+	}
+
+	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
+		     current->comm, current->pid,
+		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
+
+	current->thread.error_code = 0;
+	current->thread.trap_nr = X86_TRAP_AC;
+	force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
+	return false;
+}
+EXPORT_SYMBOL_GPL(handle_guest_split_lock);
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+	split_lock_warn(regs->ip);
 	return true;
 }
 
