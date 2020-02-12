Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAF12168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgBLOvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:51:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:51:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1tLm-0006id-8a; Wed, 12 Feb 2020 15:50:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EBB411C202D;
        Wed, 12 Feb 2020 15:50:49 +0100 (CET)
Date:   Wed, 12 Feb 2020 14:50:49 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Fix XSAVES offsets in setup_xstate_comp()
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109211452.27369-3-yu-cheng.yu@intel.com>
References: <20200109211452.27369-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158151904966.411.5216700294913698125.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     49a91d61aed1db01097b51a24c77137eb348a0bf
Gitweb:        https://git.kernel.org/tip/49a91d61aed1db01097b51a24c77137eb348a0bf
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Thu, 09 Jan 2020 13:14:51 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 12 Feb 2020 15:43:31 +01:00

x86/fpu/xstate: Fix XSAVES offsets in setup_xstate_comp()

In setup_xstate_comp(), each XSAVES component offset starts from the
end of its preceding component plus alignment. A disabled feature does
not take space and its offset should be set to the end of its preceding
one with no alignment. However, in this case, alignment is incorrectly
added to the offset, which can cause the next component to have a wrong
offset.

This problem has not been visible because currently there is no xfeature
requiring alignment.

Fix it by tracking the next starting offset only from enabled
xfeatures. To make it clear, also change the function name to
setup_xstate_comp_offsets().

 [ bp: Fix a typo in the comment above it, while at it. ]

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200109211452.27369-3-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fe67cab..edcaacd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -337,11 +337,11 @@ static int xfeature_is_aligned(int xfeature_nr)
 /*
  * This function sets up offsets and sizes of all extended states in
  * xsave area. This supports both standard format and compacted format
- * of the xsave aread.
+ * of the xsave area.
  */
-static void __init setup_xstate_comp(void)
+static void __init setup_xstate_comp_offsets(void)
 {
-	unsigned int xstate_comp_sizes[XFEATURE_MAX];
+	unsigned int next_offset;
 	int i;
 
 	/*
@@ -355,31 +355,23 @@ static void __init setup_xstate_comp(void)
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
 		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-			if (xfeature_enabled(i)) {
+			if (xfeature_enabled(i))
 				xstate_comp_offsets[i] = xstate_offsets[i];
-				xstate_comp_sizes[i] = xstate_sizes[i];
-			}
 		}
 		return;
 	}
 
-	xstate_comp_offsets[FIRST_EXTENDED_XFEATURE] =
-		FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (xfeature_enabled(i))
-			xstate_comp_sizes[i] = xstate_sizes[i];
-		else
-			xstate_comp_sizes[i] = 0;
+		if (!xfeature_enabled(i))
+			continue;
 
-		if (i > FIRST_EXTENDED_XFEATURE) {
-			xstate_comp_offsets[i] = xstate_comp_offsets[i-1]
-					+ xstate_comp_sizes[i-1];
+		if (xfeature_is_aligned(i))
+			next_offset = ALIGN(next_offset, 64);
 
-			if (xfeature_is_aligned(i))
-				xstate_comp_offsets[i] =
-					ALIGN(xstate_comp_offsets[i], 64);
-		}
+		xstate_comp_offsets[i] = next_offset;
+		next_offset += xstate_sizes[i];
 	}
 }
 
@@ -773,7 +765,7 @@ void __init fpu__init_system_xstate(void)
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
-	setup_xstate_comp();
+	setup_xstate_comp_offsets();
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
