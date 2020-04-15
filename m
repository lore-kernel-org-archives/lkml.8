Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9FC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C67E20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896003AbgDOJvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895898AbgDOJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784FC061A0F;
        Wed, 15 Apr 2020 02:49:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg8-0005uC-KL; Wed, 15 Apr 2020 11:49:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 325F51C03A9;
        Wed, 15 Apr 2020 11:49:51 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Cleanup threshold device remove path
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-7-bp@alien8.de>
References: <20200403161943.1458-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419081.28353.17469261837051002623.tip-bot2@tip-bot2>
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

Commit-ID:     f26d2580a7ddc84aa9e51e47fdbb5ad63dbee5a7
Gitweb:        https://git.kernel.org/tip/f26d2580a7ddc84aa9e51e47fdbb5ad63dbee5a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 31 Mar 2020 10:53:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:49:51 +02:00

x86/mce/amd: Cleanup threshold device remove path

Pass in the bank pointer directly to the cleaning up functions,
obviating the need for per-CPU accesses. Make the clean up path
interrupt-safe by cleaning the bank pointer first so that the rest of
the teardown happens safe from the thresholding interrupt.

No functional changes.

 [ bp: Write commit message and reverse bank->shared test to save an
   indentation level in threshold_remove_bank(). ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-7-bp@alien8.de
---
 arch/x86/include/asm/amd_nb.h |  1 +-
 arch/x86/kernel/cpu/mce/amd.c | 79 +++++++++++++++-------------------
 2 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index c7df20e..455066a 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -57,6 +57,7 @@ struct threshold_bank {
 
 	/* initialized to the number of CPUs on the node sharing this bank */
 	refcount_t		cpus;
+	unsigned int		shared;
 };
 
 struct amd_northbridge {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a33d9a1..16e7aea 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1362,6 +1362,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	}
 
 	if (is_shared_bank(bank)) {
+		b->shared = 1;
 		refcount_set(&b->cpus, 1);
 
 		/* nb is already initialized, see above */
@@ -1391,21 +1392,16 @@ static void threshold_block_release(struct kobject *kobj)
 	kfree(to_block(kobj));
 }
 
-static void deallocate_threshold_block(unsigned int cpu, unsigned int bank)
+static void deallocate_threshold_blocks(struct threshold_bank *bank)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-	struct threshold_bank *head = per_cpu(threshold_banks, cpu)[bank];
-
-	if (!head)
-		return;
+	struct threshold_block *pos, *tmp;
 
-	list_for_each_entry_safe(pos, tmp, &head->blocks->miscj, miscj) {
+	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
 		list_del(&pos->miscj);
 		kobject_put(&pos->kobj);
 	}
 
-	kobject_put(&head->blocks->kobj);
+	kobject_put(&bank->blocks->kobj);
 }
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
@@ -1419,57 +1415,56 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 		kobject_del(&pos->kobj);
 }
 
-static void threshold_remove_bank(unsigned int cpu, int bank)
+static void threshold_remove_bank(struct threshold_bank *bank)
 {
 	struct amd_northbridge *nb;
-	struct threshold_bank *b;
 
-	b = per_cpu(threshold_banks, cpu)[bank];
-	if (!b)
-		return;
+	if (!bank->blocks)
+		goto out_free;
 
-	if (!b->blocks)
-		goto free_out;
+	if (!bank->shared)
+		goto out_dealloc;
 
-	if (is_shared_bank(bank)) {
-		if (!refcount_dec_and_test(&b->cpus)) {
-			__threshold_remove_blocks(b);
-			per_cpu(threshold_banks, cpu)[bank] = NULL;
-			return;
-		} else {
-			/*
-			 * the last CPU on this node using the shared bank is
-			 * going away, remove that bank now.
-			 */
-			nb = node_to_amd_nb(amd_get_nb_id(cpu));
-			nb->bank4 = NULL;
-		}
+	if (!refcount_dec_and_test(&bank->cpus)) {
+		__threshold_remove_blocks(bank);
+		return;
+	} else {
+		/*
+		 * The last CPU on this node using the shared bank is going
+		 * away, remove that bank now.
+		 */
+		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb->bank4 = NULL;
 	}
 
-	deallocate_threshold_block(cpu, bank);
+out_dealloc:
+	deallocate_threshold_blocks(bank);
 
-free_out:
-	kobject_del(b->kobj);
-	kobject_put(b->kobj);
-	kfree(b);
-	per_cpu(threshold_banks, cpu)[bank] = NULL;
+out_free:
+	kobject_put(bank->kobj);
+	kfree(bank);
 }
 
 int mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	unsigned int bank;
+	unsigned int bank, numbanks = this_cpu_read(mce_num_banks);
 
 	if (!bp)
 		return 0;
 
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
-			continue;
-		threshold_remove_bank(cpu, bank);
-	}
-	/* Clear the pointer before freeing the memory */
+	/*
+	 * Clear the pointer before cleaning up, so that the interrupt won't
+	 * touch anything of this.
+	 */
 	this_cpu_write(threshold_banks, NULL);
+
+	for (bank = 0; bank < numbanks; bank++) {
+		if (bp[bank]) {
+			threshold_remove_bank(bp[bank]);
+			bp[bank] = NULL;
+		}
+	}
 	kfree(bp);
 	return 0;
 }
