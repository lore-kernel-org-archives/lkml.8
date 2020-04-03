Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3ABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBFB20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dVtlbBWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404387AbgDCQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:19:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404204AbgDCQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:52 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 053541EC0CD0;
        Fri,  3 Apr 2020 18:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrI2tqziihWKmgid+p/WSz2Owx5iw+EvTOrx+QIvOKk=;
        b=dVtlbBWltlq2p/HQ4jWOYow1Z89liHU0uiofyHM29z09gbQYbw5T6OY+T7hLjb0LnaHwG1
        9X0y+APtISF8w1cB49zb9QzbExHNjiQdb0f0anisQwSuMx+gAcJYgNCDYXlZ7fMj7Nw9gb
        hjum4nbsmWldV/BvDoHfD6O2+Q6dyPE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] x86/mce/amd: Init thresholding machinery only on relevant vendors
Date:   Fri,  3 Apr 2020 18:19:38 +0200
Message-Id: <20200403161943.1458-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403161943.1458-1-bp@alien8.de>
References: <20200403161943.1458-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

... and not unconditionally.

 [ bp: Add a new vendor_flags bit for that. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c      | 12 ++++++++++--
 arch/x86/kernel/cpu/mce/core.c     |  1 +
 arch/x86/kernel/cpu/mce/internal.h |  9 ++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 477cf773cf1c..c3b3326ad4ac 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1442,15 +1442,20 @@ static void threshold_remove_bank(unsigned int cpu, int bank)
 
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
index 54165f3569e8..43ca91e14a77 100644
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
index 3b008172ad73..74a01829c4f4 100644
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
-- 
2.21.0

