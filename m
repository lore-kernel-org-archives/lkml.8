Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646EC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4486A206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBB9GmPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Iz87Nq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgG1M3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgG1M3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A921C061794;
        Tue, 28 Jul 2020 05:29:18 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S0GPeOT575VDIu9dVFjsNOq+UDoG7rnlQNeDEnhF38=;
        b=gBB9GmPiODnYJRU3B9dYhjS6KCpEm69Aw5JE94RNyxIQCf5TDQIrZ85tvulEL1W0bY8FF7
        aAyHDfBTuRFUq0N5r+7oF4FMAxiL4gxANsAI5BJC9AS+kFJj+IXTWcJ5a8egV8O2SJ7qWw
        M8PoAkJu5pfHUWGKgBpzkKFtnPiit/+pga3nWFba3oIA9EgQjFBYSYcHvQDse/t4MfL/mF
        GusD3C82yU6rtV4FubYKFd7fpGmObTJy6a1ZkyENRgURKWz6RyDiR6T3LwrG4VJjp+zv08
        KSXxpjWd5Ak1VXvIUQ6Hi9ll12gjAmpFf0yQe6wVJFRjnQR8PTCPyW2oQ0vsvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S0GPeOT575VDIu9dVFjsNOq+UDoG7rnlQNeDEnhF38=;
        b=5Iz87Nq6MnoH0JxXNLX03HL2dtfaAIV7DhP3cwMrcMPmSBYoVF26Dv8cilpm2/2Ts3k0SN
        3SzSl9Jh+GqKPPCw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Make command line handling safer
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-2-nivedita@alum.mit.edu>
References: <20200727230801.3468620-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159593935568.4006.12876607482586309970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     c8465b03acf9d4bb43b9714b6cfb99442defe664
Gitweb:        https://git.kernel.org/tip/c8465b03acf9d4bb43b9714b6cfb99442defe664
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:54 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 12:54:42 +02:00

x86/kaslr: Make command line handling safer

Handle the possibility that the command line is NULL.

Replace open-coded strlen with a function call.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af..a4af896 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -268,15 +268,19 @@ static void parse_gb_huge_pages(char *param, char *val)
 static void handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
-	size_t len = strlen((char *)args);
+	size_t len;
 	char *tmp_cmdline;
 	char *param, *val;
 	u64 mem_size;
 
+	if (!args)
+		return;
+
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
 		!strstr(args, "hugepages"))
 		return;
 
+	len = strlen(args);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
 		error("Failed to allocate space for tmp_cmdline");
@@ -399,8 +403,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 {
 	unsigned long init_size = boot_params->hdr.init_size;
 	u64 initrd_start, initrd_size;
-	u64 cmd_line, cmd_line_size;
-	char *ptr;
+	unsigned long cmd_line, cmd_line_size = 0;
 
 	/*
 	 * Avoid the region that is unsafe to overlap during
@@ -421,12 +424,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* No need to set mapping for initrd, it will be handled in VO. */
 
 	/* Avoid kernel command line. */
-	cmd_line  = (u64)boot_params->ext_cmd_line_ptr << 32;
-	cmd_line |= boot_params->hdr.cmd_line_ptr;
+	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
-	ptr = (char *)(unsigned long)cmd_line;
-	for (cmd_line_size = 0; ptr[cmd_line_size++];)
-		;
+	if (cmd_line)
+		cmd_line_size = strlen((char *)cmd_line);
 	mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 	mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
 	add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
