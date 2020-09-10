Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD11C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127EC2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POhcQjzG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uavonhzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIJJfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgIJJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB5C06179B;
        Thu, 10 Sep 2020 02:22:16 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI9BHd4zWgchyb4B26I1hkolTgyohOnT3/L1apZ4bIg=;
        b=POhcQjzGC5X3/pvGQkX8onKhGadkKbvIDGazTC6Im6xEOfxJc7iF4GE2fFjjx2a5nr4oql
        y/dzDRNMnL5gFocayRmSTBNtnZVFsSiKGFmJY2+JEDtG5dXwR0QG3OEFtRQkjk6l45PtzO
        keJ7M6PwkV/5YI3Lh3lm6UF6LoQYL6nqEH+9SRp1pbB0iPo0LlpTjLecrGj3zumGqpaz8m
        s4eMpBQxbhskAF3/Nwkyt1L5Q1OPna6pH8cR5r4vLs/Y/BJ7yJMuTsGhmZaZZKmSx8LXcT
        +MHsp+qpJI3tKHlcvPxiElz14k4z/Usyj0Ot36lWnvSxoAHGShTnBadvD7p5eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI9BHd4zWgchyb4B26I1hkolTgyohOnT3/L1apZ4bIg=;
        b=UavonhziflKzL+XGSUjfnkj3gfwgxH2lp8gJz4Z+saZgiDMlslwaBJh87wshtmIyVWQFeK
        +wZrDefmOpMc8ZDQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle MONITOR/MONITORX Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-58-joro@8bytes.org>
References: <20200907131613.12703-58-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972847.20229.16459671165924211565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     0c2fd2ef64ef1a91d81c2f61309735ac438b68a4
Gitweb:        https://git.kernel.org/tip/0c2fd2ef64ef1a91d81c2f61309735ac438b68a4
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle MONITOR/MONITORX Events

Implement a handler for #VC exceptions caused by MONITOR and MONITORX
instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-58-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 236cfc1..b9976e7 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -872,6 +872,16 @@ static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt
 	return ES_OK;
 }
 
+static enum es_result vc_handle_monitor(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Treat it as a NOP and do not leak a physical address to the
+	 * hypervisor.
+	 */
+	return ES_OK;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -908,6 +918,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WBINVD:
 		result = vc_handle_wbinvd(ghcb, ctxt);
 		break;
+	case SVM_EXIT_MONITOR:
+		result = vc_handle_monitor(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = vc_handle_mmio(ghcb, ctxt);
 		break;
