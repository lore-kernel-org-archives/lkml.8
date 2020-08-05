Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5092FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D020738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586261;
	bh=1r88PiJ4+qN8LrCQuZ269REltscufpvg7w78mKLxLaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PcbJVsWTD0keGyO9jZEa8warOObAFE/rOqvwzXvt6IlzYLyOZkdL/qjkU5ZllXiV1
	 nO3D++NqW0+kME2EJ5xaNYr9CVodhTifz5ZghC81/8YmaiyrRPl9L3KxNe8Q17T5cg
	 yAtyBDgwOzaPXEPL1Z2O06R80rvAkdcypnih4Anw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHEAK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgHEAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C9720738;
        Wed,  5 Aug 2020 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586249;
        bh=1r88PiJ4+qN8LrCQuZ269REltscufpvg7w78mKLxLaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bz8FBpurFRkt+w70lfrvemA7YRZA3N5G3D78JhV2a7AOowr8sinq7MKQAjkRGi7MZ
         wuVSE0Dv6pXyHiwuXjkpntSGbg28Z4/r0ByZ7YLIJYv7fGILONZGs1cJ8HiUSTmmGn
         EMer08NpXnc4Iv3ZrxmYOzwGhOSZmPZrICi64VM0=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 04/14] tools bitmap: add bitmap_andnot definition
Date:   Tue,  4 Aug 2020 20:10:33 -0400
Message-Id: <20200805001043.3331907-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition of bitmap_andnot() and wire tools/lib/bitmap.c into
liblockdep.

This is needed as a result of de4643a77356 ("locking/lockdep: Reuse lock
chains that have been freed").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/bitmap.h | 10 ++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 tools/lib/lockdep/Build      |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f2..ab5df035f8eda 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
+int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 
@@ -178,4 +180,12 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+                        const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 5043747ef6c5f..b6bc037623fc1 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -86,3 +86,18 @@ int __bitmap_equal(const unsigned long *bitmap1,
 
 	return 1;
 }
+
+int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+                                const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int lim = bits/BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
index 6f667355b0687..219a9e2d9e0ba 100644
--- a/tools/lib/lockdep/Build
+++ b/tools/lib/lockdep/Build
@@ -1 +1 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o
+liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o
-- 
2.25.1

