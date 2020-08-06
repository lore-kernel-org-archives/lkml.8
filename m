Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB8B21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAAGpn/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KT176TXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHFXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHFXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:03 -0400
Date:   Thu, 06 Aug 2020 23:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qr987amBZwdnITURmE65nMl6RZWE9Vvv/+AZTeUYqj0=;
        b=DAAGpn/zFU9XUKjA17apPVl6tkZ15PxzCCg0EFOpDKHHVif2fCjXplT/D/jqwhHh5uQdaP
        6e1ZV4OBDhQFsjg31YDnS4/Ta6mf2JCB7/dghhxV1Rq2HnQwdprvm6ptC62MscA0Vv0zyS
        V/XwtiycAk070SWPRVMnds6++qBcE0cANcQByeqxx9ZmLiSCsUuj3AjoXkJUf8I8OloC79
        EtmTksb+Kv9dzITNIFgtv9x6ryWXOw7ftAlzgQS185STztRf58kkxhgCNb2BHyN1rQD8K9
        6IswqJFLY7ZigGdmTwfReDRGpvKuJMs6cXWS6C41cT6cdJWUmqJ9OMtq75i8gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qr987amBZwdnITURmE65nMl6RZWE9Vvv/+AZTeUYqj0=;
        b=KT176TXhwShaaIEF7jUzFoD/ZXcDBKALQNwpOfzMMi9nU3UsL/gFx5uyroHljmJYpWSdKS
        yd71d83h2o1X/3AA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop redundant cur_entry from
 __process_mem_region()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-7-nivedita@alum.mit.edu>
References: <20200728225722.67457-7-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675714018.3192.1265605139963105539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     3f9412c73053a5be311607e42560c1303a873be7
Gitweb:        https://git.kernel.org/tip/3f9412c73053a5be311607e42560c1303a873be7
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:07 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop redundant cur_entry from __process_mem_region()

cur_entry is only used as cur_entry.start + cur_entry.size, which is
always equal to end.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-7-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 848346f..f2454ee 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -624,7 +624,6 @@ static void __process_mem_region(struct mem_vector *entry,
 {
 	struct mem_vector region, overlap;
 	unsigned long start_orig, end;
-	struct mem_vector cur_entry;
 
 	/* Ignore entries entirely below our minimum. */
 	if (entry->start + entry->size < minimum)
@@ -634,11 +633,9 @@ static void __process_mem_region(struct mem_vector *entry,
 	end = min(entry->size + entry->start, mem_limit);
 	if (entry->start >= end)
 		return;
-	cur_entry.start = entry->start;
-	cur_entry.size = end - entry->start;
 
-	region.start = cur_entry.start;
-	region.size = cur_entry.size;
+	region.start = entry->start;
+	region.size = end - entry->start;
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
@@ -652,7 +649,7 @@ static void __process_mem_region(struct mem_vector *entry,
 		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
 
 		/* Did we raise the address above the passed in memory entry? */
-		if (region.start > cur_entry.start + cur_entry.size)
+		if (region.start > end)
 			return;
 
 		/* Reduce size by any delta from the original address. */
