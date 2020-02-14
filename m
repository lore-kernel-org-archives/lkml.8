Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FA022314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBNW2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:5120 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgBNW1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756432"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:21 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] x86/mce: Convert corrected error collector to use mce notifier
Date:   Fri, 14 Feb 2020 14:27:15 -0800
Message-Id: <20200214222720.13168-3-tony.luck@intel.com>
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

