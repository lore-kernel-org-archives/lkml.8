Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D402173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oE3qlRgB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUnK+3i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHFXjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHFXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:58 -0400
Date:   Thu, 06 Aug 2020 23:38:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJ3t4IzCnqYZfoqTW+ZNYage2ClJbjW6jNQ/cNP+1gg=;
        b=oE3qlRgBgzCoamBeEMYL1355nUULygJBiEh+kih8MG1Vqy0NqMx2w4bzF6+J3AfAqcUh//
        VOPsfTN0gIZ1ge1BEfdKyCgeiijOP7d9Je8TzWq/p6j05rxkBQSM7cDv2PetYgxGPDBpNX
        ZsQUb73UZ8bJlf4alr7WiDbjAZcv63w2s4plFYrYPWs/p3TNQz+Q5vtH1b6SsqyT/Styu3
        3wTOpp+HMcl+R1gC52LiDGDZ5sZRNCGi9qGok09HEEuBZ67iSsjpRg2buMwP4qujEPl7T4
        3xAaPBhROIfucRC8e8+RnmV5mjNX5Q+0gXNXxB7TLAjojzX/JMKMaDmQaZQPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJ3t4IzCnqYZfoqTW+ZNYage2ClJbjW6jNQ/cNP+1gg=;
        b=KUnK+3i2wgEdtL6jzWf+2qZBLv9641WPlsvTULJUbV+98qhrQbebwl4YqgdE7ZptYMKKnl
        wSk1U/JKcgcC51Bw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Make the type of number of slots/slot
 areas consistent
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-15-nivedita@alum.mit.edu>
References: <20200728225722.67457-15-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713511.3192.15949852694615792267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     d6d0f36c735367ed7cf42b5ba454ba5858e17816
Gitweb:        https://git.kernel.org/tip/d6d0f36c735367ed7cf42b5ba454ba5858e17816
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:15 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Make the type of number of slots/slot areas consistent

The number of slots can be 'unsigned int', since on 64-bit, the maximum
amount of memory is 2^52, the minimum alignment is 2^21, so the slot
number cannot be greater than 2^31. But in case future processors have
more than 52 physical address bits, make it 'unsigned long'.

The slot areas are limited by MAX_SLOT_AREA, currently 100. It is
indexed by an int, but the number of areas is stored as 'unsigned long'.
Change both to 'unsigned int' for consistency.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-15-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index bd13dc5..5c7457c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -508,17 +508,15 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 
 struct slot_area {
 	unsigned long addr;
-	int num;
+	unsigned long num;
 };
 
 #define MAX_SLOT_AREA 100
 
 static struct slot_area slot_areas[MAX_SLOT_AREA];
-
+static unsigned int slot_area_index;
 static unsigned long slot_max;
 
-static unsigned long slot_area_index;
-
 static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 {
 	struct slot_area slot_area;
@@ -588,7 +586,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 static unsigned long slots_fetch_random(void)
 {
 	unsigned long slot;
-	int i;
+	unsigned int i;
 
 	/* Handle case of no slots stored. */
 	if (slot_max == 0)
