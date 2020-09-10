Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A56C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F581207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3AeO1Eb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LntWGCDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgIJJiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXlVFfGsQ5R86vMSL2nzI4Yw1P09A2UcGYbS31L9EmI=;
        b=u3AeO1EbV9j7cACwHJ727k+FRaaAR/r+0NSoINbG72MfJzFW0WhdEEwZaJdyMZCONssVWs
        IUAV9gkmshK1+DcrGPNO5wx3/ewWgm+rsFWoufEfADn5NMOw2fwCjfnnZt34Z0vA4mRoxO
        EcdoRatmwH89r54iC/rxTdFCBjf4TW6S7Qb968ILaiOIAoQ/2tz2xjpATLtSFS6M0og2Bb
        a1krhsZfQoo1Pe5p8TGq5uVY7WEwdURvGtJlmFIbkXYMbJ8V74TGNnzO5dB1CJPJm0gmIz
        P8dQfSJH+BDnwV+KtBjS80VHeXEFVkzpQn4RTY4s+29GsrudPGmHgTPaUStPMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXlVFfGsQ5R86vMSL2nzI4Yw1P09A2UcGYbS31L9EmI=;
        b=LntWGCDdWSRC9OtvtePSICHxsTxkxHkYpMEa+EImaMIeToq3yUHP16E+lm4zkoJCPDd6/2
        YHMDPPjcdnOHhTBA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle WBINVD Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-54-joro@8bytes.org>
References: <20200907131613.12703-54-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973018.20229.4628171075961862587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     a14a92fc4b420ae6713800a8ae8c3686c1a1fa20
Gitweb:        https://git.kernel.org/tip/a14a92fc4b420ae6713800a8ae8c3686c1a1fa20
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle WBINVD Events

Implement a handler for #VC exceptions caused by WBINVD instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling framework ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-54-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 391b9c7..aba27c3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -847,6 +847,12 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
+				       struct es_em_ctxt *ctxt)
+{
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -869,6 +875,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_MSR:
 		result = vc_handle_msr(ghcb, ctxt);
 		break;
+	case SVM_EXIT_WBINVD:
+		result = vc_handle_wbinvd(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = vc_handle_mmio(ghcb, ctxt);
 		break;
