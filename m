Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40298C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29541206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgHXJCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:02:00 -0400
Received: from 8bytes.org ([81.169.241.247]:38956 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgHXI4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:56:40 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 594D0168B;
        Mon, 24 Aug 2020 10:56:31 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 74/76] x86/sev-es: Handle NMI State
Date:   Mon, 24 Aug 2020 10:55:09 +0200
Message-Id: <20200824085511.7553-75-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When running under SEV-ES the kernel has to tell the hypervisor when to
open the NMI window again after an NMI was injected. This is done with
an NMI-complete message to the hypervisor.

Add code to the kernels NMI handler to send this message right at the
beginning of do_nmi(). This always allows nesting NMIs.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-74-joro@8bytes.org
---
 arch/x86/include/asm/sev-es.h   |  7 +++++++
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kernel/nmi.c           |  6 ++++++
 arch/x86/kernel/sev-es.c        | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 6ca38dc378e0..21fdee11ac83 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -95,10 +95,17 @@ static __always_inline void sev_es_ist_exit(void)
 		__sev_es_ist_exit();
 }
 extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
+extern void __sev_es_nmi_complete(void);
+static __always_inline void sev_es_nmi_complete(void)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_nmi_complete();
+}
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
+static inline void sev_es_nmi_complete(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 20a05839dd9a..0f837339db66 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,7 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_NMI_COMPLETE		0x80000003
 #define SVM_VMGEXIT_AP_HLT_LOOP			0x80000004
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define		SVM_VMGEXIT_SET_AP_JUMP_TABLE			0
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 951f098a4bf5..16ce58c7ed0f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -478,6 +478,12 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 {
 	bool irq_state;
 
+	/*
+	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
+	 * cause nested NMIs, but those can be handled safely.
+	 */
+	sev_es_nmi_complete();
+
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 597ebb73411f..7202d2f5deb8 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -414,6 +414,24 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
+void __sev_es_nmi_complete(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	sev_es_put_ghcb(&state);
+}
+
 static u64 sev_es_get_jump_table_addr(void)
 {
 	struct ghcb_state state;
-- 
2.28.0

