Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB44C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F392206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgDIRQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:16:36 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:60563 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDIRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:16:36 -0400
Received: from localhost.localdomain ([93.22.150.119])
        by mwinf5d45 with ME
        id QhGa220032aoYT903hGajk; Thu, 09 Apr 2020 19:16:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 09 Apr 2020 19:16:35 +0200
X-ME-IP: 93.22.150.119
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lib: avoid trailing '\n' hidden in pr_fmt() in test_hash.c
Date:   Thu,  9 Apr 2020 19:16:32 +0200
Message-Id: <20200409171632.30738-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_xxx() functions usually have '\n' at the end of the logging message.
Here, this '\n' is added via the 'pr_fmt' macro.

In order to be more consistent with other files, use a more standard
convention and put these '\n' back in the messages themselves and remove it
from the pr_fmt macro.

While at it, merge some split strings.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 lib/test_hash.c | 55 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index 0ee40b4a56dd..e4bd06fdb9cb 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -14,7 +14,7 @@
  * and hash_64().
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/compiler.h>
 #include <linux/types.h>
@@ -77,7 +77,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 	hash_or[1][0] |= h2 = __hash_32_generic(h0);
 #if HAVE_ARCH__HASH_32 == 1
 	if (h1 != h2) {
-		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
+		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x\n",
 			h0, h1, h2);
 		return false;
 	}
@@ -91,20 +91,20 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 		/* Test hash_32 */
 		hash_or[0][k] |= h1 = hash_32(h0, k);
 		if (h1 > m) {
-			pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
+			pr_err("hash_32(%#x, %d) = %#x > %#x\n", h0, k, h1, m);
 			return false;
 		}
 #ifdef HAVE_ARCH_HASH_32
 		h2 = hash_32_generic(h0, k);
 #if HAVE_ARCH_HASH_32 == 1
 		if (h1 != h2) {
-			pr_err("hash_32(%#x, %d) = %#x != hash_32_generic() "
-				" = %#x", h0, k, h1, h2);
+			pr_err("hash_32(%#x, %d) = %#x != hash_32_generic() = %#x\n",
+				h0, k, h1, h2);
 			return false;
 		}
 #else
 		if (h2 > m) {
-			pr_err("hash_32_generic(%#x, %d) = %#x > %#x",
+			pr_err("hash_32_generic(%#x, %d) = %#x > %#x\n",
 				h0, k, h1, m);
 			return false;
 		}
@@ -113,20 +113,21 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 		/* Test hash_64 */
 		hash_or[1][k] |= h1 = hash_64(h64, k);
 		if (h1 > m) {
-			pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, h1, m);
+			pr_err("hash_64(%#llx, %d) = %#x > %#x\n",
+				h64, k, h1, m);
 			return false;
 		}
 #ifdef HAVE_ARCH_HASH_64
 		h2 = hash_64_generic(h64, k);
 #if HAVE_ARCH_HASH_64 == 1
 		if (h1 != h2) {
-			pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
-				"= %#x", h64, k, h1, h2);
+			pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x\n",
+				h64, k, h1, h2);
 			return false;
 		}
 #else
 		if (h2 > m) {
-			pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
+			pr_err("hash_64_generic(%#llx, %d) = %#x > %#x\n",
 				h64, k, h1, m);
 			return false;
 		}
@@ -161,15 +162,13 @@ test_hash_init(void)
 
 			/* Check that hashlen_string gets the length right */
 			if (hashlen_len(hashlen) != j-i) {
-				pr_err("hashlen_string(%d..%d) returned length"
-					" %u, expected %d",
+				pr_err("hashlen_string(%d..%d) returned length %u, expected %d\n",
 					i, j, hashlen_len(hashlen), j-i);
 				return -EINVAL;
 			}
 			/* Check that the hashes match */
 			if (hashlen_hash(hashlen) != h0) {
-				pr_err("hashlen_string(%d..%d) = %08x != "
-					"full_name_hash() = %08x",
+				pr_err("hashlen_string(%d..%d) = %08x != full_name_hash() = %08x\n",
 					i, j, hashlen_hash(hashlen), h0);
 				return -EINVAL;
 			}
@@ -184,19 +183,19 @@ test_hash_init(void)
 
 	/* The OR of all the hash values should cover all the bits */
 	if (~string_or) {
-		pr_err("OR of all string hash results = %#x != %#x",
+		pr_err("OR of all string hash results = %#x != %#x\n",
 			string_or, -1u);
 		return -EINVAL;
 	}
 	if (~hash_or[0][0]) {
-		pr_err("OR of all __hash_32 results = %#x != %#x",
+		pr_err("OR of all __hash_32 results = %#x != %#x\n",
 			hash_or[0][0], -1u);
 		return -EINVAL;
 	}
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1	/* Test is pointless if results match */
 	if (~hash_or[1][0]) {
-		pr_err("OR of all __hash_32_generic results = %#x != %#x",
+		pr_err("OR of all __hash_32_generic results = %#x != %#x\n",
 			hash_or[1][0], -1u);
 		return -EINVAL;
 	}
@@ -208,13 +207,13 @@ test_hash_init(void)
 		u32 const m = ((u32)2 << (i-1)) - 1;	/* Low i bits set */
 
 		if (hash_or[0][i] != m) {
-			pr_err("OR of all hash_32(%d) results = %#x "
-				"(%#x expected)", i, hash_or[0][i], m);
+			pr_err("OR of all hash_32(%d) results = %#x (%#x expected)\n",
+				i, hash_or[0][i], m);
 			return -EINVAL;
 		}
 		if (hash_or[1][i] != m) {
-			pr_err("OR of all hash_64(%d) results = %#x "
-				"(%#x expected)", i, hash_or[1][i], m);
+			pr_err("OR of all hash_64(%d) results = %#x (%#x expected)\n",
+				i, hash_or[1][i], m);
 			return -EINVAL;
 		}
 	}
@@ -222,27 +221,27 @@ test_hash_init(void)
 	/* Issue notices about skipped tests. */
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1
-	pr_info("__hash_32() is arch-specific; not compared to generic.");
+	pr_info("__hash_32() is arch-specific; not compared to generic.\n");
 #endif
 #else
-	pr_info("__hash_32() has no arch implementation to test.");
+	pr_info("__hash_32() has no arch implementation to test.\n");
 #endif
 #ifdef HAVE_ARCH_HASH_32
 #if HAVE_ARCH_HASH_32 != 1
-	pr_info("hash_32() is arch-specific; not compared to generic.");
+	pr_info("hash_32() is arch-specific; not compared to generic.\n");
 #endif
 #else
-	pr_info("hash_32() has no arch implementation to test.");
+	pr_info("hash_32() has no arch implementation to test.\n");
 #endif
 #ifdef HAVE_ARCH_HASH_64
 #if HAVE_ARCH_HASH_64 != 1
-	pr_info("hash_64() is arch-specific; not compared to generic.");
+	pr_info("hash_64() is arch-specific; not compared to generic.\n");
 #endif
 #else
-	pr_info("hash_64() has no arch implementation to test.");
+	pr_info("hash_64() has no arch implementation to test.\n");
 #endif
 
-	pr_notice("%u tests passed.", tests);
+	pr_notice("%u tests passed.\n", tests);
 
 	return 0;
 }
-- 
2.20.1

