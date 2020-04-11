Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C593C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390E21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607101;
	bh=n9rmmBrENhy6TDpT9Axt8H10o6yNclgku19ixyVaLpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D75+xUl3SNDC5Lt3tB5ilmn7J4xmSfqvm9hD6h8jXd2P61wOXONEtpxYPUvDqN0/8
	 +N6T7ak5Tf0O/FuSC4T/cmssiMLDy3OrX8SZw1Vw93i+rkNROTdIqG3WRs49ahnyTV
	 2AuARV/s1tcP28ysNDNnsFzkI+MXk/4LoBrbZbsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgDKMLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgDKMLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:11:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A029421D79;
        Sat, 11 Apr 2020 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607095;
        bh=n9rmmBrENhy6TDpT9Axt8H10o6yNclgku19ixyVaLpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWpTJG5rONBIpixT0aLmnilQ4l881bMFlulp2j3A+Utk944D7jlvOB4V2vo3WUHes
         yf/dMDqTauICqcqYDLwQjYp93yqz6lGlxMvSL6ujT6fg6RNyPk53wJHCX2dw8mraLs
         f28JoHF1c0HHQUD7XQYeQRrrz2DiOZdIUNa4GcnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.4 19/29] random: always use batched entropy for get_random_u{32,64}
Date:   Sat, 11 Apr 2020 14:08:49 +0200
Message-Id: <20200411115411.092282795@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115407.651296755@linuxfoundation.org>
References: <20200411115407.651296755@linuxfoundation.org>
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
 drivers/char/random.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1824,9 +1824,6 @@ unsigned int get_random_int(void)
 	__u32 *hash;
 	unsigned int ret;
 
-	if (arch_get_random_int(&ret))
-		return ret;
-
 	hash = get_cpu_var(get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
@@ -1846,9 +1843,6 @@ unsigned long get_random_long(void)
 	__u32 *hash;
 	unsigned long ret;
 
-	if (arch_get_random_long(&ret))
-		return ret;
-
 	hash = get_cpu_var(get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();


