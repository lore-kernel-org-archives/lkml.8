Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A90C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DE32083E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kkL9eZNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgDGQeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgDGQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:22 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 998E21EC0CE1;
        Tue,  7 Apr 2020 18:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVePcEN5rX9U+YD9qBHBAUyHWvNU8DcClDL4UV8p+fY=;
        b=kkL9eZNaHHZzl6W3n2iZZVUV3XVfDptN24k+dQYIBEnLiS9DZwjF4rGZ0ZHbiYKrJ5BeTU
        zm6+A2jK8fVLIpjXda7MFbs1/7HkdaOCtAxleTI0gbvy339AOk+cFy7FxEOfESNBUdh2Eg
        upLcALRoyv/oB0mlykq3VxaxMJy9sNQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] x86/mce: Rename "first" function as "early"
Date:   Tue,  7 Apr 2020 18:34:07 +0200
Message-Id: <20200407163414.18058-3-bp@alien8.de>
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

It isn't going to be first on the notifier chain when the CEC is moved
to be a normal user of the notifier chain.

Fix the enum for the MCE_PRIO symbols to list them in reverse order so
that the compiler can give them numbers from low to high priority. Add
an entry for MCE_PRIO_CEC as the highest priority.

 [ bp: Use passive voice, add comments. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-2-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h     | 16 +++++++++-------
 arch/x86/kernel/cpu/mce/core.c | 10 +++++-----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 83b6ddafa032..689ac6e9c65f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -144,14 +144,16 @@ struct mce_log_buffer {
 	struct mce entry[];
 };
 
+/* Highest last */
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
index a6009efdfe2b..43b1519ad4e5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -559,7 +559,7 @@ static bool cec_add_mce(struct mce *m)
 	return false;
 }
 
-static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
+static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
 	struct mce *m = (struct mce *)data;
@@ -580,9 +580,9 @@ static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
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
@@ -2041,7 +2041,7 @@ __setup("mce", mcheck_enable);
 int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
-	mce_register_decode_chain(&first_nb);
+	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
 	mcheck_vendor_init_severity();
-- 
2.21.0

