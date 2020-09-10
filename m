Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13721C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A547320809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXiz5/jp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4+bGXJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgIJJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgIJJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7AC061798;
        Thu, 10 Sep 2020 02:22:15 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRyZclTz2iLmvYnzLXyhFhhw2Nkp8T/JfvKO9WdhGJs=;
        b=wXiz5/jpOMvRzc1IdKV47vochrW1IcHxszweIInBGgWydH/Tu9l1KkwkuoLBsePV7yMXr8
        2oGV0TJCJP5HbRFz9eoWfa3W9XwW8qHbpBLcQ8MG9U+BYoK4AnepysVc10fXwSKyndAJXu
        jvk5vfQBYczVwNEWAzrPhzIf/Y3AVDGm5tyGZVsIh9yLJexoe3aM/o1nlOYiJBV9/Wc9Gx
        2BEIYHmeVYVhS6H0fz3hp1xD/0iNmx6KtgExQJQS4Rjg3LwPTCUglZkeDEfBOk/+kH0qNu
        ug0yGFDzNlbEv28dSYtZDDAOvuPv32qIJRJHqx26vZ9nYZ9v9QgSWHqXdBrwjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRyZclTz2iLmvYnzLXyhFhhw2Nkp8T/JfvKO9WdhGJs=;
        b=M4+bGXJb0omE9f5wvBVLesCk+bGJVCNShcVzStwV9Yyo0N0RiDpkbGhyqyN+MXZpgFQa3L
        zPgwBWl8Od0cKaBg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle VMMCALL Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-60-joro@8bytes.org>
References: <20200907131613.12703-60-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972767.20229.2258359538543108664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     2eb7dcf0ccc40ad3f39b000becf16661abf98102
Gitweb:        https://git.kernel.org/tip/2eb7dcf0ccc40ad3f39b000becf16661abf98102
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle VMMCALL Events

Implement a handler for #VC exceptions caused by VMMCALL instructions.
This is only a starting point, VMMCALL emulation under SEV-ES needs
further hypervisor-specific changes to provide additional state.

 [ bp: Drop "this patch". ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-60-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 2aea903..86cb4c5 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -889,6 +889,26 @@ static enum es_result vc_handle_mwait(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ghcb_set_rax(ghcb, ctxt->regs->ax);
+	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!ghcb_rax_is_valid(ghcb))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -922,6 +942,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_MSR:
 		result = vc_handle_msr(ghcb, ctxt);
 		break;
+	case SVM_EXIT_VMMCALL:
+		result = vc_handle_vmmcall(ghcb, ctxt);
+		break;
 	case SVM_EXIT_WBINVD:
 		result = vc_handle_wbinvd(ghcb, ctxt);
 		break;
