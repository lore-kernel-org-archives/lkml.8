Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4710621744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8vSvWNl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JOeaMKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHFXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHFXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6618C061757;
        Thu,  6 Aug 2020 16:38:55 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2R5Q1dWK/hb6Z0v4CJ605VU5izTAXbniCYChQw+63X0=;
        b=i8vSvWNlefsfg9kU1FRZvBJ4RH714a6ZJ00wBQhTL6YJtDa8opVKG/xNhhKNaroBytjh87
        WpPYLvXRTknvu6egkHLBfBRlJfyB18QvviAaNjhRDFhG+pPGmoPv7GC0kNDu8qxAeGFY3F
        iUg00fccKZ7oP6OD+NO4NA3eDKyI5iJoW5oB27LIvN1ix4m4yYMbwHCd9Snk84mgHX/Zq/
        5pBqjl7EreyV5rFyO/RToP0TU+cyDTi/+Qk692o0ShLMAqhk3J/yXEJvsKwJMMeYOlzW7p
        cCPM6GJH0KiXqIEtG2NSZDQWsg8T77xzyYCR9H33QZ2VgGN8b7EDAaW65cdlzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2R5Q1dWK/hb6Z0v4CJ605VU5izTAXbniCYChQw+63X0=;
        b=1JOeaMKI9h3i0WRZyRr4pnDhQakAaDo4QmP23kGRSIVdQIrbADUHsTU7k6s3Ch0SxmnemI
        qKMEtyGc8ZOCTFAQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Drop unnecessary alignment in
 find_random_virt_addr()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-17-nivedita@alum.mit.edu>
References: <20200728225722.67457-17-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713376.3192.5137291775003011083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     eb38be6db516fb72ccf7282628b545a185b3bc7a
Gitweb:        https://git.kernel.org/tip/eb38be6db516fb72ccf7282628b545a185b3bc7a
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Drop unnecessary alignment in find_random_virt_addr()

Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
find_random_virt_addr, it cannot change the result: the largest valid
slot is the largest n that satisfies

  minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE

(since minimum is already aligned) and so n is equal to

  (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN

even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-17-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0c64026..ce34a05 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -825,16 +825,12 @@ static unsigned long find_random_virt_addr(unsigned long minimum,
 {
 	unsigned long slots, random_addr;
 
-	/* Align image_size for easy slot calculations. */
-	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
-
 	/*
 	 * There are how many CONFIG_PHYSICAL_ALIGN-sized slots
 	 * that can hold image_size within the range of minimum to
 	 * KERNEL_IMAGE_SIZE?
 	 */
-	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
-		 CONFIG_PHYSICAL_ALIGN + 1;
+	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;
 
 	random_addr = kaslr_get_random_long("Virtual") % slots;
 
