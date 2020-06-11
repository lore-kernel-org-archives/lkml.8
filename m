Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899482074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgFKHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:44:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34228 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgFKHoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:44:08 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjHs4-0005aM-JI; Thu, 11 Jun 2020 17:43:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2020 17:43:32 +1000
Date:   Thu, 11 Jun 2020 17:43:32 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iov_iter: Move unnecessary inclusion of crypto/hash.h
Message-ID: <20200611074332.GA12274@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file linux/uio.h includes crypto/hash.h which pulls in
most of the Crypto API.  Since linux/uio.h is used throughout the
kernel this means that every tiny bit of change to the Crypto API
causes the entire kernel to get rebuilt.

This patch fixes this by moving it into lib/iov_iter.c instead
where it is actually used.

This patch also fixes the ifdef to use CRYPTO_HASH instead of just
CRYPTO which does not guarantee the existence of ahash.

Finally the prototype of the function has been changed to avoid
the unnecessary use of a void pointer.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9576fd8158d7..67a8ffd31ad8 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -7,9 +7,9 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
-#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
+struct ahash_request;
 struct page;
 struct pipe_inode_info;
 
@@ -264,7 +264,7 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
-size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, struct ahash_request *hash,
 		struct iov_iter *i);
 
 ssize_t import_iovec(int type, const struct iovec __user * uvector,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..ac537111dcc6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <crypto/hash.h>
 #include <linux/export.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
@@ -1563,11 +1564,10 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
-size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, struct ahash_request *hash,
 		struct iov_iter *i)
 {
-#ifdef CONFIG_CRYPTO
-	struct ahash_request *hash = hashp;
+#ifdef CONFIG_CRYPTO_HASH
 	struct scatterlist sg;
 	size_t copied;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
