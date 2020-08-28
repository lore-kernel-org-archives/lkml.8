Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2312078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgH1HLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:11:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35262 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1HLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:11:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kBYXl-0003Zo-HP; Fri, 28 Aug 2020 17:11:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Aug 2020 17:11:25 +1000
Date:   Fri, 28 Aug 2020 17:11:25 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kernel.h: Silence sparse warning in lower_32_bits
Message-ID: <20200828071125.GA18772@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting sparse warnings in crypto such as:

  CHECK   ../drivers/crypto/ccree/cc_hash.c
../drivers/crypto/ccree/cc_hash.c:49:9: warning: cast truncates bits from constant value (47b5481dbefa4fa4 becomes befa4fa4)
../drivers/crypto/ccree/cc_hash.c:49:26: warning: cast truncates bits from constant value (db0c2e0d64f98fa7 becomes 64f98fa7)
../drivers/crypto/ccree/cc_hash.c:49:43: warning: cast truncates bits from constant value (8eb44a8768581511 becomes 68581511)
../drivers/crypto/ccree/cc_hash.c:49:60: warning: cast truncates bits from constant value (67332667ffc00b31 becomes ffc00b31)
../drivers/crypto/ccree/cc_hash.c:50:9: warning: cast truncates bits from constant value (152fecd8f70e5939 becomes f70e5939)
../drivers/crypto/ccree/cc_hash.c:50:26: warning: cast truncates bits from constant value (9159015a3070dd17 becomes 3070dd17)
../drivers/crypto/ccree/cc_hash.c:50:43: warning: cast truncates bits from constant value (629a292a367cd507 becomes 367cd507)
../drivers/crypto/ccree/cc_hash.c:50:60: warning: cast truncates bits from constant value (cbbb9d5dc1059ed8 becomes c1059ed8)
../drivers/crypto/ccree/cc_hash.c:52:9: warning: cast truncates bits from constant value (5be0cd19137e2179 becomes 137e2179)
../drivers/crypto/ccree/cc_hash.c:52:26: warning: cast truncates bits from constant value (1f83d9abfb41bd6b becomes fb41bd6b)
../drivers/crypto/ccree/cc_hash.c:52:43: warning: cast truncates bits from constant value (9b05688c2b3e6c1f becomes 2b3e6c1f)
../drivers/crypto/ccree/cc_hash.c:52:60: warning: cast truncates bits from constant value (510e527fade682d1 becomes ade682d1)
../drivers/crypto/ccree/cc_hash.c:53:9: warning: cast truncates bits from constant value (a54ff53a5f1d36f1 becomes 5f1d36f1)
../drivers/crypto/ccree/cc_hash.c:53:26: warning: cast truncates bits from constant value (3c6ef372fe94f82b becomes fe94f82b)
../drivers/crypto/ccree/cc_hash.c:53:43: warning: cast truncates bits from constant value (bb67ae8584caa73b becomes 84caa73b)
../drivers/crypto/ccree/cc_hash.c:53:60: warning: cast truncates bits from constant value (6a09e667f3bcc908 becomes f3bcc908)

This patch removes the warning by adding a mask to keep sparse
happy.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def620d8f..c25b8e41c0ea 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -186,7 +186,7 @@
  * lower_32_bits - return bits 0-31 of a number
  * @n: the number we're accessing
  */
-#define lower_32_bits(n) ((u32)(n))
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
 
 struct completion;
 struct pt_regs;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
