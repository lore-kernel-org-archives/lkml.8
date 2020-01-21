Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3119CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0555020661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAUIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:34:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47809 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgAUIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ToHWnsP_1579595638;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWnsP_1579595638)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:33:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bitmap: remove expect_eq_u32_array
Date:   Tue, 21 Jan 2020 16:33:45 +0800
Message-Id: <1579595625-250942-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

expect_eq_u32_array isn't used from commit 3aa56885e516 ("bitmap:
replace bitmap_{from,to}_u32array").
And EXP2_IN_BITS are never used. so better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Yury Norov <yury.norov@gmail.com> 
Cc: William Breathitt Gray <vilhelm.gray@gmail.com> 
Cc: "Tobin C. Harding" <tobin@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/test_bitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index e14a15ac250b..0d344ae494a9 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -170,7 +170,6 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
-#define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
@@ -270,8 +269,6 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
-#define EXP2_IN_BITS	(sizeof(exp2) * 8)
-
 static void __init test_replace(void)
 {
 	unsigned int nbits = 64;
-- 
1.8.3.1

