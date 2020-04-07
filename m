Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B9C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49CD206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dMT43QtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgDGLNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:13:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGLNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k18ChHz5jq7GnLj8UdXR7lsxUanr/pTCe7iNAcGVsLI=; b=dMT43QtDWREnSUGCJ6+jHS57Yn
        uZlm4BKaWhWGdPOB07XRzXqy/IfHQrhIqpgawmDwdE5SbkOtjpAmgJ+WEYnN4w4mMYQ47oXe7zxnJ
        10IdHNfqt7sDhxBzpm7DzyT0Rkpg50ekaspuS1TGnhL8+v5oUCI7dE2L+RfI+d28GC2QQym8j+KXB
        wMWqmxSvV2kv56f7FE+P22+By3G1thNZ3Qa7TFkj84Tan2TI0dreKRWbpA+vfVqBvRG6tzo56kQ+f
        6gJqtmtj+BlMGmpc1A1vX2n4i1+Ez4lWO2v6x1r4C6vVH4aJLZ5z9ZCI5T9O6xlxK90k1UnNYfLIL
        uAqQj7lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLm9n-0002wK-D7; Tue, 07 Apr 2020 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B30A305FB6;
        Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 22B0E29C96F20; Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Message-Id: <20200407111007.352324393@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 07 Apr 2020 13:02:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, peterz@infradead.org, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
References: <20200407110236.930134290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that with Split-Lock-Detect enabled (default) any VMX
hypervisor needs at least a little modification in order to not blindly
inject the #AC into the guest without the guest being ready for it.

Since there is no telling which module implements a hypervisor, scan
all out-of-tree modules' text and look for VMX instructions and refuse
to load it when SLD is enabled (default) and the module isn't marked
'sld_safe'.

Hypervisors, which have been modified and are known to work correctly,
can add:

  MODULE_INFO(sld_safe, "Y");

to explicitly tell the module loader they're good.

Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200402124205.242674296@linutronix.de
---
 arch/x86/include/asm/cpu.h   |    5 ++
 arch/x86/kernel/cpu/intel.c  |    5 ++
 arch/x86/kernel/module.c     |   87 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/moduleloader.h |    2 
 kernel/module.c              |    3 -
 5 files changed, 99 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int s
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern bool split_lock_enabled(void);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -51,5 +52,9 @@ static inline bool handle_user_split_loc
 {
 	return false;
 }
+static inline bool split_lock_enabled(void)
+{
+	return false;
+}
 #endif
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1061,6 +1061,11 @@ static void sld_update_msr(bool on)
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
 }
 
+bool split_lock_enabled(void)
+{
+	return sld_state != sld_off;
+}
+
 static void split_lock_init(void)
 {
 	split_lock_verify_msr(sld_state != sld_off);
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -24,6 +24,8 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 #include <asm/unwind.h>
+#include <asm/cpu.h>
+#include <asm/insn.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -217,6 +219,78 @@ int apply_relocate_add(Elf64_Shdr *sechd
 }
 #endif
 
+static bool insn_is_vmx(struct insn *insn)
+{
+	u8 modrm = insn->modrm.bytes[0];
+	u8 modrm_mod = X86_MODRM_MOD(modrm);
+	u8 modrm_reg = X86_MODRM_REG(modrm);
+
+	u8 prefix = insn->prefixes.bytes[0];
+
+	if (insn->opcode.bytes[0] != 0x0f)
+		return false;
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x01:
+		switch (insn->opcode.bytes[2]) {
+		case 0xc1: /* VMCALL */
+		case 0xc2: /* VMLAUNCH */
+		case 0xc3: /* VMRESUME */
+		case 0xc4: /* VMXOFF */
+			return true;
+
+		default:
+			break;
+		}
+		break;
+
+	case 0x78: /* VMREAD */
+	case 0x79: /* VMWRITE */
+		return true;
+
+	case 0xc7:
+		/* VMPTRLD, VMPTRST, VMCLEAR, VMXON */
+		if (modrm_mod == 0x03)
+			break;
+
+		if ((modrm_reg == 6 && (!prefix || prefix == 0x66 || prefix == 0xf3)) ||
+		    (modrm_reg == 7 && (!prefix || prefix == 0xf3)))
+			return true;
+
+		break;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
+{
+	bool allow_vmx = sld_safe || !split_lock_enabled();
+	struct insn insn;
+
+	while (text < text_end) {
+		kernel_insn_init(&insn, text, text_end - text);
+		insn_get_length(&insn);
+
+		if (WARN_ON_ONCE(!insn_complete(&insn))) {
+			pr_err("Module text malformed: %s\n", mod->name);
+			return -ENOEXEC;
+		}
+
+		if (!allow_vmx && insn_is_vmx(&insn)) {
+			pr_err("Module has VMX instructions and is not marked 'sld_safe', boot with: 'split_lock_detect=off': %s\n", mod->name);
+			return -ENOEXEC;
+		}
+
+		text += insn.length;
+	}
+
+	return 0;
+}
+
 int module_finalize(const struct load_info *info, struct module *me)
 {
 	const Elf_Ehdr *hdr = info->hdr;
@@ -253,6 +327,16 @@ int module_finalize(const struct load_in
 					    tseg, tseg + text->sh_size);
 	}
 
+	if (text && !get_modinfo(info, "intree")) {
+		bool sld_safe = get_modinfo(info, "sld_safe");
+		void *tseg = (void *)text->sh_addr;
+		int ret;
+
+		ret = decode_module(me, tseg, tseg + text->sh_size, sld_safe);
+		if (ret)
+			return ret;
+	}
+
 	if (para) {
 		void *pseg = (void *)para->sh_addr;
 		apply_paravirt(pseg, pseg + para->sh_size);
@@ -261,9 +345,10 @@ int module_finalize(const struct load_in
 	/* make jump label nops */
 	jump_label_apply_nops(me);
 
-	if (orc && orc_ip)
+	if (orc && orc_ip) {
 		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
 				   (void *)orc->sh_addr, orc->sh_size);
+	}
 
 	return 0;
 }
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -26,6 +26,8 @@ struct load_info {
 	} index;
 };
 
+extern char *get_modinfo(const struct load_info *info, const char *tag);
+
 /* These may be implemented by architectures that need to hook into the
  * module loader code.  Architectures that don't need to do anything special
  * can just rely on the 'weak' default hooks defined in kernel/module.c.
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1393,7 +1393,6 @@ static inline int same_magic(const char
 }
 #endif /* CONFIG_MODVERSIONS */
 
-static char *get_modinfo(const struct load_info *info, const char *tag);
 static char *get_next_modinfo(const struct load_info *info, const char *tag,
 			      char *prev);
 
@@ -2521,7 +2520,7 @@ static char *get_next_modinfo(const stru
 	return NULL;
 }
 
-static char *get_modinfo(const struct load_info *info, const char *tag)
+char *get_modinfo(const struct load_info *info, const char *tag)
 {
 	return get_next_modinfo(info, tag, NULL);
 }


