Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6906BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E3C20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895866AbgDOJwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895897AbgDOJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187EC061A0E;
        Wed, 15 Apr 2020 02:49:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg7-0005ug-Gb; Wed, 15 Apr 2020 11:49:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 188D51C0450;
        Wed, 15 Apr 2020 11:49:52 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Sanitize thresholding device creation
 hotplug path
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403161943.1458-5-bp@alien8.de>
References: <20200403161943.1458-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694419173.28353.4360802211784932006.tip-bot2@tip-bot2>
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

Commit-ID:     6e7a41c63abcfee28734c4c8872dae8d642329b6
Gitweb:        https://git.kernel.org/tip/6e7a41c63abcfee28734c4c8872dae8d642329b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 30 Mar 2020 16:21:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:48:30 +02:00

x86/mce/amd: Sanitize thresholding device creation hotplug path

Drop the stupid threshold_init_device() initcall iterating over all
online CPUs in favor of properly setting up everything on the CPU
hotplug path, when each CPU's callback is invoked.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200403161943.1458-5-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c  | 57 +++++++++------------------------
 arch/x86/kernel/cpu/mce/core.c | 11 ++++++-
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5639421..d3c416b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1474,12 +1474,22 @@ int mce_threshold_remove_device(unsigned int cpu)
 	return 0;
 }
 
-/* create dir/files for all valid threshold banks */
+/**
+ * mce_threshold_create_device - Create the per-CPU MCE threshold device
+ * @cpu:	The plugged in CPU
+ *
+ * Create directories and files for all valid threshold banks.
+ *
+ * This is invoked from the CPU hotplug callback which was installed in
+ * mcheck_init_device(). The invocation happens in context of the hotplug
+ * thread running on @cpu.  The callback is invoked on all CPUs which are
+ * online when the callback is installed or during a real hotplug event.
+ */
 int mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int bank;
 	struct threshold_bank **bp;
-	int err = 0;
+	int err;
 
 	if (!mce_flags.amd_threshold)
 		return 0;
@@ -1500,49 +1510,14 @@ int mce_threshold_create_device(unsigned int cpu)
 			continue;
 		err = threshold_create_bank(cpu, bank);
 		if (err)
-			goto err;
-	}
-	return err;
-err:
-	mce_threshold_remove_device(cpu);
-	return err;
-}
-
-static __init int threshold_init_device(void)
-{
-	unsigned lcpu = 0;
-
-	/* to hit CPUs online before the notifier is up */
-	for_each_online_cpu(lcpu) {
-		int err = mce_threshold_create_device(lcpu);
-
-		if (err)
-			return err;
+			goto out_err;
 	}
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
 
 	return 0;
+out_err:
+	mce_threshold_remove_device(cpu);
+	return err;
 }
-/*
- * there are 3 funcs which need to be _initcalled in a logic sequence:
- * 1. xen_late_init_mcelog
- * 2. mcheck_init_device
- * 3. threshold_init_device
- *
- * xen_late_init_mcelog must register xen_mce_chrdev_device before
- * native mce_chrdev_device registration if running under xen platform;
- *
- * mcheck_init_device should be inited before threshold_init_device to
- * initialize mce_device, otherwise a NULL ptr dereference will cause panic.
- *
- * so we use following _initcalls
- * 1. device_initcall(xen_late_init_mcelog);
- * 2. device_initcall_sync(mcheck_init_device);
- * 3. late_initcall(threshold_init_device);
- *
- * when running under xen, the initcall order is 1,2,3;
- * on baremetal, we skip 1 and we do only 2 and 3.
- */
-late_initcall(threshold_init_device);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 43ca91e..a6009ef 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2481,6 +2481,13 @@ static __init void mce_init_banks(void)
 	}
 }
 
+/*
+ * When running on XEN, this initcall is ordered against the XEN mcelog
+ * initcall:
+ *
+ *   device_initcall(xen_late_init_mcelog);
+ *   device_initcall_sync(mcheck_init_device);
+ */
 static __init int mcheck_init_device(void)
 {
 	int err;
@@ -2512,6 +2519,10 @@ static __init int mcheck_init_device(void)
 	if (err)
 		goto err_out_mem;
 
+	/*
+	 * Invokes mce_cpu_online() on all CPUs which are online when
+	 * the state is installed.
+	 */
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/mce:online",
 				mce_cpu_online, mce_cpu_pre_down);
 	if (err < 0)
