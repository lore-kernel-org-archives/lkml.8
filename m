Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583EB20692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607434;
	bh=JYLApusJ2vZ0Fk5B+rq4ZitGLZMDKMrcIp+WZ7wLTKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GXIhnQdV8uRiue0F7aBlbOmxjmOli2LG3J9v90F96wiDda9ScSOXuI1VBR95DPaQC
	 bwr6W23jxcKLk4NcrxPAQWWhkOHEh71ew2LKkpe7J5sCAhf4y7Bk0Q5DADDEiT+BRM
	 kboLgFBnJ4YHnBscrUtvZlQaQ+bBeIF1YuUSdDZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgDKMRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgDKMRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8BC20644;
        Sat, 11 Apr 2020 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607428;
        bh=JYLApusJ2vZ0Fk5B+rq4ZitGLZMDKMrcIp+WZ7wLTKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UL//3BU/JLd9cG6Su8faxoFjcoR3b8WdgFDSEsx5ma+4moBOipu9PqZZIrEZGT5KH
         5YjbNCxOwR2fS8KsLEQc7duTBiHVhDMqcMK/maMetEvqDoKSfymlXqKqvpqX47QIjP
         C4tn1JEYQBKeEsUAMl6LojPlOPTizNN7rqZicZoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 16/41] random: always use batched entropy for get_random_u{32,64}
Date:   Sat, 11 Apr 2020 14:09:25 +0200
Message-Id: <20200411115505.212960460@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 69efea712f5b0489e67d07565aad5c94e09a3e52 upstream.

It turns out that RDRAND is pretty slow. Comparing these two
constructions:

  for (i = 0; i < CHACHA_BLOCK_SIZE; i += sizeof(ret))
    arch_get_random_long(&ret);

and

  long buf[CHACHA_BLOCK_SIZE / sizeof(long)];
  extract_crng((u8 *)buf);

it amortizes out to 352 cycles per long for the top one and 107 cycles
per long for the bottom one, on Coffee Lake Refresh, Intel Core i9-9880H.

And importantly, the top one has the drawback of not benefiting from the
real rng, whereas the bottom one has all the nice benefits of using our
own chacha rng. As get_random_u{32,64} gets used in more places (perhaps
beyond what it was originally intended for when it was introduced as
get_random_{int,long} back in the md5 monstrosity era), it seems like it
might be a good thing to strengthen its posture a tiny bit. Doing this
should only be stronger and not any weaker because that pool is already
initialized with a bunch of rdrand data (when available). This way, we
get the benefits of the hardware rng as well as our own rng.

Another benefit of this is that we no longer hit pitfalls of the recent
stream of AMD bugs in RDRAND. One often used code pattern for various
things is:

  do {
  	val = get_random_u32();
  } while (hash_table_contains_key(val));

That recent AMD bug rendered that pattern useless, whereas we're really
very certain that chacha20 output will give pretty distributed numbers,
no matter what.

So, this simplification seems better both from a security perspective
and from a performance perspective.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20200221201037.30231-1-Jason@zx2c4.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2358,11 +2358,11 @@ struct batched_entropy {
 
 /*
  * Get a random word for internal kernel use only. The quality of the random
- * number is either as good as RDRAND or as good as /dev/urandom, with the
- * goal of being quite fast and not depleting entropy. In order to ensure
+ * number is good as /dev/urandom, but there is no backtrack protection, with
+ * the goal of being quite fast and not depleting entropy. In order to ensure
  * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once
- * at any point prior.
+ * wait_for_random_bytes() should be called and return 0 at least once at any
+ * point prior.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
 	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
@@ -2375,15 +2375,6 @@ u64 get_random_u64(void)
 	struct batched_entropy *batch;
 	static void *previous;
 
-#if BITS_PER_LONG == 64
-	if (arch_get_random_long((unsigned long *)&ret))
-		return ret;
-#else
-	if (arch_get_random_long((unsigned long *)&ret) &&
-	    arch_get_random_long((unsigned long *)&ret + 1))
-	    return ret;
-#endif
-
 	warn_unseeded_randomness(&previous);
 
 	batch = raw_cpu_ptr(&batched_entropy_u64);
@@ -2408,9 +2399,6 @@ u32 get_random_u32(void)
 	struct batched_entropy *batch;
 	static void *previous;
 
-	if (arch_get_random_int(&ret))
-		return ret;
-
 	warn_unseeded_randomness(&previous);
 
 	batch = raw_cpu_ptr(&batched_entropy_u32);


