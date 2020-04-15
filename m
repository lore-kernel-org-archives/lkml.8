Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06331C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF749206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896061AbgDOJw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895887AbgDOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B5EC061A10;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOeg0-0005rv-Py; Wed, 15 Apr 2020 11:49:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6A0431C03A9;
        Wed, 15 Apr 2020 11:49:48 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:48 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Fix all mce notifiers to update the
 mce->kflags bitmask
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-5-tony.luck@intel.com>
References: <20200214222720.13168-5-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418803.28353.3640626332771354859.tip-bot2@tip-bot2>
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

Commit-ID:     23ba710a0864108910c7531dc4c73ef65eca5568
Gitweb:        https://git.kernel.org/tip/23ba710a0864108910c7531dc4c73ef65eca5568
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:17 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 15:59:26 +02:00

x86/mce: Fix all mce notifiers to update the mce->kflags bitmask

If the handler took any action to log or deal with the error, set a bit
in mce->kflags so that the default handler on the end of the machine
check chain can see what has been done.

Get rid of NOTIFY_STOP returns. Make the EDAC and dev-mcelog handlers
skip over errors already processed by CEC.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-5-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c       |  4 +++-
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  5 +++++
 drivers/acpi/acpi_extlog.c           |  5 +++--
 drivers/acpi/nfit/mce.c              |  1 +
 drivers/edac/i7core_edac.c           |  5 +++--
 drivers/edac/mce_amd.c               |  6 +++++-
 drivers/edac/pnd2_edac.c             |  5 +++--
 drivers/edac/sb_edac.c               |  5 ++++-
 drivers/edac/skx_common.c            |  4 ++++
 drivers/ras/cec.c                    |  9 ++++++---
 10 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b033b35..5666a48 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -581,8 +581,10 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0))
+	if (!memory_failure(pfn, 0)) {
 		set_mce_nospec(pfn);
+		mce->kflags |= MCE_HANDLED_UC;
+	}
 
 	return NOTIFY_OK;
 }
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index d089567..c033e7e 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -39,6 +39,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	unsigned int entry;
 
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
 	mutex_lock(&mce_chrdev_read_mutex);
 
 	entry = mcelog->next;
@@ -56,6 +59,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 
 	memcpy(mcelog->entry + entry, mce, sizeof(struct mce));
 	mcelog->entry[entry].finished = 1;
+	mcelog->entry[entry].kflags = 0;
 
 	/* wake processes polling /dev/mcelog */
 	wake_up_interruptible(&mce_chrdev_wait);
@@ -63,6 +67,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
+	mce->kflags |= MCE_HANDLED_MCELOG;
 	return NOTIFY_OK;
 }
 
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 8596a10..9cc3c1f 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -146,7 +146,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
-	if (estatus == NULL)
+	if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
@@ -176,7 +176,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	}
 
 out:
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EXTLOG;
+	return NOTIFY_OK;
 }
 
 static bool __init extlog_get_l1addr(void)
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index f0ae485..ee8d997 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -76,6 +76,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 			 */
 			acpi_nfit_ars_rescan(acpi_desc, 0);
 		}
+		mce->kflags |= MCE_HANDLED_NFIT;
 		break;
 	}
 
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index b3135b2..5860ca4 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1815,7 +1815,7 @@ static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 
 	i7_dev = get_i7core_dev(mce->socketid);
-	if (!i7_dev)
+	if (!i7_dev || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	mci = i7_dev->mci;
@@ -1834,7 +1834,8 @@ static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 	i7core_check_error(mci, mce);
 
 	/* Advise mcelog that the errors were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block i7_mce_dec = {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index e58644d..2b5401d 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1046,6 +1046,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
+	if (m->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
 
 	pr_emerg(HW_ERR "CPU:%d (%x:%x:%x) MC%d_STATUS[%s|%s|%s|%s|%s",
@@ -1146,7 +1149,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
  err_code:
 	amd_decode_err_code(m->status & 0xffff);
 
-	return NOTIFY_STOP;
+	m->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block amd_mce_dec_nb = {
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index bc47328..1929a5d 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1400,7 +1400,7 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 		return NOTIFY_DONE;
 
 	mci = pnd2_mci;
-	if (!mci)
+	if (!mci || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	/*
@@ -1429,7 +1429,8 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 	pnd2_mce_output_error(mci, mce, &daddr);
 
 	/* Advice mcelog that the error were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block pnd2_mce_dec = {
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 7d51c82..f790f7d 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3136,6 +3136,8 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
 		return NOTIFY_DONE;
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
 
 	/*
 	 * Just let mcelog handle it if the error is
@@ -3183,7 +3185,8 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 	sbridge_mce_output_error(mci, mce);
 
 	/* Advice mcelog that the error were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block sbridge_mce_dec = {
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 99bbaf6..6f08a12 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -577,6 +577,9 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
 		return NOTIFY_DONE;
 
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
 	/* ignore unless this is memory related with an address */
 	if ((mce->status & 0xefff) >> 7 != 1 || !(mce->status & MCI_STATUS_ADDRV))
 		return NOTIFY_DONE;
@@ -616,6 +619,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	skx_mce_output_error(mci, mce, &res);
 
+	mce->kflags |= MCE_HANDLED_EDAC;
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 6b42040..569d9ad 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -538,9 +538,12 @@ static int cec_notifier(struct notifier_block *nb, unsigned long val,
 	/* We eat only correctable DRAM errors with usable addresses. */
 	if (mce_is_memory_error(m) &&
 	    mce_is_correctable(m)  &&
-	    mce_usable_address(m))
-		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
-			return NOTIFY_STOP;
+	    mce_usable_address(m)) {
+		if (!cec_add_elem(m->addr >> PAGE_SHIFT)) {
+			m->kflags |= MCE_HANDLED_CEC;
+			return NOTIFY_OK;
+		}
+	}
 
 	return NOTIFY_DONE;
 }
