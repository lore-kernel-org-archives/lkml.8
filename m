Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A8DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745A021582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+fvQKgZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wqWYfqNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgIJJXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:23:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkC3Uo7XNJDg4jGF18WR5gMyrzBCb+gzMY+iUOcwdrU=;
        b=f+fvQKgZeyhs40MxGig4XVMYT5m31x3jVkutEbiY9g+wqzuD9kV4SDAXXtcUqHjMOb3Tdt
        6aSf3jFSloZV1wVYW8MehAe/W6W99Hrjk0bDbpPsEWgsJVbfsyZdWzVpIbllIKqZdkDtXI
        buUifT8/fpVnLV41r1BNDGo71GoHDTq9rJrf9/GnltZFiqBQ2sOr3WXnSYIZNHStdoknO5
        t3vy9/kW3ds9aoZH7ASasGkFs7iQRmmRiP63kSSIvT3EaOOTUQJ8oB7Soaao3aT49IJj59
        nrtrcQCl6ybcDpCGC7b+3uflygMmUu35ZI6k1nRNWU6yqwHfVsAuwS2VFboezQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkC3Uo7XNJDg4jGF18WR5gMyrzBCb+gzMY+iUOcwdrU=;
        b=wqWYfqNzkJbCglRFEA7iAD07kHDOBdvoTcoAUCcb0N4log0YmmjsCgH1pS2LdOEc35iHBc
        OkHasef3kLQeZ4CA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/realmode: Add SEV-ES specific trampoline entry point
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-66-joro@8bytes.org>
References: <20200907131613.12703-66-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972517.20229.2323269831339763947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     bf5ff276448f64f1f9ef9ffc9e231026e3887d3d
Gitweb:        https://git.kernel.org/tip/bf5ff276448f64f1f9ef9ffc9e231026e3887d3d
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/realmode: Add SEV-ES specific trampoline entry point

The code at the trampoline entry point is executed in real-mode. In
real-mode, #VC exceptions can't be handled so anything that might cause
such an exception must be avoided.

In the standard trampoline entry code this is the WBINVD instruction and
the call to verify_cpu(), which are both not needed anyway when running
as an SEV-ES guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-66-joro@8bytes.org
---
 arch/x86/include/asm/realmode.h      |  3 +++
 arch/x86/realmode/rm/header.S        |  3 +++
 arch/x86/realmode/rm/trampoline_64.S | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 96118fb..4d4d853 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -21,6 +21,9 @@ struct real_mode_header {
 	/* SMP trampoline */
 	u32	trampoline_start;
 	u32	trampoline_header;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	u32	sev_es_trampoline_start;
+#endif
 #ifdef CONFIG_X86_64
 	u32	trampoline_pgd;
 #endif
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index af04512..8c1db5b 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -20,6 +20,9 @@ SYM_DATA_START(real_mode_header)
 	/* SMP trampoline */
 	.long	pa_trampoline_start
 	.long	pa_trampoline_header
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	.long	pa_sev_es_trampoline_start
+#endif
 #ifdef CONFIG_X86_64
 	.long	pa_trampoline_pgd;
 #endif
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 251758e..84c5d1b 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -56,6 +56,7 @@ SYM_CODE_START(trampoline_start)
 	testl   %eax, %eax		# Check for return code
 	jnz	no_longmode
 
+.Lswitch_to_protected:
 	/*
 	 * GDT tables in non default location kernel can be beyond 16MB and
 	 * lgdt will not be able to load the address as in real mode default
@@ -80,6 +81,25 @@ no_longmode:
 	jmp no_longmode
 SYM_CODE_END(trampoline_start)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/* SEV-ES supports non-zero IP for entry points - no alignment needed */
+SYM_CODE_START(sev_es_trampoline_start)
+	cli			# We should be safe anyway
+
+	LJMPW_RM(1f)
+1:
+	mov	%cs, %ax	# Code and data in the same place
+	mov	%ax, %ds
+	mov	%ax, %es
+	mov	%ax, %ss
+
+	# Setup stack
+	movl	$rm_stack_end, %esp
+
+	jmp	.Lswitch_to_protected
+SYM_CODE_END(sev_es_trampoline_start)
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
+
 #include "../kernel/verify_cpu.S"
 
 	.section ".text32","ax"
