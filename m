Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62417C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4397A20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896070AbgDOJxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895886AbgDOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4FC061A0F;
        Wed, 15 Apr 2020 02:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOefz-0005rU-Bn; Wed, 15 Apr 2020 11:49:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EDDB51C03A9;
        Wed, 15 Apr 2020 11:49:46 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:46 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC: Drop the EDAC report status checks
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-8-tony.luck@intel.com>
References: <20200214222720.13168-8-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418661.28353.12261124197420017840.tip-bot2@tip-bot2>
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

Commit-ID:     7fc0b9b995f222646ece8d5bca528060c098ee88
Gitweb:        https://git.kernel.org/tip/7fc0b9b995f222646ece8d5bca528060c098ee88
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:20 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 16:01:01 +02:00

EDAC: Drop the EDAC report status checks

When acpi_extlog was added, we were worried that the same error would
be reported more than once by different subsystems. But in the ensuing
years I've seen complaints that people could not find an error log
(because this mechanism suppressed the log they were looking for).

Rip it all out. People are smart enough to notice the same address from
different reporting mechanisms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-8-tony.luck@intel.com
---
 drivers/acpi/acpi_extlog.c | 14 +--------
 drivers/edac/edac_mc.c     | 61 +-------------------------------------
 drivers/edac/pnd2_edac.c   |  3 +--
 drivers/edac/sb_edac.c     |  4 +--
 drivers/edac/skx_common.c  |  3 +--
 include/linux/edac.h       |  8 +-----
 6 files changed, 93 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 9cc3c1f..f138e12 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -42,8 +42,6 @@ struct extlog_l1_head {
 	u8  rev1[12];
 };
 
-static int old_edac_report_status;
-
 static u8 extlog_dsm_uuid[] __initdata = "663E35AF-CC10-41A4-88EA-5470AF055295";
 
 /* L1 table related physical address */
@@ -229,11 +227,6 @@ static int __init extlog_init(void)
 	if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
 		return -ENODEV;
 
-	if (edac_get_report_status() == EDAC_REPORTING_FORCE) {
-		pr_warn("Not loading eMCA, error reporting force-enabled through EDAC.\n");
-		return -EPERM;
-	}
-
 	rc = -EINVAL;
 	/* get L1 header to fetch necessary information */
 	l1_hdr_size = sizeof(struct extlog_l1_head);
@@ -281,12 +274,6 @@ static int __init extlog_init(void)
 	if (elog_buf == NULL)
 		goto err_release_elog;
 
-	/*
-	 * eMCA event report method has higher priority than EDAC method,
-	 * unless EDAC event report method is mandatory.
-	 */
-	old_edac_report_status = edac_get_report_status();
-	edac_set_report_status(EDAC_REPORTING_DISABLED);
 	mce_register_decode_chain(&extlog_mce_dec);
 	/* enable OS to be involved to take over management from BIOS */
 	((struct extlog_l1_head *)extlog_l1_addr)->flags |= FLAG_OS_OPTIN;
@@ -308,7 +295,6 @@ err:
 
 static void __exit extlog_exit(void)
 {
-	edac_set_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
 	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 	if (extlog_l1_addr)
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 75ede27..5813e93 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -43,8 +43,6 @@
 int edac_op_state = EDAC_OPSTATE_INVAL;
 EXPORT_SYMBOL_GPL(edac_op_state);
 
-static int edac_report = EDAC_REPORTING_ENABLED;
-
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
@@ -60,65 +58,6 @@ static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *e)
 	return container_of(e, struct mem_ctl_info, error_desc);
 }
 
-int edac_get_report_status(void)
-{
-	return edac_report;
-}
-EXPORT_SYMBOL_GPL(edac_get_report_status);
-
-void edac_set_report_status(int new)
-{
-	if (new == EDAC_REPORTING_ENABLED ||
-	    new == EDAC_REPORTING_DISABLED ||
-	    new == EDAC_REPORTING_FORCE)
-		edac_report = new;
-}
-EXPORT_SYMBOL_GPL(edac_set_report_status);
-
-static int edac_report_set(const char *str, const struct kernel_param *kp)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!strncmp(str, "on", 2))
-		edac_report = EDAC_REPORTING_ENABLED;
-	else if (!strncmp(str, "off", 3))
-		edac_report = EDAC_REPORTING_DISABLED;
-	else if (!strncmp(str, "force", 5))
-		edac_report = EDAC_REPORTING_FORCE;
-
-	return 0;
-}
-
-static int edac_report_get(char *buffer, const struct kernel_param *kp)
-{
-	int ret = 0;
-
-	switch (edac_report) {
-	case EDAC_REPORTING_ENABLED:
-		ret = sprintf(buffer, "on");
-		break;
-	case EDAC_REPORTING_DISABLED:
-		ret = sprintf(buffer, "off");
-		break;
-	case EDAC_REPORTING_FORCE:
-		ret = sprintf(buffer, "force");
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static const struct kernel_param_ops edac_report_ops = {
-	.set = edac_report_set,
-	.get = edac_report_get,
-};
-
-module_param_cb(edac_report, &edac_report_ops, &edac_report, 0644);
-
 unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 				     unsigned int len)
 {
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 1929a5d..c1f2e6d 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1396,9 +1396,6 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 	struct dram_addr daddr;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-		return NOTIFY_DONE;
-
 	mci = pnd2_mci;
 	if (!mci || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index f790f7d..d414698 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3134,8 +3134,6 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-		return NOTIFY_DONE;
 	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
@@ -3526,8 +3524,6 @@ static int __init sbridge_init(void)
 
 	if (rc >= 0) {
 		mce_register_decode_chain(&sbridge_mce_dec);
-		if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-			sbridge_printk(KERN_WARNING, "Loading driver, error reporting disabled.\n");
 		return 0;
 	}
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6f08a12..423d33a 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -574,9 +574,6 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-		return NOTIFY_DONE;
-
 	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 0f20b98..6eb7d55 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -31,14 +31,6 @@ struct device;
 extern int edac_op_state;
 
 struct bus_type *edac_get_sysfs_subsys(void);
-int edac_get_report_status(void);
-void edac_set_report_status(int new);
-
-enum {
-	EDAC_REPORTING_ENABLED,
-	EDAC_REPORTING_DISABLED,
-	EDAC_REPORTING_FORCE
-};
 
 static inline void opstate_init(void)
 {
