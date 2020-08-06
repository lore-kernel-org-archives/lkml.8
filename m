Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2322C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2BC22D6F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kxtv3LqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAO4oa1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHFXjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHFXiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A1C061574;
        Thu,  6 Aug 2020 16:38:52 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4nbLAAuSFU/iG/0iov28OXKQeCl8AQVN5QtOnyn6SA=;
        b=Kxtv3LqYINat3EB9eh1QDQDiHqpFvOTi6c65sT5DLRTJUc4aZKBrpYKlLQ2Ojd3ok4i94r
        ovVeGvln0I2Fw0xn4bS7sWG9yYDuJNUih1SQlUYsGKe+Ya0ggge+hMVyyB3FGQ/SO7hL8G
        wEMv3Q8tnEbd/pg+Ki9tiKHrVGelZbxVjwhYJtaV/7IZTs6doZb2mLLBm70x9MsmrMKkcB
        RYnKFFpM9W5Wn4NiiaGr1KY8eIkUG5WB2QfNPCul+q4Elxvke4D/PsVk3g8UO6msliy+jJ
        9AkUI+5ncsPnMq60UdPDPbATr5ejBvjCLJ+kuiF2NC00e6M+mtV8iRCE2z8gog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4nbLAAuSFU/iG/0iov28OXKQeCl8AQVN5QtOnyn6SA=;
        b=eAO4oa1zUFfsd/Ox5wnUqMG3BDdICSbc2tA8tZx/gqL+mXzrJT2MFbkbKrdpD//SCkZPAg
        eVDgIoUdppGqBSBA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Replace strlen() with strnlen()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200803011534.730645-2-nivedita@alum.mit.edu>
References: <20200803011534.730645-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675712976.3192.9635151038817654680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     76167e5c5457aee8fba3edc5b8554183696fc94d
Gitweb:        https://git.kernel.org/tip/76167e5c5457aee8fba3edc5b8554183696fc94d
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Sun, 02 Aug 2020 21:15:34 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 17:03:19 +02:00

x86/kaslr: Replace strlen() with strnlen()

strnlen is safer in case the command line is not NUL-terminated.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200803011534.730645-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 735fcb2..6d39743 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -43,6 +43,10 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
@@ -278,7 +282,7 @@ static void handle_mem_options(void)
 	if (!args)
 		return;
 
-	len = strlen(args);
+	len = strnlen(args, COMMAND_LINE_SIZE-1);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
 		error("Failed to allocate space for tmp_cmdline");
@@ -425,7 +429,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
 	if (cmd_line) {
-		cmd_line_size = strlen((char *)cmd_line) + 1;
+		cmd_line_size = strnlen((char *)cmd_line, COMMAND_LINE_SIZE-1) + 1;
 		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
 		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
