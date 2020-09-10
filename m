Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E69C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414E9208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kZmnTX3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQL9apK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIJTyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:54:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIJTwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:52:37 -0400
Date:   Thu, 10 Sep 2020 19:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599767554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txick5ALC6qL2ykJRTautBk8DbO3VkbKX42YfmaBpbM=;
        b=kZmnTX3FFcCbCG+L3BrefarI3tkpGuUt+FhVbdKNmgb5/lmdZ8d+ktnhK7gul0E8eSZeLm
        Ld+VB4FKE7qq3p0vL/39zhh6geLpQ7yO8+kDGah/UPW3zPokRNgYNO/+bgL70WyRrinLJA
        1ICHdUbSkR2bi/qKLeGOZv4eILYCWwqqzY/lJ5l3cgXBpmKMRkG3oW2GMnKFCovQ60BOtA
        b51wkIltXr13IA3Jkn9BIy/GaszjyKMQshnE8cNqjY/YEBENdrnKKbaxf1PYxA8Mkhb0xZ
        MT2Tap9Fw9+4hHZ73+9n+tzfRW1W4AHlae2eIaXomQ1PeS3JteJWgHT5HAosKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599767554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txick5ALC6qL2ykJRTautBk8DbO3VkbKX42YfmaBpbM=;
        b=GQL9apK209A/3+foBWH6zTET29SRNIcKfgEZLm/ZeaKR0bZkiD0BPWSGTuOtm9NCO6SQKo
        ZXGyrS8LPUlcbxCg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/efi: Add GHCB mappings when SEV-ES is active
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-72-joro@8bytes.org>
References: <20200907131613.12703-72-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159976755405.20229.8190086156867136296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     39336f4ffb2478ad384075cf4ba7ef2e5db2bbd7
Gitweb:        https://git.kernel.org/tip/39336f4ffb2478ad384075cf4ba7ef2e5db2bbd7
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Sep 2020 21:48:50 +02:00

x86/efi: Add GHCB mappings when SEV-ES is active

Calling down to EFI runtime services can result in the firmware
performing VMGEXIT calls. The firmware is likely to use the GHCB of the
OS (e.g., for setting EFI variables), so each GHCB in the system needs
to be identity-mapped in the EFI page tables, as unencrypted, to avoid
page faults.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Moved GHCB mapping loop to sev-es.c ]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-72-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c |  1 +-
 arch/x86/include/asm/sev-es.h     |  2 ++-
 arch/x86/kernel/sev-es.c          | 30 ++++++++++++++++++++++++++++++-
 arch/x86/platform/efi/efi_64.c    | 10 ++++++++++-
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 5f15e58..2a6c7c3 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <asm/pgtable_types.h>
 #include <asm/sev-es.h>
 #include <asm/trapnr.h>
 #include <asm/trap_pf.h>
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index e919f09..cf1d957 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -102,11 +102,13 @@ static __always_inline void sev_es_nmi_complete(void)
 	if (static_branch_unlikely(&sev_es_enable_key))
 		__sev_es_nmi_complete();
 }
+extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
+static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index b6518e9..8cac9f8 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -491,6 +491,36 @@ int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 	return 0;
 }
 
+/*
+ * This is needed by the OVMF UEFI firmware which will use whatever it finds in
+ * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
+ * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
+ */
+int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
+{
+	struct sev_es_runtime_data *data;
+	unsigned long address, pflags;
+	int cpu;
+	u64 pfn;
+
+	if (!sev_es_active())
+		return 0;
+
+	pflags = _PAGE_NX | _PAGE_RW;
+
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+
+		address = __pa(&data->ghcb_page);
+		pfn = address >> PAGE_SHIFT;
+
+		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
+			return 1;
+	}
+
+	return 0;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 6af4da1..8f5759d 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -47,6 +47,7 @@
 #include <asm/realmode.h>
 #include <asm/time.h>
 #include <asm/pgalloc.h>
+#include <asm/sev-es.h>
 
 /*
  * We allocate runtime services regions top-down, starting from -4G, i.e.
@@ -230,6 +231,15 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	}
 
 	/*
+	 * When SEV-ES is active, the GHCB as set by the kernel will be used
+	 * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
+	 */
+	if (sev_es_efi_map_ghcbs(pgd)) {
+		pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
+		return 1;
+	}
+
+	/*
 	 * When making calls to the firmware everything needs to be 1:1
 	 * mapped and addressable with 32-bit pointers. Map the kernel
 	 * text and allocate a new stack because we can't rely on the
