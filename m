Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF43C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE4C2081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbgAPVCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53368 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:39 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHj-00013L-RQ; Thu, 16 Jan 2020 22:02:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 471551C0E70;
        Thu, 16 Jan 2020 22:02:35 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:35 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/mce_amd: Make fam_ops static global
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200116163403.GF27148@zn.tnic>
References: <20200116163403.GF27148@zn.tnic>
MIME-Version: 1.0
Message-ID: <157920855506.396.12217713594707433235.tip-bot2@tip-bot2>
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

Commit-ID:     86e9f9d60eb5e0c5d99ddf6b79f4d308d6453bd0
Gitweb:        https://git.kernel.org/tip/86e9f9d60eb5e0c5d99ddf6b79f4d308d6453bd0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 16 Jan 2020 17:28:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 21:52:48 +01:00

EDAC/mce_amd: Make fam_ops static global

... and do not kmalloc a three-pointer struct. Which simplifies
mce_amd_init() a bit.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200116163403.GF27148@zn.tnic
---
 drivers/edac/mce_amd.c | 68 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 524c63f..ea980c5 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -6,7 +6,7 @@
 
 #include "mce_amd.h"
 
-static struct amd_decoder_ops *fam_ops;
+static struct amd_decoder_ops fam_ops;
 
 static u8 xec_mask	 = 0xf;
 
@@ -583,7 +583,7 @@ static void decode_mc0_mce(struct mce *m)
 					    : (xec ? "multimatch" : "parity")));
 			return;
 		}
-	} else if (fam_ops->mc0_mce(ec, xec))
+	} else if (fam_ops.mc0_mce(ec, xec))
 		;
 	else
 		pr_emerg(HW_ERR "Corrupted MC0 MCE info?\n");
@@ -697,7 +697,7 @@ static void decode_mc1_mce(struct mce *m)
 			pr_cont("Hardware Assert.\n");
 		else
 			goto wrong_mc1_mce;
-	} else if (fam_ops->mc1_mce(ec, xec))
+	} else if (fam_ops.mc1_mce(ec, xec))
 		;
 	else
 		goto wrong_mc1_mce;
@@ -831,7 +831,7 @@ static void decode_mc2_mce(struct mce *m)
 
 	pr_emerg(HW_ERR "MC2 Error: ");
 
-	if (!fam_ops->mc2_mce(ec, xec))
+	if (!fam_ops.mc2_mce(ec, xec))
 		pr_cont(HW_ERR "Corrupted MC2 MCE info?\n");
 }
 
@@ -1130,7 +1130,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (m->tsc)
 		pr_emerg(HW_ERR "TSC: %llu\n", m->tsc);
 
-	if (!fam_ops)
+	/* Doesn't matter which member to test. */
+	if (!fam_ops.mc0_mce)
 		goto err_code;
 
 	switch (m->bank) {
@@ -1185,10 +1186,6 @@ static int __init mce_amd_init(void)
 	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
-	fam_ops = kzalloc(sizeof(struct amd_decoder_ops), GFP_KERNEL);
-	if (!fam_ops)
-		return -ENOMEM;
-
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		xec_mask = 0x3f;
 		goto out;
@@ -1196,59 +1193,58 @@ static int __init mce_amd_init(void)
 
 	switch (c->x86) {
 	case 0xf:
-		fam_ops->mc0_mce = k8_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = k8_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x10:
-		fam_ops->mc0_mce = f10h_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = f10h_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x11:
-		fam_ops->mc0_mce = k8_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = k8_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x12:
-		fam_ops->mc0_mce = f12h_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = f12h_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x14:
-		fam_ops->mc0_mce = cat_mc0_mce;
-		fam_ops->mc1_mce = cat_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = cat_mc0_mce;
+		fam_ops.mc1_mce = cat_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x15:
 		xec_mask = c->x86_model == 0x60 ? 0x3f : 0x1f;
 
-		fam_ops->mc0_mce = f15h_mc0_mce;
-		fam_ops->mc1_mce = f15h_mc1_mce;
-		fam_ops->mc2_mce = f15h_mc2_mce;
+		fam_ops.mc0_mce = f15h_mc0_mce;
+		fam_ops.mc1_mce = f15h_mc1_mce;
+		fam_ops.mc2_mce = f15h_mc2_mce;
 		break;
 
 	case 0x16:
 		xec_mask = 0x1f;
-		fam_ops->mc0_mce = cat_mc0_mce;
-		fam_ops->mc1_mce = cat_mc1_mce;
-		fam_ops->mc2_mce = f16h_mc2_mce;
+		fam_ops.mc0_mce = cat_mc0_mce;
+		fam_ops.mc1_mce = cat_mc1_mce;
+		fam_ops.mc2_mce = f16h_mc2_mce;
 		break;
 
 	case 0x17:
 	case 0x18:
 		pr_warn("Decoding supported only on Scalable MCA processors.\n");
-		goto err_out;
-		break;
+		return -EINVAL;
 
 	default:
 		printk(KERN_WARNING "Huh? What family is it: 0x%x?!\n", c->x86);
-		goto err_out;
+		return -EINVAL;
 	}
 
 out:
@@ -1257,11 +1253,6 @@ out:
 	mce_register_decode_chain(&amd_mce_dec_nb);
 
 	return 0;
-
-err_out:
-	kfree(fam_ops);
-	fam_ops = NULL;
-	return -EINVAL;
 }
 early_initcall(mce_amd_init);
 
@@ -1269,7 +1260,6 @@ early_initcall(mce_amd_init);
 static void __exit mce_amd_exit(void)
 {
 	mce_unregister_decode_chain(&amd_mce_dec_nb);
-	kfree(fam_ops);
 }
 
 MODULE_DESCRIPTION("AMD MCE decoder");
