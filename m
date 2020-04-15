Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A00720775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896018AbgDOJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895894AbgDOJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB125C061A0C;
        Wed, 15 Apr 2020 02:49:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg6-0005vL-GG; Wed, 15 Apr 2020 11:49:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2367B1C0493;
        Wed, 15 Apr 2020 11:49:53 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:52 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Init thresholding machinery only on
 relevant vendors
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-3-bp@alien8.de>
References: <20200403161943.1458-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419273.28353.5335708172984243606.tip-bot2@tip-bot2>
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

Commit-ID:     c9bf318f77b3a78483e656e609d005c52aadc86d
Gitweb:        https://git.kernel.org/tip/c9bf318f77b3a78483e656e609d005c52aadc86d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 12 Feb 2020 00:34:01 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:47:11 +02:00

x86/mce/amd: Init thresholding machinery only on relevant vendors

... and not unconditionally.

 [ bp: Add a new vendor_flags bit for that. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-3-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c      | 12 ++++++++++--
 arch/x86/kernel/cpu/mce/core.c     |  1 +
 arch/x86/kernel/cpu/mce/internal.h |  9 ++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 477cf77..c3b3326 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1442,15 +1442,20 @@ free_out:
 
 int mce_threshold_remove_device(unsigned int cpu)
 {
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank;
 
+	if (!bp)
+		return 0;
+
 	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 		threshold_remove_bank(cpu, bank);
 	}
-	kfree(per_cpu(threshold_banks, cpu));
-	per_cpu(threshold_banks, cpu) = NULL;
+	/* Clear the pointer before freeing the memory */
+	this_cpu_write(threshold_banks, NULL);
+	kfree(bp);
 	return 0;
 }
 
@@ -1461,6 +1466,9 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err = 0;
 
+	if (!mce_flags.amd_threshold)
+		return 0;
+
 	bp = per_cpu(threshold_banks, cpu);
 	if (bp)
 		return 0;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 54165f3..43ca91e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1756,6 +1756,7 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
+		mce_flags.amd_threshold	 = 1;
 
 		if (mce_flags.smca) {
 			msr_ops.ctl	= smca_ctl_reg;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 3b00817..74a0182 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -148,7 +148,7 @@ struct mce_vendor_flags {
 	 * Recovery. It indicates support for data poisoning in HW and deferred
 	 * error interrupts.
 	 */
-	      succor		: 1,
+	succor			: 1,
 
 	/*
 	 * (AMD) SMCA: This bit indicates support for Scalable MCA which expands
@@ -156,9 +156,12 @@ struct mce_vendor_flags {
 	 * banks. Also, to accommodate the new banks and registers, the MCA
 	 * register space is moved to a new MSR range.
 	 */
-	      smca		: 1,
+	smca			: 1,
 
-	      __reserved_0	: 61;
+	/* AMD-style error thresholding banks present. */
+	amd_threshold		: 1,
+
+	__reserved_0		: 60;
 };
 
 extern struct mce_vendor_flags mce_flags;
