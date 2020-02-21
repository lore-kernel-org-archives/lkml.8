Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E4C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0720578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a72Iwp74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBUUKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:10:47 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:36897 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:10:47 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 67b8b6f5;
        Fri, 21 Feb 2020 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=Y5FQH6O7ANENEU2z1fYsRnL7r
        EY=; b=a72Iwp74d5zGb/pN41iOtoXdQFeY7YX+ZibpbG6rmxr7+PvxHX4aAsCJ+
        cvLrv5CwBoG5xT1qh/lXSOXjSw3vffBUDUFwUWj/v6bt5Q7x6/HsbVFRdr1KbeLe
        HYCpjVG6X1TURBQu7TudAVbdHMBtvo2XBahoulUxoOKiPckjQaJDX8AJsUZXUiRV
        FBRqhSau3cbcLarBOvK22tRe3djblSRuqGnm7w5LgjvZafElpz3b9GGPf2i5HSSQ
        2lhnNiimH2Z3FNxyvdNSpkkP/wuDMznrxI+cG2/2cOd2nVKpwnbIPGZITakvj2H6
        VRy0DsnWeADgIr5VAaX7//oCinxSQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3d9c1c2 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Feb 2020 20:07:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: always use batched entropy for get_random_u{32,64}
Date:   Fri, 21 Feb 2020 21:10:37 +0100
Message-Id: <20200221201037.30231-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
References: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes v1->v2:

- Tony Luck suggested I also update the comment that referenced the
  no-longer relevant RDRAND.

 drivers/char/random.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..a6b77a850ddd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2149,11 +2149,11 @@ struct batched_entropy {
 
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
@@ -2166,15 +2166,6 @@ u64 get_random_u64(void)
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
@@ -2199,9 +2190,6 @@ u32 get_random_u32(void)
 	struct batched_entropy *batch;
 	static void *previous;
 
-	if (arch_get_random_int(&ret))
-		return ret;
-
 	warn_unseeded_randomness(&previous);
 
 	batch = raw_cpu_ptr(&batched_entropy_u32);
-- 
2.25.0

