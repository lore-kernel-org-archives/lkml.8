Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A18C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB9B21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvNaYrgV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p30u/u19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgIJJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:38:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94KqhcXM7adubusp3ibsRJIFEeZAgOjjhCje3a5h4Ds=;
        b=NvNaYrgVBEq2DqNx1+866SdBlbYgVXsByfmhliqItUSDIdGyOt/iLuioX95dby8JtdhmFc
        nzNMuugkx8ogYXnw1R7Y3eyco/2oJhbWv5ajS80s7XPejwXNehrbaykfN/WXNIxey9tOw/
        H5/Cd7mMVltgBrFrhPKGnNbzQCxOCWvtj3Rbv/3Y5G2YGt60xIlNto2zFD0rvaZwsQCnLW
        Ft+fhi/XOw06nuGgUfCoeJk0bMse/kxqG4FwOMh6OyXcS3ZGiEfD+cxm1VSH28StYDwKDW
        fTZzvXDu4ASqFdIgVqj7PVh0j53lXVvDVFI9yrHcTiz6d6BRMqk8bjv4i11rpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94KqhcXM7adubusp3ibsRJIFEeZAgOjjhCje3a5h4Ds=;
        b=p30u/u19d2O96PeYN7yzn35RfhlBkhs2tOR9n1zxDMrnX9ObW/35kmRVCqjdUlRD6rNYR/
        FtGiR0+M73TtPSBw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle MWAIT/MWAITX Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-59-joro@8bytes.org>
References: <20200907131613.12703-59-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972806.20229.9638856651512934490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     ded476bbe203e59cb571d6c576f680efe4a0ddff
Gitweb:        https://git.kernel.org/tip/ded476bbe203e59cb571d6c576f680efe4a0ddff
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:59 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle MWAIT/MWAITX Events

Implement a handler for #VC exceptions caused by MWAIT and MWAITX
instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-59-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index b9976e7..2aea903 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -882,6 +882,13 @@ static enum es_result vc_handle_monitor(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result vc_handle_mwait(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	/* Treat the same as MONITOR/MONITORX */
+	return ES_OK;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -921,6 +928,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_MONITOR:
 		result = vc_handle_monitor(ghcb, ctxt);
 		break;
+	case SVM_EXIT_MWAIT:
+		result = vc_handle_mwait(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = vc_handle_mmio(ghcb, ctxt);
 		break;
