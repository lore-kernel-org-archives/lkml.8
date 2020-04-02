Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3013C2BA17
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C760E20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbgDBNB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:01:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:01:26 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJzSu-0004Fx-KC; Thu, 02 Apr 2020 15:01:00 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 28EE2FFAA7;
        Thu,  2 Apr 2020 15:01:00 +0200 (CEST)
Message-Id: <20200402124205.242674296@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 02 Apr 2020 14:32:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
References: <20200402123258.895628824@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

It turns out that with Split-Lock-Detect enabled (default) any VMX
hypervisor needs at least a little modification in order to not blindly
inject the #AC into the guest without the guest being ready for it.

Since there is no telling which module implements a hypervisor, scan the
module text and look for the VMLAUNCH instruction. If found, the module is
assumed to be a hypervisor of some sort and SLD is disabled.

Hypervisors, which have been modified and are known to work correctly,
can add:

  MODULE_INFO(sld_safe, "Y");

to explicitly tell the module loader they're good.

NOTE: it is unfortunate that struct load_info is not available to the
      arch module code, this means CONFIG_CPU_SUP_INTEL gunk is needed
      in generic code.

NOTE: while we can 'trivially' fix KVM, we're still stuck with stuff
      like VMware and VirtualBox doing their own thing.

Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/cpu.h  |    2 ++
 arch/x86/kernel/cpu/intel.c |   38 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.c    |    6 ++++++
 include/linux/module.h      |    4 ++++
 kernel/module.c             |    5 +++++
 5 files changed, 54 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int s
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern void split_lock_validate_module_text(struct module *me, void *text, void *text_end);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -51,5 +52,6 @@ static inline bool handle_user_split_loc
 {
 	return false;
 }
+static inline void split_lock_validate_module_text(struct module *me, void *text, void *text_end) {}
 #endif
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/module.h>
 
 #include <asm/cpufeature.h>
 #include <asm/pgtable.h>
@@ -21,6 +22,7 @@
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
+#include <asm/insn.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -1055,12 +1057,46 @@ static void sld_update_msr(bool on)
 {
 	u64 test_ctrl_val = msr_test_ctrl_cache;
 
-	if (on)
+	if (on && (sld_state != sld_off))
 		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
 }
 
+static void sld_remote_kill(void *arg)
+{
+	sld_update_msr(false);
+}
+
+void split_lock_validate_module_text(struct module *me, void *text, void *text_end)
+{
+	u8 vmlaunch[] = { 0x0f, 0x01, 0xc2 };
+	struct insn insn;
+
+	if (sld_state == sld_off)
+		return;
+
+	while (text < text_end) {
+		kernel_insn_init(&insn, text, text_end - text);
+		insn_get_length(&insn);
+
+		if (WARN_ON_ONCE(!insn_complete(&insn)))
+			break;
+
+		if (insn.length == sizeof(vmlaunch) && !memcmp(text, vmlaunch, sizeof(vmlaunch)))
+			goto bad_module;
+
+		text += insn.length;
+	}
+
+	return;
+
+bad_module:
+	pr_warn("disabled due to VMLAUNCH in module: %s\n", me->name);
+	sld_state = sld_off;
+	on_each_cpu(sld_remote_kill, NULL, 1);
+}
+
 static void split_lock_init(void)
 {
 	split_lock_verify_msr(sld_state != sld_off);
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -24,6 +24,7 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 #include <asm/unwind.h>
+#include <asm/cpu.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -253,6 +254,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    tseg, tseg + text->sh_size);
 	}
 
+	if (text && !me->sld_safe) {
+		void *tseg = (void *)text->sh_addr;
+		split_lock_validate_module_text(me, tseg, tseg + text->sh_size);
+	}
+
 	if (para) {
 		void *pseg = (void *)para->sh_addr;
 		apply_paravirt(pseg, pseg + para->sh_size);
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -407,6 +407,10 @@ struct module {
 	bool sig_ok;
 #endif
 
+#ifdef CONFIG_CPU_SUP_INTEL
+	bool sld_safe;
+#endif
+
 	bool async_probe_requested;
 
 	/* symbols that will be GPL-only in the near future. */
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3096,6 +3096,11 @@ static int check_modinfo(struct module *
 			"is unknown, you have been warned.\n", mod->name);
 	}
 
+#ifdef CONFIG_CPU_SUP_INTEL
+	if (get_modinfo(info, "sld_safe"))
+		mod->sld_safe = true;
+#endif
+
 	err = check_modinfo_livepatch(mod, info);
 	if (err)
 		return err;

