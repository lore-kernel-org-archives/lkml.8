Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99284C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5F621D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XOQqlHSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g//5kze1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgIJJYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:24:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wT293J7mNzVPMjSoMeNRoLUfHbRCXhjafzpPcLdq2M=;
        b=XOQqlHSP/cBR0lvtEK0nOERYm+itzn6Z+slh8cpjXw9e3aeYPzAbHbc5wfmqfApWIVsiyn
        r0Daw0pdpdNpFKwaznrfyuKNvpB055+wglKFTYGamPmevMrU5q5JW1G6vrc251XHfz2Jm2
        ZE12lbS4/0itgJUX24Ty0mQutG6WVxazvgrxyTPQ5hqFZxR6YE77DtrQZwOiPV22lJ70HC
        RRb5BSrQaEwDiJ9had7h11UZymoI+viz4xm0MlsDpF9fZTPk3474V1bgFuxDb6HOSRBOo2
        JQQseuiO8Ak22m5hxPeh20edBEjc0yNmx/jAxdnWQqCjJuyJZFtrv+NhhRVazg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wT293J7mNzVPMjSoMeNRoLUfHbRCXhjafzpPcLdq2M=;
        b=g//5kze17IGr3nf0tXCGyFxZycTl5Ia/y9H3SVjTEi0SsbO2huS305xmBg5QPaOBfuCHGL
        yCtoZNZYXxKvEdCg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle MSR events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-52-joro@8bytes.org>
References: <20200907131613.12703-52-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973096.20229.8422083448675364819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     a4afa6081c88701635e1e20090f953a25f9444e0
Gitweb:        https://git.kernel.org/tip/a4afa6081c88701635e1e20090f953a25f9444e0
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:52 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/sev-es: Handle MSR events

Implement a handler for #VC exceptions caused by RDMSR/WRMSR
instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure. ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-52-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index f724b75..6205100 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -393,6 +393,31 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
+static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	enum es_result ret;
+	u64 exit_info_1;
+
+	/* Is it a WRMSR? */
+	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
+
+	ghcb_set_rcx(ghcb, regs->cx);
+	if (exit_info_1) {
+		ghcb_set_rax(ghcb, regs->ax);
+		ghcb_set_rdx(ghcb, regs->dx);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
+
+	if ((ret == ES_OK) && (!exit_info_1)) {
+		regs->ax = ghcb->save.rax;
+		regs->dx = ghcb->save.rdx;
+	}
+
+	return ret;
+}
+
 /*
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
@@ -756,6 +781,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_IOIO:
 		result = vc_handle_ioio(ghcb, ctxt);
 		break;
+	case SVM_EXIT_MSR:
+		result = vc_handle_msr(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = vc_handle_mmio(ghcb, ctxt);
 		break;
