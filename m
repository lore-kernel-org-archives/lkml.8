Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93727C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B004206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DY25a8mn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Moaa4emO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGAIFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgGAIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D5C061755;
        Wed,  1 Jul 2020 01:04:53 -0700 (PDT)
Date:   Wed, 01 Jul 2020 08:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dI8s4+cIJXIr3ppZrNkXAQDHLyAZwlVAKlfgSA65wnI=;
        b=DY25a8mn0Pg5hMJvjsu2zJz6qOoeYO7zHf0D57EhYxOWg7/7dScMHQTMr/040/M1P3FrL5
        AyJ7BYearhVtOI7Cmb5elDKe2PnQyAyysqnpYkmnM3FLjig7jo1iI2HPXuZZ8h7pvH3mzJ
        Z+WspR5NZ2sxOnZX5+2FwByQbQce3qlxGwPiJH+IYA1iPDx84XhitUOra7/BuOemCoLR8D
        hoSgnN6c8Dumyb4ZovyB7C7wBAa1MFfyCw7c/Cqq6cV/VRV3iJEQ7JS28Ig56vQrT/CRd9
        AdAGTNDGYuf+z4ix1Cog1kavECKv9J1qqJ1QFVERto6XbaNV4EYCuLc3PTsbmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dI8s4+cIJXIr3ppZrNkXAQDHLyAZwlVAKlfgSA65wnI=;
        b=Moaa4emOtmLyMHEYslHaop0GLGJIOEhMSuwCVRLvQHlBDYP1diR7p/RPPicqnP3RfqPYfe
        Rlvie/SECazeHIDA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
References: <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069165.4006.16569596642784099904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ffae641f57476369b4d503402b37ebe489d23395
Gitweb:        https://git.kernel.org/tip/ffae641f57476369b4d503402b37ebe489d23395
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:26 +02:00

x86/entry/64/compat: Fix Xen PV SYSENTER frame setup

The SYSENTER frame setup was nonsense.  It worked by accident because the
normal code into which the Xen asm jumped (entry_SYSENTER_32/compat) threw
away SP without touching the stack.  entry_SYSENTER_compat was recently
modified such that it relied on having a valid stack pointer, so now the
Xen asm needs to invoke it with a valid stack.

Fix it up like SYSCALL: use the Xen-provided frame and skip the bare
metal prologue.

Fixes: 1c3e5d3f60e2 ("x86/entry: Make entry_64_compat.S objtool clean")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lkml.kernel.org/r/947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org

---
 arch/x86/entry/entry_64_compat.S |  1 +
 arch/x86/xen/xen-asm_64.S        | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 7b9d815..381a6de 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -79,6 +79,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	pushfq				/* pt_regs->flags (except IF = 0) */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
+SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 5d252aa..e1e1c7e 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -161,10 +161,22 @@ SYM_FUNC_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
 SYM_FUNC_START(xen_sysenter_target)
-	mov 0*8(%rsp), %rcx
-	mov 1*8(%rsp), %r11
-	mov 5*8(%rsp), %rsp
-	jmp entry_SYSENTER_compat
+	/*
+	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
+	 * that we don't need to guard against single step exceptions here.
+	 */
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER32_CS, 1*8(%rsp)
+
+	jmp entry_SYSENTER_compat_after_hwframe
 SYM_FUNC_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
