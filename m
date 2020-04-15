Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF93BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FE520775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895957AbgDOJvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895891AbgDOJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D7C0610D6;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg2-0005tL-6Y; Wed, 15 Apr 2020 11:49:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC2CB1C0081;
        Wed, 15 Apr 2020 11:49:49 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:49 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Rename "first" function as "early"
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-2-tony.luck@intel.com>
References: <20200214222720.13168-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418938.28353.14495297521999305514.tip-bot2@tip-bot2>
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

Commit-ID:     c9c6d216ed28be6e2c91e3651af169eca284813a
Gitweb:        https://git.kernel.org/tip/c9c6d216ed28be6e2c91e3651af169eca284813a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:14 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:55:01 +02:00

x86/mce: Rename "first" function as "early"

It isn't going to be first on the notifier chain when the CEC is moved
to be a normal user of the notifier chain.

Fix the enum for the MCE_PRIO symbols to list them in reverse order so
that the compiler can give them numbers from low to high priority. Add
an entry for MCE_PRIO_CEC as the highest priority.

 [ bp: Use passive voice, add comments. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-2-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h     | 16 +++++++++-------
 arch/x86/kernel/cpu/mce/core.c | 10 +++++-----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 83b6dda..689ac6e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -144,14 +144,16 @@ struct mce_log_buffer {
 	struct mce entry[];
 };
 
+/* Highest last */
 enum mce_notifier_prios {
-	MCE_PRIO_FIRST		= INT_MAX,
-	MCE_PRIO_UC		= INT_MAX - 1,
-	MCE_PRIO_EXTLOG		= INT_MAX - 2,
-	MCE_PRIO_NFIT		= INT_MAX - 3,
-	MCE_PRIO_EDAC		= INT_MAX - 4,
-	MCE_PRIO_MCELOG		= 1,
-	MCE_PRIO_LOWEST		= 0,
+	MCE_PRIO_LOWEST,
+	MCE_PRIO_MCELOG,
+	MCE_PRIO_EDAC,
+	MCE_PRIO_NFIT,
+	MCE_PRIO_EXTLOG,
+	MCE_PRIO_UC,
+	MCE_PRIO_EARLY,
+	MCE_PRIO_CEC
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a6009ef..43b1519 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -559,7 +559,7 @@ static bool cec_add_mce(struct mce *m)
 	return false;
 }
 
-static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
+static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
 	struct mce *m = (struct mce *)data;
@@ -580,9 +580,9 @@ static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block first_nb = {
-	.notifier_call	= mce_first_notifier,
-	.priority	= MCE_PRIO_FIRST,
+static struct notifier_block early_nb = {
+	.notifier_call	= mce_early_notifier,
+	.priority	= MCE_PRIO_EARLY,
 };
 
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
@@ -2041,7 +2041,7 @@ __setup("mce", mcheck_enable);
 int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
-	mce_register_decode_chain(&first_nb);
+	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
 	mcheck_vendor_init_severity();
