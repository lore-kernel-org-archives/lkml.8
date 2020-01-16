Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E2C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB18A2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgAPVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbgAPVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHk-00013U-Rl; Thu, 16 Jan 2020 22:02:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 352FE1C1929;
        Thu, 16 Jan 2020 22:02:36 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:36 -0000
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/mce_amd: Always load on SMCA systems
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110015651.14887-3-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <157920855605.396.13628660534731252208.tip-bot2@tip-bot2>
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

Commit-ID:     9f6aef86315ac31481a288ba1b3f43b2aac93757
Gitweb:        https://git.kernel.org/tip/9f6aef86315ac31481a288ba1b3f43b2aac93757
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 10 Jan 2020 01:56:48 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 17:09:13 +01:00

EDAC/mce_amd: Always load on SMCA systems

MCA error decoding on SMCA systems is not dependent on family. Return
success early if the system supports the SMCA feature.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110015651.14887-3-Yazen.Ghannam@amd.com
---
 drivers/edac/mce_amd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index aa6ea53..524c63f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1189,6 +1189,11 @@ static int __init mce_amd_init(void)
 	if (!fam_ops)
 		return -ENOMEM;
 
+	if (boot_cpu_has(X86_FEATURE_SMCA)) {
+		xec_mask = 0x3f;
+		goto out;
+	}
+
 	switch (c->x86) {
 	case 0xf:
 		fam_ops->mc0_mce = k8_mc0_mce;
@@ -1237,11 +1242,8 @@ static int __init mce_amd_init(void)
 
 	case 0x17:
 	case 0x18:
-		xec_mask = 0x3f;
-		if (!boot_cpu_has(X86_FEATURE_SMCA)) {
-			printk(KERN_WARNING "Decoding supported only on Scalable MCA processors.\n");
-			goto err_out;
-		}
+		pr_warn("Decoding supported only on Scalable MCA processors.\n");
+		goto err_out;
 		break;
 
 	default:
@@ -1249,6 +1251,7 @@ static int __init mce_amd_init(void)
 		goto err_out;
 	}
 
+out:
 	pr_info("MCE: In-kernel MCE decoding enabled.\n");
 
 	mce_register_decode_chain(&amd_mce_dec_nb);
