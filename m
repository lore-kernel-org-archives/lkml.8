Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FDCC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052D20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBVVGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:06:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgBVVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:06:02 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j5byF-0003Ae-Sw; Sat, 22 Feb 2020 22:05:56 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 444A7104089;
        Sat, 22 Feb 2020 22:05:55 +0100 (CET)
Date:   Sat, 22 Feb 2020 21:00:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] ras fixes for 5.6-rc3
References: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
Message-ID: <158240520445.852.9501937854549164336.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-2020-02-22

up to:  51dede9c05df: x86/mce/amd: Fix kobject lifetime

Two fixes for the AMD MCE driver:

  - Populate the per CPU MCA bank descriptor pointer only after it has been
    completely set up to prevent a use-after-free in case that one of the
    subsequent initialization step fails

  - Implement a proper release function for the sysfs entries of MCA
    threshold controls instead of freeing the memory right in the CPU
    teardown code, which leads to another use-after-free when the
    associated sysfs file is opened and accessed.


Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/mce/amd: Publish the bank pointer only after setup has succeeded

Thomas Gleixner (1):
      x86/mce/amd: Fix kobject lifetime


 arch/x86/kernel/cpu/mce/amd.c | 50 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b3a50d962851..52de616a8065 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1163,9 +1163,12 @@ static const struct sysfs_ops threshold_ops = {
 	.store			= store,
 };
 
+static void threshold_block_release(struct kobject *kobj);
+
 static struct kobj_type threshold_ktype = {
 	.sysfs_ops		= &threshold_ops,
 	.default_attrs		= default_attrs,
+	.release		= threshold_block_release,
 };
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
@@ -1198,8 +1201,9 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	return buf_mcatype;
 }
 
-static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
-				     unsigned int block, u32 address)
+static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb,
+				     unsigned int bank, unsigned int block,
+				     u32 address)
 {
 	struct threshold_block *b = NULL;
 	u32 low, high;
@@ -1243,16 +1247,12 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 
 	INIT_LIST_HEAD(&b->miscj);
 
-	if (per_cpu(threshold_banks, cpu)[bank]->blocks) {
-		list_add(&b->miscj,
-			 &per_cpu(threshold_banks, cpu)[bank]->blocks->miscj);
-	} else {
-		per_cpu(threshold_banks, cpu)[bank]->blocks = b;
-	}
+	if (tb->blocks)
+		list_add(&b->miscj, &tb->blocks->miscj);
+	else
+		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype,
-				   per_cpu(threshold_banks, cpu)[bank]->kobj,
-				   get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1260,7 +1260,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	if (!address)
 		return 0;
 
-	err = allocate_threshold_blocks(cpu, bank, block, address);
+	err = allocate_threshold_blocks(cpu, tb, bank, block, address);
 	if (err)
 		goto out_free;
 
@@ -1345,8 +1345,6 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out_free;
 	}
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
 	if (is_shared_bank(bank)) {
 		refcount_set(&b->cpus, 1);
 
@@ -1357,9 +1355,13 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
+	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	if (err)
+		goto out_free;
+
+	per_cpu(threshold_banks, cpu)[bank] = b;
+
+	return 0;
 
  out_free:
 	kfree(b);
@@ -1368,8 +1370,12 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	return err;
 }
 
-static void deallocate_threshold_block(unsigned int cpu,
-						 unsigned int bank)
+static void threshold_block_release(struct kobject *kobj)
+{
+	kfree(to_block(kobj));
+}
+
+static void deallocate_threshold_block(unsigned int cpu, unsigned int bank)
 {
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
@@ -1379,13 +1385,11 @@ static void deallocate_threshold_block(unsigned int cpu,
 		return;
 
 	list_for_each_entry_safe(pos, tmp, &head->blocks->miscj, miscj) {
-		kobject_put(&pos->kobj);
 		list_del(&pos->miscj);
-		kfree(pos);
+		kobject_put(&pos->kobj);
 	}
 
-	kfree(per_cpu(threshold_banks, cpu)[bank]->blocks);
-	per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;
+	kobject_put(&head->blocks->kobj);
 }
 
 static void __threshold_remove_blocks(struct threshold_bank *b)

