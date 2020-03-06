Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5862F206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsNGbxp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:14:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38908 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFWOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:14:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so3824887ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9A8bb6Dd4q1KloLSMciak2cHd7VLsJhpyC5tpVoZ/I=;
        b=DsNGbxp3EvIRQ1+Cjbx86npj3Tmdldis3gBYdtgBzEthjzfwXJ8cXLU4vnaCPeUUJN
         amzAcFKVSnzPE6U5TrEDnZ9EQv56URYXoRHqwPOcqtB/GhdAFWQhNsrnHbnM4NRaORHs
         nK4RU1o5Rn9HJGjekObGoF4MwRGe5LJ2+fRonC+J4kATT3CvGXO8NaLssYZGWfBAExIl
         P1Gm3eR8utAnnxpSJiGOtLct3fxb0LxuMAL3XKaot4rEFOhg737r394IFhtJzRevnafs
         vUWHE0sPeAd1IHj7n00pW/Gnb2jGf0DCq+pVNcHgdl+1Km+NBmukuOiHWvKpcVUbxmjo
         f79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9A8bb6Dd4q1KloLSMciak2cHd7VLsJhpyC5tpVoZ/I=;
        b=Vo7i1UAH2VkKJH9C7Jgz3PBiUsZAisS7wvVZ+MTu762dgUtMhcO6I3nAhLO+n96Jta
         7kvGVESACzEccDylZR4x36a5s3YJ6RLvQ4JSjMfWoW+9JY82s/FqIbyh0+OHgV8BFm2u
         q97dARLvntgow7jFtF0wTaZCeltSX9oQ8G7gg752uRcRBTw98NYui1rJ6Vqj2jnq7xlH
         1DnVSrXPvtr4dChyxWb3Zf/xwErOa9/+yPS2CJXhQs57Fw/EvvkfIauwrcW8w7wMbXxR
         fj8hJPTKY7+hMexq5K9z0ejnKSh6gHAht0UI1VgJ7Y0vaiENOxgRYEABR8kP/iZY9Ymb
         nYkA==
X-Gm-Message-State: ANhLgQ3tB7ydA5MzXo89ykr9xJK8jAFGNC59REQPVdORFwFmDYMAwdQG
        +e/C5Iz3TcvVmLt0FI3BnRlQM9K8
X-Google-Smtp-Source: ADFU+vsWl0txMP8AUe8Lh7uDKkjFqEhXxbY5LeC91lXfUKM/0exSdlnse/Kd2mwnamA+BqG4lGA+7A==
X-Received: by 2002:a2e:b246:: with SMTP id n6mr3295601ljm.70.1583532891947;
        Fri, 06 Mar 2020 14:14:51 -0800 (PST)
Received: from localhost.localdomain ([46.159.134.13])
        by smtp.gmail.com with ESMTPSA id s17sm14333158lfs.6.2020.03.06.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 14:14:51 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bitmap: rework bitmap_cut()
Date:   Fri,  6 Mar 2020 14:14:23 -0800
Message-Id: <20200306221423.18631-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_cut() refers src after memmove(). If dst and src overlap,
it may cause buggy behaviour because src may become inconsistent.

The function complexity is of O(nbits * cut_bits), which can be
improved to O(nbits).

We can also rely on bitmap_shift_right() to do most of the work.

I don't like interface of bitmap_cut(). The idea of copying of a
whole bitmap inside the function from src to dst doesn't look
useful in practice. The function is introduced a few weeks ago and
was most probably inspired by bitmap_shift_*. Looking at the code,
it's easy to see that bitmap_shift_* is usually passed with
dst == src. bitmap_cut() has a single user so far, and it also
calls it with dst == src.

This patch removes dst so the whole work is made in-place. It also
switches the function to bitmap_shift_right() internally in sake of
performance and simplicity.

I've added a very basic test too.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h         |  7 ++---
 lib/bitmap.c                   | 51 +++++++++-------------------------
 lib/test_bitmap.c              | 32 +++++++++++++++++++++
 net/netfilter/nft_set_pipapo.c |  3 +-
 4 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb81042..ed60b7272437 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -59,7 +59,7 @@
  *  						Iterate over all set regions
  *  bitmap_shift_right(dst, src, n, nbits)      *dst = *src >> n
  *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
- *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
+ *  bitmap_cut(bmap, first, n, nbits)           Cut n bits from first, copy rest
  *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
@@ -140,9 +140,8 @@ extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits);
 extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits);
-extern void bitmap_cut(unsigned long *dst, const unsigned long *src,
-		       unsigned int first, unsigned int cut,
-		       unsigned int nbits);
+extern void bitmap_cut(unsigned long *bmap, unsigned int first,
+			unsigned int cut, unsigned int nbits);
 extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa342d6..06e06e0c3096 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -170,67 +170,42 @@ EXPORT_SYMBOL(__bitmap_shift_left);
 
 /**
  * bitmap_cut() - remove bit region from bitmap and right shift remaining bits
- * @dst: destination bitmap, might overlap with src
- * @src: source bitmap
+ * @bmap:  bitmap to cut
  * @first: start bit of region to be removed
  * @cut: number of bits to remove
  * @nbits: bitmap size, in bits
  *
- * Set the n-th bit of @dst iff the n-th bit of @src is set and
- * n is less than @first, or the m-th bit of @src is set for any
- * m such that @first <= n < nbits, and m = n + @cut.
- *
  * In pictures, example for a big-endian 32-bit architecture:
  *
- * @src:
+ * @bmap:
  * 31                                   63
  * |                                    |
  * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
  *                 |  |              |                                    |
  *                16  14             0                                   32
  *
- * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is:
+ * if @cut is 3, and @first is 14, bits 14-16 in @bmap are cut and @dst is:
  *
  * 31                                   63
  * |                                    |
  * 10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
  *                    |              |                                    |
  *                    14 (bit 17     0                                   32
- *                        from @src)
- *
- * Note that @dst and @src might overlap partially or entirely.
- *
- * This is implemented in the obvious way, with a shift and carry
- * step for each moved bit. Optimisation is left as an exercise
- * for the compiler.
+ *                        from @bmap)
  */
-void bitmap_cut(unsigned long *dst, const unsigned long *src,
-		unsigned int first, unsigned int cut, unsigned int nbits)
+void bitmap_cut(unsigned long *bmap, unsigned int first,
+		unsigned int cut, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits);
-	unsigned long keep = 0, carry;
-	int i;
-
-	memmove(dst, src, len * sizeof(*dst));
-
-	if (first % BITS_PER_LONG) {
-		keep = src[first / BITS_PER_LONG] &
-		       (~0UL >> (BITS_PER_LONG - first % BITS_PER_LONG));
-	}
+	unsigned long tmp;
+	unsigned long *b = bmap + first / BITS_PER_LONG;
 
-	while (cut--) {
-		for (i = first / BITS_PER_LONG; i < len; i++) {
-			if (i < len - 1)
-				carry = dst[i + 1] & 1UL;
-			else
-				carry = 0;
+	if (first % BITS_PER_LONG)
+		tmp = b[0] & BITMAP_LAST_WORD_MASK(first);
 
-			dst[i] = (dst[i] >> 1) | (carry << (BITS_PER_LONG - 1));
-		}
-	}
+	bitmap_shift_right(b, b, cut - first, nbits - first);
 
-	dst[first / BITS_PER_LONG] &= ~0UL << (first % BITS_PER_LONG);
-	dst[first / BITS_PER_LONG] |= keep;
+	if (first % BITS_PER_LONG)
+		b[0] = tmp | (b[0] & BITMAP_FIRST_WORD_MASK(first));
 }
 EXPORT_SYMBOL(bitmap_cut);
 
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..4b2fef13003d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -540,6 +540,37 @@ static void __init test_bitmap_arr32(void)
 	}
 }
 
+struct test_bitmap_cut {
+	unsigned int first;
+	unsigned int last;
+	unsigned int nbits;
+	unsigned long in;
+	unsigned long out;
+};
+
+static struct test_bitmap_cut test_cut[] = {
+	{ 0,  0,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbeefUL },
+	{ 0,  8,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbeUL },
+	{ 4,  8,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbefUL },
+	{ 8,  24, BITS_PER_LONG, 0xdeadbeefUL, 0xdeefUL },
+	{ 16, 32, BITS_PER_LONG, 0xdeadbeefUL, 0xbeefUL },
+};
+
+static void __init test_bitmap_cut(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
+		struct test_bitmap_cut *t = &test_cut[i];
+
+		bitmap_cut(&t->in, t->first, t->last, t->nbits);
+		if (!bitmap_equal(&t->in, &t->out, t->nbits)) {
+			pr_err("bitmap_cut #%d failed:\n%*pb.\nExpected:\n%*pb\n",
+					i, t->nbits, &t->in, t->nbits, &t->out);
+		}
+	}
+}
+
 static void noinline __init test_mem_optimisations(void)
 {
 	DECLARE_BITMAP(bmap1, 1024);
@@ -617,6 +648,7 @@ static void __init selftest(void)
 	test_copy();
 	test_replace();
 	test_bitmap_arr32();
+	test_bitmap_cut();
 	test_bitmap_parse();
 	test_bitmap_parse_user();
 	test_bitmap_parselist();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 26395c8188b1..68faaf9a4f66 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1397,8 +1397,7 @@ static void pipapo_drop(struct nft_pipapo_match *m,
 			pos = f->lt + g * NFT_PIPAPO_BUCKETS * f->bsize;
 
 			for (b = 0; b < NFT_PIPAPO_BUCKETS; b++) {
-				bitmap_cut(pos, pos, rulemap[i].to,
-					   rulemap[i].n,
+				bitmap_cut(pos, rulemap[i].to, rulemap[i].n,
 					   f->bsize * BITS_PER_LONG);
 
 				pos += f->bsize;
-- 
2.20.1

