Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F57C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9151206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896046AbgDOJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895892AbgDOJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15617C061BD3;
        Wed, 15 Apr 2020 02:49:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg4-0005ub-07; Wed, 15 Apr 2020 11:49:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A261D1C0081;
        Wed, 15 Apr 2020 11:49:51 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Straighten CPU hotplug path
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-6-bp@alien8.de>
References: <20200403161943.1458-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419128.28353.10655211548905615274.tip-bot2@tip-bot2>
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

Commit-ID:     6458de97fc15530b54477c4e2b70af653e8ac3d9
Gitweb:        https://git.kernel.org/tip/6458de97fc15530b54477c4e2b70af653e8ac3d9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 30 Mar 2020 20:30:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:49:10 +02:00

x86/mce/amd: Straighten CPU hotplug path

mce_threshold_create_device() hotplug callback runs on the plugged in
CPU so:

 - use this_cpu_read() which is faster
 - pass in struct threshold_bank **bp to threshold_create_bank() and
   instead of doing per-CPU accesses
 - Use rdmsr_safe() instead of rdmsr_safe_on_cpu() which avoids an IPI.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-6-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d3c416b..a33d9a1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1223,10 +1223,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	u32 low, high;
 	int err;
 
-	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
+	if ((bank >= this_cpu_read(mce_num_banks)) || (block >= NR_BLOCKS))
 		return 0;
 
-	if (rdmsr_safe_on_cpu(cpu, address, &low, &high))
+	if (rdmsr_safe(address, &low, &high))
 		return 0;
 
 	if (!(high & MASK_VALID_HI)) {
@@ -1316,9 +1316,10 @@ static int __threshold_add_blocks(struct threshold_bank *b)
 	return err;
 }
 
-static int threshold_create_bank(unsigned int cpu, unsigned int bank)
+static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
+				 unsigned int bank)
 {
-	struct device *dev = per_cpu(mce_device, cpu);
+	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
 	const char *name = get_name(bank, NULL);
@@ -1338,7 +1339,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 			if (err)
 				goto out;
 
-			per_cpu(threshold_banks, cpu)[bank] = b;
+			bp[bank] = b;
 			refcount_inc(&b->cpus);
 
 			err = __threshold_add_blocks(b);
@@ -1374,8 +1375,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	if (err)
 		goto out_kobj;
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
+	bp[bank] = b;
 	return 0;
 
 out_kobj:
@@ -1487,35 +1487,33 @@ int mce_threshold_remove_device(unsigned int cpu)
  */
 int mce_threshold_create_device(unsigned int cpu)
 {
-	unsigned int bank;
+	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
 	int err;
 
 	if (!mce_flags.amd_threshold)
 		return 0;
 
-	bp = per_cpu(threshold_banks, cpu);
+	bp = this_cpu_read(threshold_banks);
 	if (bp)
 		return 0;
 
-	bp = kcalloc(per_cpu(mce_num_banks, cpu), sizeof(struct threshold_bank *),
-		     GFP_KERNEL);
+	numbanks = this_cpu_read(mce_num_banks);
+	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
 		return -ENOMEM;
 
-	per_cpu(threshold_banks, cpu) = bp;
-
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+	for (bank = 0; bank < numbanks; ++bank) {
+		if (!(this_cpu_read(bank_map) & (1 << bank)))
 			continue;
-		err = threshold_create_bank(cpu, bank);
+		err = threshold_create_bank(bp, cpu, bank);
 		if (err)
 			goto out_err;
 	}
+	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-
 	return 0;
 out_err:
 	mce_threshold_remove_device(cpu);
