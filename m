Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF97C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A1420C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Un+bsvrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jd/2ajek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgIJJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbgIJJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33340C0617B1;
        Thu, 10 Sep 2020 02:22:22 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2BwUm1PxuhEHe47jJhy27fr6ytXLlVMKNfvQYFkLrA=;
        b=Un+bsvrQR2s8KkQEvFmpWYy5Hur2Ig/SxWAW4s8bk7tVD/SLscd2KcR+Fq26/keTdsgqXx
        qHJc8nVNlGswHeA3cis5nSvE0C1nZjI+q+sfIJaS9GxosPIJxz759cU9v5s84APDcV4ZIo
        YO8um1yqi01U8tqGPjo3NHkf/v+nHbJdeFJhTXWeT3Jp+e9BpHuq77e+usx55SlZnZ3Z/M
        +6NA0cn1zDR4Lk0AGwYFwrVhOJ+zpafOwjo+c+qAlQ4n6fFhLPRT/imkzPTzaCYjltcjFQ
        4N6rUC+fazEzB0Ocvfd8evFJgtbaiYClUzVcqamTjpZw8LCOirioujq8l0Qehg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2BwUm1PxuhEHe47jJhy27fr6ytXLlVMKNfvQYFkLrA=;
        b=Jd/2ajekAcvh6gsmoYaUfdqlnVkhmzvsPy/cwyQ20bYN2azGCEQY9Rv3MjxTTNYCjkLgsB
        ThoSkJjJJrYpV4CA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Load GDT after switch to virtual addresses
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-31-joro@8bytes.org>
References: <20200907131613.12703-31-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974006.20229.13724907581434195856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     e04b88336360e101329add0c05e5cb1cebae64fd
Gitweb:        https://git.kernel.org/tip/e04b88336360e101329add0c05e5cb1cebae64fd
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 21:35:54 +02:00

x86/head/64: Load GDT after switch to virtual addresses

Load the GDT right after switching to virtual addresses to make sure
there is a defined GDT for exception handling.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-31-joro@8bytes.org
---
 arch/x86/kernel/head_64.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2b2e916..03b03f2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -158,6 +158,14 @@ SYM_CODE_START(secondary_startup_64)
 1:
 	UNWIND_HINT_EMPTY
 
+	/*
+	 * We must switch to a new descriptor in kernel space for the GDT
+	 * because soon the kernel won't have access anymore to the userspace
+	 * addresses where we're currently running on. We have to do that here
+	 * because in 32bit we couldn't load a 64bit linear address.
+	 */
+	lgdt	early_gdt_descr(%rip)
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -185,14 +193,6 @@ SYM_CODE_START(secondary_startup_64)
 	pushq $0
 	popfq
 
-	/*
-	 * We must switch to a new descriptor in kernel space for the GDT
-	 * because soon the kernel won't have access anymore to the userspace
-	 * addresses where we're currently running on. We have to do that here
-	 * because in 32bit we couldn't load a 64bit linear address.
-	 */
-	lgdt	early_gdt_descr(%rip)
-
 	/* set up data segments */
 	xorl %eax,%eax
 	movl %eax,%ds
