Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43082C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D2D206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896053AbgDOJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895893AbgDOJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB60C03C1A6;
        Wed, 15 Apr 2020 02:49:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg2-0005tc-Lx; Wed, 15 Apr 2020 11:49:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D73C1C03A9;
        Wed, 15 Apr 2020 11:49:50 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:49 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd, edac: Remove report_gart_errors
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407163414.18058-2-bp@alien8.de>
References: <20200407163414.18058-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694418990.28353.15548445324761477732.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3e0fdec858d82c829774f271e88b5ceb17051551
Gitweb:        https://git.kernel.org/tip/3e0fdec858d82c829774f271e88b5ceb17051551
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 07 Apr 2020 09:55:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:53:46 +02:00

x86/mce/amd, edac: Remove report_gart_errors

... because no one should be interested in spurious MCEs anyway. Make
the filtering unconditional and move it to amd_filter_mce().

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200407163414.18058-2-bp@alien8.de
---
 arch/x86/include/asm/mce.h    |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c |  9 +++++++--
 drivers/edac/amd64_edac.c     |  8 --------
 drivers/edac/mce_amd.c        | 24 ------------------------
 drivers/edac/mce_amd.h        |  2 --
 5 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index f9cea08..83b6dda 100644
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
index 15c87b8..ea3cf71 100644
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
index f91f3bc..6bdc5bb 100644
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
index 8874b77..e58644d 100644
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
index 4e9c5e5..4811b18 100644
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
 
