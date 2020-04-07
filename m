Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB65BC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC20768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JAusqSio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDGQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgDGQeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:23 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FA311EC0CE2;
        Tue,  7 Apr 2020 18:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L++T/eHJQ4wQj0es+pUzShPUQPqyKRj22HWDQVhzfPI=;
        b=JAusqSiobci4wDF6QYXUWcqDePXyEGiN9+pQWI6uED05IE0Z2/Zd78G2yyThhUXmS12enD
        I0IGMqEOIHH/oNzG/DqW65JYgzvfCiFT3CiAvW+hJlxdU8sw2fBcwF0uy8uOotpdVJSP03
        Gkon4NHsegw2SjhIo2iQnHRyh5bAQqw=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] x86/mce: Convert the CEC to use the MCE notifier
Date:   Tue,  7 Apr 2020 18:34:08 +0200
Message-Id: <20200407163414.18058-4-bp@alien8.de>
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

The CEC code has its claws in a couple of routines in mce/core.c.
Convert it to just register itself on the normal MCE notifier chain.

 [ bp: Make cec_add_elem() and cec_init() static. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 19 -------------------
 drivers/ras/cec.c              | 30 ++++++++++++++++++++++++++++--
 include/linux/ras.h            |  5 -----
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 43b1519ad4e5..b033b3589630 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -544,21 +544,6 @@ bool mce_is_correctable(struct mce *m)
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
@@ -567,9 +552,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (cec_add_mce(m))
-		return NOTIFY_STOP;
-
 	/* Emit the trace record: */
 	trace_mce_record(m);
 
@@ -2612,7 +2594,6 @@ static int __init mcheck_late_init(void)
 		static_branch_inc(&mcsafe_key);
 
 	mcheck_debugfs_init();
-	cec_init();
 
 	/*
 	 * Flush out everything that has been logged during early boot, now that
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index c09cf55e2d20..6b42040bf956 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -309,7 +309,7 @@ static bool sanity_check(struct ce_array *ca)
 	return ret;
 }
 
-int cec_add_elem(u64 pfn)
+static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
 	unsigned int to = 0;
@@ -527,7 +527,30 @@ static int __init create_debugfs_nodes(void)
 	return 1;
 }
 
-void __init cec_init(void)
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
+static void __init cec_init(void)
 {
 	if (ce_arr.disabled)
 		return;
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
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 7c3debb47c87..1f4048bf2674 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -17,12 +17,7 @@ static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
 
 #ifdef CONFIG_RAS_CEC
-void __init cec_init(void);
 int __init parse_cec_param(char *str);
-int cec_add_elem(u64 pfn);
-#else
-static inline void __init cec_init(void)	{ }
-static inline int cec_add_elem(u64 pfn)		{ return -ENODEV; }
 #endif
 
 #ifdef CONFIG_RAS
-- 
2.21.0

