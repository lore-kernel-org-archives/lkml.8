Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A8BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AE021744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdoINPRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5nXBHIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgHFXju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgHFXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:01 -0400
Date:   Thu, 06 Aug 2020 23:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7CWj2s6SdgROMAEjUATGzwAp9kEOqwvACXgDBJ+znM=;
        b=RdoINPRKm8exJ7V047pI9pgadbenh2F/pLl8oOpRxrtkdq/15A3WojCRgNxK+rwV6wryTa
        qPre490dxMZpHVfpO1G3WDtqLcwdc6xq7ROYKDXwbSB5oAdoVa7bddk3H6bTlIH0SdhTCD
        tgYymQNEb5P5qVoxicGZU2/6nI5KNRrdAICQeaRa3hZvel/2Z3HjK97hh7x43VJcMZ38I7
        48frSKc82TJYJxUwVGWl5k2eL2B1C8SR2aF6xVJ4DJ7QDSo0r1hFrvJ17Fn8tOTauHi3qw
        0QqjnYoaBTu+ESejDCX8D2HmSKdVHSZEQjyeVlespfT5UeDk4y+/iVaKOaYz0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7CWj2s6SdgROMAEjUATGzwAp9kEOqwvACXgDBJ+znM=;
        b=L5nXBHIPh4BUGzON5HzJq4O8516ZtVddALeS1yvqvG0ofFM+xr/uDbyjeHHZenxpOZquFs
        BucY7oTgj67Z1EAA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop redundant variable in __process_mem_region()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-9-nivedita@alum.mit.edu>
References: <20200728225722.67457-9-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713888.3192.5122154999856550965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     ef7b07d59e2f18042622cecde0c7a89b60f33a89
Gitweb:        https://git.kernel.org/tip/ef7b07d59e2f18042622cecde0c7a89b60f33a89
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:09 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop redundant variable in __process_mem_region()

region.size can be trimmed to store the portion of the region before the
overlap, instead of a separate mem_vector variable.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-9-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e978c35..8cc47fa 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -664,11 +664,8 @@ static void __process_mem_region(struct mem_vector *entry,
 
 		/* Store beginning of region if holds at least image_size. */
 		if (overlap.start >= region.start + image_size) {
-			struct mem_vector beginning;
-
-			beginning.start = region.start;
-			beginning.size = overlap.start - region.start;
-			process_gb_huge_pages(&beginning, image_size);
+			region.size = overlap.start - region.start;
+			process_gb_huge_pages(&region, image_size);
 		}
 
 		/* Return if overlap extends to or past end of region. */
