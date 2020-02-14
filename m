Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3992C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124B2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgBNW2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:5118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgBNW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:23 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756449"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:23 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] x86/mce: Drop the EDAC report status checks
Date:   Fri, 14 Feb 2020 14:27:20 -0800
Message-Id: <20200214222720.13168-8-tony.luck@intel.com>
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

When we added acpi_extlog we were worried that the same error
would be reported more than once by different subsystems. But
in the ensuing years I've seen complaints that people could not
find an error log (because this mechanism suppressed the log
they were looking for).

Rip it all out.  People are smart enough to notice the same
address from different reporting mechanisms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_extlog.c | 14 ---------
 drivers/edac/edac_mc.c     | 61 --------------------------------------
 drivers/edac/pnd2_edac.c   |  3 --
 drivers/edac/sb_edac.c     |  4 ---
 drivers/edac/skx_common.c  |  3 --
 include/linux/edac.h       |  8 -----
 6 files changed, 93 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 9cc3c1f92db5..f138e12b7b82 100644
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
@@ -308,7 +295,6 @@ static int __init extlog_init(void)
 
 static void __exit extlog_exit(void)
 {
-	edac_set_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
 	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 	if (extlog_l1_addr)
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..288ba9e0c26d 100644
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
@@ -55,65 +53,6 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
 
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
index 77ad315c7e8d..bfb6c88ebb28 100644
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
index 6e17f601ea63..898f567d5d89 100644
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
index 6f08a12f6b11..423d33aef54f 100644
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
index cc31b9742684..bd770e31ced6 100644
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
-- 
2.21.1

