Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F235C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CD2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dH8tROJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPl0kblo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgG1M3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgG1M3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395CC061794;
        Tue, 28 Jul 2020 05:29:17 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YdZ/axXCwm5XLxxjQO1zY7IIzjjaE8o/vGu+HswV80=;
        b=dH8tROJOv5vjYJgzWMafFdY/lsmhhOQ/gZ6CCVcdeS0RXPzVxNBG91+B++8EytuJGlc4fU
        L3sfQ6mlzzTjW9DHTpo2P2D4IQKYURRK9yjq0FJzUTjBhrN0Nnq9H5FlQXKDeLZhsCHD5E
        vLTerRL7avkl1b5dX4aXUqYBtc6InfHASl/kcTSHj8SxrkCftIXvhQe9uQ8jAV5HAOAFZj
        IQjLXNtm/rOENV4ZBBfbYwnt1QUbJ6qseXY2j/VxK7yMTmR3J6IL5K2uCKdb5g/1v+6WGW
        pUIwWbX5QmQVODFs2IkEva6aIHtyl2J0jV7UcUOEr1wnUo2BkCc4878wpTfeNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YdZ/axXCwm5XLxxjQO1zY7IIzjjaE8o/vGu+HswV80=;
        b=ZPl0kblootfNSOyfVkLc775LwHAsmZXdljwDmeWMMQd92NzieEeZC99S/jnXuZpK+BCjKe
        im+W8hZqG3PVwhCA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Remove bogus warning and unnecessary goto
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-3-nivedita@alum.mit.edu>
References: <20200727230801.3468620-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159593935504.4006.12364452342763685270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     237069512d18f0f20b230680f067a2c070a7903a
Gitweb:        https://git.kernel.org/tip/237069512d18f0f20b230680f067a2c070a7903a
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:55 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 12:54:42 +02:00

x86/kaslr: Remove bogus warning and unnecessary goto

Drop the warning on seeing "--" in handle_mem_options(). This will trigger
whenever one of the memory options is present in the command line
together with "--", but there's no problem if that is the case.

Replace goto with break.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-3-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a4af896..21cd9e0 100644
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
