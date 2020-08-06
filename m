Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D521744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aU09s6H9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7dQBnQcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHFXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHFXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:00 -0400
Date:   Thu, 06 Aug 2020 23:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4S3pVhMKh2t0G9uw4IYK8KX+fkH+eaym+tHkM+R+FA=;
        b=aU09s6H9NvZ/+JZOi7zcmRhOkZraNuGzvZF0ZJzjBkV4v8tOZDMUxiHpjn6zajEnYDQCEA
        +oDiq+jSSqCaIaDqD4v7t40i8essFlgdo5Tozyif//nSn594jrKD3oT2517RVaRlQwFzp7
        EHY2ujcntNJFYYZzQJNwSYc+12yDHbulb1QGGK7OzThL0TlIkQMgUXnJ1vzC2N9z1BzoBH
        CUbg54DKYt3mHx+zNBCF9l0BR4OQ16lXEZtEdanz+73KlCfmg+mVRxxQ3rx+ujNTnzVCdk
        Ui5t2b0cGUS6SFJ3ChzH1Wdev4qFF7hdtw3Ga32gexZz0jiRB4HILT4W1w7ZVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4S3pVhMKh2t0G9uw4IYK8KX+fkH+eaym+tHkM+R+FA=;
        b=7dQBnQcW4XCUYMP4v0jwK0F56nfaplP+qeBwi7MPemX/0nVpKdcf4nPNkEth0gqQvj6R1K
        rMBjJQraivjHp1DQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop some redundant checks from
 __process_mem_region()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-10-nivedita@alum.mit.edu>
References: <20200728225722.67457-10-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713825.3192.5330235874355690213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     bf457be1548eee6d106daf9604e029b36fed2b11
Gitweb:        https://git.kernel.org/tip/bf457be1548eee6d106daf9604e029b36fed2b11
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:10 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop some redundant checks from __process_mem_region()

Clip the start and end of the region to minimum and mem_limit prior to
the loop. region.start can only increase during the loop, so raising it
to minimum before the loop is enough.

A region that becomes empty due to this will get checked in
the first iteration of the loop.

Drop the check for overlap extending beyond the end of the region. This
will get checked in the next loop iteration anyway.

Rename end to region_end for symmetry with region.start.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-10-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8cc47fa..d074986 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -623,34 +623,23 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long end;
+	unsigned long region_end;
 
-	/* Ignore entries entirely below our minimum. */
-	if (entry->start + entry->size < minimum)
-		return;
-
-	/* Ignore entries above memory limit */
-	end = min(entry->size + entry->start, mem_limit);
-	if (entry->start >= end)
-		return;
-
-	region.start = entry->start;
+	/* Enforce minimum and memory limit. */
+	region.start = max_t(unsigned long long, entry->start, minimum);
+	region_end = min(entry->start + entry->size, mem_limit);
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
-		/* Potentially raise address to minimum location. */
-		if (region.start < minimum)
-			region.start = minimum;
-
 		/* Potentially raise address to meet alignment needs. */
 		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
 
 		/* Did we raise the address above the passed in memory entry? */
-		if (region.start > end)
+		if (region.start > region_end)
 			return;
 
 		/* Reduce size by any delta from the original address. */
-		region.size = end - region.start;
+		region.size = region_end - region.start;
 
 		/* Return if region can't contain decompressed kernel */
 		if (region.size < image_size)
@@ -668,10 +657,6 @@ static void __process_mem_region(struct mem_vector *entry,
 			process_gb_huge_pages(&region, image_size);
 		}
 
-		/* Return if overlap extends to or past end of region. */
-		if (overlap.start + overlap.size >= region.start + region.size)
-			return;
-
 		/* Clip off the overlapping region and start over. */
 		region.start = overlap.start + overlap.size;
 	}
