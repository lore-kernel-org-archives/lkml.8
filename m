Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9989C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73320786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgC3Fyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:54:37 -0400
Received: from mx.sdf.org ([205.166.94.20]:58149 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgC3Fyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:54:37 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02U5sX5m028519
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 05:54:34 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02U5sXJP028790;
        Mon, 30 Mar 2020 05:54:33 GMT
Date:   Mon, 30 Mar 2020 05:54:33 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, lkml@sdf.org
Subject: [PATCH] random: reduce temporary buffers
Message-ID: <20200330055433.GA9333@SDF.ORG>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
 <20200329174122.GD4675@SDF.ORG>
 <20200329214214.GB768293@mit.edu>
 <20200330024511.GB4206@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
        filename="0001-random-reduce-temporary-buffers.patch"
In-Reply-To: <20200330024511.GB4206@SDF.ORG>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extract_buf() allocates a temporary buffer, copies a prefix to
a caller-provided temporary buffer, then wipes it.

By just having the caller allocate the full size, extract_buf()
can work in-place, saving stack space, copying, and wiping.

The FIPS initialization in extract_entropy() required some
rejiggering, since that would have allocated a second (enlarged)
buffer on the stack in addition to the one in _extract_entropy().

I had hoped there would be a code size reduction, but it's +80
bytes.  :-(  I guess the extra indirections in extract_buf()
more than make up for the rest.

   text	   data	    bss	    dec	    hex	filename
  17783	   1405	    864	  20052	   4e54	drivers/char/random.o.old
  17863	   1405	    864	  20132	   4ea4	drivers/char/random.o.new

Signed-off-by: George Spelvin <lkml@sdf.org>
---
I started working on the idea in my previous e-mail, and spotted this
cleanup.  Only compile-tested so far; I don't want to stop to reboot.

 drivers/char/random.c | 105 +++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 02e80000310c..38bb80a9efa2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -357,11 +357,26 @@
 #define OUTPUT_POOL_SHIFT	10
 #define OUTPUT_POOL_WORDS	(1 << (OUTPUT_POOL_SHIFT-5))
 #define SEC_XFER_SIZE		512
-#define EXTRACT_SIZE		10
+#define SHA_DIGEST_BYTES	(SHA_DIGEST_WORDS * 4)
+#define EXTRACT_SIZE		(SHA_DIGEST_BYTES / 2)
 
 
 #define LONGS(x) (((x) + sizeof(unsigned long) - 1)/sizeof(unsigned long))
 
+/*
+ * This buffer is used by the extract_buf function, and includes
+ * additional working space it needs.  By having the caller
+ * allocate it, we save stack space, copying, and wiping overhead.
+ */
+union extract_buf {
+	__u8 b[EXTRACT_SIZE];
+	struct {
+		__u32 w[SHA_DIGEST_WORDS];
+		__u32 workspace[SHA_WORKSPACE_WORDS];
+	};
+	unsigned long l[LONGS(SHA_DIGEST_BYTES)];
+};
+
 /*
  * To allow fractional bits to be tracked, the entropy_count field is
  * denominated in units of 1/16 bits.
@@ -1548,34 +1563,29 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
  * This function does the actual extraction for extract_entropy and
  * extract_entropy_user.
  *
- * Note: we assume that .poolwords is a multiple of 16 words.
+ * Note: we assume that .poolbytes is a multiple of SHA_MESSAGE_BYTES = 64.
  */
-static void extract_buf(struct entropy_store *r, __u8 *out)
+static void extract_buf(struct entropy_store *r, union extract_buf *out)
 {
 	int i;
-	union {
-		__u32 w[5];
-		unsigned long l[LONGS(20)];
-	} hash;
-	__u32 workspace[SHA_WORKSPACE_WORDS];
 	unsigned long flags;
 
 	/*
 	 * If we have an architectural hardware random number
 	 * generator, use it for SHA's initial vector
 	 */
-	sha_init(hash.w);
-	for (i = 0; i < LONGS(20); i++) {
+	sha_init(out->w);
+	for (i = 0; i < ARRAY_SIZE(out->l); i++) {
 		unsigned long v;
 		if (!arch_get_random_long(&v))
 			break;
-		hash.l[i] = v;
+		out->l[i] = v;
 	}
 
-	/* Generate a hash across the pool, 16 words (512 bits) at a time */
+	/* Generate a hash across the pool, 64 bytes (512 bits) at a time */
 	spin_lock_irqsave(&r->lock, flags);
-	for (i = 0; i < r->poolinfo->poolwords; i += 16)
-		sha_transform(hash.w, (__u8 *)(r->pool + i), workspace);
+	for (i = 0; i < r->poolinfo->poolbytes; i += SHA_MESSAGE_BYTES)
+		sha_transform(out->w, (__u8 *)r->pool + i, out->workspace);
 
 	/*
 	 * We mix the hash back into the pool to prevent backtracking
@@ -1586,50 +1596,50 @@ static void extract_buf(struct entropy_store *r, __u8 *out)
 	 * brute-forcing the feedback as hard as brute-forcing the
 	 * hash.
 	 */
-	__mix_pool_bytes(r, hash.w, sizeof(hash.w));
+	__mix_pool_bytes(r, out->w, sizeof(out->w));
 	spin_unlock_irqrestore(&r->lock, flags);
 
-	memzero_explicit(workspace, sizeof(workspace));
-
 	/*
 	 * In case the hash function has some recognizable output
 	 * pattern, we fold it in half. Thus, we always feed back
 	 * twice as much data as we output.
 	 */
-	hash.w[0] ^= hash.w[3];
-	hash.w[1] ^= hash.w[4];
-	hash.w[2] ^= rol32(hash.w[2], 16);
-
-	memcpy(out, &hash, EXTRACT_SIZE);
-	memzero_explicit(&hash, sizeof(hash));
+	out->w[0] ^= out->w[3];
+	out->w[1] ^= out->w[4];
+	out->w[2] ^= rol32(out->w[2], 16);
 }
 
 static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
 				size_t nbytes, int fips)
 {
-	ssize_t ret = 0, i;
-	__u8 tmp[EXTRACT_SIZE];
-	unsigned long flags;
+	ssize_t ret = 0;
+	union extract_buf tmp;
 
 	while (nbytes) {
-		extract_buf(r, tmp);
+		ssize_t i;
+
+		extract_buf(r, &tmp);
 
 		if (fips) {
+			unsigned long flags;
+
 			spin_lock_irqsave(&r->lock, flags);
-			if (!memcmp(tmp, r->last_data, EXTRACT_SIZE))
+			if (unlikely(!r->last_data_init))
+				r->last_data_init = 1;
+			else if (!memcmp(tmp.b, r->last_data, EXTRACT_SIZE))
 				panic("Hardware RNG duplicated output!\n");
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
+			memcpy(r->last_data, tmp.b, EXTRACT_SIZE);
 			spin_unlock_irqrestore(&r->lock, flags);
 		}
 		i = min_t(int, nbytes, EXTRACT_SIZE);
-		memcpy(buf, tmp, i);
+		memcpy(buf, tmp.b, i);
 		nbytes -= i;
 		buf += i;
 		ret += i;
 	}
 
 	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
+	memzero_explicit(&tmp, sizeof(tmp));
 
 	return ret;
 }
@@ -1646,24 +1656,13 @@ static ssize_t _extract_entropy(struct entropy_store *r, void *buf,
 static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 				 size_t nbytes, int min, int reserved)
 {
-	__u8 tmp[EXTRACT_SIZE];
-	unsigned long flags;
-
-	/* if last_data isn't primed, we need EXTRACT_SIZE extra bytes */
-	if (fips_enabled) {
-		spin_lock_irqsave(&r->lock, flags);
-		if (!r->last_data_init) {
-			r->last_data_init = 1;
-			spin_unlock_irqrestore(&r->lock, flags);
-			trace_extract_entropy(r->name, EXTRACT_SIZE,
-					      ENTROPY_BITS(r), _RET_IP_);
-			xfer_secondary_pool(r, EXTRACT_SIZE);
-			extract_buf(r, tmp);
-			spin_lock_irqsave(&r->lock, flags);
-			memcpy(r->last_data, tmp, EXTRACT_SIZE);
-		}
-		spin_unlock_irqrestore(&r->lock, flags);
-	}
+	/*
+	 * If last_data isn't primed, prime it.  We don't lock for the
+	 * check, so there's a tiny chance two CPUs race and do this
+	 * redundantly, but that's harmless.
+	 */
+	if (fips_enabled && unlikely(!r->last_data_init))
+		_extract_entropy(r, buf, 1, fips_enabled);
 
 	trace_extract_entropy(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
 	xfer_secondary_pool(r, nbytes);
@@ -1680,7 +1679,7 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
 				    size_t nbytes)
 {
 	ssize_t ret = 0, i;
-	__u8 tmp[EXTRACT_SIZE];
+	union extract_buf tmp;
 	int large_request = (nbytes > 256);
 
 	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
@@ -1702,9 +1701,9 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
 			schedule();
 		}
 
-		extract_buf(r, tmp);
+		extract_buf(r, &tmp);
 		i = min_t(int, nbytes, EXTRACT_SIZE);
-		if (copy_to_user(buf, tmp, i)) {
+		if (copy_to_user(buf, tmp.b, i)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -1715,7 +1714,7 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
 	}
 
 	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
+	memzero_explicit(&tmp, sizeof(tmp));
 
 	return ret;
 }
-- 
2.26.0

