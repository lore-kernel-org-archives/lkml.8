Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DD421941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPWyiB6L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbrScJxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgIJJiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCSjOkW/IVkIprEZv9/1BCNq1kbFS4c+apPeO+UwGr0=;
        b=hPWyiB6LSxuRkPE18lzPqZtvANKEJvhojY3mGo5h5G8L6pL2d2U3joU46OpW71ra/WUemm
        xlSdq9cxDUHhBmV8fz4RZTwBtNSywbwN2tbllplT3UI9n/0ODmT/0VNb6GGeVxkxJvacNa
        hDAMkChrY7p7WjsQNFlNz76OuHwI4yF46BjpzqfjcZ9RfWRLy/am1mYmb9lWw46iIH6mJk
        4rIX/VuzgC4QIDQ/3GdhpmL9i3iNHFJR9NBc4V/F2u2X7XPH0jdfavWh9hTPU3G9yfo5Zx
        pM3NvTsDIlhdG4rqzQcDT8lJV/8AnQDzz3LC+F27/7eYj7E7HGUAe8mflZ/GAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCSjOkW/IVkIprEZv9/1BCNq1kbFS4c+apPeO+UwGr0=;
        b=XbrScJxcp90box7a7x1nlTvOA8E6+D9TfJoAXgpOZRntF3js3W5N/EeXbWdgaP1yt+5YTD
        tqBqZlPA9MwBotAw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Setup per-CPU GHCBs for the runtime handler
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-42-joro@8bytes.org>
References: <20200907131613.12703-42-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973518.20229.13337837901588454962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     885689e47dfa1499b756a07237eb645234d93cf9
Gitweb:        https://git.kernel.org/tip/885689e47dfa1499b756a07237eb645234d93cf9
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/sev-es: Setup per-CPU GHCBs for the runtime handler

The runtime handler needs one GHCB per-CPU. Set them up and map them
unencrypted.

 [ bp: Touchups and simplification. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-42-joro@8bytes.org
---
 arch/x86/include/asm/mem_encrypt.h |  2 +-
 arch/x86/kernel/sev-es.c           | 56 ++++++++++++++++++++++++++++-
 arch/x86/kernel/traps.c            |  3 ++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 4e72b73..c9f5df0 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -49,6 +49,7 @@ void __init mem_encrypt_free_decrypted_mem(void);
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
+void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
@@ -72,6 +73,7 @@ static inline void __init sme_early_init(void) { }
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
+static inline void sev_es_init_vc_handling(void) { }
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 213a427..720b1b6 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -8,8 +8,13 @@
  */
 
 #include <linux/sched/debug.h>	/* For show_regs() */
-#include <linux/kernel.h>
+#include <linux/percpu-defs.h>
+#include <linux/mem_encrypt.h>
 #include <linux/printk.h>
+#include <linux/mm_types.h>
+#include <linux/set_memory.h>
+#include <linux/memblock.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 
 #include <asm/sev-es.h>
@@ -29,6 +34,13 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+/* #VC handler runtime per-CPU data */
+struct sev_es_runtime_data {
+	struct ghcb ghcb_page;
+};
+
+static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -198,6 +210,48 @@ static bool __init sev_es_setup_ghcb(void)
 	return true;
 }
 
+static void __init alloc_runtime_data(int cpu)
+{
+	struct sev_es_runtime_data *data;
+
+	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
+	if (!data)
+		panic("Can't allocate SEV-ES runtime data");
+
+	per_cpu(runtime_data, cpu) = data;
+}
+
+static void __init init_ghcb(int cpu)
+{
+	struct sev_es_runtime_data *data;
+	int err;
+
+	data = per_cpu(runtime_data, cpu);
+
+	err = early_set_memory_decrypted((unsigned long)&data->ghcb_page,
+					 sizeof(data->ghcb_page));
+	if (err)
+		panic("Can't map GHCBs unencrypted");
+
+	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
+}
+
+void __init sev_es_init_vc_handling(void)
+{
+	int cpu;
+
+	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
+
+	if (!sev_es_active())
+		return;
+
+	/* Initialize per-cpu GHCB pages */
+	for_each_possible_cpu(cpu) {
+		alloc_runtime_data(cpu);
+		init_ghcb(cpu);
+	}
+}
+
 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
 {
 	int trapnr = ctxt->fi.vector;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb7..2dc32b0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1074,6 +1074,9 @@ void __init trap_init(void)
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 
+	/* Init GHCB memory pages when running as an SEV-ES guest */
+	sev_es_init_vc_handling();
+
 	idt_setup_traps();
 
 	/*
