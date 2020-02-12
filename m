Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5404C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E98A21739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBLUrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:47:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:27753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgBLUqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:46:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281335115"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the mce->handled bitmask
Date:   Wed, 12 Feb 2020 12:46:51 -0800
Message-Id: <20200212204652.1489-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the handler took any action to log or deal with the error, set
a bit int mce->handled so that the default handler on the end of
the machine check chain can see what has been done.

[!!! What to do about NOTIFY_STOP ... any handler that returns this
value short-circuits calling subsequent entries on the chain. In
some cases this may be the right thing to do ... but it others we
really want to keep calling other functions on the chain]

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c       | 4 +++-
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
 drivers/acpi/acpi_extlog.c           | 1 +
 drivers/acpi/nfit/mce.c              | 1 +
 drivers/edac/i7core_edac.c           | 1 +
 drivers/edac/mce_amd.c               | 5 ++++-
 drivers/edac/pnd2_edac.c             | 1 +
 drivers/edac/sb_edac.c               | 1 +
 drivers/edac/skx_common.c            | 1 +
 drivers/ras/cec.c                    | 7 +++++--
 10 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 06240cbe6f3e..ce7a78872f8f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -579,8 +579,10 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0))
+	if (!memory_failure(pfn, 0)) {
 		set_mce_nospec(pfn);
+		mce->handled |= MCE_HANDLED_UC;
+	}
 
 	return NOTIFY_OK;
 }
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 7c8958dee103..83d83c210ab9 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -67,6 +67,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
+	mce->handled |= MCE_HANDLED_MCELOG;
 	return NOTIFY_OK;
 }
 
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 8596a106a933..f7617831ee74 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -176,6 +176,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	}
 
 out:
+	mce->handled |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_STOP;
 }
 
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index f0ae48515b48..c81c879610d6 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -76,6 +76,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 			 */
 			acpi_nfit_ars_rescan(acpi_desc, 0);
 		}
+		mce->handled |= MCE_HANDLED_NFIT;
 		break;
 	}
 
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index b3135b208f9a..727d444e0ac0 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1834,6 +1834,7 @@ static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 	i7core_check_error(mci, mce);
 
 	/* Advise mcelog that the errors were handled */
+	mce->handled |= MCE_HANDLED_EDAC;
 	return NOTIFY_STOP;
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ea980c556f2e..693b0c00b714 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1067,8 +1067,10 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
-	if (ignore_mce(m))
+	if (ignore_mce(m)) {
+		m->handled |= MCE_HANDLED_EDAC;
 		return NOTIFY_STOP;
+	}
 
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
 
@@ -1170,6 +1172,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
  err_code:
 	amd_decode_err_code(m->status & 0xffff);
 
+	m->handled |= MCE_HANDLED_EDAC;
 	return NOTIFY_STOP;
 }
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f7722b893..6c2dee16f4e9 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1429,6 +1429,7 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 	pnd2_mce_output_error(mci, mce, &daddr);
 
 	/* Advice mcelog that the error were handled */
+	mce->handled |= MCE_HANDLED_EDAC;
 	return NOTIFY_STOP;
 }
 
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4957e8ee1879..93dd92f8c9bd 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3183,6 +3183,7 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 	sbridge_mce_output_error(mci, mce);
 
 	/* Advice mcelog that the error were handled */
+	mce->handled |= MCE_HANDLED_EDAC;
 	return NOTIFY_STOP;
 }
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 99bbaf629b8d..1501c8aeb980 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -616,6 +616,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	skx_mce_output_error(mci, mce, &res);
 
+	mce->handled |= MCE_HANDLED_EDAC;
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index d7f6718cbf8d..a993ffacfe9d 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -538,9 +538,12 @@ static int cec_notifier(struct notifier_block *nb, unsigned long val,
 	/* We eat only correctable DRAM errors with usable addresses. */
 	if (mce_is_memory_error(m) &&
 	    mce_is_correctable(m)  &&
-	    mce_usable_address(m))
-		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
+	    mce_usable_address(m)) {
+		if (!cec_add_elem(m->addr >> PAGE_SHIFT)) {
+			m->handled |= MCE_HANDLED_CEC;
 			return NOTIFY_STOP;
+		}
+	}
 
 	return NOTIFY_DONE;
 }
-- 
2.21.1

