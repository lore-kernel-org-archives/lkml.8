Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2A8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB021556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQjmajbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/Soq6Vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIJJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:22:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:07 -0400
Date:   Thu, 10 Sep 2020 09:22:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frpSjncJLU9SXbHKTKLo6vQ6DaBpk51FY2szvnht8Mo=;
        b=HQjmajbLcG8BobZZfs3ly1EPsSM0y/45qfJtBAciU3+NGOZdE6JxFQY5RICMRR2pENzOTM
        GL6qn5E0/Zj0STsgpkBlTDk++RuVhvRIXbFRnWYti/05L5D6ELn8CMUp9QKITGB4CLhdYg
        MJYRCALCDTb0Fh++vABOdmUlocszg3CW66dB+GRQz+2fnJZxA1GpouvGh0tQ/MEwUX4gVJ
        wzJ6IilrQYapFiJwEZcAWBeBDeBmW3xkPHk6h8Od8pAT+F7RBj9I1kJsUsAUauW/8RXiRK
        uGtb5yXfWSy0EbUIVWl2BBCPO1jcHvuI8ndF4mHt3YLqRPwCPwOJVOAQWqo3Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frpSjncJLU9SXbHKTKLo6vQ6DaBpk51FY2szvnht8Mo=;
        b=I/Soq6Vr26gA053qqd52vrgGBZzDTLiUu09ku7vpNubMjTggxIqVwdNrERJnsb3ZZ/wgVQ
        /hr3Tt3dkKm1MECA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle NMI State
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-71-joro@8bytes.org>
References: <20200907131613.12703-71-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972316.20229.16608188045012606373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     4ca68e023b11e4d5908bf9ee326fab01111d77d5
Gitweb:        https://git.kernel.org/tip/4ca68e023b11e4d5908bf9ee326fab01111d77d5
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:11 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 18:02:35 +02:00

x86/sev-es: Handle NMI State

When running under SEV-ES, the kernel has to tell the hypervisor when to
open the NMI window again after an NMI was injected. This is done with
an NMI-complete message to the hypervisor.

Add code to the kernel's NMI handler to send this message right at the
beginning of do_nmi(). This always allows nesting NMIs.

 [ bp: Mark __sev_es_nmi_complete() noinstr:
   vmlinux.o: warning: objtool: exc_nmi()+0x17: call to __sev_es_nmi_complete()
	leaves .noinstr.text section
   While at it, use __pa_nodebug() for the same reason due to
   CONFIG_DEBUG_VIRTUAL=y:
   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xd9: call to __phys_addr()
   	leaves .noinstr.text section ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-71-joro@8bytes.org
---
 arch/x86/include/asm/sev-es.h   |  7 +++++++
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kernel/nmi.c           |  6 ++++++
 arch/x86/kernel/sev-es.c        | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index db88e1c..e919f09 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -96,10 +96,17 @@ static __always_inline void sev_es_ist_exit(void)
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
index c1dcf3e..a7a3403 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,7 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_NMI_COMPLETE		0x80000003
 #define SVM_VMGEXIT_AP_HLT_LOOP			0x80000004
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4c89c4d..56b64d7 100644
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
index d1bcd0d..b6518e9 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -408,6 +408,24 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
+void noinstr __sev_es_nmi_complete(void)
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
+	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
+	VMGEXIT();
+
+	sev_es_put_ghcb(&state);
+}
+
 static u64 get_jump_table_addr(void)
 {
 	struct ghcb_state state;
