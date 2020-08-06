Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823B62173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IMPKijvw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDZkm5vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHFXkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHFXiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:54 -0400
Date:   Thu, 06 Aug 2020 23:38:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch/ZbyQPh5zAPHhTTKYTrb8KpxCzGor9HlcTJgHy8tY=;
        b=IMPKijvwk+rwZOUB7nmyrWvaEE9UHFlNrMjDbiCQNmaX1oOVZIARN6JXl30mudGfcK1UAM
        afhONUWmF61wv4uzqNrzbip4NyWq8d/C9NYLZtwuDDhQfgRl1bbfXPJ72v9tsRLHR1dsNF
        5Vo16ux7bwClIJBDpea+fTxJcP+AWvTPRTWqfyRxfUUHl50+m0w9A8hSWR5sGffmUm/Esb
        VtT/zGGl8hLmm86Nqwx07gomJJXRsJ3lDPD0TMHd02MWvibJngo1g64577leIvZVZZIlhV
        Td9gl5uXtOCyFhzJ3Oo94+6R5z9HRuWFxq2xphu4w9Fne8gKBEiPq7/WlNkcJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch/ZbyQPh5zAPHhTTKYTrb8KpxCzGor9HlcTJgHy8tY=;
        b=dDZkm5vhH4rD4uT6ZM2Keusr+t7ui3LMJ0wV3srWiD7bu4BNY+01ESe5nvoNDvUC3nvE4W
        GN0hIAvV6B01mcCA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Make local variables 64-bit
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-21-nivedita@alum.mit.edu>
References: <20200728225722.67457-21-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713110.3192.165971171564749416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     0eb1a8af01d6264cf948d67c8bff15e2eb859355
Gitweb:        https://git.kernel.org/tip/0eb1a8af01d6264cf948d67c8bff15e2eb859355
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:21 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Make local variables 64-bit

Change the type of local variables/fields that store mem_vector
addresses to u64 to make it less likely that 32-bit overflow will cause
issues on 32-bit.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-21-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index db8589c..80cdd20 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -461,7 +461,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 {
 	int i;
 	struct setup_data *ptr;
-	unsigned long earliest = img->start + img->size;
+	u64 earliest = img->start + img->size;
 	bool is_overlapping = false;
 
 	for (i = 0; i < MEM_AVOID_MAX; i++) {
@@ -506,7 +506,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 }
 
 struct slot_area {
-	unsigned long addr;
+	u64 addr;
 	unsigned long num;
 };
 
@@ -537,7 +537,8 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 static void
 process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 {
-	unsigned long pud_start, pud_end, gb_huge_pages;
+	u64 pud_start, pud_end;
+	unsigned long gb_huge_pages;
 	struct mem_vector tmp;
 
 	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
@@ -579,7 +580,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 	}
 }
 
-static unsigned long slots_fetch_random(void)
+static u64 slots_fetch_random(void)
 {
 	unsigned long slot;
 	unsigned int i;
@@ -595,7 +596,7 @@ static unsigned long slots_fetch_random(void)
 			slot -= slot_areas[i].num;
 			continue;
 		}
-		return slot_areas[i].addr + slot * CONFIG_PHYSICAL_ALIGN;
+		return slot_areas[i].addr + ((u64)slot * CONFIG_PHYSICAL_ALIGN);
 	}
 
 	if (i == slot_area_index)
@@ -608,7 +609,7 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long region_end;
+	u64 region_end;
 
 	/* Enforce minimum and memory limit. */
 	region.start = max_t(u64, entry->start, minimum);
