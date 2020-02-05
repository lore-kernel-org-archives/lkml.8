Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95594C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745AF24672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBEWjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:39:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:60116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbgBEWji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:39:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="225092462"
Received: from unknown (HELO localhost.jf.intel.com) ([10.54.75.26])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2020 14:39:37 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org
Cc:     rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Date:   Wed,  5 Feb 2020 14:39:48 -0800
Message-Id: <20200205223950.1212394-10-kristen@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205223950.1212394-1-kristen@linux.intel.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support finer grained kaslr (fgkaslr), we need to make a couple changes
to kallsyms. Firstly, we need to hide our sorted list of symbols, since
this will give away our new layout. Secondly, we will export the seed used
for randomizing the layout so that it can be used to make a particular
layout persist across boots for debug purposes.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 kernel/kallsyms.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 136ce049c4ad..432b13a3a033 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -698,6 +698,21 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 }
 #endif	/* CONFIG_KGDB_KDB */
 
+#ifdef CONFIG_FG_KASLR
+extern const u64 fgkaslr_seed[] __weak;
+
+static int proc_fgkaslr_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%llx\n", fgkaslr_seed[0]);
+	seq_printf(m, "%llx\n", fgkaslr_seed[1]);
+	seq_printf(m, "%llx\n", fgkaslr_seed[2]);
+	seq_printf(m, "%llx\n", fgkaslr_seed[3]);
+	return 0;
+}
+#else
+static inline int proc_fgkaslr_show(struct seq_file *m, void *v) { return 0; }
+#endif
+
 static const struct file_operations kallsyms_operations = {
 	.open = kallsyms_open,
 	.read = seq_read,
@@ -707,7 +722,20 @@ static const struct file_operations kallsyms_operations = {
 
 static int __init kallsyms_init(void)
 {
-	proc_create("kallsyms", 0444, NULL, &kallsyms_operations);
+	/*
+	 * When fine grained kaslr is enabled, we don't want to
+	 * print out the symbols even with zero pointers because
+	 * this reveals the randomization order. If fg kaslr is
+	 * enabled, make kallsyms available only to privileged
+	 * users.
+	 */
+	if (!IS_ENABLED(CONFIG_FG_KASLR))
+		proc_create("kallsyms", 0444, NULL, &kallsyms_operations);
+	else {
+		proc_create_single("fgkaslr_seed", 0400, NULL,
+					proc_fgkaslr_show);
+		proc_create("kallsyms", 0400, NULL, &kallsyms_operations);
+	}
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.24.1

