Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E78F20663
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGZLWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:22:07 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59748C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 04:22:07 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E74BC6F633;
        Sun, 26 Jul 2020 11:22:00 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        changbin.du@intel.com, masahiroy@kernel.org, rdunlap@infradead.org,
        krzk@kernel.org, andriy.shevchenko@linux.intel.com,
        ben.dooks@codethink.co.uk, colyli@suse.de, axboe@kernel.dk,
        tpiepho@gmail.com, chenqiwu@xiaomi.com, walken@google.com,
        gustavo@embeddedor.com, lasse.collin@tukaani.org,
        danielwa@cisco.com, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] lib: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 13:21:54 +0200
Message-Id: <20200726112154.16510-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 lib/Kconfig.debug        | 2 +-
 lib/crc64.c              | 2 +-
 lib/decompress_bunzip2.c | 2 +-
 lib/decompress_unlzma.c  | 6 +++---
 lib/math/rational.c      | 2 +-
 lib/rbtree.c             | 2 +-
 lib/ts_bm.c              | 2 +-
 lib/xxhash.c             | 2 +-
 lib/xz/xz_crc32.c        | 2 +-
 lib/xz/xz_dec_bcj.c      | 2 +-
 lib/xz/xz_dec_lzma2.c    | 2 +-
 lib/xz/xz_lzma2.h        | 2 +-
 lib/xz/xz_stream.h       | 2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..4d891008a9c6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2164,7 +2164,7 @@ config LIST_KUNIT_TEST
 	  and associated macros.
 
 	  KUnit tests run during boot and output the results to the debug log
-	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
 	  running the KUnit test harness, and not intended for inclusion into a
 	  production build.
 
diff --git a/lib/crc64.c b/lib/crc64.c
index f8928ce28280..47cfa054827f 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -4,7 +4,7 @@
  *
  * This is a basic crc64 implementation following ECMA-182 specification,
  * which can be found from,
- * http://www.ecma-international.org/publications/standards/Ecma-182.htm
+ * https://www.ecma-international.org/publications/standards/Ecma-182.htm
  *
  * Dr. Ross N. Williams has a great document to introduce the idea of CRC
  * algorithm, here the CRC64 code is also inspired by the table-driven
diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 7c4932eed748..f9628f3924ce 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -34,7 +34,7 @@
 		Phone (337) 232-1234 or 1-800-738-2226
 		Fax   (337) 232-1297
 
-		http://www.hospiceacadiana.com/
+		https://www.hospiceacadiana.com/
 
 	Manuel
  */
diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index ed7a1fd819f2..1cf409ef8d04 100644
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -8,7 +8,7 @@
  *implementation for lzma.
  *Copyright (C) 2006  Aurelien Jacobs < aurel@gnuage.org >
  *
- *Based on LzmaDecode.c from the LZMA SDK 4.22 (http://www.7-zip.org/)
+ *Based on LzmaDecode.c from the LZMA SDK 4.22 (https://www.7-zip.org/)
  *Copyright (C) 1999-2005  Igor Pavlov
  *
  *Copyrights of the parts, see headers below.
@@ -56,7 +56,7 @@ static long long INIT read_int(unsigned char *ptr, int size)
 /* Small range coder implementation for lzma.
  *Copyright (C) 2006  Aurelien Jacobs < aurel@gnuage.org >
  *
- *Based on LzmaDecode.c from the LZMA SDK 4.22 (http://www.7-zip.org/)
+ *Based on LzmaDecode.c from the LZMA SDK 4.22 (https://www.7-zip.org/)
  *Copyright (c) 1999-2005  Igor Pavlov
  */
 
@@ -213,7 +213,7 @@ rc_bit_tree_decode(struct rc *rc, uint16_t *p, int num_levels, int *symbol)
  * Small lzma deflate implementation.
  * Copyright (C) 2006  Aurelien Jacobs < aurel@gnuage.org >
  *
- * Based on LzmaDecode.c from the LZMA SDK 4.22 (http://www.7-zip.org/)
+ * Based on LzmaDecode.c from the LZMA SDK 4.22 (https://www.7-zip.org/)
  * Copyright (C) 1999-2005  Igor Pavlov
  */
 
diff --git a/lib/math/rational.c b/lib/math/rational.c
index 31fb27db2deb..df75c8809693 100644
--- a/lib/math/rational.c
+++ b/lib/math/rational.c
@@ -27,7 +27,7 @@
  * with the fractional part size described in given_denominator.
  *
  * for theoretical background, see:
- * http://en.wikipedia.org/wiki/Continued_fraction
+ * https://en.wikipedia.org/wiki/Continued_fraction
  */
 
 void rational_best_approximation(
diff --git a/lib/rbtree.c b/lib/rbtree.c
index 8545872e61db..c4ac5c2421f2 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -13,7 +13,7 @@
 #include <linux/export.h>
 
 /*
- * red-black trees properties:  http://en.wikipedia.org/wiki/Rbtree
+ * red-black trees properties:  https://en.wikipedia.org/wiki/Rbtree
  *
  *  1) A node is either red or black
  *  2) The root is black
diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 277cb4417ac2..4cf250031f0f 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -11,7 +11,7 @@
  *   [1] A Fast String Searching Algorithm, R.S. Boyer and Moore.
  *       Communications of the Association for Computing Machinery, 
  *       20(10), 1977, pp. 762-772.
- *       http://www.cs.utexas.edu/users/moore/publications/fstrpos.pdf
+ *       https://www.cs.utexas.edu/users/moore/publications/fstrpos.pdf
  *
  *   [2] Handbook of Exact String Matching Algorithms, Thierry Lecroq, 2004
  *       http://www-igm.univ-mlv.fr/~lecroq/string/string.pdf
diff --git a/lib/xxhash.c b/lib/xxhash.c
index aa61e2a3802f..d5bb9ff10607 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -34,7 +34,7 @@
  * ("BSD").
  *
  * You can contact the author at:
- * - xxHash homepage: http://cyan4973.github.io/xxHash/
+ * - xxHash homepage: https://cyan4973.github.io/xxHash/
  * - xxHash source repository: https://github.com/Cyan4973/xxHash
  */
 
diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 912aae5fa09e..88a2c35e1b59 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -2,7 +2,7 @@
  * CRC32 using the polynomial from IEEE-802.3
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
- *          Igor Pavlov <http://7-zip.org/>
+ *          Igor Pavlov <https://7-zip.org/>
  *
  * This file has been put into the public domain.
  * You can do whatever you want with this file.
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index a768e6d28bbb..72ddac6ef2ec 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -2,7 +2,7 @@
  * Branch/Call/Jump (BCJ) filter decoders
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
- *          Igor Pavlov <http://7-zip.org/>
+ *          Igor Pavlov <https://7-zip.org/>
  *
  * This file has been put into the public domain.
  * You can do whatever you want with this file.
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 156f26fdc4c9..9f336bc07ed6 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -2,7 +2,7 @@
  * LZMA2 decoder
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
- *          Igor Pavlov <http://7-zip.org/>
+ *          Igor Pavlov <https://7-zip.org/>
  *
  * This file has been put into the public domain.
  * You can do whatever you want with this file.
diff --git a/lib/xz/xz_lzma2.h b/lib/xz/xz_lzma2.h
index 071d67bee9f5..92d852d4f87a 100644
--- a/lib/xz/xz_lzma2.h
+++ b/lib/xz/xz_lzma2.h
@@ -2,7 +2,7 @@
  * LZMA2 definitions
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
- *          Igor Pavlov <http://7-zip.org/>
+ *          Igor Pavlov <https://7-zip.org/>
  *
  * This file has been put into the public domain.
  * You can do whatever you want with this file.
diff --git a/lib/xz/xz_stream.h b/lib/xz/xz_stream.h
index 66cb5a7055ec..430bb3a0d195 100644
--- a/lib/xz/xz_stream.h
+++ b/lib/xz/xz_stream.h
@@ -19,7 +19,7 @@
 
 /*
  * See the .xz file format specification at
- * http://tukaani.org/xz/xz-file-format.txt
+ * https://tukaani.org/xz/xz-file-format.txt
  * to understand the container format.
  */
 
-- 
2.27.0

