Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE57C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A8E21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMqoema1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tk5EY1R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHFXkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgHFXiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:54 -0400
Date:   Thu, 06 Aug 2020 23:38:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLpJDeFxy+PTx4/tTPkZdjyWW+ZYuXF66k678B1t4rs=;
        b=aMqoema19u4I+UEZh/OHpX5/t6hc11TnLMeDgv9Mykk5ndN6t0a0D9hb80Rr8TrKzOf4T+
        M1hKA5DMqC+ByNdKyMeXRVUpj/IbOaeCdQB2QsWVlvJfTx0t+ZHqE+OFC8IoWDx4ETA0M3
        pJxbrIz9VR8tJ7gFPrkWhKCWseErQo62fRUB6+3ZxZgQeFaRje5J5fJXuhDUnuJb9W2bUl
        LLPVCtb+yU2Rahqcf1a+471yDc0slYbdm4ff9VC7Mv/bzmDvQcA+cv7OfthIJSllM9WB7h
        15iuWnlDG0KknkhKQgBBbO3HTvUTC8A8p5JUtggojMZoJYi6XPViNYRehKwd0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLpJDeFxy+PTx4/tTPkZdjyWW+ZYuXF66k678B1t4rs=;
        b=Tk5EY1R/kqCQMZVHzBKj/uBDdZc3YcUMe768w0kFwSteOd8CX5tRXVQPPm0Hl1yM/t+XhC
        1esuHuCd7zLWQJAw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Replace 'unsigned long long' with 'u64'
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-20-nivedita@alum.mit.edu>
References: <20200728225722.67457-20-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713178.3192.13197922720000433482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     3a066990a35eb289d54036637d2793d4743b8f07
Gitweb:        https://git.kernel.org/tip/3a066990a35eb289d54036637d2793d4743b8f07
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:20 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Replace 'unsigned long long' with 'u64'

No functional change.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-20-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 13 ++++++-------
 arch/x86/boot/compressed/misc.h  |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3244f5b..db8589c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -98,7 +98,7 @@ static bool memmap_too_large;
  * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
  * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
  */
-static unsigned long long mem_limit;
+static u64 mem_limit;
 
 /* Number of immovable memory regions */
 static int num_immovable_mem;
@@ -141,8 +141,7 @@ enum parse_mode {
 };
 
 static int
-parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
-		enum parse_mode mode)
+parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
 {
 	char *oldp;
 
@@ -172,7 +171,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
 			 */
 			*size = 0;
 		} else {
-			unsigned long long flags;
+			u64 flags;
 
 			/*
 			 * efi_fake_mem=nn@ss:attr the attr specifies
@@ -211,7 +210,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
-		unsigned long long start, size;
+		u64 start, size;
 		char *k = strchr(str, ',');
 
 		if (k)
@@ -612,7 +611,7 @@ static void __process_mem_region(struct mem_vector *entry,
 	unsigned long region_end;
 
 	/* Enforce minimum and memory limit. */
-	region.start = max_t(unsigned long long, entry->start, minimum);
+	region.start = max_t(u64, entry->start, minimum);
 	region_end = min(entry->start + entry->size, mem_limit);
 
 	/* Give up if slot area array is full. */
@@ -673,7 +672,7 @@ static bool process_mem_region(struct mem_vector *region,
 	 * immovable memory and @region.
 	 */
 	for (i = 0; i < num_immovable_mem; i++) {
-		unsigned long long start, end, entry_end, region_end;
+		u64 start, end, entry_end, region_end;
 		struct mem_vector entry;
 
 		if (!mem_overlaps(region, &immovable_mem[i]))
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264..3efce27 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -70,8 +70,8 @@ int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
 
 struct mem_vector {
-	unsigned long long start;
-	unsigned long long size;
+	u64 start;
+	u64 size;
 };
 
 #if CONFIG_RANDOMIZE_BASE
