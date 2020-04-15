Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD0C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21636206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895945AbgDOJuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895890AbgDOJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C88C0610D5;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg1-0005t5-Ob; Wed, 15 Apr 2020 11:49:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 449831C03A9;
        Wed, 15 Apr 2020 11:49:49 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:48 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Convert the CEC to use the MCE notifier
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-3-tony.luck@intel.com>
References: <20200214222720.13168-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418890.28353.11828147027206185087.tip-bot2@tip-bot2>
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

Commit-ID:     9554bfe403bdfc084823df8695a01f28c680af61
Gitweb:        https://git.kernel.org/tip/9554bfe403bdfc084823df8695a01f28c680af61
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:15 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:58:08 +02:00

x86/mce: Convert the CEC to use the MCE notifier

The CEC code has its claws in a couple of routines in mce/core.c.
Convert it to just register itself on the normal MCE notifier chain.

 [ bp: Make cec_add_elem() and cec_init() static. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 19 -------------------
 drivers/ras/cec.c              | 30 ++++++++++++++++++++++++++++--
 include/linux/ras.h            |  5 -----
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 43b1519..b033b35 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -544,21 +544,6 @@ bool mce_is_correctable(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_correctable);
 
-static bool cec_add_mce(struct mce *m)
-{
-	if (!m)
-		return false;
-
-	/* We eat only correctable DRAM errors with usable addresses. */
-	if (mce_is_memory_error(m) &&
-	    mce_is_correctable(m)  &&
-	    mce_usable_address(m))
-		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
-			return true;
-
-	return false;
-}
-
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
@@ -567,9 +552,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (cec_add_mce(m))
-		return NOTIFY_STOP;
-
 	/* Emit the trace record: */
 	trace_mce_record(m);
 
@@ -2612,7 +2594,6 @@ static int __init mcheck_late_init(void)
 		static_branch_inc(&mcsafe_key);
 
 	mcheck_debugfs_init();
-	cec_init();
 
 	/*
 	 * Flush out everything that has been logged during early boot, now that
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index c09cf55..6b42040 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -309,7 +309,7 @@ static bool sanity_check(struct ce_array *ca)
 	return ret;
 }
 
-int cec_add_elem(u64 pfn)
+static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
 	unsigned int to = 0;
@@ -527,7 +527,30 @@ err:
 	return 1;
 }
 
-void __init cec_init(void)
+static int cec_notifier(struct notifier_block *nb, unsigned long val,
+			void *data)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (!m)
+		return NOTIFY_DONE;
+
+	/* We eat only correctable DRAM errors with usable addresses. */
+	if (mce_is_memory_error(m) &&
+	    mce_is_correctable(m)  &&
+	    mce_usable_address(m))
+		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
+			return NOTIFY_STOP;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cec_nb = {
+	.notifier_call	= cec_notifier,
+	.priority	= MCE_PRIO_CEC,
+};
+
+static void __init cec_init(void)
 {
 	if (ce_arr.disabled)
 		return;
@@ -546,8 +569,11 @@ void __init cec_init(void)
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
+	mce_register_decode_chain(&cec_nb);
+
 	pr_info("Correctable Errors collector initialized.\n");
 }
+late_initcall(cec_init);
 
 int __init parse_cec_param(char *str)
 {
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 7c3debb..1f4048b 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -17,12 +17,7 @@ static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
 
 #ifdef CONFIG_RAS_CEC
-void __init cec_init(void);
 int __init parse_cec_param(char *str);
-int cec_add_elem(u64 pfn);
-#else
-static inline void __init cec_init(void)	{ }
-static inline int cec_add_elem(u64 pfn)		{ return -ENODEV; }
 #endif
 
 #ifdef CONFIG_RAS
