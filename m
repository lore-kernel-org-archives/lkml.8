Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5612C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1DA217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBNW10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:27:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:5118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgBNW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756439"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] x86/mce: Fix all mce notifiers to update the mce->kflags bitmask
Date:   Fri, 14 Feb 2020 14:27:17 -0800
Message-Id: <20200214222720.13168-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214222720.13168-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the handler took any action to log or deal with the error, set
a bit int mce->kflags so that the default handler on the end of
the machine check chain can see what has been done.

Get rid of NOTIFY_STOP (well almost ... mce_amd.c is currently using
it to filter out some GART TLB errors ... need to deal with that
later).

Make the EDAC and dev-mcelog handlers skip over errors already
processed by CEC.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c       | 4 +++-
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 5 +++++
 drivers/acpi/acpi_extlog.c           | 5 +++--
 drivers/acpi/nfit/mce.c              | 1 +
 drivers/edac/i7core_edac.c           | 5 +++--
 drivers/edac/mce_amd.c               | 9 +++++++--
 drivers/edac/pnd2_edac.c             | 5 +++--
 drivers/edac/sb_edac.c               | 5 ++++-
 drivers/edac/skx_common.c            | 4 ++++
 drivers/ras/cec.c                    | 9 ++++++---
 10 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 06240cbe6f3e..d3d11d1e52b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -579,8 +579,10 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
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
index 7c8958dee103..f1bf7535ead7 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -43,6 +43,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	unsigned int entry;
 
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
 	mutex_lock(&mce_chrdev_read_mutex);
 
 	entry = mcelog.next;
@@ -60,6 +63,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 
 	memcpy(mcelog.entry + entry, mce, sizeof(struct mce));
 	mcelog.entry[entry].finished = 1;
+	mcelog.entry[entry].kflags = 0;
 
 	/* wake processes polling /dev/mcelog */
 	wake_up_interruptible(&mce_chrdev_wait);
@@ -67,6 +71,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
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
index ea980c556f2e..e31e4db64e1b 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1067,8 +1067,12 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
-	if (ignore_mce(m))
+	if (ignore_mce(m)) {
+		m->kflags |= MCE_HANDLED_EDAC;
 		return NOTIFY_STOP;
+	}
+	if (m->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
 
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
 
@@ -1170,7 +1174,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
  err_code:
 	amd_decode_err_code(m->status & 0xffff);
 
-	return NOTIFY_STOP;
+	m->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block amd_mce_dec_nb = {
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f7722b893..77ad315c7e8d 100644
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
index 4957e8ee1879..6e17f601ea63 100644
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
index d7f6718cbf8d..e061962d3c58 100644
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
2.21.1

