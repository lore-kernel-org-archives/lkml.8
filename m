Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFCE207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZ+fpA6U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KOSA3Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgGANdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:33:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39104 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgGANdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:19 -0400
Date:   Wed, 01 Jul 2020 13:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593610397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGREWTZQfGzvQo1BDmWCpHmJqoIsctBdt0l0hZ2KfmM=;
        b=cZ+fpA6U950WuXtSCgMSNL15WJyt1gYMJRMfyONLQ4z6pPNNp08+RtjWHx+HSBF1mHVwu5
        zly+er1OkAa1+zq+2PzHsJLPPUCushTBC8nUPTiqVy89Q1XIVP1N6vcTGKNSn7Rg9QBZ8t
        /cfIQpGGv/BbCZIaoWn8Qsc8iNVrS/ias5kRU8zOMRro+NbyPnxp5MHyIswkuKwxs/q6vr
        C567RFWUR0V0fRO6W9M4GP3/drt2aq0nASz+qO+CnOOG90BYI+1TZITc1hLRs4bozcp1cC
        026T6XyN7yxtjosndIpBk8/+GDR1UxkRjjVu0CV4FgGwoUtLJYLzpu2V2m/dgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593610397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGREWTZQfGzvQo1BDmWCpHmJqoIsctBdt0l0hZ2KfmM=;
        b=0KOSA3Fj+wJa+LxmYZALkF2JUjtjOVxcQZluMbCKxXhizvTiZ5sakd8GLEwYZurK74n1tH
        rw5X5rQMfnu8IMDg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] selftests/x86/fsgsbase: Fix a comment in the
 ptrace_write_gsbase test
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <901034a91a40169ec84f1f699ea86704dff762e4.1593192140.git.luto@kernel.org>
References: <901034a91a40169ec84f1f699ea86704dff762e4.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159361039674.4006.9037710578613400832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     979c2c4247cafd8a91628a7306b6871efbd12fdb
Gitweb:        https://git.kernel.org/tip/979c2c4247cafd8a91628a7306b6871efbd12fdb
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:24:27 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 15:27:20 +02:00

selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test

A comment was unclear.  Fix it.

Fixes: 5e7ec8578fa3 ("selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/901034a91a40169ec84f1f699ea86704dff762e4.1593192140.git.luto@kernel.org

---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 9a43498..f47495d 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -498,7 +498,8 @@ static void test_ptrace_write_gsbase(void)
 			 * base would zero the selector.  On newer kernels,
 			 * this behavior has changed -- poking the base
 			 * changes only the base and, if FSGSBASE is not
-			 * available, this may not effect.
+			 * available, this may have no effect once the tracee
+			 * is resumed.
 			 */
 			if (gs == 0)
 				printf("\tNote: this is expected behavior on older kernels.\n");
