Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B0BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10632173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKNOVCYP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4LXh0Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHFXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgHFXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:06 -0400
Date:   Thu, 06 Aug 2020 23:39:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRN6QvitSIvL/somoMlX60NzPXdS9FzFfalaag+UTxM=;
        b=RKNOVCYPvKU5dgrAcJfXJpCLw6QDFJPr4TunVyd4NhVKNBz6XJ8bM0oS6ooFywRTkFZHO6
        wBaTDxU3O73ZQ9Z7OaxGP0BRiYG8tuYFcNLkt+zKed7u46svRn4z7UYdURcMlK/1YcbYnG
        ObX84yg/34OJh9KUPAv5IpMdRGKrAa3GGPsEOR/CoSDVOeBTKZQ72wcSZ60NNiFCdE56AJ
        notzgDwlPx6MV05FjllQXeqquQJrUd2DTpomUc6fClv9ELqUFcyi4j0qncOidlbd1d4V9A
        tagDrtS3hNmHdXpcFcpnm4Mx5i/eeyefLCztQUEorZIG1UrY3XRbBLBsLRX+kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRN6QvitSIvL/somoMlX60NzPXdS9FzFfalaag+UTxM=;
        b=K4LXh0Sduu8HHbfoGYV1qPVQUXXTWMeY+kN0WHJpn0oLPUFJOdBsaVExwpvnA9IzmjoaeP
        fQR8FVpHyX3H/lAQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Make command line handling safer
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-2-nivedita@alum.mit.edu>
References: <20200727230801.3468620-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675714346.3192.17629244064214120082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     709709ac6410f4a14ded158a4b23b979e33e10fb
Gitweb:        https://git.kernel.org/tip/709709ac6410f4a14ded158a4b23b979e33e10fb
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:54 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:07:51 +02:00

x86/kaslr: Make command line handling safer

Handle the possibility that the command line is NULL.

Replace open-coded strlen with a function call.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af..e0f69f3 100644
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
+	unsigned long cmd_line, cmd_line_size;
 
 	/*
 	 * Avoid the region that is unsafe to overlap during
@@ -421,16 +424,15 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* No need to set mapping for initrd, it will be handled in VO. */
 
 	/* Avoid kernel command line. */
-	cmd_line  = (u64)boot_params->ext_cmd_line_ptr << 32;
-	cmd_line |= boot_params->hdr.cmd_line_ptr;
+	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
-	ptr = (char *)(unsigned long)cmd_line;
-	for (cmd_line_size = 0; ptr[cmd_line_size++];)
-		;
-	mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
-	mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
-	add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-			 mem_avoid[MEM_AVOID_CMDLINE].size);
+	if (cmd_line) {
+		cmd_line_size = strlen((char *)cmd_line) + 1;
+		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
+		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
+		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
+				 mem_avoid[MEM_AVOID_CMDLINE].size);
+	}
 
 	/* Avoid boot parameters. */
 	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
