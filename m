Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2554C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBA720768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ShfcdAE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgDGQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgDGQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:27 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AB601EC0985;
        Tue,  7 Apr 2020 18:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOfDt3pK6G7IuE+Ro6ZrAWyfrYgSq6SsAk7qyB2c93k=;
        b=ShfcdAE4LTRYLcuoDolh00zD/Wp95JoEoRXlHxjTcQhJVI619tKrXiYKAhowFEuSf9D9N5
        W/qeMfUsybyaYtlryxmzCRAi27Z5rwVR59JmOEU2vv4vqaxj5N5QpwdINEGwmkXst6xskX
        5JVterfWu1gl0AVo8niHRyxl/0yLAhw=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] EDAC: Drop the EDAC report status checks
Date:   Tue,  7 Apr 2020 18:34:13 +0200
Message-Id: <20200407163414.18058-9-bp@alien8.de>
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

When acpi_extlog was added, we were worried that the same error would
be reported more than once by different subsystems. But in the ensuing
years I've seen complaints that people could not find an error log
(because this mechanism suppressed the log they were looking for).

Rip it all out. People are smart enough to notice the same address from
different reporting mechanisms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-8-tony.luck@intel.com
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
index 75ede27bdf6a..5813e931f2f0 100644
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
index 1929a5dc8f94..c1f2e6deb021 100644
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
index f790f7d08688..d414698ca324 100644
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
index 0f20b986b0ab..6eb7d55d7c3d 100644
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
2.21.0

