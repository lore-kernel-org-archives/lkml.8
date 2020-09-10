Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF63C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ABB21582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="duPmDBMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StVpUaql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgIJJYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:24:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgIJJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnXv12gGBDaSrD0ETKCH4ffZcRC1dqZFTwndZAy2Q/4=;
        b=duPmDBMfMRTAcuacqlRsOjLHbyWJA2lDIOHNW9hKeHD/tPLK5OoLwI+w/wLfGuM8QWLeZa
        ryhJf1Nmn/YTpHaNcoSYkjNmpc6WDwqhd500Hf7WbWEdzz0llgVX/utGX5qFdh+ou2rz5c
        Zr2dcx0e9DlQm96pQQkjpYUNEwIwLm1BC6pFRY/IlOjZ8xkPLX8qM36AOpyoEZowQdJ802
        B2HxdJ1CAEAYyuoqLs7ng0ShUm6SiAOYQuf7DqMYBKs21KTM/9OOr3GRGiU+F3pJ2sY0E4
        6+KS7P0734JeXjUa/3Q5PStbteQc6gbvMd/LoXpE5C1vCNoENCLU0clgK38qIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnXv12gGBDaSrD0ETKCH4ffZcRC1dqZFTwndZAy2Q/4=;
        b=StVpUaqlQe+FQnCFYtdqs1MevyxK+opsL4vs1BQOS+KpVHPNN1GE5d1PtzoPdzCxfHuMzn
        Q1jSUOxJKHTDlLDg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle INVD Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-57-joro@8bytes.org>
References: <20200907131613.12703-57-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972887.20229.4347569173529097534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     8b4ce83707cb2cff5f6d175ea38f751ac4456096
Gitweb:        https://git.kernel.org/tip/8b4ce83707cb2cff5f6d175ea38f751ac4456096
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle INVD Events

Implement a handler for #VC exceptions caused by INVD instructions.
Since Linux should never use INVD, just mark it as unsupported.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-57-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index b2d7287..236cfc1 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -892,6 +892,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_RDPMC:
 		result = vc_handle_rdpmc(ghcb, ctxt);
 		break;
+	case SVM_EXIT_INVD:
+		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
+		result = ES_UNSUPPORTED;
+		break;
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(ghcb, ctxt);
 		break;
