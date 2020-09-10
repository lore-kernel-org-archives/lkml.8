Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F32C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2624020C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iE30cmYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9g9fhrZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgIJJbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgIJJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC975C0617BA;
        Thu, 10 Sep 2020 02:22:23 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9g7bm+cdXI5Vmo4l5RBC13hzSXc1ind1ejHSFFKubVs=;
        b=iE30cmYjRlF41I/bJeTehbqK77gd8b+zfoMZac4wQRItGZ1VmkTU1ouzy6dWEzV/0S73FK
        KTFxSnhaMYkYHKH6XNLFcFbKil6RbYKVK5ARlrX1866tAKZ8MlV0BJDytmCXNm8Jpg/n/b
        D6BzRUs5959lcFd+elM1EYfYZ7dEK7OBNWjtRHH5A1wYUlBKDvsMs5b1AvgyWxwT8tn4lJ
        akYwBrLv+Cvb11eOQOYvcLSRhjKOQjBUK/v1hbpJ0RwArdnrt0ny+OnM6J4lghyBYpjARQ
        lJtVB/LSKH9ykNvE62BeizqV7Y4nQkM01SWLD0tQ5CHRajIFFDdMkoFAv5YvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9g7bm+cdXI5Vmo4l5RBC13hzSXc1ind1ejHSFFKubVs=;
        b=9g9fhrZpj3bb7r44tRdMAhYpznGT6ve1jlV6NtvcOX7/H0Pgd5u16ixVclgfDMZOsdzfOI
        Sm1Es6zdeAl1KhAw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Add CPUID handling to #VC handler
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-28-joro@8bytes.org>
References: <20200907131613.12703-28-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974133.20229.5160639798798149324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     a7de15d489d956217b47671705ac2218ca50eaae
Gitweb:        https://git.kernel.org/tip/a7de15d489d956217b47671705ac2218ca50eaae
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 20:15:51 +02:00

x86/sev-es: Add CPUID handling to #VC handler

Handle #VC exceptions caused by CPUID instructions. These happen in
early boot code when the KASLR code checks for RDTSC.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling framework ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-28-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c |  4 +++-
 arch/x86/kernel/sev-es-shared.c   | 35 ++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 61504eb..b1790f4 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -16,6 +16,7 @@
 #include <asm/trapnr.h>
 #include <asm/trap_pf.h>
 #include <asm/msr-index.h>
+#include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
 
@@ -183,6 +184,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	case SVM_EXIT_IOIO:
 		result = vc_handle_ioio(boot_ghcb, &ctxt);
 		break;
+	case SVM_EXIT_CPUID:
+		result = vc_handle_cpuid(boot_ghcb, &ctxt);
+		break;
 	default:
 		result = ES_UNSUPPORTED;
 		break;
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index bae7cf2..a6b4191 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -432,3 +432,38 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 
 	return ret;
 }
+
+static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u32 cr4 = native_read_cr4();
+	enum es_result ret;
+
+	ghcb_set_rax(ghcb, regs->ax);
+	ghcb_set_rcx(ghcb, regs->cx);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #GP - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	regs->ax = ghcb->save.rax;
+	regs->bx = ghcb->save.rbx;
+	regs->cx = ghcb->save.rcx;
+	regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
