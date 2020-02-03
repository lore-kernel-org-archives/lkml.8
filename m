Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7462051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747930;
	bh=CVclESlCh4sxDfLxveJPDtGVWFzcdGQ7O6FFLEyx1Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJTcHB0XP5v96e7V49NymeOLmEgLy1mMf4vUFxPAjdSop2cWrYYBIWT7VKiYDktHR
	 3saI0QTVuq32yfATDkFq7iIldo/4ta3leHiSBDyS6bT3Yy2Cu1b3m8gNtViYuh8U7F
	 fc4IiS3C2vWWPXmjsuiyEhE53qdcfRNIZ2rIW7/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgBCQit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731463AbgBCQiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:38:14 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE862051A;
        Mon,  3 Feb 2020 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747894;
        bh=CVclESlCh4sxDfLxveJPDtGVWFzcdGQ7O6FFLEyx1Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuXiHaJJEmw6seoyKxNKiDWgxkojMynLTf6dUkej+wwQa+9/ofePYmyt5VzNIbZtd
         IfPxMpGV2jq9kPtt90AsntImKMQya7pRzojtNbGhwUr7yjlzHblZ57iqCP68adqA3s
         RqmiVHbsfp1mtN1Cp545PIrVBxrR3RALZ4kUGqog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.5 08/23] lib/test_bitmap: correct test data offsets for 32-bit
Date:   Mon,  3 Feb 2020 16:20:28 +0000
Message-Id: <20200203161904.366836024@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.288335885@linuxfoundation.org>
References: <20200203161902.288335885@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 69334ca530da80c1563ac6a3bd32afa40884ccd3 upstream.

On 32-bit platform the size of long is only 32 bits which makes wrong
offset in the array of 64 bit size.

Calculate offset based on BITS_PER_LONG.

Link: http://lkml.kernel.org/r/20200109103601.45929-1-andriy.shevchenko@linux.intel.com
Fixes: 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_bitmap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -275,22 +275,23 @@ static void __init test_copy(void)
 static void __init test_replace(void)
 {
 	unsigned int nbits = 64;
+	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
 	DECLARE_BITMAP(bmap, 1024);
 
 	bitmap_zero(bmap, 1024);
-	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_0_1, nbits);
 
 	bitmap_zero(bmap, 1024);
-	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 
 	bitmap_fill(bmap, 1024);
-	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_0_1, nbits);
 
 	bitmap_fill(bmap, 1024);
-	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
+	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 }
 


