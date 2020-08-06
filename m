Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29B62173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bOdP1wC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/4LXZD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHFXjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHFXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:58 -0400
Date:   Thu, 06 Aug 2020 23:38:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRy200Kpf4NnYVl0QfDk0nBUrm1f1yuZ/hbZQNG/7+8=;
        b=3bOdP1wCSXP5PR74QgDyZXOaaAQCI/dI4r2jrs2ZYLirjz3iicbceIO0zuvrPIDI0UTXLW
        qTaEMAypwr6AHH0nQYv7pSQflEUGb/25cRwfcQeYiZLWG+pSm0uiUvdcphqHyVUc9KB6Mq
        D7vE0VIvnZ2gnzoTlRq5wglhCEJggYCQTMZGvS5VMuHmiaIYIHdZqn8bUTx8VHJgni3g1a
        94xW2KtUoEYqdUySgdIy3ak5BPXTHVn3dr0vHsoe1mTdmMSuCQ7JRqzcqufHiI+8wMw0rf
        ZvgFbaW7vdhZnstofVFRuGkIuOEToYCQtCZajn341mS5ACgrsVJrPMRsYCpF+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRy200Kpf4NnYVl0QfDk0nBUrm1f1yuZ/hbZQNG/7+8=;
        b=K/4LXZD4NVHsIRsLV0wJs37hluvA0y43fA6p1db1Ar5nmRjTX/v2HQZa/V7mPTWH6BLvLF
        7cEKLJF9xO5goqCg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop test for command-line parameters
 before parsing
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-14-nivedita@alum.mit.edu>
References: <20200728225722.67457-14-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713575.3192.10750788728765458633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     3870d971791f13df88a7a656e3fd6e2df8686097
Gitweb:        https://git.kernel.org/tip/3870d971791f13df88a7a656e3fd6e2df8686097
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:14 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop test for command-line parameters before parsing

This check doesn't save anything. In the case when none of the
parameters are present, each strstr will scan args twice (once to find
the length and then for searching), six scans in total. Just going ahead
and parsing the arguments only requires three scans: strlen, memcpy, and
parsing. This will be the first malloc, so free will actually free up
the memory, so the check doesn't save heap space either.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-14-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 00ef84b..bd13dc5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -279,10 +279,6 @@ static void handle_mem_options(void)
 	if (!args)
 		return;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
-		!strstr(args, "hugepages"))
-		return;
-
 	len = strlen(args);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
