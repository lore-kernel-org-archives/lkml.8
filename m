Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B86C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0CD21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mvj7DpcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tr+pM94A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgIJJhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:37:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgIJJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:22 -0400
Date:   Thu, 10 Sep 2020 09:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37rnW2MFf1C/zxksBhYxrAibDAQHO5x+bY/dAgpC/9I=;
        b=Mvj7DpcGyCa4paufu8vah2MREsg3soFHmzB8pdjdOCOSEKsx0mpV4vPb7U1bClTfkKCT8b
        HAvkTZLPjNhTtj/nwsN7sq2Olu+wZ/ljmXCFAoOXbU3BwCpVKfVuLoa5PiugKznCP7VWEH
        srqFVz4OUs8Kr43lLZlU8wS1Kn7VOHLB9GmLDRvYmdg8Nif6or8CRnle+S3YVnLo7WEvfW
        WWQoSP2710SLHknm0JDQ24Fvr6AwDfHZB8Q5LTIbWzN+9EIbnXOjF6YVnnblOk3dmP8ILR
        ZxdHEdVIQ4GlOWH3BhemJYaEAwa0cWvQlEQjn2GiLjkV0dKOrm63YUKxvioabw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37rnW2MFf1C/zxksBhYxrAibDAQHO5x+bY/dAgpC/9I=;
        b=tr+pM94A/baYIlZHmGOayCWahH8vTCc/7V5d9NRa1RbJ0U2S028r4TcBsUDbkTjBSmnTB9
        iYFZATJbQFOzVeCg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Load segment registers earlier
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-32-joro@8bytes.org>
References: <20200907131613.12703-32-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973966.20229.7475736092254046152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     7b99819dfb60268cc1c75f83c949bc4a09221bea
Gitweb:        https://git.kernel.org/tip/7b99819dfb60268cc1c75f83c949bc4a09221bea
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 21:40:53 +02:00

x86/head/64: Load segment registers earlier

Make sure segments are properly set up before setting up an IDT and
doing anything that might cause a #VC exception. This is later needed
for early exception handling.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-32-joro@8bytes.org
---
 arch/x86/kernel/head_64.S | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 03b03f2..f402087 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -166,6 +166,32 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	lgdt	early_gdt_descr(%rip)
 
+	/* set up data segments */
+	xorl %eax,%eax
+	movl %eax,%ds
+	movl %eax,%ss
+	movl %eax,%es
+
+	/*
+	 * We don't really need to load %fs or %gs, but load them anyway
+	 * to kill any stale realmode selectors.  This allows execution
+	 * under VT hardware.
+	 */
+	movl %eax,%fs
+	movl %eax,%gs
+
+	/* Set up %gs.
+	 *
+	 * The base of %gs always points to fixed_percpu_data. If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
+	movl	$MSR_GS_BASE,%ecx
+	movl	initial_gs(%rip),%eax
+	movl	initial_gs+4(%rip),%edx
+	wrmsr
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -193,32 +219,6 @@ SYM_CODE_START(secondary_startup_64)
 	pushq $0
 	popfq
 
-	/* set up data segments */
-	xorl %eax,%eax
-	movl %eax,%ds
-	movl %eax,%ss
-	movl %eax,%es
-
-	/*
-	 * We don't really need to load %fs or %gs, but load them anyway
-	 * to kill any stale realmode selectors.  This allows execution
-	 * under VT hardware.
-	 */
-	movl %eax,%fs
-	movl %eax,%gs
-
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
-	 * Note that, on SMP, the boot cpu uses init data section until
-	 * the per cpu areas are set up.
-	 */
-	movl	$MSR_GS_BASE,%ecx
-	movl	initial_gs(%rip),%eax
-	movl	initial_gs+4(%rip),%edx
-	wrmsr
-
 	/* rsi is pointer to real mode structure with interesting info.
 	   pass it to C */
 	movq	%rsi, %rdi
