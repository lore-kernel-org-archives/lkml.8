Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52782C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570EC21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+KIdBQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orYR0jLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHFXj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHFXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:59 -0400
Date:   Thu, 06 Aug 2020 23:38:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INTq0XLsB267sE8Ey06szv6/TkBzi3zrOmLj6qcppWs=;
        b=v+KIdBQSCRWqk34IF/6S/HxLXs57UwGXHbH7eeepVMhoWGhBCYGyw+yX5TsrxWZ0CatWLe
        7tGOpUw121hSbJr8Rcy1cliemNwqmMqIV/ZLDRtUN49avonGpv+2lCuD24BSGVSIGJpc70
        uBLmZQK88tBhRxeEgjujPjihgof/lA9Vrvfl+dGLlk+L8PdR7N8homLaA0e6ehhocYCsx4
        lmQvK1RaGN70JSb5x6zmF5NMtSgpcufiBfHA06ZUCo8SRuL5l9mBScVXWFV4bE83lvHG3u
        g7bMcSt9UWkjaZ1UndvVodQhgq0e92yW15fSpsSBKpvsCi8/gXhABeGr1IJgqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INTq0XLsB267sE8Ey06szv6/TkBzi3zrOmLj6qcppWs=;
        b=orYR0jLZwgAVhC5m4tqayPKUDbHBxAySbdwf0DbuIUErgUo8RnZCcXA7w5CiR0SIKsSZig
        WB1PCQqm3p0lmmDQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Simplify process_gb_huge_pages()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-13-nivedita@alum.mit.edu>
References: <20200728225722.67457-13-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713636.3192.8550558633124756003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     be9e8d9541a95bdfac1c13d112cc032ea7fc745f
Gitweb:        https://git.kernel.org/tip/be9e8d9541a95bdfac1c13d112cc032ea7fc745f
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:13 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Simplify process_gb_huge_pages()

Replace the loop to determine the number of 1Gb pages with arithmetic.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-13-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 47 +++++++++++++------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3727e97..00ef84b 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -547,49 +547,44 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 static void
 process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 {
-	unsigned long addr, size = 0;
+	unsigned long pud_start, pud_end, gb_huge_pages;
 	struct mem_vector tmp;
-	int i = 0;
 
 	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
 		store_slot_info(region, image_size);
 		return;
 	}
 
-	addr = ALIGN(region->start, PUD_SIZE);
-	/* Did we raise the address above the passed in memory entry? */
-	if (addr < region->start + region->size)
-		size = region->size - (addr - region->start);
-
-	/* Check how many 1GB huge pages can be filtered out: */
-	while (size >= PUD_SIZE && max_gb_huge_pages) {
-		size -= PUD_SIZE;
-		max_gb_huge_pages--;
-		i++;
-	}
+	/* Are there any 1GB pages in the region? */
+	pud_start = ALIGN(region->start, PUD_SIZE);
+	pud_end = ALIGN_DOWN(region->start + region->size, PUD_SIZE);
 
 	/* No good 1GB huge pages found: */
-	if (!i) {
+	if (pud_start >= pud_end) {
 		store_slot_info(region, image_size);
 		return;
 	}
 
-	/*
-	 * Skip those 'i'*1GB good huge pages, and continue checking and
-	 * processing the remaining head or tail part of the passed region
-	 * if available.
-	 */
-
-	if (addr >= region->start + image_size) {
+	/* Check if the head part of the region is usable. */
+	if (pud_start >= region->start + image_size) {
 		tmp.start = region->start;
-		tmp.size = addr - region->start;
+		tmp.size = pud_start - region->start;
 		store_slot_info(&tmp, image_size);
 	}
 
-	size  = region->size - (addr - region->start) - i * PUD_SIZE;
-	if (size >= image_size) {
-		tmp.start = addr + i * PUD_SIZE;
-		tmp.size = size;
+	/* Skip the good 1GB pages. */
+	gb_huge_pages = (pud_end - pud_start) >> PUD_SHIFT;
+	if (gb_huge_pages > max_gb_huge_pages) {
+		pud_end = pud_start + (max_gb_huge_pages << PUD_SHIFT);
+		max_gb_huge_pages = 0;
+	} else {
+		max_gb_huge_pages -= gb_huge_pages;
+	}
+
+	/* Check if the tail part of the region is usable. */
+	if (region->start + region->size >= pud_end + image_size) {
+		tmp.start = pud_end;
+		tmp.size = region->start + region->size - pud_end;
 		store_slot_info(&tmp, image_size);
 	}
 }
