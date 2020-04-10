Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C41C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A9A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJL4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:56:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJL4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:56:08 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMsGP-0004bl-BG; Fri, 10 Apr 2020 13:56:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ADEF2100BB6;
        Fri, 10 Apr 2020 13:56:00 +0200 (CEST)
Message-Id: <20200410115516.978037132@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 10 Apr 2020 13:54:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 1/3] x86/split_lock: Provide handle_guest_split_lock()
References: <20200410115359.242241855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Without at least minimal handling for split lock detection induced #AC, VMX
will just run into the same problem as the VMWare hypervisor, which was
reported by Kenneth.

It will inject the #AC blindly into the guest whether the guest is prepared
or not.

Provide a function for guest mode which acts depending on the host SLD
mode.  If mode == sld_warn, treat it like user space, i.e. emit a warning
disable SLD and mark the task accordingly. Otherwise force SIGBUS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Kenneth R. Crudup" <kenny@panix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tony Luck <tony.luck@intel.com>

---
 arch/x86/include/asm/cpu.h  |    1 +
 arch/x86/kernel/cpu/intel.c |   33 ++++++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int s
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern bool handle_guest_split_lock(unsigned long ip);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
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
@@ -1081,6 +1079,31 @@ bool handle_user_split_lock(struct pt_re
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
 

