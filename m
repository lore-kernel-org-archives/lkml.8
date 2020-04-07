Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3008C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF831206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f7NWj5/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgDGQe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgDGQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:25 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DB901EC0CE7;
        Tue,  7 Apr 2020 18:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDgbKfx+MYULAUC3vXuOtGr5jdJ2m5guSWRYfageLn8=;
        b=f7NWj5/rDeT/vAk9d8OSJJfZKcoXuBUf3bpBKgSh4mnQ88gRToyTb6HcGqUXsAin8YN2fW
        HARnVTIxMTfIsrpje3LPVsw+xgmVxsU4VQFOeWZjlR+14M/g5/mal0m7/GO9aRA/45Gs8x
        pY7y4LDS4aIYsdh4b7HUQmYCJydNTRM=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] x86/mce: Fix all mce notifiers to update the mce->kflags bitmask
Date:   Tue,  7 Apr 2020 18:34:10 +0200
Message-Id: <20200407163414.18058-6-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

If the handler took any action to log or deal with the error, set a bit
in mce->kflags so that the default handler on the end of the machine
check chain can see what has been done.

Get rid of NOTIFY_STOP returns. Make the EDAC and dev-mcelog handlers
skip over errors already processed by CEC.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-5-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c       | 4 +++-
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 5 +++++
 drivers/acpi/acpi_extlog.c           | 5 +++--
 drivers/acpi/nfit/mce.c              | 1 +
 drivers/edac/i7core_edac.c           | 5 +++--
 drivers/edac/mce_amd.c               | 6 +++++-
 drivers/edac/pnd2_edac.c             | 5 +++--
 drivers/edac/sb_edac.c               | 5 ++++-
 drivers/edac/skx_common.c            | 4 ++++
 drivers/ras/cec.c                    | 9 ++++++---
 10 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b033b3589630..5666a48a4bc9 100644
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
index d089567a9ce8..c033e7ea9e3c 100644
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
index 8596a106a933..9cc3c1f92db5 100644
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
index f0ae48515b48..ee8d9973f60b 100644
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
index b3135b208f9a..5860ca41185c 100644
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
index e58644d9c92b..2b5401db56ad 100644
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
index bc47328eb485..1929a5dc8f94 100644
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
index 7d51c82be62b..f790f7d08688 100644
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
index 99bbaf629b8d..6f08a12f6b11 100644
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
index 6b42040bf956..569d9ad2c594 100644
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
-- 
2.21.0

