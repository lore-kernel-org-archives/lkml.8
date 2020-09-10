Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74284C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B782075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdS2eI19";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdlZWBZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgIJJfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgIJJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85782C06179F;
        Thu, 10 Sep 2020 02:22:17 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odBe+hsn5smopQlsclW6Pk83LjFC5FJmfNaQ+36jlFw=;
        b=mdS2eI19MKEWlUOvf0E0K8RcVIqrG71kdMuFc7KCIb6yt878H14SZIcKK3Kyl7JSP208uB
        TDyfxVZQr52kVcfroKkHuuhbvXZlVf40qfbkF60KnyycpwICFV1zuo1fEe7D3T5xuCc6/8
        GB8YrkxjcNAHj4XCEFIT0+YfxKNiFja8kTor1p0GO1aXFTnEzGVqUQUUrv3Sdtup7R/VuE
        Y8zVV6pqedmQ3pb7HplIrJBMHlhnBoSQJ4ANc+128UKr2tWz1g6aetIlk+WUeKlUs53Lti
        xBb6VX+5pb0h2raeAV0UWS0qKPk3e/nPiOWZ40ZYiXR4qZBlwTWxBqFTYMEsHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odBe+hsn5smopQlsclW6Pk83LjFC5FJmfNaQ+36jlFw=;
        b=RdlZWBZ/4NeQ/z9OaF6SqXvba4e3lb33IvUgU4DSDrNY+9FfgWHy929xn4ld8X6sHV/g9x
        b/VKQpXlzwgZ+yDg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle instruction fetches from user-space
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-49-joro@8bytes.org>
References: <20200907131613.12703-49-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973220.20229.16614295207021809730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     5e3427a7bc432ed2e5de394ac30f160cc6c37a1f
Gitweb:        https://git.kernel.org/tip/5e3427a7bc432ed2e5de394ac30f160cc6c37a1f
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/sev-es: Handle instruction fetches from user-space

When a #VC exception is triggered by user-space, the instruction decoder
needs to read the instruction bytes from user addresses. Enhance
vc_decode_insn() to safely fetch kernel and user instructions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-49-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index b10a62a..6c30dbc 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -232,17 +232,30 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 	enum es_result ret;
 	int res;
 
-	res = vc_fetch_insn_kernel(ctxt, buffer);
-	if (unlikely(res == -EFAULT)) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = 0;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
+	if (user_mode(ctxt->regs)) {
+		res = insn_fetch_from_user(ctxt->regs, buffer);
+		if (!res) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+			ctxt->fi.cr2        = ctxt->regs->ip;
+			return ES_EXCEPTION;
+		}
+
+		if (!insn_decode(&ctxt->insn, ctxt->regs, buffer, res))
+			return ES_DECODE_FAILED;
+	} else {
+		res = vc_fetch_insn_kernel(ctxt, buffer);
+		if (res) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.error_code = X86_PF_INSTR;
+			ctxt->fi.cr2        = ctxt->regs->ip;
+			return ES_EXCEPTION;
+		}
+
+		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+		insn_get_length(&ctxt->insn);
 	}
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-	insn_get_length(&ctxt->insn);
-
 	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
 
 	return ret;
