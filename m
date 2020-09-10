Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4C121941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAju1UVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8r9WJs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgIJJiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgIJJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:20 -0400
Date:   Thu, 10 Sep 2020 09:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6aPnzNgCPl75LPP9i2pcCTPnrsIX5K+D4UisQtH4yo=;
        b=gAju1UVY56AsruHCOKkW9Zj7zTOgP8P5BBGeQnXR15ClpH67Y2CdFp72UPi5STog8W5f5z
        za4AJnUzgBwk9jwBoXHqLaWXh7IOM8WyG9WIbyjAgHwctjXKPuJKny8Mx1VBy100Qps4Os
        h+myZ6+SOlXp+tDDPC6PPg2g5RQrbHH/BEKHmw1btZOCUF4jUUJXib0+y0kT5GwqEfRujn
        Azeerh3dwabN8+8VtQM+MM0qpY0p/7qKE+5Jw05J86rtNQ5/SDKfos95hSEPBcgayN//rN
        ENdMT7RuHUCTIdBsm6DTMD+NjrEzRjTWUGKbqwR9bC7vMvP72AOg86LZ/XPUKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6aPnzNgCPl75LPP9i2pcCTPnrsIX5K+D4UisQtH4yo=;
        b=N8r9WJs8ay/yeexncEUFADjAS3IvW3Xt4W3I54X4vBjfSfcMx2cftzwqfKXZUjLDjjIvn2
        EmgcVZL811dDMFDw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Add SEV-ES Feature Detection
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-37-joro@8bytes.org>
References: <20200907131613.12703-37-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973726.20229.4326936704104004217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     b57de6cd16395be1ebdaa9b489ffbf462bb585c4
Gitweb:        https://git.kernel.org/tip/b57de6cd16395be1ebdaa9b489ffbf462bb585c4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 23:00:20 +02:00

x86/sev-es: Add SEV-ES Feature Detection

Add a sev_es_active() function for checking whether SEV-ES is enabled.
Also cache the value of MSR_AMD64_SEV at boot to speed up the feature
checking in the running code.

 [ bp: Remove "!!" in sev_active() too. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-37-joro@8bytes.org
---
 arch/x86/include/asm/mem_encrypt.h |  3 +++
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/mm/mem_encrypt.c          |  9 ++++++++-
 arch/x86/mm/mem_encrypt_identity.c |  3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 5049f6c..4e72b73 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -19,6 +19,7 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u64 sme_me_mask;
+extern u64 sev_status;
 extern bool sev_enabled;
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
@@ -50,6 +51,7 @@ void __init mem_encrypt_init(void);
 
 bool sme_active(void);
 bool sev_active(void);
+bool sev_es_active(void);
 
 #define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
 
@@ -72,6 +74,7 @@ static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
+static inline bool sev_es_active(void) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index da34fdb..249a414 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -469,7 +469,9 @@
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
+#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
+#define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f1177e..a38f556 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -38,6 +38,7 @@
  * section is later cleared.
  */
 u64 sme_me_mask __section(.data) = 0;
+u64 sev_status __section(.data) = 0;
 EXPORT_SYMBOL(sme_me_mask);
 DEFINE_STATIC_KEY_FALSE(sev_enable_key);
 EXPORT_SYMBOL_GPL(sev_enable_key);
@@ -347,7 +348,13 @@ bool sme_active(void)
 
 bool sev_active(void)
 {
-	return sme_me_mask && sev_enabled;
+	return sev_status & MSR_AMD64_SEV_ENABLED;
+}
+
+/* Needs to be called from non-instrumentable code */
+bool noinstr sev_es_active(void)
+{
+	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index e2b0e2a..68d7537 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -540,6 +540,9 @@ void __init sme_enable(struct boot_params *bp)
 		if (!(msr & MSR_AMD64_SEV_ENABLED))
 			return;
 
+		/* Save SEV_STATUS to avoid reading MSR again */
+		sev_status = msr;
+
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
