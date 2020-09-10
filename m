Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C71C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A985C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PiKnazAH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DROpx82l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIJJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:23:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgIJJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:14 -0400
Date:   Thu, 10 Sep 2020 09:22:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvQnQfh9Bo3ltrX7QyNNcZwy6fdepNogXP0tysz4lic=;
        b=PiKnazAHcvDBv9sF94e983uCAZDjydt3C8irq8UZiuyRZTrlEiMjbbCRdHWmhp8jO8CQYk
        PaU1C4ozEKbb2NH9r1/v4W8YV6HhiRX8DZryRJTG7cZGSCfJyBTQxOQadhax7EEgAoVBUb
        qyxEiBYqpztBeQ8xxfXcP97xe2mCrWIIIpRG7Nd3jHXAb2P+MlPk8iZ011eqzhHDkFxPAj
        Jr6nOIy5iMvfxps5GW18tAIXo/wQiqWgmXnrD6NUsiLQiANdKRRtEoHH2cwADzpURb0x46
        cCOLqlGjzCVo8G00WbIDVVdxF1yqdJ2zZJCZLI0x5RKlpVtnZXghPn+lChwzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvQnQfh9Bo3ltrX7QyNNcZwy6fdepNogXP0tysz4lic=;
        b=DROpx82l/iv7Y/ur4GNG+XF8KS2oM2/w2EqKILqCV2YeJX1jPLj8ZG+KiFABFuq0xxQbIq
        qetNkwV6A8DJofAw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/realmode: Setup AP jump table
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-67-joro@8bytes.org>
References: <20200907131613.12703-67-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972474.20229.3672512084927619910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     8940ac9ced8bc1c48c4e28b0784e3234c9d14469
Gitweb:        https://git.kernel.org/tip/8940ac9ced8bc1c48c4e28b0784e3234c9d14469
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/realmode: Setup AP jump table

As part of the GHCB specification, the booting of APs under SEV-ES
requires an AP jump table when transitioning from one layer of code to
another (e.g. when going from UEFI to the OS). As a result, each layer
that parks an AP must provide the physical address of an AP jump table
to the next layer via the hypervisor.

Upon booting of the kernel, read the AP jump table address from the
hypervisor. Under SEV-ES, APs are started using the INIT-SIPI-SIPI
sequence. Before issuing the first SIPI request for an AP, the start
CS and IP is programmed into the AP jump table. Upon issuing the SIPI
request, the AP will awaken and jump to that start CS:IP address.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapted to different code base
                   - Moved AP table setup from SIPI sending path to
		     real-mode setup code
		   - Fix sparse warnings ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-67-joro@8bytes.org
---
 arch/x86/include/asm/sev-es.h   |  5 ++-
 arch/x86/include/uapi/asm/svm.h |  3 +-
 arch/x86/kernel/sev-es.c        | 69 ++++++++++++++++++++++++++++++++-
 arch/x86/realmode/init.c        | 18 +++++++-
 4 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 59176e8..db88e1c 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -73,6 +73,9 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 	return (val & mask);
 }
 
+struct real_mode_header;
+enum stack_type;
+
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
@@ -92,9 +95,11 @@ static __always_inline void sev_es_ist_exit(void)
 	if (static_branch_unlikely(&sev_es_enable_key))
 		__sev_es_ist_exit();
 }
+extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
+static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 8f36ae0..346b8a7 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,9 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
+#define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
+#define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6d89df9..9ad36ce 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/stacktrace.h>
 #include <asm/sev-es.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/internal.h>
@@ -214,6 +215,9 @@ static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
 	}
 }
 
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
@@ -402,6 +406,71 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
+static u64 get_jump_table_addr(void)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u64 ret = 0;
+
+	local_irq_save(flags);
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_1(ghcb, SVM_VMGEXIT_GET_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
+	    ghcb_sw_exit_info_2_is_valid(ghcb))
+		ret = ghcb->save.sw_exit_info_2;
+
+	sev_es_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
+{
+	u16 startup_cs, startup_ip;
+	phys_addr_t jump_table_pa;
+	u64 jump_table_addr;
+	u16 __iomem *jump_table;
+
+	jump_table_addr = get_jump_table_addr();
+
+	/* On UP guests there is no jump table so this is not a failure */
+	if (!jump_table_addr)
+		return 0;
+
+	/* Check if AP Jump Table is page-aligned */
+	if (jump_table_addr & ~PAGE_MASK)
+		return -EINVAL;
+
+	jump_table_pa = jump_table_addr & PAGE_MASK;
+
+	startup_cs = (u16)(rmh->trampoline_start >> 4);
+	startup_ip = (u16)(rmh->sev_es_trampoline_start -
+			   rmh->trampoline_start);
+
+	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
+	if (!jump_table)
+		return -EIO;
+
+	writew(startup_ip, &jump_table[0]);
+	writew(startup_cs, &jump_table[1]);
+
+	iounmap(jump_table);
+
+	return 0;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 1ed1208..3fb9b60 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -9,6 +9,7 @@
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
 #include <asm/crash.h>
+#include <asm/sev-es.h>
 
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
@@ -38,6 +39,19 @@ void __init reserve_real_mode(void)
 	crash_reserve_low_1M();
 }
 
+static void sme_sev_setup_real_mode(struct trampoline_header *th)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_active())
+		th->flags |= TH_FLAGS_SME_ACTIVE;
+
+	if (sev_es_active()) {
+		if (sev_es_setup_ap_jump_table(real_mode_header))
+			panic("Failed to get/update SEV-ES AP Jump Table");
+	}
+#endif
+}
+
 static void __init setup_real_mode(void)
 {
 	u16 real_mode_seg;
@@ -104,13 +118,13 @@ static void __init setup_real_mode(void)
 	*trampoline_cr4_features = mmu_cr4_features;
 
 	trampoline_header->flags = 0;
-	if (sme_active())
-		trampoline_header->flags |= TH_FLAGS_SME_ACTIVE;
 
 	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
 	trampoline_pgd[0] = trampoline_pgd_entry.pgd;
 	trampoline_pgd[511] = init_top_pgt[511].pgd;
 #endif
+
+	sme_sev_setup_real_mode(trampoline_header);
 }
 
 /*
