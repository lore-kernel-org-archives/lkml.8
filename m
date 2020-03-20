Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D5206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC1Qnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:46 -0400
Received: from mx.sdf.org ([205.166.94.20]:50046 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgC1Qn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:29 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhQWq022097
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:27 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhQQ5025294;
        Sat, 28 Mar 2020 16:43:26 GMT
Message-Id: <202003281643.02SGhQQ5025294@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 20 Mar 2020 19:38:09 -0400
Subject: [RFC PATCH v1 50/50] random: add get_random_nonce()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like get_random_bytes(), but uses the same batched entropy
buffer as get_random_u32().

Many kernel users of get_random_bytes could be switched to this.
E.g. eth_random_addr().

But before doing that, we should decide if it wouldn't be better
to rename this function to get_random_bytes, and let the smaller
number of sites which really need strongly secure random numbers
use a different name like "get_secret_bytes()".

Code size +731 bytes (x86-64)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/random.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 67bdfb51eb25c..02e80000310ce 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -342,6 +342,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/random.h>
@@ -2569,6 +2570,82 @@ u32 get_random_u32(void)
 }
 EXPORT_SYMBOL(get_random_u32);
 
+/**
+ * get_random_nonce - Generate a random string of bytes
+ * @buf:	The buffer to fill
+ * @nbytes:	The size of the buffer
+ *
+ * This generates cryptographically strong bytes, at less cost than
+ * get_random_bytes.  In particular, anti-backtracking is not
+ * provided.  It is suitable for public values (random cookies or
+ * MAC addresses which are supposed to be unguessable), and for
+ * secret values which are stored in the kernel as long as they
+ * are valuable, such as SipHash keys or stack canaries.
+ *
+ * In general, if the calling code does not use memzero_explicit(), it
+ * is safe to use this function rather than get_random_bytes.
+ *
+ * TODO: Perhaps get_random_bytes should be renamed to get_secret_bytes
+ * and this function should be renamed to get_random_bytes?
+ */
+void get_random_nonce(void *buf, size_t nbytes)
+{
+	unsigned long ret;
+	size_t pos;
+	unsigned long flags;
+	struct batched_entropy *batch;
+	static void *previous;
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	while (nbytes >= sizeof(ret)) {
+		if (!arch_get_random_long(buf))
+			goto software;
+		buf += sizeof(ret);
+		nbytes -= sizeof(ret);
+	}
+	if (nbytes) {
+		if (!arch_get_random_long(&ret))
+			goto software;
+		memcpy(buf, &ret, nbytes);
+	}
+	return;
+software:
+#else
+	while (arch_get_random_long(&ret)) {
+		if (nbytes > sizeof(ret)) {
+			put_unaligned(ret, (unsigned long *)buf);
+			buf += sizeof(ret);
+			nbytes -= sizeof(ret);
+		} else {
+			memcpy(buf, &ret, nbytes);
+			return;
+		}
+	}
+#endif
+
+	warn_unseeded_randomness(&previous);
+
+	local_irq_save(flags);
+	batch = this_cpu_ptr(&batched_entropy);
+	pos = batch->position + 1;
+	if (unlikely(crng_init != batch->crng_init)) {
+		batch->crng_init = crng_init;
+		pos = CHACHA_BLOCK_SIZE;
+	}
+
+	while (nbytes > CHACHA_BLOCK_SIZE - pos) {
+		memcpy(buf, batch->entropy8 + pos, CHACHA_BLOCK_SIZE - pos);
+		buf += CHACHA_BLOCK_SIZE - pos;
+		nbytes -= CHACHA_BLOCK_SIZE - pos;
+		extract_crng(batch->entropy32);
+		pos = 0;
+	}
+	batch->position = pos + nbytes - 1;
+	memcpy(buf, batch->entropy8 + pos, nbytes);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(get_random_nonce);
+
 /**
  * __get_random_max32 - Generate a uniform random number 0 <= x < range < 2^32
  * @range:	Modulus for random number; must not be zero!
diff --git a/include/linux/random.h b/include/linux/random.h
index 97d3469f3aad8..de9eae20b69af 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -50,6 +50,7 @@ extern const struct file_operations random_fops, urandom_fops;
 
 u32 get_random_u32(void);
 u64 get_random_u64(void);
+void get_random_nonce(void *buf, size_t nbytes);
 static inline unsigned int get_random_int(void)
 {
 	return get_random_u32();
-- 
2.26.0

