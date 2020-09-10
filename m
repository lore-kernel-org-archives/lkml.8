Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2065C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cra+/lP1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pyYMvQIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJJYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:24:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFX/uTiakBqTFJB/i3iIMMFQpW9Ex0Ba06GaoLATOIg=;
        b=Cra+/lP19atOvKERyqlIie1msuaTzIfeMr+Bv9zQTvy8krqQPiR+aa5n60O2gQIBpEcw6o
        2blePwtptfS8uQfNaZKwtn3jl+Apuzj3YuhrfsYD44/IYjLjRoEG6XAD3vpq4nq1QZxLxj
        kcw3+hbeh1RpTbPijeJ3n3RC4U/90eVd4hq5gAOyvN+rrv3JLLHIkoH2L5NzqlJuEdHc0Y
        YggsTBdX/RdMXY5VnZpFLWOiac/J8b0GillAZhCOMQr47/f/PwpgKu/ZtYKFG6cfPDeAz4
        RBC1h0t2Zx/5cDSmxCVJBO7aLCt2w+3PyJvQiI0P8gS1Ufk7AdenOjtsWCDiiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFX/uTiakBqTFJB/i3iIMMFQpW9Ex0Ba06GaoLATOIg=;
        b=pyYMvQIQWqatcrBw5CKG9qqt5xqKjpcXBhg77EF998Wi605sFq/elrqg2amUP0NOsQPi3k
        hNm1jLieogXVE6Ag==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle #AC Events
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-61-joro@8bytes.org>
References: <20200907131613.12703-61-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972729.20229.16252285186177564189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     a2d0171a9cf59637411281a929900fde80e6c1cb
Gitweb:        https://git.kernel.org/tip/a2d0171a9cf59637411281a929900fde80e6c1cb
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:01 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle #AC Events

Implement a handler for #VC exceptions caused by #AC exceptions. The
#AC exception is just forwarded to do_alignment_check() and not pushed
down to the hypervisor, as requested by the SEV-ES GHCB Standardization
Specification.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-61-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 86cb4c5..8867c48 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -909,6 +909,19 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Calling ecx_alignment_check() directly does not work, because it
+	 * enables IRQs and the GHCB is active. Forward the exception and call
+	 * it later from vc_forward_exception().
+	 */
+	ctxt->fi.vector = X86_TRAP_AC;
+	ctxt->fi.error_code = 0;
+	return ES_EXCEPTION;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -922,6 +935,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = vc_handle_dr7_write(ghcb, ctxt);
 		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
+		result = vc_handle_trap_ac(ghcb, ctxt);
+		break;
 	case SVM_EXIT_RDTSC:
 	case SVM_EXIT_RDTSCP:
 		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
@@ -981,6 +997,9 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 	case X86_TRAP_UD:
 		exc_invalid_op(ctxt->regs);
 		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
 	default:
 		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
 		BUG();
