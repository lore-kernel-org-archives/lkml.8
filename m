Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73621C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29F24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBSSzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:55:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBSSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:55:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4UVV-0002CX-Rc; Wed, 19 Feb 2020 19:55:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 646F81C20D5;
        Wed, 19 Feb 2020 19:55:37 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:55:37 -0000
From:   "tip-bot2 for Prarit Bhargava" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Do not log spurious corrected mce errors
Cc:     Alexander Krupp <centos@akr.yagii.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219131611.36816-1-prarit@redhat.com>
References: <20200219131611.36816-1-prarit@redhat.com>
MIME-Version: 1.0
Message-ID: <158213853701.13786.14681165672201600813.tip-bot2@tip-bot2>
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

Commit-ID:     2976908e4198aa02fc3f76802358f69396267189
Gitweb:        https://git.kernel.org/tip/2976908e4198aa02fc3f76802358f69396267189
Author:        Prarit Bhargava <prarit@redhat.com>
AuthorDate:    Wed, 19 Feb 2020 08:16:11 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Feb 2020 18:14:49 +01:00

x86/mce: Do not log spurious corrected mce errors

A user has reported that they are seeing spurious corrected errors on
their hardware.

Intel Errata HSD131, HSM142, HSW131, and BDM48 report that "spurious
corrected errors may be logged in the IA32_MC0_STATUS register with
the valid field (bit 63) set, the uncorrected error field (bit 61) not
set, a Model Specific Error Code (bits [31:16]) of 0x000F, and an MCA
Error Code (bits [15:0]) of 0x0005." The Errata PDFs are linked in the
bugzilla below.

Block these spurious errors from the console and logs.

 [ bp: Move the intel_filter_mce() header declarations into the already
   existing CONFIG_X86_MCE_INTEL ifdeffery. ]

Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
Signed-off-by: Alexander Krupp <centos@akr.yagii.de>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206587
Link: https://lkml.kernel.org/r/20200219131611.36816-1-prarit@redhat.com
---
 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949..fe3983d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1877,6 +1877,8 @@ bool filter_mce(struct mce *m)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return amd_filter_mce(m);
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return intel_filter_mce(m);
 
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 5627b10..989148e 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -520,3 +520,20 @@ void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
 }
+
+bool intel_filter_mce(struct mce *m)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
+	if ((c->x86 == 6) &&
+	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
+	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
+	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
+	     (c->x86_model == INTEL_FAM6_HASWELL_G)) &&
+	    (m->bank == 0) &&
+	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
+		return true;
+
+	return false;
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b785c0d..97db184 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -48,6 +48,7 @@ void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
+bool intel_filter_mce(struct mce *m);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
@@ -56,6 +57,7 @@ static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
+static inline bool intel_filter_mce(struct mce *m) { return false; };
 #endif
 
 void mce_timer_kick(unsigned long interval);
