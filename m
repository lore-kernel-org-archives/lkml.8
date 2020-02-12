Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F084C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6AE24650
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBLUqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:46:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:27753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBLUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:46:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281335105"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] x86/mce: Rename "first" function as "early"
Date:   Wed, 12 Feb 2020 12:46:48 -0800
Message-Id: <20200212204652.1489-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't going to be first on the notifier chain when we move
the CEC code to be a normal user of the notifier chain.

Fix the enum for the MCE_PRIO symbols to list them in reverse
order so that the compiler can give them numbers from low to
high priority. Add an entry for MCE_PRIO_CEC as the highest
priority.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/mce.h     | 15 ++++++++-------
 arch/x86/kernel/cpu/mce/core.c | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4359b955e0b7..6f17cc618d5e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -143,13 +143,14 @@ struct mce_log_buffer {
 };
 
 enum mce_notifier_prios {
-	MCE_PRIO_FIRST		= INT_MAX,
-	MCE_PRIO_UC		= INT_MAX - 1,
-	MCE_PRIO_EXTLOG		= INT_MAX - 2,
-	MCE_PRIO_NFIT		= INT_MAX - 3,
-	MCE_PRIO_EDAC		= INT_MAX - 4,
-	MCE_PRIO_MCELOG		= 1,
-	MCE_PRIO_LOWEST		= 0,
+	MCE_PRIO_LOWEST,
+	MCE_PRIO_MCELOG,
+	MCE_PRIO_EDAC,
+	MCE_PRIO_NFIT,
+	MCE_PRIO_EXTLOG,
+	MCE_PRIO_UC,
+	MCE_PRIO_EARLY,
+	MCE_PRIO_CEC
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949611e4..3366807d8e58 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -557,7 +557,7 @@ static bool cec_add_mce(struct mce *m)
 	return false;
 }
 
-static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
+static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
 	struct mce *m = (struct mce *)data;
@@ -578,9 +578,9 @@ static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block first_nb = {
-	.notifier_call	= mce_first_notifier,
-	.priority	= MCE_PRIO_FIRST,
+static struct notifier_block early_nb = {
+	.notifier_call	= mce_early_notifier,
+	.priority	= MCE_PRIO_EARLY,
 };
 
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
@@ -2028,7 +2028,7 @@ __setup("mce", mcheck_enable);
 int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
-	mce_register_decode_chain(&first_nb);
+	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
 	mcheck_vendor_init_severity();
-- 
2.21.1

