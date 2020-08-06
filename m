Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F324221E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAezeRCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u8iA+PVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHFXj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgHFXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:05 -0400
Date:   Thu, 06 Aug 2020 23:39:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yToSpdeM6C3ejk+ILWYfVNM0PXl/drpN3uSrQ21Pn/Q=;
        b=BAezeRCgd0W5xKSk0G0pk6XCms3uGSDsZMRFf6Mw810jgEqFxrGUeeXvgFleG4aJF0U4em
        RrJ07nnGGDbYBiFG3GTXjU0jznvcBRDBsb3T7ERQh8Gs1iwOb2HoJ2soFeYzRB6w36OkbC
        6GqZ7lDZ+5f+qF5BmUtouJClolMW2+gvLj8QvBVmSZ6Jkld0IU6WorNRUJA07SE/gCelmv
        whfoKGPozStGXhwr9qshx3xkM2zN11Tw6edJ17BXFGM9Oa9Jumnz0Qo9ObzJIJ+/E4f6NR
        RLIuNVL0Gt5+nIG1LxSc2xP7kjnLLHLMvtgUAyJ0gVWi8aPO9hlykgcJ4yj6zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yToSpdeM6C3ejk+ILWYfVNM0PXl/drpN3uSrQ21Pn/Q=;
        b=u8iA+PVvfqcZV/UkkWW0vL+1ds+iPg7NkXBWSU6eFX7wke3RfY2ICwdW7bfgBaB985zFLk
        EccljINe4wp1o6Cw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Remove bogus warning and unnecessary goto
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-3-nivedita@alum.mit.edu>
References: <20200727230801.3468620-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675714282.3192.931391555464136826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     e2ee6173162b28053cb76b25887a0be9331c9e21
Gitweb:        https://git.kernel.org/tip/e2ee6173162b28053cb76b25887a0be9331c9e21
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:55 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:07 +02:00

x86/kaslr: Remove bogus warning and unnecessary goto

Drop the warning on seeing "--" in handle_mem_options(). This will trigger
whenever one of the memory options is present in the command line
together with "--", but there's no problem if that is the case.

Replace goto with break.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-3-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e0f69f3..c31f3a5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -295,10 +295,8 @@ static void handle_mem_options(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 		/* Stop at -- */
-		if (!val && strcmp(param, "--") == 0) {
-			warn("Only '--' specified in cmdline");
-			goto out;
-		}
+		if (!val && strcmp(param, "--") == 0)
+			break;
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
@@ -311,7 +309,7 @@ static void handle_mem_options(void)
 				continue;
 			mem_size = memparse(p, &p);
 			if (mem_size == 0)
-				goto out;
+				break;
 
 			mem_limit = mem_size;
 		} else if (!strcmp(param, "efi_fake_mem")) {
@@ -319,7 +317,6 @@ static void handle_mem_options(void)
 		}
 	}
 
-out:
 	free(tmp_cmdline);
 	return;
 }
