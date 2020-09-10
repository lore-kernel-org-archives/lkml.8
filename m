Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FBF21582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emSKpoVW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khfIOz/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgIJJgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgIJJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78EC061796;
        Thu, 10 Sep 2020 02:22:15 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZT9tKa93L7WPZ1JE6NJcHZ3tz7aYFULXT+oz24YpzLQ=;
        b=emSKpoVWsbLKA/vQsCDOuX1rrQLWcZiApp4L5/aY5Hk+Dplv9pknOg981MEOVZW0TCKBQi
        MIa/Jm/Y//ktqfsSEFmO3fL2dTzmLrsSASbLOlB5qrsLbz/1XU1yV90n8Mb2nBOPyEk+DA
        5xZnrxvXOEQQ1Z0h9Gkf8BE0N6orLfvMMPBj4M4yVpJmcYRqbgsjVk9YicXt1U+TxP2eOf
        TmhBuse9eVQEXqFw0p6plaUXhzKNI4kcrJbLO13+TIi7z4+uN9JyloHslvA4521rXeFxOT
        dY3FAeTdBhlfNN5YKU+OpVUQIGdhS3g3vQsDk3c6AeGD/Ze3G5UUIdIgU34wFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZT9tKa93L7WPZ1JE6NJcHZ3tz7aYFULXT+oz24YpzLQ=;
        b=khfIOz/UjUJfJPDo4kEh/n5+vxJkWvy2UqDsWJYLEEoHbFgRZHvGz2maQqGkIGbb60SeeV
        YPRWeHEqD+0EoICA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle #DB Events
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-62-joro@8bytes.org>
References: <20200907131613.12703-62-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972689.20229.8860672427707184220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     cb1ad3ecea959593400dfac4f027dbc005e62c39
Gitweb:        https://git.kernel.org/tip/cb1ad3ecea959593400dfac4f027dbc005e62c39
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle #DB Events

Handle #VC exceptions caused by #DB exceptions in the guest. Those
must be handled outside of instrumentation_begin()/end() so that the
handler will not be raised recursively.

Handle them by calling the kernel's debug exception handler.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-62-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 8867c48..79d5190 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -922,6 +922,14 @@ static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
 	return ES_EXCEPTION;
 }
 
+static __always_inline void vc_handle_trap_db(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		noist_exc_debug(regs);
+	else
+		exc_debug(regs);
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -1033,6 +1041,15 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	struct ghcb *ghcb;
 
 	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB) {
+		vc_handle_trap_db(regs);
+		return;
+	}
+
 	instrumentation_begin();
 
 	/*
