Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E0C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C234D20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PgUHMnen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgDGQeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgDGQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:22 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8F721EC0CE0;
        Tue,  7 Apr 2020 18:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZ5pLgbgSLN1V0f3WtsEnTbKJcsVVonDVjoU3FdkRw4=;
        b=PgUHMnenUY+Ln1t9ksWtf9oWL4xmCrxLKpJ9VYTSIP6rbYZqqCu3S5w/jaHm55x7hwAogC
        SlQB3Hho4/OLqhHJCvEZyY/r2VeiZfLye2b7lv8Z2idN+CGmus6a5NmYdaGo2JIQYh1nMd
        WUnRjqDd770WZz1gf2Ei+zdxDMJN1Og=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] x86/mce/amd, edac: Remove report_gart_errors
Date:   Tue,  7 Apr 2020 18:34:06 +0200
Message-Id: <20200407163414.18058-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... because no one should be interested in spurious MCEs anyway. Make
the filtering unconditional and move it to amd_filter_mce().

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h    |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c |  9 +++++++--
 drivers/edac/amd64_edac.c     |  8 --------
 drivers/edac/mce_amd.c        | 24 ------------------------
 drivers/edac/mce_amd.h        |  2 --
 5 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index f9cea081c05b..83b6ddafa032 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -127,6 +127,8 @@
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
 
+#define XEC(x, mask)			(((x) >> 16) & mask)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
@@ -347,5 +349,4 @@ umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
-
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 15c87b87b901..ea3cf714b7ad 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -577,14 +577,19 @@ bool amd_filter_mce(struct mce *m)
 {
 	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
-	u8 xec = (m->status >> 16) & 0x3F;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 == 0x17 &&
 	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
-	    bank_type == SMCA_IF && xec == 10)
+	    bank_type == SMCA_IF && XEC(m->status, 0x3f) == 10)
 		return true;
 
+	/* NB GART TLB error reporting is disabled by default. */
+	if (c->x86 < 0x17) {
+		if (m->bank == 4 && XEC(m->status, 0x1f) == 0x5)
+			return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f91f3bc1e0b2..6bdc5bb8c8bc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4,9 +4,6 @@
 
 static struct edac_pci_ctl_info *pci_ctl;
 
-static int report_gart_errors;
-module_param(report_gart_errors, int, 0644);
-
 /*
  * Set by command line parameter. If BIOS has enabled the ECC, this override is
  * cleared to prevent re-enabling the hardware by this driver.
@@ -3681,9 +3678,6 @@ static int __init amd64_edac_init(void)
 	}
 
 	/* register stuff with EDAC MCE */
-	if (report_gart_errors)
-		amd_report_gart_errors(true);
-
 	if (boot_cpu_data.x86 >= 0x17)
 		amd_register_ecc_decoder(decode_umc_error);
 	else
@@ -3718,8 +3712,6 @@ static void __exit amd64_edac_exit(void)
 		edac_pci_release_generic_ctl(pci_ctl);
 
 	/* unregister from EDAC MCE */
-	amd_report_gart_errors(false);
-
 	if (boot_cpu_data.x86 >= 0x17)
 		amd_unregister_ecc_decoder(decode_umc_error);
 	else
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8874b7722b2f..e58644d9c92b 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -10,15 +10,8 @@ static struct amd_decoder_ops fam_ops;
 
 static u8 xec_mask	 = 0xf;
 
-static bool report_gart_errors;
 static void (*decode_dram_ecc)(int node_id, struct mce *m);
 
-void amd_report_gart_errors(bool v)
-{
-	report_gart_errors = v;
-}
-EXPORT_SYMBOL_GPL(amd_report_gart_errors);
-
 void amd_register_ecc_decoder(void (*f)(int, struct mce *))
 {
 	decode_dram_ecc = f;
@@ -1030,20 +1023,6 @@ static inline void amd_decode_err_code(u16 ec)
 	pr_cont("\n");
 }
 
-/*
- * Filter out unwanted MCE signatures here.
- */
-static bool ignore_mce(struct mce *m)
-{
-	/*
-	 * NB GART TLB error reporting is disabled by default.
-	 */
-	if (m->bank == 4 && XEC(m->status, 0x1f) == 0x5 && !report_gart_errors)
-		return true;
-
-	return false;
-}
-
 static const char *decode_error_status(struct mce *m)
 {
 	if (m->status & MCI_STATUS_UC) {
@@ -1067,9 +1046,6 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
-	if (ignore_mce(m))
-		return NOTIFY_STOP;
-
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
 
 	pr_emerg(HW_ERR "CPU:%d (%x:%x:%x) MC%d_STATUS[%s|%s|%s|%s|%s",
diff --git a/drivers/edac/mce_amd.h b/drivers/edac/mce_amd.h
index 4e9c5e596c6c..4811b18d9606 100644
--- a/drivers/edac/mce_amd.h
+++ b/drivers/edac/mce_amd.h
@@ -7,7 +7,6 @@
 #include <asm/mce.h>
 
 #define EC(x)				((x) & 0xffff)
-#define XEC(x, mask)			(((x) >> 16) & mask)
 
 #define LOW_SYNDROME(x)			(((x) >> 15) & 0xff)
 #define HIGH_SYNDROME(x)		(((x) >> 24) & 0xff)
@@ -77,7 +76,6 @@ struct amd_decoder_ops {
 	bool (*mc2_mce)(u16, u8);
 };
 
-void amd_report_gart_errors(bool);
 void amd_register_ecc_decoder(void (*f)(int, struct mce *));
 void amd_unregister_ecc_decoder(void (*f)(int, struct mce *));
 
-- 
2.21.0

