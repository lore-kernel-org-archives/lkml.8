Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D539DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC0820775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895978AbgDOJvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895905AbgDOJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:50:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17076C061A0C;
        Wed, 15 Apr 2020 02:50:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg0-0005re-B4; Wed, 15 Apr 2020 11:49:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D9FA51C0081;
        Wed, 15 Apr 2020 11:49:47 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:47 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Change default MCE logger to check mce->kflags
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-6-tony.luck@intel.com>
References: <20200214222720.13168-6-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418749.28353.3257367523808500822.tip-bot2@tip-bot2>
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

Commit-ID:     925946cfa715a5a71639528f82b98e58f14dd4cb
Gitweb:        https://git.kernel.org/tip/925946cfa715a5a71639528f82b98e58f14dd4cb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:18 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:59:57 +02:00

x86/mce: Change default MCE logger to check mce->kflags

Instead of keeping count of how many handlers are registered on the
MCE notifier chain and printing if below some magic value, look at
mce->kflags to see if anyone claims to have handled/logged this error.

 [ bp: Do not print ->kflags in __print_mce(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-6-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5666a48..fc879b6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -158,29 +158,17 @@ void mce_log(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
-/*
- * We run the default notifier if we have only the UC, the first and the
- * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
- * notifiers registered on the chain.
- */
-#define NUM_DEFAULT_NOTIFIERS	3
-static atomic_t num_notifiers;
-
 void mce_register_decode_chain(struct notifier_block *nb)
 {
 	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
 		return;
 
-	atomic_inc(&num_notifiers);
-
 	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_register_decode_chain);
 
 void mce_unregister_decode_chain(struct notifier_block *nb)
 {
-	atomic_dec(&num_notifiers);
-
 	blocking_notifier_chain_unregister(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
@@ -263,6 +251,7 @@ static void __print_mce(struct mce *m)
 	}
 
 	pr_cont("\n");
+
 	/*
 	 * Note this output is parsed by external tools and old fields
 	 * should not be changed.
@@ -602,10 +591,8 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (atomic_read(&num_notifiers) > NUM_DEFAULT_NOTIFIERS)
-		return NOTIFY_DONE;
-
-	__print_mce(m);
+	if (!m->kflags)
+		__print_mce(m);
 
 	return NOTIFY_DONE;
 }
