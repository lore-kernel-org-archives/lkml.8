Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9AB206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895988AbgDOJvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895899AbgDOJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB5C061A10;
        Wed, 15 Apr 2020 02:49:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg8-0005vX-Tx; Wed, 15 Apr 2020 11:49:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 958B11C0081;
        Wed, 15 Apr 2020 11:49:53 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:53 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Do proper cleanup on error paths
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-2-bp@alien8.de>
References: <20200403161943.1458-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419320.28353.3043235024253335642.tip-bot2@tip-bot2>
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

Commit-ID:     ada018b15ccecbdb95df46db7121516edb906bf6
Gitweb:        https://git.kernel.org/tip/ada018b15ccecbdb95df46db7121516edb906bf6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 14 Feb 2020 18:32:43 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:31:17 +02:00

x86/mce/amd: Do proper cleanup on error paths

Drop kobject reference counts properly on error in the banks and blocks
allocation functions.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-2-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 52de616..477cf77 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1267,13 +1267,12 @@ recurse:
 	if (b)
 		kobject_uevent(&b->kobj, KOBJ_ADD);
 
-	return err;
+	return 0;
 
 out_free:
 	if (b) {
-		kobject_put(&b->kobj);
 		list_del(&b->miscj);
-		kfree(b);
+		kobject_put(&b->kobj);
 	}
 	return err;
 }
@@ -1339,6 +1338,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out;
 	}
 
+	/* Associate the bank with the per-CPU MCE device */
 	b->kobj = kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err = -EINVAL;
@@ -1357,16 +1357,17 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 
 	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
 	if (err)
-		goto out_free;
+		goto out_kobj;
 
 	per_cpu(threshold_banks, cpu)[bank] = b;
 
 	return 0;
 
- out_free:
+out_kobj:
+	kobject_put(b->kobj);
+out_free:
 	kfree(b);
-
- out:
+out:
 	return err;
 }
 
