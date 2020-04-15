Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF97206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896036AbgDOJwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895895AbgDOJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170ABC03C1A8;
        Wed, 15 Apr 2020 02:49:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg4-0005v6-WF; Wed, 15 Apr 2020 11:49:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9F3F71C0081;
        Wed, 15 Apr 2020 11:49:52 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:52 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Protect a not-fully initialized bank
 from the thresholding interrupt
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-4-bp@alien8.de>
References: <20200403161943.1458-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419219.28353.17940565183365109106.tip-bot2@tip-bot2>
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

Commit-ID:     cca9cc05fe98f3eb0cfb58ec6739cfc9d0b4ccbf
Gitweb:        https://git.kernel.org/tip/cca9cc05fe98f3eb0cfb58ec6739cfc9d0b4ccbf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Mar 2020 20:05:43 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:47:55 +02:00

x86/mce/amd: Protect a not-fully initialized bank from the thresholding interrupt

Make sure the thresholding bank descriptor is fully initialized when the
thresholding interrupt fires after a hotplug event.

 [ bp: Write commit message and document long-forgotten bank_map. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-4-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c3b3326..5639421 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -192,7 +192,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
-static DEFINE_PER_CPU(unsigned int, bank_map);	/* see which banks are on */
+
+/*
+ * A list of the banks enabled on each logical CPU. Controls which respective
+ * descriptors to initialize later in mce_threshold_create_device().
+ */
+static DEFINE_PER_CPU(unsigned int, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
 static DEFINE_PER_CPU(u32, smca_misc_banks_map);
@@ -1016,13 +1021,22 @@ static void log_and_reset_block(struct threshold_block *block)
 static void amd_threshold_interrupt(void)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
 
+	/*
+	 * Validate that the threshold bank has been initialized already. The
+	 * handler is installed at boot time, but on a hotplug event the
+	 * interrupt might fire before the data has been initialized.
+	 */
+	if (!bp)
+		return;
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
-		first_block = per_cpu(threshold_banks, cpu)[bank]->blocks;
+		first_block = bp[bank]->blocks;
 		if (!first_block)
 			continue;
 
@@ -1247,6 +1261,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	INIT_LIST_HEAD(&b->miscj);
 
+	/* This is safe as @tb is not visible yet */
 	if (tb->blocks)
 		list_add(&b->miscj, &tb->blocks->miscj);
 	else
