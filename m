Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57F9C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E4524670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBNW11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:27:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:5118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgBNW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756442"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] x86/mce: Change default mce logger to check mce->kflags
Date:   Fri, 14 Feb 2020 14:27:18 -0800
Message-Id: <20200214222720.13168-6-tony.luck@intel.com>
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

Instead of keeping count of how many handlers are registered on the
mce chain and printing if we are below some magic value. Look at the
mce->kflags to see if anyone claims to have handled/logged this error.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d3d11d1e52b3..066d3903ef97 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,29 +156,17 @@ void mce_log(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
-/*
- * We run the default notifier if we have only the UC, the first and the
- * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
- * notifiers registered on the chain.
- */
-#define NUM_DEFAULT_NOTIFIERS	3
-static atomic_t num_notifiers;
-
 void mce_register_decode_chain(struct notifier_block *nb)
 {
 	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
 		return;
 
-	atomic_inc(&num_notifiers);
-
 	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_register_decode_chain);
 
 void mce_unregister_decode_chain(struct notifier_block *nb)
 {
-	atomic_dec(&num_notifiers);
-
 	blocking_notifier_chain_unregister(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
@@ -261,6 +249,8 @@ static void __print_mce(struct mce *m)
 	}
 
 	pr_cont("\n");
+	if (m->kflags)
+		pr_emerg(HW_ERR "kflags = 0x%llx\n", m->kflags);
 	/*
 	 * Note this output is parsed by external tools and old fields
 	 * should not be changed.
@@ -600,10 +590,8 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (atomic_read(&num_notifiers) > NUM_DEFAULT_NOTIFIERS)
-		return NOTIFY_DONE;
-
-	__print_mce(m);
+	if (!m->kflags)
+		__print_mce(m);
 
 	return NOTIFY_DONE;
 }
-- 
2.21.1

