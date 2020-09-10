Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C66C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB8521D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnsq3jEF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+vdysP98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgIJJhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:37:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbgIJJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:21 -0400
Date:   Thu, 10 Sep 2020 09:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QD1v8bsZImEeiNSDgX6Ze2YQSeBDgl0KHzGM1X9wHA=;
        b=lnsq3jEFXayscGrg3a6BT8ZJUNgrcMG1TKHZslj/WBziSbqiW4aCox7XGiuve0k0HLu//F
        9EGMndoWb0JYdcjM76uquztqDPgtlO+A5m2M7KK/L6i2fAMf1wQNQyEtc4pGy0RUtZavoD
        sWwE3vInh1RHRtxoRQRRth3XEyAuezqheoKf36+IsNHa0h/WqAHmIQf3/vuJW7ZcdTlvRu
        smJwzgh9onoBttTW7wP7ZAO13NSx680jXKjiUxOXOu7Xri6CcMAwD+NVB/B04hAFhxscrn
        afyPrqGxcgMmbXt67nMJ/eiqhhk8jUau09f0qL8MIDDENMP15jnh2IfFHgL/zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QD1v8bsZImEeiNSDgX6Ze2YQSeBDgl0KHzGM1X9wHA=;
        b=+vdysP987g2ZMweL7dvG/rDbgnvZOqxiCTv/qcg9sf+7xeUgo9A/NK06eEP2sVFyBTAXcb
        OEaUON76m+Fo1xBg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Switch to initial stack earlier
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-33-joro@8bytes.org>
References: <20200907131613.12703-33-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973918.20229.8742099836749431075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     3add38cb96a1ae7d152db69ab4329e809c2af2d4
Gitweb:        https://git.kernel.org/tip/3add38cb96a1ae7d152db69ab4329e809c2af2d4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 21:44:01 +02:00

x86/head/64: Switch to initial stack earlier

Make sure there is a stack once the kernel runs from virtual addresses.
At this stage any secondary CPU which boots will have lost its stack
because the kernel switched to a new page-table which does not map the
real-mode stack anymore.

This is needed for handling early #VC exceptions caused by instructions
like CPUID.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-33-joro@8bytes.org
---
 arch/x86/kernel/head_64.S |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f402087..83050c9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -192,6 +192,12 @@ SYM_CODE_START(secondary_startup_64)
 	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
+	/*
+	 * Setup a boot time stack - Any secondary CPU will have lost its stack
+	 * by now because the cr3-switch above unmaps the real-mode stack
+	 */
+	movq initial_stack(%rip), %rsp
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -212,9 +218,6 @@ SYM_CODE_START(secondary_startup_64)
 	/* Make changes effective */
 	movq	%rax, %cr0
 
-	/* Setup a boot time stack */
-	movq initial_stack(%rip), %rsp
-
 	/* zero EFLAGS after setting rsp */
 	pushq $0
 	popfq
