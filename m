Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96827C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B66C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iB0PrJIA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VKQeoA6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgIJJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgIJJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4545C061799;
        Thu, 10 Sep 2020 02:22:16 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJk3MYLbFbSfPhJZF4bSYd6z3TZoLOoRN1THYmZyuo0=;
        b=iB0PrJIAEPHGOVvXpW6SO0i5j3ncHIqLCDnUZNBk4og3RrFeUNShqV/PqYwzX2r/wLE1rV
        S+rds0YQ89EzYION0K4UOonjwdRjIMTpALaOzLzcSudeqLsfRcMywPS6Rs1g6ONFBpGtAR
        ZPxFSaoNyxwd35XCNaPAVKI5kDRrGU3lEzNaXhSnz8ygkkPJo8EQk/k5EBziL3pjKNdXFn
        leAxq7u5Kv5CH6BYHJ1N4/tjE4uMrlCvY2UgXm0IyCNUetpALZXOmlEfsxnraI6+X2VuvD
        uKN10d5bGylPifrZLt3p8xW7EI87a3aVAHdtDq5pfH1aDjsiwf3+xtMa3Nu5ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJk3MYLbFbSfPhJZF4bSYd6z3TZoLOoRN1THYmZyuo0=;
        b=VKQeoA6kSOPnX9NkJ76BjxEgsFrrJsFMTfYPg08DUSR7z2JC15oMsjmdZNO631ex2ZlzN6
        qaeOK/xG7rVVcGBA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle RDTSC(P) Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-55-joro@8bytes.org>
References: <20200907131613.12703-55-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972968.20229.4360332624550491069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     4711e7acaa125d8cc242f06e1f4d6c74e177454b
Gitweb:        https://git.kernel.org/tip/4711e7acaa125d8cc242f06e1f4d6c74e177454b
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:55 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle RDTSC(P) Events

Implement a handler for #VC exceptions caused by RDTSC and RDTSCP
instructions. Also make it available in the pre-decompression stage
because the KASLR code uses RDTSC/RDTSCP to gather entropy and some
hypervisors intercept these instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapt to #VC handling infrastructure
                   - Make it available early ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-55-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c |  4 ++++
 arch/x86/kernel/sev-es-shared.c   | 23 +++++++++++++++++++++++
 arch/x86/kernel/sev-es.c          |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index b1790f4..5f15e58 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -181,6 +181,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		goto finish;
 
 	switch (exit_code) {
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
+		break;
 	case SVM_EXIT_IOIO:
 		result = vc_handle_ioio(boot_ghcb, &ctxt);
 		break;
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 491b557..4be8af2 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -467,3 +467,26 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt,
+				      unsigned long exit_code)
+{
+	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
+	enum es_result ret;
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb) &&
+	     (!rdtscp || ghcb_rcx_is_valid(ghcb))))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+	if (rdtscp)
+		ctxt->regs->cx = ghcb->save.rcx;
+
+	return ES_OK;
+}
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index aba27c3..4d468ec 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -866,6 +866,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = vc_handle_dr7_write(ghcb, ctxt);
 		break;
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
+		break;
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(ghcb, ctxt);
 		break;
