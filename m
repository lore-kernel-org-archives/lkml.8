Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21730C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A2206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TxL8D42D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDGQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgDGQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:25 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 175DA1EC0CE2;
        Tue,  7 Apr 2020 18:34:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qu6nhacTkj3XLSwwbnceRykoEnFbvqIecSTSJvAabgI=;
        b=TxL8D42DIubIxCwqJ8nG7KXoAU7vDrIxKBOFQOfQSDrdxeMCPZM2gw3X9KwRgQPlNLiLhk
        0P9zPBRKBXD+cqwg7DfFeoLhxXzwzoNlHCxXYFwAROmhKWxvQQjYQnveJFv5kJlJ38+240
        LpIPH0PI26u4UYB6YL8SOmLZbhPWAjY=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/9] x86/mce: Change default MCE logger to check mce->kflags
Date:   Tue,  7 Apr 2020 18:34:11 +0200
Message-Id: <20200407163414.18058-7-bp@alien8.de>
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

Instead of keeping count of how many handlers are registered on the
MCE notifier chain and printing if below some magic value, look at
mce->kflags to see if anyone claims to have handled/logged this error.

 [ bp: Do not print ->kflags in __print_mce(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-6-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5666a48a4bc9..fc879b6669d5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -158,29 +158,17 @@ void mce_log(struct mce *m)
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
@@ -263,6 +251,7 @@ static void __print_mce(struct mce *m)
 	}
 
 	pr_cont("\n");
+
 	/*
 	 * Note this output is parsed by external tools and old fields
 	 * should not be changed.
@@ -602,10 +591,8 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
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
2.21.0

