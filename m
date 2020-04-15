Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB13C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF4720775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408043AbgDOHbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:31:13 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:34948 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408029AbgDOH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:28:30 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 9A0CF261E55;
        Wed, 15 Apr 2020 15:28:21 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] Bitmap: Optimized division operation to shift operation
Date:   Wed, 15 Apr 2020 15:27:40 +0800
Message-Id: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLTE1LS0tJSkhNSUhLTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6Vgw5Azg4NAkQCCk2CAkq
        T04KCS5VSlVKTkNNQkhOTEtKQkxNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhJSkM3Bg++
X-HM-Tid: 0a717cbd216b9375kuws9a0cf261e55
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some processors, the / operate will call the compiler`s div lib,
which is low efficient. Bitmap is performance sensitive, We can
replace the / operation with shift.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/bitmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb..85ff982 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -337,7 +337,7 @@ static inline int bitmap_equal(const unsigned long *src1,
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		return !memcmp(src1, src2, nbits / 8);
+		return !memcmp(src1, src2, nbits >> 3);
 	return __bitmap_equal(src1, src2, nbits);
 }
 
@@ -411,7 +411,7 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0xff, nbits / 8);
+		memset((char *)map + (start >> 3), 0xff, nbits >> 3);
 	else
 		__bitmap_set(map, start, nbits);
 }
@@ -425,7 +425,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0, nbits / 8);
+		memset((char *)map + (start >> 3), 0, nbits >> 3);
 	else
 		__bitmap_clear(map, start, nbits);
 }
-- 
2.7.4

