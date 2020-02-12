Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCCCC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7EB24650
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgBLUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:46:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:27753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLUqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:46:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281335109"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] x86/mce: Convert corrected error collector to use mce notifier
Date:   Wed, 12 Feb 2020 12:46:49 -0800
Message-Id: <20200212204652.1489-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CEC code has its claws in a couple of routines in mce/core.c

Convert it to just register itself on the normal mce notifier
chain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 19 -------------------
 drivers/ras/cec.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3366807d8e58..06240cbe6f3e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -542,21 +542,6 @@ bool mce_is_correctable(struct mce *m)
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
@@ -565,9 +550,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (cec_add_mce(m))
-		return NOTIFY_STOP;
-
 	/* Emit the trace record: */
 	trace_mce_record(m);
 
@@ -2588,7 +2570,6 @@ static int __init mcheck_late_init(void)
 		static_branch_inc(&mcsafe_key);
 
 	mcheck_debugfs_init();
-	cec_init();
 
 	/*
 	 * Flush out everything that has been logged during early boot, now that
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index c09cf55e2d20..d7f6718cbf8d 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -527,6 +527,29 @@ static int __init create_debugfs_nodes(void)
 	return 1;
 }
 
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
 void __init cec_init(void)
 {
 	if (ce_arr.disabled)
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
-- 
2.21.1

