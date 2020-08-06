Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987332173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSmfHO9J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GcjmlV6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHFXkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgHFXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755ECC061574;
        Thu,  6 Aug 2020 16:38:56 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQY8wlFdAMbk+rX+h7Exb26MmUdtOhMNurOWN+bIpIg=;
        b=uSmfHO9JSwFXv5DkbxOyGi01CvK+Qd8dY2rXU9xpGMSmtom/svXcoRKrMrSelbtVEGdKyW
        lhUoJn3HdVBj4jXxlRFFZSb7UWQoEwDSamggwQNux1ziUrS/ktRb/jJ7OFe2R2MiZ2Tj7L
        u1ukXOMPj8JD+dfWG+KHTEzsZyxXEwZ0jYULM6uAIth40G53FK29B3WCafhAF+kxO58maA
        rbQtlgaF+hyt5YAW0E+1CoKmFa8op7ddtRxWQ/3HOWpz5Ck6ka89N8DHU2bIy8zjofaYCN
        fPETWonadXgHMw2Wbom6hY4OcBgz3GVC9Jn/Cn9gUS3eqOftu1blJTub2Q0GYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQY8wlFdAMbk+rX+h7Exb26MmUdtOhMNurOWN+bIpIg=;
        b=GcjmlV6odMwkI2p3AEn4e7hky5ksrHxqcaXaGzUwbZNfCUwK10ce7R63qubs/eKciNfyt3
        PBTP1pUmoF1bIXBQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop redundant check in store_slot_info()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-16-nivedita@alum.mit.edu>
References: <20200728225722.67457-16-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713441.3192.1630860700272865045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     46a5b29a4a63a3ba987cbb5467774a4b5787618e
Gitweb:        https://git.kernel.org/tip/46a5b29a4a63a3ba987cbb5467774a4b5787618e
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:16 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop redundant check in store_slot_info()

Drop unnecessary check that number of slots is not zero in
store_slot_info, it's guaranteed to be at least 1 by the calculation.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-16-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 5c7457c..0c64026 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -525,13 +525,10 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 		return;
 
 	slot_area.addr = region->start;
-	slot_area.num = (region->size - image_size) /
-			CONFIG_PHYSICAL_ALIGN + 1;
+	slot_area.num = 1 + (region->size - image_size) / CONFIG_PHYSICAL_ALIGN;
 
-	if (slot_area.num > 0) {
-		slot_areas[slot_area_index++] = slot_area;
-		slot_max += slot_area.num;
-	}
+	slot_areas[slot_area_index++] = slot_area;
+	slot_max += slot_area.num;
 }
 
 /*
